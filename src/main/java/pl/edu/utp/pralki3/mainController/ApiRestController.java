package pl.edu.utp.pralki3.mainController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.service.UserService;

import javax.ws.rs.GET;
import java.util.List;

@RestController
@RequestMapping("/api")
public class ApiRestController {
    @Autowired
    private UserService userService;

    @GET
    @RequestMapping("/users")
    @Secured(value = {"ROLE_ADMIN"})
    public List<User> users()
    {
        return userService.findAll();
    }
}
