package pl.edu.utp.pralki3.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Getter
@Setter
@Table(name = "laundry")
public class Laundry {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_laundry")
    private int idLaundry;
    @Column(name = "number_laundry")
    @NotNull
    private String numberLaundry;
    @ManyToOne
    @JoinColumn(name = "id_dormitory")
    @NotNull
    private Dormitory dormitory;
    @Transient
    private String nameOfDormitory;
}
