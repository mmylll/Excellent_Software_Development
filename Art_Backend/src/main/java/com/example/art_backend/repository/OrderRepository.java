package com.example.art_backend.repository;

import com.example.art_backend.model.Order;
import com.example.art_backend.model.Painting;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order,Integer> {

    List<Order> getAllByUserEmail(String userEmail);

    Order deleteByOrderId(Integer orderId);
}
