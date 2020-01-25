package pl.edu.utp.pralki3.mainController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import pl.edu.utp.pralki3.entity.Reservation;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.model.UserUtilities;
import pl.edu.utp.pralki3.service.ReservationService;
import pl.edu.utp.pralki3.service.UserService;

import javax.ws.rs.GET;
import java.util.List;

@Secured(value = {"ROLE_RECEPTION"})
@Controller
public class ReceptionPagesController {
    @Autowired
    private UserService userService;
    @Autowired
    private ReservationService reservationService;

    @GET
    @RequestMapping("/reception/reservations")
    public String reservations(Model model) {
        User loggedUser = userService.findUserByEmail(UserUtilities.getLoggedUser());
        model.addAttribute("loggedUser", loggedUser);
        List<Reservation> reservations = reservationService.findTodayOrLater();
        model.addAttribute("reservations", reservations);
        return "receptionReviewReservations";
    }
}
