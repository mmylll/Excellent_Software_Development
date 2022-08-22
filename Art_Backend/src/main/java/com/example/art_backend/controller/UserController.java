package com.example.art_backend.controller;
import com.example.art_backend.annotation.BaseResponse;

import com.example.art_backend.model.Token;
import com.example.art_backend.model.User;
import com.example.art_backend.response.ResponseResult;
import com.example.art_backend.service.UserService;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * user接口
 */

@BaseResponse
@RestController
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("Register")
    public ResponseResult register(HttpServletResponse response, @RequestBody User user) throws FirebaseAuthException {
        response.setHeader("uid",userService.register(user.getUsername(),user.getPassword(),user.getEmail(),user.getAddress(),user.getPhone()));
        return new ResponseResult("注册成功");
    }

    @PostMapping("Login")
    public User login(HttpServletResponse response, HttpServletRequest request){
        return userService.login(request.getParameter("username"));
    }

    @PostMapping("GetToken")
    public String getToken(@RequestBody Token token) throws FirebaseAuthException {
        System.out.println(token.toString());
        FirebaseToken decodedToken = FirebaseAuth.getInstance().verifyIdToken(token.getToken());
        String uid = decodedToken.getUid();
        System.out.println(decodedToken.getEmail());
        return uid;
    }

    @ResponseBody
    @GetMapping("getArtUserByEmail")
    public User getArtUserByEmail(HttpServletRequest request){

        return userService.getArtUserByEmail(request.getParameter("email"));
    }

    @PostMapping("recharge")
    public User recharge(HttpServletRequest request){
        return userService.recharge(request.getParameter("email"),Double.parseDouble(request.getParameter("addBalance")));
    }

    @PostMapping("uploadImage")
    public User uploadImage(HttpServletRequest request){
        return userService.uploadImage(request.getParameter("photoUrl"),request.getParameter("email"));
    }

    @ResponseBody
    @GetMapping("getArtUserByUsername")
    public User getArtUserByUsername(HttpServletRequest request){
        return userService.getArtUserByUsername(request.getParameter("username"));
    }
}