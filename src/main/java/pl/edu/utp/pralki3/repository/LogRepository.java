package pl.edu.utp.pralki3.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import pl.edu.utp.pralki3.entity.Log;

public interface LogRepository extends JpaRepository<Log, Integer> {
    @Modifying
    @Query(value = "DELETE FROM log WHERE user_id=:userId", nativeQuery = true)
    void deleteLogOfUser(@Param("userId") int userId);
}
