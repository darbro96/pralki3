package pl.edu.utp.pralki3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import pl.edu.utp.pralki3.entity.Role;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.repository.RoleRepository;
import pl.edu.utp.pralki3.repository.UserRepository;

import javax.transaction.Transactional;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

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
        userRepository.updateName(user.getName(), user.getEmail());
        userRepository.updateLastName(user.getLastName(), user.getEmail());
        userRepository.updateDormitory(user.getDormitory(), user.getEmail());
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
}
