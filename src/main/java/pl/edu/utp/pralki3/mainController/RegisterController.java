package pl.edu.utp.pralki3.mainController;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.hibernate.dialect.DataDirectOracle9Dialect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import pl.edu.utp.pralki3.entity.Dormitory;
import pl.edu.utp.pralki3.entity.Role;
import pl.edu.utp.pralki3.entity.Room;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.mailSender.MyMailSender;
import pl.edu.utp.pralki3.model.UserUtilities;
import pl.edu.utp.pralki3.service.DormitoryService;
import pl.edu.utp.pralki3.service.RoleSerivce;
import pl.edu.utp.pralki3.service.RoomService;
import pl.edu.utp.pralki3.service.UserService;
import pl.edu.utp.pralki3.utilities.PasswordGenerator;

import javax.annotation.PostConstruct;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import java.io.*;
import java.util.List;
import java.util.Locale;
import java.util.NoSuchElementException;

@Controller
@Secured(value = {"ROLE_ADMIN"})
public class RegisterController {
    @Autowired
    private UserService userService;
    @Autowired
    private DormitoryService dormitoryService;
    @Autowired
    private RoleSerivce roleSerivce;
    @Autowired
    private RoomService roomService;
    @Autowired
    private MyMailSender mailSender;

    @GET
    @RequestMapping("/register")
    public String registerForm(Model model) {
        User loggedUser = userService.findUserByEmail(UserUtilities.getLoggedUser());
        model.addAttribute("loggedUser", loggedUser);
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
    public String registerAction(User user, BindingResult bindingResult, Model model, Locale locale, @RequestParam(value = "fileupload", required = true) MultipartFile importFile) {
        String returnPage = null;
        User userExist = userService.findUserByEmail(user.getEmail());
        if (userExist != null) {
            bindingResult.rejectValue("email", "error.userEmailExist");
        }
        try {
            if (!user.getNumberOfRoom().equals("") && user != null) {
                Room room = roomService.findByNumber(user.getNumberOfRoom(), dormitoryService.findByName(user.getNameOfDormitory()));
                if (userService.findUsersFromRoom(room).size() >= room.getCapacity()) {
                    bindingResult.rejectValue("numberOfRoom", "error.room");
                }
            }
        } catch (NoSuchElementException ex) {
            bindingResult.rejectValue("numberOfRoom", "error.room");
        }

        if (bindingResult.hasErrors()) {
            returnPage = "register";
        } else {
            String password = PasswordGenerator.generatePassword();
            user.setPassword(password);
            userService.saveUser(user);
            String content = "Hasło do serwisu: " + password;
            String subject = "[noreply] Haslo do serwisu";
            mailSender.send(user.getEmail(), subject, content);
            model.addAttribute("message", "Zarejestrowano użytkownika");
            model.addAttribute("user", new User());
            List<Dormitory> dormsList = dormitoryService.findAll();
            model.addAttribute("dorms", dormsList);
            List<Role> roleList = roleSerivce.findAll();
            model.addAttribute("roles", roleList);
            user = userService.findUserByEmail(user.getEmail());
            //wgrywanie pliku
            try {
                File uploadDirectory = new File("users_img");
                uploadDirectory.mkdirs();
                File oFile = new File(uploadDirectory.getPath() + "/" + user.getIdUser() + ".png");
                try (OutputStream os = new FileOutputStream(oFile)) {
                    InputStream inputStream = importFile.getInputStream();

                    IOUtils.copy(inputStream, os);

                    os.close();
                    inputStream.close();
                }
            } catch (IOException ex) {
                System.out.println("\n\n" + ex.toString() + "\n\n");
            }

            returnPage = "register";
        }
        return returnPage;
    }
}
