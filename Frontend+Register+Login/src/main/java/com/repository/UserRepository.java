package com.repository;

import com.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    // JPA built-in function to work with database
    User findByUsername(String username);
}
