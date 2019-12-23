package pl.edu.utp.pralki3.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Set;

@Entity
@Getter
@Setter
@Table(name = "user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "user_id")
    private int idUser;
    @Column(name = "email")
    @NotNull
    private String email;
    @Column(name = "password")
    @NotNull
    private String password;
    @Column(name = "name")
    @NotNull
    private String name;
    @Column(name = "last_name")
    @NotNull
    private String lastName;
    @Column(name = "active")
    @NotNull
    private int active;
    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "role_id"))
    private Set<Role> roles;
    @ManyToOne
    @JoinColumn(name = "id_dormitory")
    private Dormitory dormitory;
    @Transient
    private String operacja;
    @Transient
    private int nrRoli;
    @Transient
    private String newPassword;
    @Transient
    private String nameOfDormitory;
    @Transient
    private String nameOfRole;

}
