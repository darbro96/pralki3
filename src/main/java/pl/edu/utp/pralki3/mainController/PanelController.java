package pl.edu.utp.pralki3.mainController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.model.UserUtilities;
import pl.edu.utp.pralki3.service.UserService;

import javax.ws.rs.GET;

@Controller
public class PanelController {
    @Autowired
    private UserService userService;

    @GET
    @RequestMapping("/panel")
    public String showPanel(Model model)
    {
        String username= UserUtilities.getLoggedUser();
        User user=userService.findUserByEmail(username);
        model.addAttribute("user",user);
        return "panel_new";
    }
}
