package com.example.art_backend.utils;

import com.example.art_backend.exception.BaseException;
import com.example.art_backend.response.ResponseCode;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;

public class ArtFirebaseToken {
    FirebaseToken firebaseToken;

    public FirebaseToken getFirebaseToken(String token) throws FirebaseAuthException {
        try{
            this.firebaseToken = FirebaseAuth.getInstance().verifyIdToken(token);
        }catch (Exception e){
            throw new BaseException(ResponseCode.JWT_FALSE);
        }
        return firebaseToken;
    }
}
