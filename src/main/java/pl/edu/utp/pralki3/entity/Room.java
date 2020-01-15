package pl.edu.utp.pralki3.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Getter
@Setter
@Table(name = "room")
public class Room {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_room")
    private int idRoom;
    @Column(name = "number")
    private String number;
    @ManyToOne
    @JoinColumn(name = "id_room_type")
    @NotNull
    private RoomType roomType;
    @ManyToOne
    @JoinColumn(name = "id_dormitory")
    @NotNull
    private Dormitory dormitory;
    @Column(name = "capacity")
    @NotNull
    private int capacity;
    @Column(name = "id_card")
    private String idCard;
    @Transient
    private int idRoomType;
    @Transient
    private String nameOfDormitory;
}
