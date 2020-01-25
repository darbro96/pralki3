package pl.edu.utp.pralki3.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "role")
@Getter
@Setter
public class Role {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "role_id")
    private int idRole;
    @Column(name = "role")
    private String role;
    @Column(name = "description")
    private String description;
}
