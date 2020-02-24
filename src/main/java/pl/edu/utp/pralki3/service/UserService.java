package pl.edu.utp.pralki3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import pl.edu.utp.pralki3.entity.*;
import pl.edu.utp.pralki3.mailSender.MyMailSender;
import pl.edu.utp.pralki3.model.UserUtilities;
import pl.edu.utp.pralki3.repository.RoleRepository;
import pl.edu.utp.pralki3.repository.UserRepository;

import javax.annotation.PostConstruct;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class UserService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    @Autowired
    private DormitoryService dormitoryService;
    @Autowired
    private RoomService roomService;
    @Autowired
    private ReservationService reservationService;
    @Autowired
    private MyMailSender mailSender;
    @Autowired
    private LogService logService;

    public User findUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public void saveUser(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setActive(1);
        Role role = roleRepository.findByRole(user.getNameOfRole());
        user.setNrRoli(role.getIdRole());
        user.setRoles(new HashSet<>(Arrays.asList(role)));
        user.setDormitory(dormitoryService.findByName(user.getNameOfDormitory()));
        user.setKeptKey(false);
        if (user.getNumberOfRoom() != null)
            user.setRoom(roomService.findByNumber(user.getNumberOfRoom(), user.getDormitory()));
        userRepository.save(user);
        if (UserUtilities.getLoggedUser() != null)
            logService.saveLog(findUserByEmail(UserUtilities.getLoggedUser()), "Utworzono użytkownika id: " + findUserByEmail(user.getEmail()).getIdUser());
    }

    public void updateUserPassword(String newPassword, String email) {
        userRepository.updateUserPassword(bCryptPasswordEncoder.encode(newPassword), email);
        logService.saveLog(findUserByEmail(UserUtilities.getLoggedUser()), "Zmiana hasła użytkownika id: " + findUserByEmail(email).getIdUser());
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public Page<User> findAll(Pageable pageable) {
        return updatePages(userRepository.findAll(pageable));
    }

    public Page<User> findAll(Pageable pageable, String word) {
        return updatePages(userRepository.findAll(pageable, word));
    }

    public User get(int id) {
        return userRepository.getOne(id);
    }

    public void updateUser(User user) {
        Role role = roleRepository.findByRole(user.getNameOfRole());
        user.setNrRoli(role.getIdRole());
        user.setRoles(new HashSet<>(Arrays.asList(role)));
        user.setDormitory(dormitoryService.findByName(user.getNameOfDormitory()));
        user.setRoom(roomService.findByNumber(user.getNumberOfRoom(), user.getDormitory()));
        userRepository.updateMail(user.getEmail(), user.getIdUser());
        userRepository.updateName(user.getName(), user.getEmail());
        userRepository.updateLastName(user.getLastName(), user.getEmail());
        userRepository.updateDormitory(user.getDormitory(), user.getEmail());
        if (user.getRoom() != null) {
            userRepository.updateRoom(user.getRoom().getIdRoom(), user.getEmail());
        }
        logService.saveLog(findUserByEmail(UserUtilities.getLoggedUser()), "Zaktualizowano dane użytkownika id: " + user.getIdUser());
    }

    public void deleteUser(User user) {
        logService.deleteByUser(user);
        userRepository.deleteReservationOfUser(user.getIdUser());
        userRepository.deleteFromUserRole(user.getIdUser());
        logService.saveLog(findUserByEmail(UserUtilities.getLoggedUser()), "Usunięto użytkownika id: " + user.getIdUser());
        userRepository.deleteFromUser(user.getIdUser());
    }

    private Page<User> updatePages(Page<User> pages) {
        for (User u : pages) {
            u.setNrRoli(u.getRoles().iterator().next().getIdRole());
        }
        return pages;
    }

    public void activateUser(User user) {
        user.setActive(1);
        String subject = "Odblokowano konto";
        String content = "Twoje konto zostało odblokowane.";
        mailSender.send(user.getEmail(), subject, content);
        logService.saveLog(findUserByEmail(UserUtilities.getLoggedUser()), "Aktywowano konto użytkownika id: " + user.getIdUser());
    }

    public void deactivateUser(User user) {
        user.setActive(0);
        String subject = "Blokada konta";
        String content = "Twoje konto zostało zablokowane. Logowanie do serwisu jest niemożliwe. W celu odzyskania dostępu skontaktuj się z administracją.";
        mailSender.send(user.getEmail(), subject, content);
        logService.saveLog(findUserByEmail(UserUtilities.getLoggedUser()), "Dezktywowano konto użytkownika id: " + user.getIdUser());
    }

    public void updateCardId(User user) {
        userRepository.updateCardId(user.getCardId(), user.getEmail());
    }

    public void clearCardId(User user) {
        userRepository.clearCardId(user.getEmail());
    }

    public boolean checkCard(String idCard) {
        for (User u : findAll()) {
            if (u.getCardId() != null && idCard.equals(u.getCardId())) {
                return false;
            }
        }
        return true;
    }

    public List<User> findUsersFromRoom(Room room) {
        if (room == null)
            return new ArrayList<>();
        else
            return findAll().stream().filter(u -> u.getRoom() != null && u.getRoom().getIdRoom() == room.getIdRoom()).collect(Collectors.toList());
    }

    public void checkOut(User user) {
        userRepository.updateRoomSetNull(user.getEmail());
    }

    public List<User> getUsersFromRoom(Room room) {
        return findAll().stream().filter(u -> u.getRoom() != null).filter(u -> u.getRoom().getIdRoom() == room.getIdRoom()).collect(Collectors.toList());
    }

    public void checkIn(User user, Room room) {
        userRepository.updateRoom(room.getIdRoom(), user.getEmail());
        logService.saveLog(findUserByEmail(UserUtilities.getLoggedUser()), "Zakwaterowano użytkownika id: " + user.getIdUser() + " do pokoju " + room.getNumber());
    }

    public void reportKeyRetention(User user) {
        deactivateUser(user);
        userRepository.setKeyKept(user.getEmail());
        List<Reservation> reservations = reservationService.findByUser(user);
        for (Reservation r : reservations) {
            reservationService.deactivateReservation(r.getIdReservation());
        }
        String subject = "Blokada konta";
        String content = "<b>Twoje konto zostało zablokowane z powodu przetrzymania klucza!</b><br><br>W celu odblokowania konta oddaj klucz do recepcji, a następnie udaj się do administracji.";
        mailSender.send(user.getEmail(), subject, content);
    }

    public List<User> findUnactiveUsers() {
        List<User> users = findAll().stream().filter(u -> u.getActive() == 0).collect(Collectors.toList());
        return users;
    }

    public void deleteKeyRetention(User user) {
        userRepository.setNoKeyKept(user.getEmail());
        logService.saveLog(findUserByEmail(UserUtilities.getLoggedUser()), "Odebrano zaległy klucz od pralki od użytkownika użytkownika id: " + user.getIdUser());
    }

    public int getAmountOfUsers() {
        return userRepository.findAll().size();
    }

    public void updateAdminPasswordIfDatabaseEmpty() {
        if (getAmountOfUsers() == 0) {
            User user = new User();
            user.setName("Admin");
            user.setLastName("Admin");
            user.setEmail("admin@mail.com");
            user.setSex("M");
            user.setNationality("PL");
            user.setKeptKey(false);
            user.setNameOfRole("ROLE_ADMIN");
            user.setPassword("haslo123");
            saveUser(user);
        }
    }
}
