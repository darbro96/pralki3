package pl.edu.utp.pralki3.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Getter
@Setter
@Table(name = "washer")
public class Washer {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_washer")
    private int idWasher;
    @Column(name = "number_washer")
    @NotNull
    private String numberWasher;
    @ManyToOne
    @JoinColumn(name = "id_laundry")
    private Laundry laundry;
    @Transient
    private int idOfLaundry;
}
