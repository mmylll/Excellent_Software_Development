package com.example.art_backend.controller;

import com.example.art_backend.annotation.BaseResponse;
import org.apache.tomcat.util.http.fileupload.FileUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

@BaseResponse
@RestController
public class TestController {

    @GetMapping("test")
    public String getAllUsers(){

        return "hdsbuvchbsd";
    }

//    @PostMapping(value = "/test")
//    public void testBinary(HttpServletRequest request) throws IOException {
//        File targetFile = new File("d:/test333.png");
//        ServletInputStream inputStream = request.getInputStream();
//        // org.apache.commons.io.FileUtils
//        FileUtils.copyInputStreamToFile(inputStream, targetFile);
//    }
}
