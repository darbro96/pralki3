package pl.edu.utp.pralki3.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import pl.edu.utp.pralki3.entity.Fault;

public interface FaultRepository extends JpaRepository<Fault, Integer> {
    @Modifying
    @Query("UPDATE Fault f SET f.done=true WHERE f.idFault= :id")
    void setFaultDone(@Param("id") int idFault);
}
