package pl.edu.utp.pralki3.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.edu.utp.pralki3.entity.Role;

public interface RoleRepository extends JpaRepository<Role, Integer> {
    Role findByRole(String role);
}
