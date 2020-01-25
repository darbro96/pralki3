package pl.edu.utp.pralki3.mainController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import pl.edu.utp.pralki3.entity.Role;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.model.UserUtilities;
import pl.edu.utp.pralki3.service.RoleSerivce;
import pl.edu.utp.pralki3.service.UserService;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import java.util.Locale;

@Controller
public class ProfilController {
    @Autowired
    private UserService userService;
    @Autowired
    private RoleSerivce roleSerivce;

    @GET
    @RequestMapping(value = "/profil")
    public String showUserProfile(Model model) {
        String username = UserUtilities.getLoggedUser();
        User user = userService.findUserByEmail(username);
        int nrRoli = user.getRoles().iterator().next().getIdRole();
        user.setNrRoli(nrRoli);
        Role role = roleSerivce.findById(nrRoli);
        user.setNameOfRole(role.getDescription());
        model.addAttribute("loggedUser", user);
        if (role.getRole().equals("ROLE_USER"))
            return "profil2";
        else
            return "profil";
    }

    @GET
    @RequestMapping(value = "/editpassword")
    public String editUserPassword(Model model) {
        String username = UserUtilities.getLoggedUser();
        User user = userService.findUserByEmail(username);
        model.addAttribute("loggedUser", user);
        model.addAttribute("user", user);
        return "editpassword";
    }

    @POST
    @RequestMapping(value = "updatepass")
    public String changeUserPassword(User user, BindingResult result, Model model, Locale locale) {
        String returnPage = null;
        if (result.hasErrors()) {
            return "editpassword";
        } else {
            userService.updateUserPassword(user.getNewPassword(), user.getEmail());
            returnPage = "editpassword";
            model.addAttribute("message", "Hasło zostało pomyślnie zmienione");
        }
        return returnPage;
    }
}
