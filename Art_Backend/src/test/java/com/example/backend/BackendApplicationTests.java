package com.example.backend;

import com.example.art_backend.repository.PaintingRepository;
import com.example.art_backend.service.PaintingService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class BackendApplicationTests {

//    @Autowired
    private PaintingService paintingRepository;

    @Test
    void contextLoads() {
        System.out.println(paintingRepository.getSearchPaintings("a",6));
    }

}
