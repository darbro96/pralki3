package pl.edu.utp.pralki3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.edu.utp.pralki3.entity.Dormitory;
import pl.edu.utp.pralki3.entity.Room;
import pl.edu.utp.pralki3.entity.RoomType;
import pl.edu.utp.pralki3.repository.RoomRepository;
import pl.edu.utp.pralki3.repository.RoomTypeRepository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class RoomService {
    @Autowired
    private RoomRepository roomRepository;

    @Autowired
    private RoomTypeRepository roomTypeRepository;

    @Autowired
    private DormitoryService dormitoryService;

    public List<Room> findAllRooms() {
        return roomRepository.findAll();
    }

    public List<Room> findAllRoomsFromDormitory(Dormitory dormitory) {
        return findAllRooms().stream().filter(r -> r.getDormitory().getIdDormitory() == dormitory.getIdDormitory()).collect(Collectors.toList());
    }

    public List<RoomType> findAllTypes() {
        return roomTypeRepository.findAll();
    }

    public Room findByNumber(String number, Dormitory dormitory) {
        try {
            List<Room> rooms = findAllRoomsFromDormitory(dormitory);
            Optional<Room> optionalRoom = rooms.stream().filter(r -> r.getNumber().equals(number)).findFirst();
            if (optionalRoom.isPresent())
                return optionalRoom.get();
            else
                return null;
        } catch (NullPointerException ex) {
            return null;
        }
    }

    public void saveRoom(Room room) {
        room.setDormitory(dormitoryService.findByName(room.getNameOfDormitory()));
        room.setRoomType(roomTypeRepository.getOne(room.getIdRoomType()));
        roomRepository.save(room);
    }
}
