package com.example.blog.controller;

import com.example.blog.dto.CommentDTO;
import com.example.blog.dto.MemberDTO;
import com.example.blog.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private CommentService commentService;

    @PostMapping("/add")
    public String addComment(CommentDTO comment, HttpSession session) {
        comment.setWriter(((com.example.blog.dto.MemberDTO) session.getAttribute("loginUser")).getId());
        commentService.addComment(comment);
        return "redirect:/board/view/" + comment.getBoardId();
    }

    @GetMapping("/delete/{id}/{postId}")
    public String deleteComment(@PathVariable int id, @PathVariable int postId) {
        commentService.deleteComment(id);
        return "redirect:/board/view/" + postId;
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable int id, Model model, HttpSession session) {
        CommentDTO comment = commentService.getCommentById(id);
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");

        if (comment == null || loginUser == null || !comment.getWriter().equals(loginUser.getId())) {
            return "redirect:/";
        }

        model.addAttribute("comment", comment);
        return "comment/editForm";
    }

    @PostMapping("/edit")
    public String edit(CommentDTO comment, HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");

        if (loginUser != null && loginUser.getId().equals(comment.getWriter())) {
            commentService.updateComment(comment);
        }

        return "redirect:/board/view/" + comment.getBoardId();
    }

}
