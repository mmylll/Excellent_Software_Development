package com.example.art_backend.repository;

import com.example.art_backend.model.Cart;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CartRepository extends JpaRepository<Cart,Integer> {

    List<Cart> findAllByUserEmail(String userEmail);

    void deleteById(Integer id);

    Cart findByPaintingIdAndUserEmail(Integer paintingId, String userEmail);

    List<Cart> findAllByUserEmailAndValid(String userEmail, Boolean valid);

    List<Cart> findAllByPaintingId(Integer paintingId);
}
