package pl.edu.utp.pralki3.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import pl.edu.utp.pralki3.entity.Laundry;

import java.util.List;

public interface LaundryRepository extends JpaRepository<Laundry, Integer> {
}
