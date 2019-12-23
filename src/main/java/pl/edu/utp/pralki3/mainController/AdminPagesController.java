package pl.edu.utp.pralki3.mainController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import pl.edu.utp.pralki3.entity.Dormitory;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.service.DormitoryService;
import pl.edu.utp.pralki3.service.UserService;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import java.util.List;
import java.util.Locale;

@Controller
public class AdminPagesController {
    @Autowired
    private UserService userService;

    @Autowired
    private DormitoryService dormitoryService;

    private static final int ELEMENTS = 5;

    @GET
    @RequestMapping(value = "/adddormitory")
    public String showAddDormitoryForm(Model model) {
        Dormitory dormitory = new Dormitory();
        model.addAttribute("dormitory", dormitory);
        return "addDormitory";
    }

    @POST
    @RequestMapping(value = "/adddorm")
    public String addNewDormitory(Dormitory dormitory, BindingResult bindingResult, Model model, Locale locale) {
        String returnPage = null;
        Dormitory dormitoryExists = null;
        if (dormitoryService.findAll().size() > 0) {
            dormitoryExists = dormitoryService.findByName(dormitory.getName());
        }
        if (dormitoryExists != null) {
            bindingResult.rejectValue("name", "Akademik już istnieje!");
        }
        if (bindingResult.hasErrors()) {
            returnPage = "addDormitory";
        } else {
            dormitoryService.saveDormitory(dormitory);
            model.addAttribute("message", "Dodano nowy akademik");
            model.addAttribute("dormitory", new Dormitory());
            returnPage = "addDormitory";
        }
        return returnPage;
    }

    @GET
    @RequestMapping(value = "/users/{page}")
    @Secured(value = {"ROLE_ADMIN"})
    public String showUsers(Model model, @PathVariable("page") int page) {
        Page<User> pages = getAllUsersPageable(page - 1);
        int totalPages = pages.getTotalPages();
        int currentPage = pages.getNumber();
        List<User> users = pages.getContent();
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", currentPage + 1);
        model.addAttribute("users", users);
        return "users";
    }

    @GET
    @RequestMapping(value = "/users/search/{word}/{page}")
    @Secured(value = {"ROLE_ADMIN"})
    public String showUsersSearch(Model model, @PathVariable("word") String word, @PathVariable("page") int page) {
        Page<User> pages = getAllUsersPageable(page - 1, word);
        int totalPages = pages.getTotalPages();
        int currentPage = pages.getNumber();
        List<User> users = pages.getContent();
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", currentPage + 1);
        model.addAttribute("users", users);
        return "users";
    }

    private Page<User> getAllUsersPageable(int page) {
        Page<User> pages = userService.findAll(PageRequest.of(page, ELEMENTS));
        for (User user : pages) {
            user.setNrRoli(user.getRoles().iterator().next().getIdRole());
        }
        return pages;
    }

    private Page<User> getAllUsersPageable(int page, String word) {
        Page<User> pages = userService.findAll(PageRequest.of(page, ELEMENTS), word);
        for (User user : pages) {
            user.setNrRoli(user.getRoles().iterator().next().getIdRole());
        }
        return pages;
    }
}
