package com.example.art_backend.service;

import com.example.art_backend.repository.ErasRepository;
import com.example.art_backend.repository.PaintingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ErasService {

    @Autowired
    private ErasRepository erasRepository;

    public String getTime(int yearOfWork){
        return erasRepository.findByStartYearLessThanEqualAndEndYearGreaterThan(yearOfWork,yearOfWork).getEraName();
    }
}
