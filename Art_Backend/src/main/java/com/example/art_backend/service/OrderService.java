package com.example.art_backend.service;

import com.example.art_backend.model.Cart;
import com.example.art_backend.model.Order;
import com.example.art_backend.repository.OrderRepository;
import com.example.art_backend.repository.PaintingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    public Order addToOrder(int paintingId,  String userEmail,double money){
        Order order = new Order(paintingId,userEmail,new Date(),money);
        return orderRepository.save(order);
    }

    public List<Order> getAllOrderByUserEmail(String userEmail){
        return orderRepository.getAllByUserEmail(userEmail);
    }

    public Order deleteOrderById(int orderId){
        return deleteOrderById(orderId);
    }
}
