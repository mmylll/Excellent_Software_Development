package com.example.art_backend.interceptor;

import com.example.art_backend.exception.BaseException;
import com.example.art_backend.response.ResponseCode;
import com.example.art_backend.utils.ArtFirebaseToken;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseToken;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 拦截器：验证用户是否登录
 */

public class UserLoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //http的header中获得token
        String token = request.getHeader("Authorization");
//        System.out.println(token);
        //token不存在
        if (token == null || token.equals(""))
            throw new BaseException(ResponseCode.LOGIN_NOT);
        //验证token
//        System.out.println(token);
        ArtFirebaseToken artFirebaseToken = new ArtFirebaseToken();
        FirebaseToken decodedToken = artFirebaseToken.getFirebaseToken(token);
//        System.out.println(decodedToken.getUid());
        decodedToken.getUid();
        return true;
    }
}
