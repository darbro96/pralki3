package pl.edu.utp.pralki3.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import pl.edu.utp.pralki3.entity.Room;

import java.util.List;

public interface RoomRepository extends JpaRepository<Room, Integer> {

    @Query("FROM Room r ORDER BY r.number")
    List<Room> findAllRooms();

    @Query("FROM Room  r WHERE r.idCard= :card")
    Room findByCard(@Param("card") String card);

    @Modifying
    @Query("UPDATE Room r SET r.idCard= :card WHERE r.idRoom= :idRoom")
    void setRoomCard(@Param("card") String card, @Param("idRoom") int idRoom);
}
