package pl.edu.utp.pralki3.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pl.edu.utp.pralki3.entity.*;
import pl.edu.utp.pralki3.mailSender.MyMailSender;
import pl.edu.utp.pralki3.model.RoomWithResidents;
import pl.edu.utp.pralki3.service.*;
import pl.edu.utp.pralki3.utilities.PasswordGenerator;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api")
@Secured(value = {"ROLE_ADMIN"})
public class ApiController {
    @Autowired
    private UserService userService;
    @Autowired
    private DormitoryService dormitoryService;
    @Autowired
    private LaundryService laundryService;
    @Autowired
    private WasherService washerService;
    @Autowired
    private RoomService roomService;
    @Autowired
    private MyMailSender mailSender;

    @GET
    @RequestMapping("/users")
    public List<User> getAllUsers() {
        List<User> users = userService.findAll();
        users.forEach(u -> u.setPassword(null));
        return users;
    }

    @GET
    @RequestMapping("/reception/users/{dorm}")
    @Secured(value = {"ROLE_ADMIN", "ROLE_RECEPTION"})
    public List<User> getAllUsersReception(@PathVariable("dorm") String nameOfDormitory) {
        List<User> users = userService.findAll();
        Dormitory dormitory = dormitoryService.findByName(nameOfDormitory);
        users = users.stream().filter(u -> u.getRoles().iterator().next().getRole().equals("ROLE_USER")).filter(u -> u.getDormitory() != null).filter(u -> u.getDormitory().getIdDormitory() == dormitory.getIdDormitory()).collect(Collectors.toList());
        users.forEach(u -> u.setPassword(null));
        return users;
    }

    @GET
    @RequestMapping("/dorms")
    public List<Dormitory> getAllDorms() {
        return dormitoryService.findAll();
    }

    @GET
    @RequestMapping("/laundries/{dorm}")
    public List<Laundry> getAllLaundriesFromDormitory(@PathVariable("dorm") String dorm) {
        Dormitory dormitory = dormitoryService.findByName(dorm);
        return laundryService.findAll().stream().filter(l -> l.getDormitory().getIdDormitory() == dormitory.getIdDormitory()).collect(Collectors.toList());
    }

    @GET
    @RequestMapping("/washers/{idLaundry}")
    public List<Washer> getAllWashersFromLaundry(@PathVariable("idLaundry") String idLaundry) {
        Optional<Laundry> optional = laundryService.findAll().stream().filter(l -> l.getIdLaundry() == Integer.parseInt(idLaundry)).findFirst();
        Laundry laundry = optional.isPresent() ? optional.get() : null;
        return washerService.getWashersFromLaundry(laundry);
    }

    @GET
    @RequestMapping("/rooms/{aka}/{pietro}")
    public List<RoomWithResidents> roomsFromFloor(@PathVariable("pietro") int pietro, @PathVariable("aka") String dorm) {
        Dormitory dormitory = dormitoryService.findByName(dorm);
        List<Room> rooms = roomService.getRoomsFromFloor(dormitory, pietro);
        List<RoomWithResidents> result = new ArrayList<>();
        for (Room r : rooms) {
            RoomWithResidents roomWithResidents = new RoomWithResidents();
            roomWithResidents.setRoom(r);
            List<User> users = userService.getUsersFromRoom(r);
            roomWithResidents.setUsers(users);
            result.add(roomWithResidents);
        }
        return result;
    }

    @GET
    @RequestMapping("/searchroom/{idUser}")
    public List<Room> adjustRoomToUser(@PathVariable("idUser") int idUser) {
        User user = userService.get(idUser);
        return roomService.adjustRoomToUser(user);
    }

    @POST
    @RequestMapping("/resetpassword/{idUser}")
    public void resetPassword(@PathVariable("idUser") int idUser) {
        String password = PasswordGenerator.generatePassword();
        User user = userService.get(idUser);
        userService.updateUserPassword(password, user.getEmail());
        String content = "Hasło do serwisu: " + password;
        String subject = "[noreply] Haslo do serwisu";
        mailSender.send(user.getEmail(), subject, content);
    }

    @GET
    @RequestMapping("/rooms/{aka}")
    @Secured(value = {"ROLE_ADMIN", "ROLE_RECEPTION"})
    public List<Room> rooms(@PathVariable("aka") String dorm) {
        Dormitory dormitory = dormitoryService.findByName(dorm);
        return roomService.findAllRoomsFromDormitory(dormitory);
    }

    @GET
    @RequestMapping("/usersfromroom/{aka}/{room}")
    @Secured(value = {"ROLE_ADMIN", "ROLE_RECEPTION"})
    public List<User> usersFromRoom(@PathVariable("aka") String dorm, @PathVariable("room") String numRoom) {
        Dormitory dormitory=dormitoryService.findByName(dorm);
        Room room = roomService.findByNumber(numRoom,dormitory);
        return userService.getUsersFromRoom(room);
    }
}
