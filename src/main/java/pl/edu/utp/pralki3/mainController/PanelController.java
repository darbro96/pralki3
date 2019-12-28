package pl.edu.utp.pralki3.mainController;

import org.apache.tomcat.jni.Local;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import pl.edu.utp.pralki3.entity.Reservation;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.entity.Washer;
import pl.edu.utp.pralki3.model.UserUtilities;
import pl.edu.utp.pralki3.service.RoleSerivce;
import pl.edu.utp.pralki3.service.UserService;
import pl.edu.utp.pralki3.service.WasherService;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@Controller
public class PanelController {
    @Autowired
    private UserService userService;
    @Autowired
    private RoleSerivce roleSerivce;
    @Autowired
    private WasherService washerService;

    @GET
    @RequestMapping("/panel")
    public String showPanel(Model model) {
        String username = UserUtilities.getLoggedUser();
        User user = userService.findUserByEmail(username);
        model.addAttribute("user", user);
        if (user.getRoles().iterator().next().getIdRole() == roleSerivce.findByRole("ROLE_user").getIdRole()) {
            List<Washer> washers = washerService.findAll();
            washers = washers.stream().filter(w -> w.getLaundry().getDormitory().getIdDormitory() == user.getDormitory().getIdDormitory()).collect(Collectors.toList());
            model.addAttribute("washers", washers);
        }
        return "panel_new";
    }
}
