package com.example.art_backend.controller;

import com.example.art_backend.annotation.BaseResponse;
import com.example.art_backend.response.ResponseResult;
import com.example.art_backend.service.ErasService;
import com.example.art_backend.service.PaintingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@BaseResponse
@RestController
public class ErasController {

    @Autowired
    private ErasService erasService;

    @ResponseBody
    @GetMapping("getTime")
    public ResponseResult getTime(HttpServletRequest request){
        System.out.println(request.getParameter("yearOfWork"));
        System.out.println(erasService.getTime(Integer.parseInt(request.getParameter("yearOfWork"))));
        return new ResponseResult("success",erasService.getTime(Integer.parseInt(request.getParameter("yearOfWork"))));
    }
}
