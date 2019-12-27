package pl.edu.utp.pralki3.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.edu.utp.pralki3.entity.Washer;

public interface WasherRepository extends JpaRepository<Washer, Integer> {
}
