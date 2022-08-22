package com.example.art_backend.service;

import com.example.art_backend.exception.BaseException;
import com.example.art_backend.model.User;
import com.example.art_backend.repository.UserRepository;
import com.example.art_backend.response.ResponseCode;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.UserRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public String register(String username,String password,String email,String address,String phone) throws FirebaseAuthException {
        UserRecord userRecord;
        if(userRepository.existsUserByUsername(username)){
            throw new BaseException(ResponseCode.REGISTER_USERNAME_DUPLICATE);
        }else if(userRepository.existsUserByEmail(email)){
            throw new BaseException(ResponseCode.REGISTER_EMAIL_DUPLICATE);
        }else{
            User user = new User(username,password,email,address,phone, (double) 0,"https://firebasestorage.googleapis.com/v0/b/art-store-d1a02.appspot.com/o/uploads%2Fdefault_user.jpeg?alt=media&token=eb10e5da-c721-4a77-a4cb-d1e478e2ae2f");
//            UserRecord.CreateRequest request = new UserRecord.CreateRequest()
//                    .setEmail(email)
//                    .setEmailVerified(false)
//                    .setPassword(password)
//                    .setDisplayName(username)
//                    .setDisabled(false);
//            try {
//                userRecord = FirebaseAuth.getInstance().createUser(request);
//            }catch (FirebaseAuthException e){
//                throw new BaseException(ResponseCode.INVALID_EMAIL);
//            }
            try {
                userRepository.save(user);
            }catch (Exception e){
                throw new BaseException(ResponseCode.REGISTER_FALSE);
            }
//            return JWTUtils.createToken(username);
            return user.getUsername();
        }
    }

    public User login(String username){
        User user = userRepository.findByUsername(username);
        if(user == null){
            throw new BaseException(ResponseCode.LOGIN_FALSE);
        }
        return user;
    }

    public User getArtUserByEmail(String email){
        return userRepository.findByEmail(email);
    }

    public User recharge(String email,double addBalance){
        System.out.println("email" + email);
        User user = userRepository.findByEmail(email);
        System.out.println("------------------------------+++++++");
        System.out.println(user.toString());
        user.setBalance(
                user.getBalance()
                + addBalance);
        return userRepository.save(user);
    }

    public User uploadImage(String imageUrl,String email){
        User user = userRepository.findByEmail(email);
        user.setPhotoUrl(imageUrl);
        return userRepository.save(user);
    }

    public User getArtUserByUsername(String username){
        return userRepository.findByUsername(username);
    }
}
