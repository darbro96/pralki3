package pl.edu.utp.pralki3.model;

import lombok.Getter;
import lombok.Setter;
import pl.edu.utp.pralki3.entity.Room;
import pl.edu.utp.pralki3.entity.User;

import java.util.List;

@Getter
@Setter
public class RoomWithResidents {
    private Room room;
    private List<User> users;
}
