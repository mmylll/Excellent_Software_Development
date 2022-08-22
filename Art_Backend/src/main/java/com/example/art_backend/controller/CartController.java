package com.example.art_backend.controller;

import com.example.art_backend.annotation.BaseResponse;
import com.example.art_backend.model.Cart;
import com.example.art_backend.response.ResponseResult;
import com.example.art_backend.service.CartService;
import com.example.art_backend.service.PaintingService;
import com.google.rpc.context.AttributeContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@BaseResponse
@RestController
public class CartController {

    @Autowired
    private CartService cartService;

    @PostMapping("addToCart")
    public Cart addToCart(HttpServletRequest request){
        return cartService.addToCart(Integer.parseInt(request.getParameter("paintingId")),Double.parseDouble(request.getParameter("money")),request.getParameter("email"));
    }

    @ResponseBody
    @GetMapping("getAllCartByUserEmail")
    public List<Cart> getAllCartByUserEmail(HttpServletRequest request){
        return cartService.getAllCartByUserEmail(request.getParameter("email"));
    }

    @PostMapping("deleteCartById")
    public void deleteCartById(HttpServletRequest request){
        cartService.deleteCartById(Integer.parseInt(request.getParameter("id")));
    }

    @PostMapping("payment")
    public ResponseResult payment(HttpServletRequest request){
        return new ResponseResult(cartService.payment(Double.parseDouble(request.getParameter("totalMoney")),request.getParameter("email")));
    }


}
