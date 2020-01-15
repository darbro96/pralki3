package pl.edu.utp.pralki3.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Getter
@Setter
@Table(name = "room_type")
public class RoomType {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_room_type")
    private int idRoomType;
    @Column(name = "type")
    @NotNull
    private String type;
}
