package com.example.art_backend.service;

import com.example.art_backend.model.Painting;
import com.example.art_backend.repository.PaintingRepository;
import com.example.art_backend.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PaintingService {

    @Autowired
    private PaintingRepository paintingRepository;

    public List<Painting> getPopularPaintings(){
        Sort sort = Sort.by(Sort.Direction.DESC,"Views");
        PageRequest pagerequest = PageRequest.of(0,3,sort);
        return paintingRepository.findAll(pagerequest).getContent();
    }

    public List<Painting> getAllPaintings(int pageIndex){
        System.out.println("**********************");
        System.out.println(pageIndex);
        PageRequest pagerequest = PageRequest.of(pageIndex-1,6);
        return paintingRepository.findAll(pagerequest).getContent();
    }

    public long getAllPaintingsCount(){
        return paintingRepository.count();
    }

    public List<Painting> getAllPaintingsAndSort(int pageIndex,int sortId){
        String sortName;
        Sort sort;
        if(sortId == 0){
            return getAllPaintings(pageIndex);
        }else if(sortId == 1){
            sortName = "Views";
        }else if(sortId == 2){
            sortName = "Title";
        }else{
            sortName = "Cost";
        }
        if(sortId == 2){
            sort = Sort.by(Sort.Direction.ASC,sortName);
        }else{
            sort = Sort.by(Sort.Direction.DESC,sortName);
        }
        PageRequest pagerequest = PageRequest.of(pageIndex-1,6,sort);
        return paintingRepository.findAll(pagerequest).getContent();
    }

    //直接搜索
    public List<Painting> getSearchPaintings(String search,int pageIndex){
        System.out.println("++++++++++++");
        System.out.println(search);
        PageRequest pagerequest = PageRequest.of(pageIndex-1,6);
//        System.out.println(paintingRepository.findByTitleLikeOrArtist_FirstNameLikeOrArtist_LastNameLike("%"+search+"%","%"+search+"%","%"+search+"%").);
        return paintingRepository.findByTitleLikeOrArtist_FirstNameLikeOrArtist_LastNameLike("%"+search+"%","%"+search+"%","%"+search+"%",pagerequest).getContent();
    }

    //排序搜索
    public List<Painting> getSearchPaintingsAndSort(String search,int pageIndex,int sortId){
        String sortName;
        if(sortId == 0){
            return getSearchPaintings(search,pageIndex);
        }else if(sortId == 1){
            sortName = "Views";
        }else if(sortId == 2){
            sortName = "Title";
        }else{
            sortName = "Cost";
        }
        Sort sort = Sort.by(Sort.Direction.DESC,sortName);
        PageRequest pagerequest = PageRequest.of(pageIndex-1,6,sort);
        return paintingRepository.findByTitleLikeOrArtist_FirstNameLikeOrArtist_LastNameLike("%"+search+"%","%"+search+"%","%"+search+"%",pagerequest).getContent();
    }

    public int getSearchPaintingsCount(String search){
        System.out.println("--------------------");
        System.out.println(search);
        return paintingRepository.countByTitleLikeOrArtist_FirstNameLikeOrArtist_LastNameLike("%"+search+"%","%"+search+"%","%"+search+"%");
//        return paintingRepository.countByTitleContaining("asd");
    }

    public Painting updateViews(int paintingId){
        Painting painting = paintingRepository.findByPaintingId(paintingId);
        painting.setViews(painting.getViews()+1);
        return paintingRepository.save(painting);
    }

}
