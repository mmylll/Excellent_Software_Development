package com.example.art_backend.repository;

import com.example.art_backend.model.Painting;
import com.example.art_backend.model.PaintingSubject;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PaintingSubjectRepository extends JpaRepository<PaintingSubject,Integer> {


}
