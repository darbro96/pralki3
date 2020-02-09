package pl.edu.utp.pralki3.mainController;

import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pl.edu.utp.pralki3.entity.Fault;
import pl.edu.utp.pralki3.entity.Log;
import pl.edu.utp.pralki3.entity.Reservation;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.mailSender.MyMailSender;
import pl.edu.utp.pralki3.model.Notification;
import pl.edu.utp.pralki3.model.UserUtilities;
import pl.edu.utp.pralki3.service.FaultService;
import pl.edu.utp.pralki3.service.LogService;
import pl.edu.utp.pralki3.service.ReservationService;
import pl.edu.utp.pralki3.service.UserService;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import java.util.List;
import java.util.Locale;

@Secured(value = {"ROLE_RECEPTION"})
@Controller
public class ReceptionPagesController {
    @Autowired
    private UserService userService;
    @Autowired
    private ReservationService reservationService;
    @Autowired
    private MyMailSender mailSender;
    @Autowired
    private LogService logService;
    @Autowired
    private FaultService faultService;

    @GET
    @RequestMapping("/reception/reservations")
    public String reservations(Model model) {
        User loggedUser = userService.findUserByEmail(UserUtilities.getLoggedUser());
        model.addAttribute("loggedUser", loggedUser);
        List<Reservation> reservations = reservationService.findToday();
        model.addAttribute("reservations", reservations);
        return "receptionReviewReservations";
    }

    @POST
    @RequestMapping("/sendothernotification")
    public String sendAnotherNotification(Notification notification, BindingResult bindingResult, Model model, Locale locale) {
        User user = userService.get(notification.getIdUser());
        String subject = "[noreply] Powiadomienie z recepcji DS";
        mailSender.send(user.getEmail(), subject, notification.getContent());
        return "redirect:/panel";
    }

    @GET
    @RequestMapping("/returnkey/{id}")
    public String returnKey(@PathVariable("id") int idReservation) {
        Reservation reservation = reservationService.findById(idReservation);
        reservationService.setKeyReturn(reservation);
        return "redirect:/reception/reservations";
    }

    @GET
    @RequestMapping("/reportuser/{id}")
    public String reportUser(@PathVariable("id") int idUser) {
        User user = userService.get(idUser);
        userService.reportKeyRetention(user);
        return "redirect:/reception/reservations";
    }

    @GET
    @RequestMapping("/deletekeyretention/{id}")
    public String deleteKeyRetention(@PathVariable("id") int idUser) {
        User user = userService.get(idUser);
        userService.deleteKeyRetention(user);
        return "redirect:/panel";
    }

    @GET
    @RequestMapping("/reception/activity")
    public String receptionActibity(Model model) {
        User user = userService.findUserByEmail(UserUtilities.getLoggedUser());
        model.addAttribute("loggedUser", user);
        List<Log> logs = logService.findByUser(user);
        model.addAttribute("logs", logs);
        return "receptionactivity";
    }

    @GET
    @RequestMapping("/reception/faults")
    public String receptionFaults(Model model, @RequestParam(value = "execute", required = false) String execute) {
        User user = userService.findUserByEmail(UserUtilities.getLoggedUser());
        model.addAttribute("loggedUser", user);
        List<Fault> faults = faultService.findAll();
        model.addAttribute("faults", faults);
        if (execute != null) {
            if ("ok".equals(execute)) {
                model.addAttribute("message", "ok");
            } else if ("error".equals(execute)) {
                model.addAttribute("message", "error");
            }
        }
        return "receptionFaults";
    }

    @GET
    @RequestMapping("/deletefault/{id}")
    public String deleteFault(@PathVariable("id") int id) {
        try {
            Fault fault = faultService.findById(id);
            faultService.setFaultDone(fault);
            return "redirect:/reception/faults?execute=ok";
        } catch (Exception ex) {
            return "redirect:/reception/faults?execute=error";
        }
    }

    @GET
    @RequestMapping("/reception/search")
    public String testSearch(Model model)
    {
        String username = UserUtilities.getLoggedUser();
        User user = userService.findUserByEmail(username);
        model.addAttribute("loggedUser", user);
        model.addAttribute("notification", new Notification());
        return "search";
    }


}
