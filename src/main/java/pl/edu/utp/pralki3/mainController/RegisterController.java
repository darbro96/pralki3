package pl.edu.utp.pralki3.mainController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import pl.edu.utp.pralki3.entity.Dormitory;
import pl.edu.utp.pralki3.entity.Role;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.service.DormitoryService;
import pl.edu.utp.pralki3.service.RoleSerivce;
import pl.edu.utp.pralki3.service.UserService;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import java.util.List;
import java.util.Locale;

@Controller
public class RegisterController {
    @Autowired
    private UserService userService;
    @Autowired
    private MessageSource messageSource;
    @Autowired
    private DormitoryService dormitoryService;
    @Autowired
    private RoleSerivce roleSerivce;

    @GET
    @RequestMapping("/register")
    public String registerForm(Model model) {
        User user = new User();
        model.addAttribute("user", user);
        List<Dormitory> dormsList = dormitoryService.findAll();
        model.addAttribute("dorms", dormsList);
        List<Role> roleList = roleSerivce.findAll();
        model.addAttribute("roles", roleList);
        return "register";
    }

    @POST
    @RequestMapping(value = "/adduser")
    public String registerAction(User user, BindingResult bindingResult, Model model, Locale locale) {
        String returnPage = null;
        User userExist = userService.findUserByEmail(user.getEmail());
        if (userExist != null) {
            bindingResult.rejectValue("email", "error.userEmailExist");
        }
        if (bindingResult.hasErrors()) {
            returnPage = "register";
        } else {
            userService.saveUser(user);
            model.addAttribute("message", "user.register.success");
            model.addAttribute("user", new User());
            List<Dormitory> dormsList = dormitoryService.findAll();
            model.addAttribute("dorms", dormsList);
            List<Role> roleList = roleSerivce.findAll();
            model.addAttribute("roles", roleList);
            returnPage = "register";
        }
        return returnPage;
    }
}
