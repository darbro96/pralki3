package pl.edu.utp.pralki3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.edu.utp.pralki3.entity.Dormitory;
import pl.edu.utp.pralki3.entity.Room;
import pl.edu.utp.pralki3.entity.RoomType;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.repository.RoomRepository;
import pl.edu.utp.pralki3.repository.RoomTypeRepository;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Transactional
public class RoomService {
    @Autowired
    private RoomRepository roomRepository;

    @Autowired
    private RoomTypeRepository roomTypeRepository;

    @Autowired
    private DormitoryService dormitoryService;

    @Autowired
    private UserService userService;

    public List<Room> findAllRooms() {
        return roomRepository.findAllRooms();
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

    public boolean isResident(User user, String numberRoom) {
        Room room = findByNumber(numberRoom, user.getDormitory());
        if (user.getRoom() != null) {
            List<User> users = userService.findAll().stream().filter(u -> u.getRoom().getIdRoom() == room.getIdRoom()).collect(Collectors.toList());
            for (User u : users) {
                if (u.getIdUser() == user.getIdUser()) {
                    return true;
                }
            }
        }
        return false;
    }

    public List<Room> getRoomsFromFloor(Dormitory dormitory, int floor) {
        List<Room> rooms = findAllRoomsFromDormitory(dormitory);
        List<Room> roomsFromFloor = new ArrayList<>();
        for (Room r : rooms) {
            int roomNumber = Integer.parseInt(r.getNumber().substring(0, r.getNumber().length() - 1));
            if (roomNumber / 100 == floor) {
                roomsFromFloor.add(r);
            }
        }
        return roomsFromFloor;
    }

    public List<Room> adjustRoomToUser(User user) {
        List<Room> rooms = findAllRooms();
        List<Room> result = new ArrayList<>();
        for (Room r : rooms) {
            if (userService.getUsersFromRoom(r).size() < r.getCapacity()) {
                if (userService.getUsersFromRoom(r).size() == 0) {
                    result.add(r);
                } else {
                    boolean ok = false;
                    for (User u : userService.getUsersFromRoom(r)) {
                        if (u.getSex().equals(user.getSex()) && u.getNationality().equals(user.getNationality())) {
                            ok = true;
                        }
                    }
                    if (ok) {
                        result.add(r);
                    }
                }
            }
        }
        return result;
    }

    public Room getById(int id) {
        return roomRepository.getOne(id);
    }

    public void updateRoom(Room room) {
        roomRepository.setRoomCard(room.getIdCard(), room.getIdRoom());

    }

    public RoomType getRoomTypeById(int id) {
        return roomTypeRepository.getOne(id);
    }

    public Room getByCardId(String idCard)
    {
        return roomRepository.findByCard(idCard);
    }
}
