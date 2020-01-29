package pl.edu.utp.pralki3.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@Table(name = "reservation")
public class Reservation {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_reservation")
    private int idReservation;
    @OneToOne
    @JoinColumn(name = "user_id")
    @NotNull
    private User user;
    @OneToOne
    @JoinColumn(name = "id_washer")
    @NotNull
    private Washer washer;
    @Column(name = "start")
    @NotNull
    private LocalDateTime start;
    @Column(name = "stop")
    @NotNull
    private LocalDateTime stop;
    @Column(name = "active")
    @NotNull
    private boolean active = true;
    @Column(name = "key_returned")
    private boolean keyReturned = false;
    @Transient
    private String username;
    @Transient
    private String washerId;
    @Transient
    private String dateStart;
    @Transient
    private String timeStart;
    @Transient
    private String duration;
    @Transient
    private boolean afterTime;

    @Override
    public String toString() {
        return "Reservation{" +
                "idReservation=" + idReservation +
                ", user=" + user +
                ", washer=" + washer +
                ", start=" + start +
                ", stop=" + stop +
                ", username'" + username + '\'' +
                ", washerId='" + washerId + '\'' +
                ", dateStart='" + dateStart + '\'' +
                ", timeStart='" + timeStart + '\'' +
                ", duration='" + duration + '\'' +
                '}';
    }
}
