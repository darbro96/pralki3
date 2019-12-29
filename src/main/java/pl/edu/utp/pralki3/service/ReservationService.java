package pl.edu.utp.pralki3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.edu.utp.pralki3.entity.Reservation;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.entity.Washer;
import pl.edu.utp.pralki3.repository.ReservationRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ReservationService {
    @Autowired
    private ReservationRepository reservationRepository;

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

    public List<Reservation> findByWasher(Washer washer) {
        List<Reservation> reservations = findAllActive();
        reservations = reservations.stream().filter(r -> r.getWasher().getIdWasher() == washer.getIdWasher()).collect(Collectors.toList());
        return reservations;
    }

    public boolean checkReservation(Reservation reservation) {
        List<Reservation> reservations = findByWasher(reservation.getWasher());
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
    }

    public boolean checkUser(User user, LocalDateTime date) {
        int d = date.getDayOfMonth();
        int m = date.getMonthValue();
        int y = date.getYear();
        List<Reservation> reservations = findByUser(user).stream().filter(r -> r.getStart().getYear() == y && r.getStart().getMonthValue() == m && r.getStart().getDayOfMonth() == d).collect(Collectors.toList());
        if (reservations.size() > 0) {
            return false;
        }
        return true;
    }

    public void deactivateReservation(int id) {
        Reservation reservation = reservationRepository.getOne(id);
        reservation.setActive(false);
        reservationRepository.save(reservation);
    }
}
