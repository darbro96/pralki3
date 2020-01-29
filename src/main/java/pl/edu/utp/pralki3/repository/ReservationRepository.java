package pl.edu.utp.pralki3.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import pl.edu.utp.pralki3.entity.Reservation;

public interface ReservationRepository extends JpaRepository<Reservation, Integer> {

    @Modifying
    @Query("UPDATE Reservation r SET r.keyReturned= :value WHERE r.idReservation= :id")
    void updateKeyReturned(@Param("value") boolean value, @Param("id") int id);
}
