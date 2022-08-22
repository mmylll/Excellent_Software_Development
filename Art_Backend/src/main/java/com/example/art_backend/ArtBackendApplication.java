package com.example.art_backend;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

@SpringBootApplication
public class ArtBackendApplication {

    public static void main(String[] args) throws IOException {
        FileInputStream serviceAccount =
                new FileInputStream("src/main/resources/serviceAccountKey.json");
//                new FileInputStream("serviceAccountKey.json");

        FirebaseOptions options = new FirebaseOptions.Builder()
                .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                .setDatabaseUrl("https://art-store-d1a02-default-rtdb.firebaseio.com")
                .build();

        try {
            FirebaseApp.initializeApp(options);
        }catch (Exception e){
            System.out.println(e);
        }
        SpringApplication.run(ArtBackendApplication.class, args);
    }

}
