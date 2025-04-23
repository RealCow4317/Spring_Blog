package com.example.blog.controller;

import com.example.blog.dto.ImageDTO;
import com.example.blog.service.ImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Controller
public class UploadController {

    private static final String UPLOAD_PATH = "C:/upload/";

    @Autowired
    private ImageService imageService;

    @PostMapping("/upload/image")
    @ResponseBody
    public String uploadImage(@RequestParam("file") MultipartFile file, HttpServletRequest request) throws IOException {
        File dir = new File(UPLOAD_PATH);
        if (!dir.exists()) dir.mkdirs();

        String originalFilename = file.getOriginalFilename();
        String uuid = UUID.randomUUID().toString();
        String savedName = uuid + "_" + originalFilename;

        File dest = new File(dir, savedName);
        file.transferTo(dest);

        // 클라이언트에게 반환할 경로 (URL)
        String imageUrl = request.getContextPath() + "/upload/" + savedName;

        // DB 저장
        ImageDTO image = new ImageDTO();
        image.setFileName(savedName);
        image.setFilePath(imageUrl);
        imageService.saveImage(image);

        return imageUrl;
    }
}
