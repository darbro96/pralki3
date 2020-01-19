package pl.edu.utp.pralki3.mainController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pl.edu.utp.pralki3.entity.Reservation;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.entity.Washer;
import pl.edu.utp.pralki3.model.SpecialReservation;
import pl.edu.utp.pralki3.model.Timetable;
import pl.edu.utp.pralki3.model.UserUtilities;
import pl.edu.utp.pralki3.service.ReservationService;
import pl.edu.utp.pralki3.service.RoleSerivce;
import pl.edu.utp.pralki3.service.UserService;
import pl.edu.utp.pralki3.service.WasherService;

import javax.ws.rs.GET;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class PanelController {
    @Autowired
    private UserService userService;
    @Autowired
    private RoleSerivce roleSerivce;
    @Autowired
    private WasherService washerService;
    @Autowired
    private ReservationService reservationService;

    private static final int TIMETABLE_SIZE = 8;

    @GET
    @RequestMapping("/panel")
    public String showPanel(Model model, @RequestParam(required = false) String washer) {
        String username = UserUtilities.getLoggedUser();
        User user = userService.findUserByEmail(username);
        model.addAttribute("user", user);
        if (user.getRoles().iterator().next().getIdRole() == roleSerivce.findByRole("ROLE_user").getIdRole()) {
            List<Washer> washers = washerService.findAll();
            washers = washers.stream().filter(w -> w.getLaundry().getDormitory().getIdDormitory() == user.getDormitory().getIdDormitory()).collect(Collectors.toList());
            model.addAttribute("washers", washers);
            model.addAttribute("message","Wybierz pralkę");
            if (washer != null) {
                Washer washerObj = washerService.get(Integer.parseInt(washer));
                List<Timetable> timetables = prepareTimetable(user, washerObj);
                model.addAttribute("timetables", timetables);
                model.addAttribute("hours", generateHours());
                model.addAttribute("message", "Harmonogram pralki:  "+washerObj.getNumberWasher()+" (pralnia "+washerObj.getLaundry().getNumberLaundry()+")");
            }
            return "panel_new";
        }
        else
        {
            return "administrationPanel";
        }

    }

    private List<Timetable> prepareTimetable(User user, Washer washer) {
        List<Timetable> timetables = new ArrayList<>();
        List<Reservation> reservations = reservationService.findByWasher(washer);
        for (int i = 0; i < TIMETABLE_SIZE; i++) {
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
}
