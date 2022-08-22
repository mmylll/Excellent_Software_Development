package com.example.art_backend.controller;

import com.example.art_backend.annotation.BaseResponse;
import com.example.art_backend.model.Painting;
import com.example.art_backend.model.User;
import com.example.art_backend.response.ResponseResult;
import com.example.art_backend.service.PaintingService;
import com.google.firebase.auth.FirebaseAuthException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@BaseResponse
@RestController
public class PaintingController {

    @Autowired
    private PaintingService paintingService;

    @GetMapping("getPopularPaintings")
    public List<Painting> getPopularPaintings(HttpServletResponse response) throws FirebaseAuthException {
        return paintingService.getPopularPaintings();
    }

    @ResponseBody
    @GetMapping("getAllPaintings")
    public List<Painting> getAllPaintings(HttpServletRequest request){
//        System.out.println(pageIndex);
        return paintingService.getAllPaintings(Integer.parseInt(request.getParameter("pageIndex")));
    }

    @ResponseBody
    @GetMapping("getAllPaintingsCount")
    public long getAllPaintingsCount(HttpServletRequest request){
//        System.out.println(pageIndex);
        return paintingService.getAllPaintingsCount();
    }

    @ResponseBody
    @GetMapping("getAllPaintingsAndSort")
    public List<Painting> getAllPaintingsAndSort(HttpServletRequest request){
//        System.out.println(pageIndex);
        return paintingService.getAllPaintingsAndSort(Integer.parseInt(request.getParameter("pageIndex")),Integer.parseInt(request.getParameter("sort")));
    }

    @ResponseBody
    @GetMapping("getSearchPaintings")
    public List<Painting> getSearchPaintings(HttpServletRequest request){
        return paintingService.getSearchPaintings(request.getParameter("search"),Integer.parseInt(request.getParameter("pageIndex")));
    }

    @ResponseBody
    @GetMapping("getSearchPaintingsAndSort")
    public List<Painting> getSearchPaintingsAndSort(HttpServletRequest request){
        return paintingService.getSearchPaintingsAndSort(request.getParameter("search"),Integer.parseInt(request.getParameter("pageIndex")),Integer.parseInt(request.getParameter("sort")));
    }

    @ResponseBody
    @GetMapping("getSearchPaintingsCount")
    public int getSearchPaintingsCount(HttpServletRequest request){
        return paintingService.getSearchPaintingsCount(request.getParameter("search"));
    }

    @PostMapping("updateViews")
    public int updateViews(HttpServletResponse response, HttpServletRequest request) {
        return paintingService.updateViews(Integer.parseInt(request.getParameter("paintingId"))).getViews();

    }
}
