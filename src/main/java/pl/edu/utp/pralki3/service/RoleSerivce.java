package pl.edu.utp.pralki3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.edu.utp.pralki3.entity.Role;
import pl.edu.utp.pralki3.repository.RoleRepository;

import java.util.List;

@Service
public class RoleSerivce {
    @Autowired
    private RoleRepository roleRepository;

    public List<Role> findAll() {
        return roleRepository.findAll();
    }

    public Role findByRole(String role) {
        return roleRepository.findByRole(role);
    }

    public Role findById(int id) {
        return roleRepository.getOne(id);
    }
}
