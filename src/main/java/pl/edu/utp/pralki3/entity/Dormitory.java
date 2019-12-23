package pl.edu.utp.pralki3.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Getter
@Setter
@Table(name = "dormitory")
public class Dormitory {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_dormitory")
    private int idDormitory;
    @Column(name = "name")
    private String name;
}
