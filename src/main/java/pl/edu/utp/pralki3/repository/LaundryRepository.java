package pl.edu.utp.pralki3.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.edu.utp.pralki3.entity.Laundry;

public interface LaundryRepository extends JpaRepository<Laundry, Integer> {
    Laundry findByNumberLaundry(String numberLaundry);
}
