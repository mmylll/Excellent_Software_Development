package com.example.art_backend.service;

import com.example.art_backend.exception.BaseException;
import com.example.art_backend.model.Cart;
import com.example.art_backend.model.Order;
import com.example.art_backend.model.Painting;
import com.example.art_backend.model.User;
import com.example.art_backend.repository.CartRepository;
import com.example.art_backend.repository.OrderRepository;
import com.example.art_backend.repository.PaintingRepository;
import com.example.art_backend.repository.UserRepository;
import com.example.art_backend.response.ResponseCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class CartService {

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private PaintingRepository paintingRepository;

    public Cart addToCart(int paintingId,double money,String userEmail){
        Cart cart1 = cartRepository.findByPaintingIdAndUserEmail(paintingId,userEmail);
        if(cart1 == null){
            Cart cart = new Cart(userEmail,paintingId,money);
            return cartRepository.save(cart);
        }else{
            return cart1;
        }

    }

    public List<Cart> getAllCartByUserEmail(String email){
        return cartRepository.findAllByUserEmail(email);
    }

    public void deleteCartById(int id){
        cartRepository.deleteById(id);
    }

    public String payment(double totalMoney,String email){
        List<Cart> list = cartRepository.findAllByUserEmailAndValid(email,true);
        User user = userRepository.findByEmail(email);
        if(user.getBalance() < totalMoney) {
            throw new BaseException(ResponseCode.INSUFFICIENT_BALANCE);
        }
        int allMoney = 0;
        if(list != null){
            for (Cart cart : list) {
                Date date = new Date();
                Order order = new Order(cart.getPaintingId(), email, date, cart.getMoney());
                System.out.println(order);
                orderRepository.save(order);
                Painting painting = paintingRepository.findByPaintingId(cart.getPaintingId());
                painting.setSell(true);
                paintingRepository.save(painting);
                List<Cart> list1 = cartRepository.findAllByPaintingId(order.getPaintingId());
                for (Cart cart1 : list1){
                    cart1.setValid(false);
                    cartRepository.save(cart1);
                }
                allMoney += order.getMoney();
            }
            cartRepository.deleteAll(list);


            user.setBalance(user.getBalance() - allMoney);
            userRepository.save(user);
            if(totalMoney > allMoney){
                return "Some orders are invalid and payment is successful!";
            }
            return "success";
        }else{
            return "no things";
        }
    }

}
