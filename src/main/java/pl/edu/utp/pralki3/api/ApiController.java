package pl.edu.utp.pralki3.api;

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
@Secured(value = {"ROLE_ADMIN"})
public class ApiController {
    @Autowired
    private UserService userService;

    @GET
    @RequestMapping("/users")
    public List<User> getAllUsers() {
        List<User> users = userService.findAll();
        users.forEach(u -> u.setPassword(null));
        return users;
    }
}
