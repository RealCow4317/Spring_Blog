package com.example.blog.controller;

import com.example.blog.dto.MemberDTO;
import com.example.blog.service.MemberService;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    // 회원가입 폼
    @GetMapping("/join")
    public String joinForm() {
        return "member/join";
    }

    // 회원가입 처리
    @PostMapping("/join")
    public String join(MemberDTO member, HttpSession session) {
        memberService.register(member);
        session.setAttribute("joinSuccess", "회원가입이 완료되었습니다");
        return "redirect:/member/login";
    }

    // 로그인 폼
    @GetMapping("/login")
    public String loginForm() {
        return "member/login";
    }

    // 로그인 처리
    @PostMapping("/login")
    public String login(MemberDTO member, HttpSession session, Model model) {
        MemberDTO loginUser = memberService.login(member);
        if (loginUser != null) {
            session.setAttribute("loginUser", loginUser);

            if (loginUser.isAdmin()) {
                session.setAttribute("isAdmin", true);
            }

            String redirect = (String) session.getAttribute("redirectAfterLogin");
            if (redirect != null) {
                session.removeAttribute("redirectAfterLogin");
                return "redirect:" + redirect;
            }

            // 기본 redirect
            session.setAttribute("loginSuccess", loginUser.getName() + "님 환영합니다!");
            return "redirect:/";
        } else {
            model.addAttribute("error", "ID 또는 비밀번호가 틀렸습니다.");
            return "member/login";
        }
    }

    // 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    // 프로필 페이지
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
