package com.example.blog.controller;

import com.example.blog.dto.MemberDTO;
import com.example.blog.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    // 회원가입 폼
    @GetMapping("/join")
    public String joinForm() {
        return "member/join";
    }

    @PostMapping("/join")
    public String join(MemberDTO member, HttpSession session) {
        memberService.register(member); // 암호화는 여기서 처리됨
        session.setAttribute("joinSuccess", "회원가입이 완료되었습니다");
        return "redirect:/member/login";
    }

    // 로그인 폼
    @GetMapping("/login")
    public String loginForm() {
        return "member/login";
    }

    // 로그인 처리 (암호 비교 + 실패 메시지 적용)
    @PostMapping("/login")
    public String login(MemberDTO input, HttpSession session, Model model) {
        MemberDTO dbMember = memberService.getMember(input.getId());

        if (dbMember != null && passwordEncoder.matches(input.getPassword(), dbMember.getPassword())) {
            session.setAttribute("loginUser", dbMember);
            session.setAttribute("isAdmin", dbMember.isAdmin());
            String redirect = (String) session.getAttribute("redirectAfterLogin");
            return "redirect:" + (redirect != null ? redirect : "/");
        } else {
            model.addAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
            model.addAttribute("enteredId", input.getId());
            return "member/login";
        }
    }

    // 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    // 프로필
    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/member/login";
        }

        model.addAttribute("loginUser", loginUser);
        return "member/profile";
    }

    @GetMapping(value = "/check-id", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String checkId(@RequestParam String id) {
        return memberService.getMember(id) == null ? "true" : "false";
    }

    @GetMapping(value = "/check-email", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String checkEmail(@RequestParam String email) {
        return memberService.getMemberByEmail(email) == null ? "true" : "false";
    }




}
