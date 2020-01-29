package pl.edu.utp.pralki3.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@Table(name = "log")
public class Log {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_log")
    private int idLog;
    @OneToOne
    @JoinColumn(name = "user_id")
    @NotNull
    private User user;
    @Column(name = "date_and_time")
    private LocalDateTime dateAndTime;
    @Column(name = "description")
    private String description;
}
