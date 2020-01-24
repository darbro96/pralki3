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
import org.springframework.web.bind.annotation.RequestParam;
import pl.edu.utp.pralki3.entity.*;
import pl.edu.utp.pralki3.model.CardToUser;
import pl.edu.utp.pralki3.model.UserUtilities;
import pl.edu.utp.pralki3.service.*;

import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import java.util.List;
import java.util.Locale;
import java.util.NoSuchElementException;

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

    @Autowired
    private RoomService roomService;

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
        String username = UserUtilities.getLoggedUser();
        User user = userService.findUserByEmail(username);
        model.addAttribute("user", user);
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
        String username = UserUtilities.getLoggedUser();
        User user = userService.findUserByEmail(username);
        model.addAttribute("user", user);
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
        if (user.getRoom() != null) {
            user.setNumberOfRoom(user.getRoom().getNumber());
        }
        user.setNameOfRole(user.getRoles().iterator().next().getRole());
        model.addAttribute("user", user);
        List<Dormitory> dormsList = dormitoryService.findAll();
        model.addAttribute("dorms", dormsList);
        List<Role> roleList = roleSerivce.findAll();
        model.addAttribute("roles", roleList);
        User loggedUser = userService.findUserByEmail(UserUtilities.getLoggedUser());
        model.addAttribute("loggedUser", loggedUser);
        return "usereditor";
    }

    @POST
    @RequestMapping(value = "/edituser/edit")
    public String editUserAction(User user, BindingResult bindingResult, Model model, Locale locale) {
        try {
            Room room = null;
            if (!user.getNumberOfRoom().equals("")) {
                room = roomService.findByNumber(user.getNumberOfRoom(), dormitoryService.findByName(user.getNameOfDormitory()));
                String number = user.getNumberOfRoom();
                user.setDormitory(dormitoryService.findByName(user.getNameOfDormitory()));
                if (!roomService.isResident(user, number)) {
                    if (userService.findUsersFromRoom(room).size() >= room.getCapacity()) {
                        bindingResult.rejectValue("numberOfRoom", "error.room");
                    }
                }
            }
        } catch (NoSuchElementException ex) {
            bindingResult.rejectValue("numberOfRoom", "error.room");
        } catch (NullPointerException ex) {
            bindingResult.rejectValue("numberOfRoom", "error.room");
        }
        if (bindingResult.hasErrors()) {
            model.addAttribute("user", user);
            List<Dormitory> dormsList = dormitoryService.findAll();
            model.addAttribute("dorms", dormsList);
            List<Role> roleList = roleSerivce.findAll();
            model.addAttribute("roles", roleList);
            User loggedUser = userService.findUserByEmail(UserUtilities.getLoggedUser());
            model.addAttribute("loggedUser", loggedUser);
            return "usereditor";
        } else {
            userService.updateUser(user);
            return "redirect:/panel";
        }
    }

    @DELETE
    @RequestMapping(value = "/deleteuser/{id}")
    public String deleteUser(@PathVariable("id") int idUser) {
        User user = userService.get(idUser);
        userService.deleteUser(user);
        return "redirect:/deleteuser";
    }

    @GET
    @RequestMapping(value = "/activateuser/{id}")
    public String activateUser(@PathVariable("id") int idUser) {
        User user = userService.get(idUser);
        userService.activateUser(user);
        return "redirect:/users";
    }

    @GET
    @RequestMapping(value = "/deactivateuser/{id}")
    public String deactivateUser(@PathVariable("id") int idUser) {
        User user = userService.get(idUser);
        userService.deactivateUser(user);
        return "redirect:/users";
    }

    @GET
    @RequestMapping(value = "/assigncard/{id}")
    public String assignCardView(Model model, @PathVariable("id") int idUser) {
        User loggedUser = userService.findUserByEmail(UserUtilities.getLoggedUser());
        model.addAttribute("loggedUser", loggedUser);
        User user = userService.get(idUser);
        CardToUser cardToUser = new CardToUser();
        cardToUser.setUsername(user.getEmail());
        model.addAttribute("user", user);
        model.addAttribute("cardToUser", cardToUser);
        return "assignCardForm";
    }

    @GET
    @RequestMapping(value = "/unassigncard/{id}")
    public String unassignCard(@PathVariable("id") int idUser) {
        User user = userService.get(idUser);
        userService.clearCardId(user);
        return "redirect:/users2";
    }

    @POST
    @RequestMapping(value = "/assigncardaction")
    public String assignCardAction(CardToUser cardToUser, BindingResult bindingResult, Model model, Locale locale) {
        User user = userService.findUserByEmail(cardToUser.getUsername());
        if (userService.checkCard(cardToUser.getCardId())) {
            user.setCardId(cardToUser.getCardId());
            userService.updateCardId(user);
            return "redirect:/users2";
        } else {
            model.addAttribute("message", "Karta jest już przypisana do innego użytkownika!");
            cardToUser = new CardToUser();
            cardToUser.setUsername(user.getEmail());
            model.addAttribute("user", user);
            model.addAttribute("cardToUser", cardToUser);
            User loggedUser = userService.findUserByEmail(UserUtilities.getLoggedUser());
            model.addAttribute("loggedUser", loggedUser);
            return "assignCardForm";
        }
    }

    @GET
    @RequestMapping(value = "/addroom")
    public String addRoom(Model model) {
        List<Dormitory> dormitories = dormitoryService.findAll();
        model.addAttribute("dormitories", dormitories);
        User loggedUser = userService.findUserByEmail(UserUtilities.getLoggedUser());
        model.addAttribute("loggedUser", loggedUser);
        Room room = new Room();
        model.addAttribute("room", room);
        List<RoomType> roomTypes = roomService.findAllTypes();
        model.addAttribute("roomTypes", roomTypes);
        return "addRoom";
    }

    @GET
    @RequestMapping(value = "/editroom/{idRoom}")
    public String editRoom(Model model, @PathVariable("idRoom") int idRoom) {
        List<RoomType> roomTypes = roomService.findAllTypes();
        model.addAttribute("roomTypes", roomTypes);
        Room room = roomService.getById(idRoom);
        room.setIdRoomType(room.getRoomType().getIdRoomType());
        room.setNameOfDormitory(room.getDormitory().getName());
        model.addAttribute("room", room);
        User loggedUser = userService.findUserByEmail(UserUtilities.getLoggedUser());
        model.addAttribute("loggedUser", loggedUser);
        List<Dormitory> dormitories = dormitoryService.findAll();
        model.addAttribute("dormitories", dormitories);
        return "editroom";
    }

    @POST
    @RequestMapping("/editroomaction")
    public String editRoomAction(Room room, BindingResult bindingResult, Model model, Locale locale) {
        room.setDormitory(dormitoryService.findByName(room.getNameOfDormitory()));
        room.setRoomType(roomService.getRoomTypeById(room.getIdRoomType()));
        roomService.updateRoom(room);
        return "redirect:/roomsByFloor";
    }

    @POST
    @RequestMapping("/searchroombycard")
    public String searchRoomByCard(Room room, BindingResult bindingResult, Model model, Locale locale) {
        try {
            Room result = roomService.getByCardId(room.getIdCard());
            return "redirect:/editroom/" + result.getIdRoom();
        } catch (NullPointerException ex) {
            return "redirect:/roomsByFloor";
        }
    }

    @POST
    @RequestMapping(value = "/addroomaction")
    public String addRoomAction(Room room, BindingResult bindingResult, Model model, Locale locale) {
        Dormitory dormitory = dormitoryService.findByName(room.getNameOfDormitory());
        Room roomExist = null;
        try {
            roomExist = roomService.findByNumber(room.getNumber(), dormitory);
        } catch (NoSuchElementException ex) {
            roomExist = null;
        }
        if (roomExist != null) {
            bindingResult.rejectValue("number", "error.roomExist");
        }
        if (bindingResult.hasErrors()) {
            User loggedUser = userService.findUserByEmail(UserUtilities.getLoggedUser());
            model.addAttribute("loggedUser", loggedUser);
            List<Dormitory> dormitories = dormitoryService.findAll();
            model.addAttribute("dormitories", dormitories);
            room = new Room();
            model.addAttribute("room", room);
            List<RoomType> roomTypes = roomService.findAllTypes();
            model.addAttribute("roomTypes", roomTypes);
            return "addRoom";
        } else {
            roomService.saveRoom(room);
            return "redirect:/panel";
        }
    }

    @GET
    @RequestMapping("/users2")
    public String newVersionUsers(Model model) {
        User user = userService.findUserByEmail(UserUtilities.getLoggedUser());
        model.addAttribute("loggedUser", user);
        return "users_new";
    }

    @GET
    @RequestMapping("/checkout")
    public String checkOutView(Model model) {
        User user = userService.findUserByEmail(UserUtilities.getLoggedUser());
        model.addAttribute("loggedUser", user);
        return "checkOutUser";
    }

    @GET
    @RequestMapping("/checkout/{idUser}")
    public String checkOutAction(@PathVariable("idUser") String idUser) {
        User user = userService.get(Integer.parseInt(idUser));
        userService.checkOut(user);
        return "redirect:/checkout";
    }

    @GET
    @RequestMapping("/deleteuser")
    public String deleteUserView(Model model) {
        User loggedUser = userService.findUserByEmail(UserUtilities.getLoggedUser());
        model.addAttribute("loggedUser", loggedUser);
        return "deleteuser";
    }

    @GET
    @RequestMapping("/checkin")
    public String checkInView(Model model) {
        User user = userService.findUserByEmail(UserUtilities.getLoggedUser());
        model.addAttribute("loggedUser", user);
        return "checkInUser";
    }

    @GET
    @RequestMapping("/checkin/{idUser}")
    public String checkInForm(Model model, @PathVariable("idUser") int idUser) {
        User user = userService.findUserByEmail(UserUtilities.getLoggedUser());
        model.addAttribute("loggedUser", user);
        user = userService.get(idUser);
        model.addAttribute("user", user);
        List<Room> rooms = roomService.adjustRoomToUser(user);
        model.addAttribute("rooms", rooms);
        return "checkInForm";
    }

    @POST
    @RequestMapping("/checkinaction")
    public String checkInAction(User user, BindingResult bindingResult, Model model, Locale locale) {
        User userFromDatabase = userService.get(user.getIdUser());
        Room room = null;
        try {
            if (!user.getNumberOfRoom().equals("")) {
                room = roomService.findByNumber(user.getNumberOfRoom(), dormitoryService.findByName(user.getDormitory().getName()));
                String number = user.getNumberOfRoom();
                user.setDormitory(dormitoryService.findByName(user.getNameOfDormitory()));
                if (!roomService.isResident(user, number)) {
                    if (userService.findUsersFromRoom(room).size() >= room.getCapacity()) {
                        bindingResult.rejectValue("numberOfRoom", "error.room");
                    }
                }
            }
        } catch (NoSuchElementException ex) {
            bindingResult.rejectValue("numberOfRoom", "error.room");
        } catch (NullPointerException ex) {
            bindingResult.rejectValue("numberOfRoom", "error.room");
        }
        if (bindingResult.hasErrors()) {
            model.addAttribute("user", user);
            User loggedUser = userService.findUserByEmail(UserUtilities.getLoggedUser());
            model.addAttribute("loggedUser", loggedUser);
            return "checkInForm";
        } else {
            userService.checkIn(userFromDatabase, room);
            return "redirect:/panel";
        }
    }

    @GET
    @RequestMapping("managewashers")
    public String manageWashers(Model model) {
        User loggedUser = userService.findUserByEmail(UserUtilities.getLoggedUser());
        model.addAttribute("loggedUser", loggedUser);
        return "managewashers";
    }

    @GET
    @RequestMapping("blockwasher/{idWasher}")
    public String blockWasher(@PathVariable("idWasher") int idWasher) {
        Washer washer = washerService.get(idWasher);
        washerService.setUnavailable(washer);
        return "redirect:/managewashers";
    }

    @GET
    @RequestMapping("unlockwasher/{idWasher}")
    public String unlockWasher(@PathVariable("idWasher") int idWasher) {
        Washer washer = washerService.get(idWasher);
        washerService.setAvailable(washer);
        return "redirect:/managewashers";
    }

    @GET
    @RequestMapping("editwasher/{idWasher}")
    public String editWasher(@PathVariable("idWasher") int idWasher, Model model) {
        Washer washer = washerService.get(idWasher);
        washer.setIdOfLaundry(washer.getLaundry().getIdLaundry());
        model.addAttribute("washer", washer);
        return "editwasher";
    }

    @POST
    @RequestMapping("/editwasheraction")
    public String editWasherAction(Washer washer, BindingResult bindingResult, Model model, Locale locale) {
        Washer washerFromDatabase = washerService.get(washer.getIdWasher());
        washerService.updateNumberOfWasher(washerFromDatabase);
        return "redirect:/editwasher";
    }

    @GET
    @RequestMapping("/roomsByFloor")
    public String roomsByFloorView(Model model, @RequestParam(required = false) boolean error) {
        User loggedUser = userService.findUserByEmail(UserUtilities.getLoggedUser());
        model.addAttribute("loggedUser", loggedUser);
        Room room = new Room();
        model.addAttribute("room", room);
        if(error)
        {
            model.addAttribute("message","Nie znaleziono pokoju ze wskazanym identyfikatorem klucza!");
        }
        return "roomsFromFloor";
    }
}
