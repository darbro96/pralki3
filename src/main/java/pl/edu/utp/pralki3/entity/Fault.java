package pl.edu.utp.pralki3.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@Table(name = "fault")
public class Fault {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_fault")
    private int idFault;
    @Column(name = "date_of_notification")
    private LocalDateTime dateOfNotification;
    @Column(name = "description")
    private String description;
    @OneToOne
    @JoinColumn(name = "user_id")
    @NotNull
    private User user;
    @Column(name = "done")
    @NotNull
    private boolean done = false;
    @Transient
    private String userEmail;
}
