package com.example.art_backend.controller;

import com.example.art_backend.annotation.BaseResponse;
import com.example.art_backend.model.Cart;
import com.example.art_backend.model.Order;
import com.example.art_backend.service.CartService;
import com.example.art_backend.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@BaseResponse
@RestController
public class OrderController {
    @Autowired
    private OrderService orderService;

    @PostMapping("addToOrder")
    public Order addToOrder(HttpServletRequest request){
        return orderService.addToOrder(Integer.parseInt(request.getParameter("paintingId")),request.getParameter("email"),Double.parseDouble(request.getParameter("money")));
    }

    @ResponseBody
    @GetMapping("getAllOrderByUserEmail")
    public List<Order> getAllOrderByUserEmail(HttpServletRequest request){
        System.out.println("3333333");
        System.out.println(request.getParameter("email"));
        return orderService.getAllOrderByUserEmail(request.getParameter("email"));
    }

    @PostMapping("deleteOrderById")
    public Order deleteOrderById(HttpServletRequest request){
        return orderService.deleteOrderById(Integer.parseInt(request.getParameter("orderId")));
    }
}
