package pl.edu.utp.pralki3.mainController;

import javax.ws.rs.GET;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import pl.edu.utp.pralki3.model.UserUtilities;

@Controller
public class MainPageController {

    @GET
    @RequestMapping(value = {"/", "/index"})
    public String showMainPage() {
        String username = UserUtilities.getLoggedUser();
        if (username == null)
            return "login";
        else
            return "redirect:/panel";
    }

}
