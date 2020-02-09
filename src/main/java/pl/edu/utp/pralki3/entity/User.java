package pl.edu.utp.pralki3.entity;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

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
    @Column(name = "sex")
    @NotNull
    private String sex;
    @Column(name = "nationality")
    @NotNull
    private String nationality;
    @Column(name = "active")
    @NotNull
    private int active;
    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "role_id"))
    private Set<Role> roles;
    @ManyToOne
    @JoinColumn(name = "id_dormitory")
    private Dormitory dormitory;
    @Column(name = "card_id")
    private String cardId;
    @ManyToOne
    @JoinColumn(name = "id_room")
    private Room room;
    @Column(name = "kept_key")
    private boolean keptKey = false;
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
    @Transient
    private String numberOfRoom;
    @Transient
    private MultipartFile fileName;
}
