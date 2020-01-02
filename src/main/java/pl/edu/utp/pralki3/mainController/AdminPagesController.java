package pl.edu.utp.pralki3.mainController;

import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import pl.edu.utp.pralki3.entity.*;
import pl.edu.utp.pralki3.service.*;

import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@Controller
@Secured(value = {"ROLE_ADMIN"})
public class AdminPagesController {
    @Autowired
    private UserService userService;

    @Autowired
    private DormitoryService dormitoryService;

    @Autowired
    private LaundryService laundryService;

    @Autowired
    private WasherService washerService;

    @Autowired
    private RoleSerivce roleSerivce;

    private static final int ELEMENTS = 10;

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
    @RequestMapping(value = "/users")
    @Secured(value = {"ROLE_ADMIN"})
    public String showUsersNoPage(Model model) {
        int page = 1;
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

    @GET
    @RequestMapping(value = "/addlaundry")
    public String showAddLaundryForm(Model model) {
        Laundry laundry = new Laundry();
        List<Dormitory> dormitories = dormitoryService.findAll();
        model.addAttribute("laundry", laundry);
        model.addAttribute("dorms", dormitories);
        return "addLaundry";
    }

    @POST
    @RequestMapping(value = "/addlaundryaction")
    public String addNewLaundry(Laundry laundry, BindingResult bindingResult, Model model, Locale locale) {
        String returnPage = null;
        Laundry laundryExists = null;
        laundryExists = laundryService.getLaundryByNumber(laundry.getNumberLaundry());
        if (laundryExists != null) {
            if (laundryExists.getDormitory().getIdDormitory() == laundry.getDormitory().getIdDormitory())
                bindingResult.rejectValue("name", "Pralnia już istnieje!");
        }
        if (bindingResult.hasErrors()) {
            returnPage = "addLaundry";
        } else {
            laundryService.saveLaundry(laundry);
            model.addAttribute("message", "Dodano nową pralnię");
            model.addAttribute("laundry", new Laundry());
            returnPage = "addLaundry";
        }
        return returnPage;
    }

    @GET
    @RequestMapping(value = "/addwasher")
    public String showAddWasherForm(Model model) {
        Washer washer = new Washer();
        List<Laundry> laundries = laundryService.findAll();
        model.addAttribute("washer", washer);
        model.addAttribute("laundries", laundries);
        return "addWasher";
    }

    @POST
    @RequestMapping(value = "/addwasheraction")
    public String addNewWasher(Washer washer, BindingResult bindingResult, Model model, Locale locale) {
        String returnPage = null;
//        Washer washerExists = null;
//        try {
//            washerExists = washerService.get(washer.getIdOfLaundry());
//        } catch (Exception ex) {
//            System.out.println(ex.toString());
//        }
//        if (washerExists != null) {
//            if (washerExists.getNumberWasher() == washer.getNumberWasher())
//                bindingResult.rejectValue("name", "Pralka o takim numerze w danej pralni już istnieje!");
//        }
        List<Washer> washers = washerService.findAll();
        for (Washer w : washers) {
            if (w.getLaundry().getIdLaundry() == washer.getIdOfLaundry() && w.getNumberWasher() == washer.getNumberWasher()) {
                bindingResult.rejectValue("name", "Pralka o takim numerze w danej pralni już istnieje!");
                break;
            }
        }
        if (bindingResult.hasErrors()) {
            returnPage = "addWasher";
        } else {
            washerService.saveWasher(washer);
            model.addAttribute("message", "Dodano nową pralkę");
            model.addAttribute("washer", new Washer());
            returnPage = "addWasher";
        }
        return returnPage;
    }

    @GET
    @RequestMapping(value = "/edituser/{idUser}")
    public String editUser(Model model, @PathVariable("idUser") int idUser) {
        User user = userService.get(idUser);
        user.setNrRoli(user.getRoles().iterator().next().getIdRole());
        try {
            user.setNameOfDormitory(user.getDormitory().getName());
        } catch (NullPointerException ex) {
            user.setNameOfDormitory(null);
        }
        user.setNameOfRole(user.getRoles().iterator().next().getRole());
        model.addAttribute("user", user);
        List<Dormitory> dormsList = dormitoryService.findAll();
        model.addAttribute("dorms", dormsList);
        List<Role> roleList = roleSerivce.findAll();
        model.addAttribute("roles", roleList);
        return "usereditor";
    }

    @POST
    @RequestMapping(value = "/edituser/edit")
    public String editUserAction(User user, BindingResult bindingResult, Model model, Locale locale) {
        userService.updateUser(user);
        return "redirect:users";
    }

    @DELETE
    @RequestMapping(value = "/deleteuser/{id}")
    public String deleteUser(@PathVariable("id") int idUser) {
        User user = userService.get(idUser);
        userService.deleteUser(user);
        return "redirect:users";
    }

    @GET
    @RequestMapping(value = "activateuser/{id}")
    public String activateUser(@PathVariable("id") int idUser) {
        User user = userService.get(idUser);
        userService.activateUser(user);
        return "redirect:/users";
    }

    @GET
    @RequestMapping(value = "deactivateuser/{id}")
    public String deactivateUser(@PathVariable("id") int idUser) {
        User user = userService.get(idUser);
        userService.deactivateUser(user);
        return "redirect:/users";
    }
}
