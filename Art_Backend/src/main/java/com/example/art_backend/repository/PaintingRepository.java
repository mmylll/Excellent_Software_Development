package com.example.art_backend.repository;

import com.example.art_backend.model.Painting;
import com.example.art_backend.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PaintingRepository extends JpaRepository<Painting,Integer> {

    @Override
    List<Painting> findAll();

//    List<Painting> findByTitleLikeOrArtist_FirstNameLikeOrArtist_LastNameLike(String title, String artist_firstName, String artist_lastName);

    Page<Painting> findByTitleLikeOrArtist_FirstNameLikeOrArtist_LastNameLike(String title, String artist_firstName, String artist_lastName, Pageable pageable);

    int countByTitleLikeOrArtist_FirstNameLikeOrArtist_LastNameLike(String title, String artist_firstName, String artist_lastName);

    Painting findByPaintingId(Integer paintingId);


//    int countByTitleContaining(String title);
//    int count();
}
