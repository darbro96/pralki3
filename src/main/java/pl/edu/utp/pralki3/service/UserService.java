package pl.edu.utp.pralki3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import pl.edu.utp.pralki3.entity.Role;
import pl.edu.utp.pralki3.entity.Room;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.repository.RoleRepository;
import pl.edu.utp.pralki3.repository.UserRepository;

import javax.transaction.Transactional;
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
        user.setRoom(roomService.findByNumber(user.getNumberOfRoom(), user.getDormitory()));
        userRepository.save(user);
    }

    public void updateUserPassword(String newPassword, String email) {
        userRepository.updateUserPassword(bCryptPasswordEncoder.encode(newPassword), email);
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
        userRepository.updateName(user.getName(), user.getEmail());
        userRepository.updateLastName(user.getLastName(), user.getEmail());
        userRepository.updateDormitory(user.getDormitory(), user.getEmail());
        userRepository.updateRoom(user.getRoom().getIdRoom(), user.getEmail());
    }

    public void deleteUser(User user) {
        userRepository.deleteFromUserRole(user.getIdUser());
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
    }

    public void deactivateUser(User user) {
        user.setActive(0);
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
        return findAll().stream().filter(u -> u.getRoom() != null && u.getRoom().getIdRoom() == room.getIdRoom()).collect(Collectors.toList());
    }
}
