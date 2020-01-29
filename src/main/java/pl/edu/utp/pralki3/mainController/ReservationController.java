package pl.edu.utp.pralki3.mainController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pl.edu.utp.pralki3.entity.Reservation;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.entity.Washer;
import pl.edu.utp.pralki3.model.UserUtilities;
import pl.edu.utp.pralki3.service.ReservationService;
import pl.edu.utp.pralki3.service.UserService;
import pl.edu.utp.pralki3.service.WasherService;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import java.time.DateTimeException;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Locale;

@Controller
public class ReservationController {
    @Autowired
    private UserService userService;

    @Autowired
    private WasherService washerService;

    @Autowired
    private ReservationService reservationService;

    @GET
    @RequestMapping("/bookwasher")
    public String showBookForm(Model model, @RequestParam(value = "error", required = false) String error) {
        User user = userService.findUserByEmail(UserUtilities.getLoggedUser());
        model.addAttribute("loggedUser", user);
        List<Washer> washers = washerService.getWashersToUser(user);
        model.addAttribute("washers", washers);
        LocalDateTime today = LocalDateTime.now();
        model.addAttribute("today", dateTimeToString(today));
        LocalDateTime max = today.plusDays(8);
        model.addAttribute("max", dateTimeToString(max));
        Reservation reservation = new Reservation();
        model.addAttribute("reservation", reservation);
        if ("1".equals(error)) {
            model.addAttribute("error", "Rezerwacja w wybranym terminie niemożliwa!");
        }
        return "bookWasherForm";
    }

    private String dateTimeToString(LocalDateTime dateTime) {
        String m, d;
        if (dateTime.getMonthValue() < 10) {
            m = "0" + dateTime.getMonthValue();
        } else {
            m = String.valueOf(dateTime.getMonthValue());
        }
        if (dateTime.getDayOfMonth() < 10) {
            d = "0" + dateTime.getDayOfMonth();
        } else {
            d = String.valueOf(dateTime.getDayOfMonth());
        }
        return dateTime.getYear() + "-" + m + "-" + d;
    }

    @POST
    @RequestMapping("/bookwasheraction")
    public String bookWasher(Reservation reservation, BindingResult bindingResult, Model model, Locale locale) {
        User user = userService.findUserByEmail(reservation.getUsername());
        reservation.setUser(user);
        Washer washer = null;
        try
        {
            washer=washerService.get(Integer.parseInt(reservation.getWasherId()));
        }
        catch (NumberFormatException ex)
        {
            bindingResult.rejectValue("start", "Nie wskazano pralki!");
        }
        reservation.setWasher(washer);
        try
        {
            reservation.setStart(LocalDateTime.parse(reservation.getDateStart() + "T" + reservation.getTimeStart()));
            reservation.setStop(reservation.getStart().plusHours(Long.parseLong(reservation.getDuration())));
        }
        catch (DateTimeParseException ex)
        {
            bindingResult.rejectValue("start", "Nieprawidłowy format daty!");
        }

        if (!reservationService.checkReservation(reservation)) {
            bindingResult.rejectValue("start", "Rezerwacja niemożliwa. Wybierz inny termin lub pralkę");
            model.addAttribute("message", "Rezerwacja niemożliwa. Wybierz inny termin lub pralkę");
        }

        if (!reservationService.checkUser(user, reservation.getStart())) {
            bindingResult.rejectValue("start", "Osiągnąłeś limit rezerwacji na wskazany dzień!");
            model.addAttribute("message", "Osiągnąłeś limit rezerwacji na wskazany dzień!");
        }


        if (bindingResult.hasErrors()) {
            user = userService.findUserByEmail(UserUtilities.getLoggedUser());
            model.addAttribute("user", user);
            List<Washer> washers = washerService.getWashersToUser(user);
            model.addAttribute("washers", washers);
            LocalDateTime today = LocalDateTime.now();
            model.addAttribute("today", dateTimeToString(today));
            LocalDateTime max = today.plusDays(8);
            model.addAttribute("max", dateTimeToString(max));
            reservation = new Reservation();
            model.addAttribute("reservation", reservation);
            return "redirect:/bookwasher?error=1";
        } else {
            reservationService.saveReservation(reservation);
            user = userService.findUserByEmail(UserUtilities.getLoggedUser());
            model.addAttribute("user", user);
            List<Reservation> reservations = reservationService.findByUserTodayOrLater(user);
            model.addAttribute("reservations", reservations);
            return "reservations";
        }
    }

    @GET
    @RequestMapping("/reservations")
    public String showUserReservations(Model model, @RequestParam(required = false) String cancel) {
        if (cancel != null) {
            try {
                reservationService.deactivateReservation(Integer.parseInt(cancel));
            } catch (NumberFormatException ex) {
                model.addAttribute("message", "Błąd podczas rezygnacji z rezerwacji");
            }
        }
        User user = userService.findUserByEmail(UserUtilities.getLoggedUser());
        model.addAttribute("loggedUser", user);
        List<Reservation> reservations = reservationService.findByUserTodayOrLater(user);
        model.addAttribute("reservations", reservations);
        return "reservations";
    }
}
