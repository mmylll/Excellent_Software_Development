package com.example.art_backend.repository;

import com.example.art_backend.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User,Integer> {

    Boolean existsUserByUsername(String username);

    Boolean existsUserByEmail(String email);

    User findByUsername(String username);

    User findByEmail(String email);
}
