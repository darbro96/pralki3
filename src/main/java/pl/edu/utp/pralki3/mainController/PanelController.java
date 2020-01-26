package pl.edu.utp.pralki3.mainController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import pl.edu.utp.pralki3.entity.Reservation;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.entity.Washer;
import pl.edu.utp.pralki3.model.Timetable;
import pl.edu.utp.pralki3.model.UserUtilities;
import pl.edu.utp.pralki3.service.ReservationService;
import pl.edu.utp.pralki3.service.RoleSerivce;
import pl.edu.utp.pralki3.service.UserService;
import pl.edu.utp.pralki3.service.WasherService;

import javax.activation.FileTypeMap;
import javax.ws.rs.GET;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.util.List;

@Controller
public class PanelController {
    @Autowired
    private UserService userService;
    @Autowired
    private RoleSerivce roleSerivce;
    @Autowired
    private WasherService washerService;
    @Autowired
    private ReservationService reservationService;

    private static final int TIMETABLE_SIZE = 8;

    @GET
    @RequestMapping("/panel")
    public String showPanel(Model model, @RequestParam(required = false) String washer) {
        String username = UserUtilities.getLoggedUser();
        User user = userService.findUserByEmail(username);
        model.addAttribute("loggedUser", user);
        if (user.getRoles().iterator().next().getIdRole() == roleSerivce.findByRole("ROLE_USER").getIdRole()) {
            List<Washer> washers = washerService.getWashersToUser(user);
            model.addAttribute("washers", washers);
            model.addAttribute("message", "Wybierz pralkę");
            if (washer != null) {
                Washer washerObj = washerService.get(Integer.parseInt(washer));
                List<Timetable> timetables = reservationService.prepareTimetable(user, washerObj, TIMETABLE_SIZE);
                model.addAttribute("timetables", timetables);
                model.addAttribute("hours", reservationService.generateHours());
                model.addAttribute("message", "Harmonogram pralki:  " + washerObj.getNumberWasher() + " (pralnia " + washerObj.getLaundry().getNumberLaundry() + ")");
            }
            List<Reservation> reservations = reservationService.findByUserTodayOrLater(user);
            model.addAttribute("reservations", reservations);
            return "panel_new2";
        } else if (user.getRoles().iterator().next().getIdRole() == roleSerivce.findByRole("ROLE_RECEPTION").getIdRole()) {
            return "receptionPanel";
        } else {
            return "administrationPanel";
        }

    }

    @RequestMapping("/userimage")
    @RestController
    public class ImageController {
        @RequestMapping("/{name}")
        public ResponseEntity<byte[]> getImage(@PathVariable("name") String name) throws IOException {
            try
            {
                File img = new File("users_img/" + name);
                return ResponseEntity.ok().contentType(MediaType.valueOf(FileTypeMap.getDefaultFileTypeMap().getContentType(img))).body(Files.readAllBytes(img.toPath()));
            }
            catch (NoSuchFileException ex)
            {
                return null;
            }
        }
    }
}
