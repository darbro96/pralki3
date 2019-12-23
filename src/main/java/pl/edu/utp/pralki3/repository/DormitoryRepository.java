package pl.edu.utp.pralki3.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.edu.utp.pralki3.entity.Dormitory;

public interface DormitoryRepository extends JpaRepository<Dormitory, Integer> {
    Dormitory findByName(String name);
}
