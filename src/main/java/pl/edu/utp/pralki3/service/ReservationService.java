package pl.edu.utp.pralki3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.edu.utp.pralki3.entity.Reservation;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.entity.Washer;
import pl.edu.utp.pralki3.model.SpecialReservation;
import pl.edu.utp.pralki3.model.Timetable;
import pl.edu.utp.pralki3.model.UserUtilities;
import pl.edu.utp.pralki3.repository.ReservationRepository;

import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class ReservationService {
    @Autowired
    private ReservationRepository reservationRepository;
    @Autowired
    private LogService logService;
    @Autowired
    private UserService userService;

    public List<Reservation> findAll() {
        return reservationRepository.findAll();
    }

    public List<Reservation> findAllActive() {
        return findAll().stream().filter(r -> r.isActive()).collect(Collectors.toList());
    }

    public void saveReservation(Reservation reservation) {
        reservation.setActive(true);
        reservationRepository.save(reservation);
    }

    public List<Reservation> findByUser(User user) {
        List<Reservation> reservations = findAllActive();
        reservations = reservations.stream().filter(r -> r.getUser().getIdUser() == user.getIdUser()).collect(Collectors.toList());
        return reservations;
    }

    public List<Reservation> findByUserTodayOrLater(User user) {
        List<Reservation> reservations = findByUser(user).stream().filter(r -> r.getStop().isAfter(LocalDateTime.now())).collect(Collectors.toList());
        return reservations;
    }

    public List<Reservation> findTodayOrLater() {
        List<Reservation> reservations = findAllActive().stream().filter(r -> r.getStop().isAfter(LocalDateTime.now())).collect(Collectors.toList());
        return reservations;
    }

    public List<Reservation> findToday() {
        LocalDateTime tomorrow = LocalDateTime.of(LocalDateTime.now().getYear(), LocalDateTime.now().getMonthValue(), LocalDateTime.now().getDayOfMonth(), 0, 0);
        LocalDateTime today = LocalDateTime.of(LocalDateTime.now().getYear(), LocalDateTime.now().getMonthValue(), LocalDateTime.now().getDayOfMonth(), 0, 0);
        List<Reservation> reservations = findAllActive().stream().filter(r -> r.getStop().isAfter(today)).filter(r -> r.getStop().isBefore(tomorrow.plusDays(1))).filter(r -> !r.isKeyReturned()).collect(Collectors.toList());
        for (Reservation r : reservations) {
            if (LocalDateTime.now().isAfter(r.getStop())) {
                r.setAfterTime(true);
            } else {
                r.setAfterTime(false);
            }
        }
        return reservations;
    }

    public List<Reservation> findByWasher(Washer washer) {
        List<Reservation> reservations = findAllActive();
        try {
            reservations = reservations.stream().filter(r -> r.getWasher().getIdWasher() == washer.getIdWasher()).collect(Collectors.toList());
            return reservations;
        } catch (NullPointerException ex) {
            return null;
        }
    }

    public boolean checkReservation(Reservation reservation) {
        List<Reservation> reservations = findByWasher(reservation.getWasher());
        try {
            for (Reservation r : reservations) {
                if (reservation.getStart().isEqual(r.getStart()) || reservation.getStart().isAfter(r.getStart())) {
                    if (reservation.getStart().isEqual(r.getStop()) || reservation.getStart().isBefore(r.getStop())) {
                        return false;
                    }
                }
                if (reservation.getStop().isAfter(r.getStart())) {
                    if (reservation.getStop().isEqual(r.getStop()) || reservation.getStop().isBefore(r.getStop())) {
                        return false;
                    }
                }
            }
            return true;
        } catch (NullPointerException ex) {
            return false;
        }
    }

    public boolean checkUser(User user, LocalDateTime date) {
        try {
            int d = date.getDayOfMonth();
            int m = date.getMonthValue();
            int y = date.getYear();
            List<Reservation> reservations = findByUser(user).stream().filter(r -> r.getStart().getYear() == y && r.getStart().getMonthValue() == m && r.getStart().getDayOfMonth() == d).collect(Collectors.toList());
            if (reservations.size() > 0) {
                return false;
            }
            return true;
        } catch (NullPointerException ex) {
            return false;
        }
    }

    public void deactivateReservation(int id) {
        Reservation reservation = reservationRepository.getOne(id);
        reservation.setActive(false);
        reservationRepository.save(reservation);
        logService.saveLog(userService.findUserByEmail(UserUtilities.getLoggedUser()), "Deaktywacja rezerwacji id: " + reservation.getIdReservation());
    }

    public List<Timetable> prepareTimetable(User user, Washer washer, int timetableSize) {
        List<Timetable> timetables = new ArrayList<>();
        List<Reservation> reservations = findByWasher(washer);
        for (int i = 0; i < timetableSize; i++) {
            LocalDateTime today = LocalDateTime.now().plusDays(i);
            LocalDateTime date = LocalDateTime.of(today.getYear(), today.getMonthValue(), today.getDayOfMonth(), 6, 0);
            Timetable timetable = new Timetable();
            String month = date.getMonthValue() < 10 ? "0" + date.getMonthValue() : String.valueOf(date.getMonthValue());
            timetable.setDay(date.getDayOfMonth() + "." + month + "." + date.getYear());
            List<Reservation> tmp = reservations.stream().filter(r -> compareEqualsOfDate(r.getStart(), today.getDayOfMonth(), today.getMonthValue(), today.getYear())).collect(Collectors.toList());
            List<SpecialReservation> specialReservations = new ArrayList<>();
            int diff = -1;
            SpecialReservation tmpReservation = null;
            while (date.getHour() <= 21) {
                SpecialReservation specialReservation = new SpecialReservation();
                if (diff < 0) {
                    for (Reservation r : tmp) {
                        if (r.getStart().getHour() == date.getHour() && r.getStart().getMinute() == date.getMinute()) {
                            specialReservation.setReservation(r);
                            if (r.getUser().getIdUser() == user.getIdUser()) {
                                specialReservation.setColor(SpecialReservation.USER_COLOR);
                            } else {
                                specialReservation.setColor(SpecialReservation.OTHER_COLOR);
                            }
                            diff = r.getStop().getHour() - date.getHour();
                            diff *= 2;
                            tmpReservation = specialReservation;
                        }
                    }
                }
                if (diff >= 0) {
                    specialReservations.add(tmpReservation);
                    diff--;
                } else {
                    specialReservations.add(specialReservation);
                }
                date = date.plusMinutes(30);
            }
            timetable.setSpecialReservations(specialReservations);
            timetables.add(timetable);
        }
        return timetables;
    }

    private boolean compareEqualsOfDate(LocalDateTime dateTime, int d, int m, int y) {
        if (dateTime.getYear() == y && dateTime.getDayOfMonth() == d && dateTime.getMonthValue() == m) {
            return true;
        } else {
            return false;
        }
    }

    public List<String> generateHours() {
        List<String> hours = new ArrayList<>();
        LocalDateTime today = LocalDateTime.now();
        LocalDateTime date = LocalDateTime.of(today.getYear(), today.getMonthValue(), today.getDayOfMonth(), 6, 0);
        while (date.getHour() <= 21) {
            String hour = date.getHour() < 10 ? "0" + date.getHour() : String.valueOf(date.getHour());
            String min = date.getMinute() < 10 ? "0" + date.getMinute() : String.valueOf(date.getMinute());
            hours.add(hour + ":" + min);
            date = date.plusMinutes(30);
        }
        return hours;
    }

    public Reservation findById(int id) {
        return reservationRepository.getOne(id);
    }

    public void setKeyReturn(Reservation reservation) {
        reservationRepository.updateKeyReturned(true, reservation.getIdReservation());
    }

    public void deleteReservation(Reservation reservation) {
        reservationRepository.delete(reservation);
    }

    public void deleteReservationFromWasher(Washer washer) {
        List<Reservation> reservations = findByWasher(washer);
        for (Reservation r : reservations) {
            deleteReservation(r);
        }
    }
}
