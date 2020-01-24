package pl.edu.utp.pralki3.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import pl.edu.utp.pralki3.entity.Washer;

public interface WasherRepository extends JpaRepository<Washer, Integer> {
    @Modifying
    @Query("UPDATE Washer w SET w.available = true WHERE w.idWasher = :washerId")
    void setAvailable(@Param("washerId") int washerId);

    @Modifying
    @Query("UPDATE Washer w SET w.available = false WHERE w.idWasher = :washerId")
    void setUnavailable(@Param("washerId") int washerId);

    @Modifying
    @Query("UPDATE Washer w SET w.numberWasher = :number WHERE w.idWasher = :washerId")
    void updateNumberOfWasher(@Param("number") String number, @Param("washerId") int washerId);
}
