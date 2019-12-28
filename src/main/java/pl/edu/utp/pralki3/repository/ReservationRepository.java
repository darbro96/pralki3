package pl.edu.utp.pralki3.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.edu.utp.pralki3.entity.Reservation;

public interface ReservationRepository extends JpaRepository<Reservation, Integer> {
}
