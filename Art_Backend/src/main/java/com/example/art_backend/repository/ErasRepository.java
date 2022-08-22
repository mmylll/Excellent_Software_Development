package com.example.art_backend.repository;

import com.example.art_backend.model.Eras;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ErasRepository extends JpaRepository<Eras,Integer> {

    Eras findByStartYearLessThanEqualAndEndYearGreaterThan(Integer startYear, Integer endYear);
}
