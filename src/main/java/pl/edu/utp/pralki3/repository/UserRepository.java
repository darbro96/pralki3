package pl.edu.utp.pralki3.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import pl.edu.utp.pralki3.entity.User;

public interface UserRepository extends JpaRepository<User, Integer> {
    User findByEmail(String email);

    @Modifying
    @Query("UPDATE User u SET u.password = :newPassword WHERE u.email= :email")
    void updateUserPassword(@Param("newPassword") String password, @Param("email") String email);

    @Query(value = "SELECT * FROM User u ORDER BY u.last_name", nativeQuery = true)
    Page<User> findAll(Pageable pageable);

    @Query(value = "SELECT * FROM User u WHERE u.name LIKE %:param% OR u.last_name LIKE %:param% OR u.email LIKE %:param% ORDER BY u.last_name", nativeQuery = true)
    Page<User> findAll(Pageable pageable, @Param("param") String param);
}
