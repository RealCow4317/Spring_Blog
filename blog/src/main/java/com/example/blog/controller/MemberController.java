package com.example.blog.controller;

import com.example.blog.dto.MemberDTO;
import com.example.blog.service.MemberService;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @GetMapping("/join")
    public String joinForm() {
        return "member/join";
    }

    @PostMapping("/join")
    public String join(MemberDTO member) {
        memberService.register(member);
        return "redirect:/member/login";
    }

    @GetMapping("/login")
    public String loginForm() {
        return "member/login";
    }

    @PostMapping("/login")
    public String login(MemberDTO member, HttpSession session, Model model) {
        MemberDTO loginUser = memberService.login(member);
        if (loginUser != null) {
            session.setAttribute("loginUser", loginUser);
            return "redirect:/";
        } else {
            model.addAttribute("error", "ID 또는 비밀번호가 틀렸습니다.");
            return "member/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/member/login";
        }

        model.addAttribute("loginUser", loginUser);
        return "member/profile";
    }

}
