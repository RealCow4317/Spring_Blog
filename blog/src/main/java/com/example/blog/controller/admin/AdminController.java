package com.example.blog.controller.admin;

import com.example.blog.dto.BoardDTO;
import com.example.blog.dto.CategoryDTO;
import com.example.blog.dto.MemberDTO;
import com.example.blog.service.BoardService;
import com.example.blog.service.CategoryService;
import com.example.blog.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private BoardService boardService;

    @ModelAttribute
    public void checkAdmin(HttpSession session,
                           HttpServletRequest request,
                           HttpServletResponse response) throws IOException {
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin == null || !isAdmin) {
            session.setAttribute("redirectAfterLogin", request.getRequestURI());
            response.sendRedirect("/member/login");
        }
    }

    @GetMapping
    public String index(Model model) {
        List<MemberDTO> users = memberService.getAllMembers().subList(0, Math.min(5, memberService.getAllMembers().size()));
        List<BoardDTO> recentPosts = boardService.getBoardsByPage(1, 5);
        List<CategoryDTO> categories = categoryService.getAll().subList(0, Math.min(5, categoryService.getAll().size()));

        model.addAttribute("users", users);
        model.addAttribute("recentPosts", recentPosts);
        model.addAttribute("categories", categories);

        return "admin/index";
    }

    @GetMapping("/users")
    public String userList(@RequestParam(required = false) String keyword, Model model) {
        List<MemberDTO> users;

        if (keyword != null && !keyword.isEmpty()) {
            users = memberService.searchMembers(keyword);
            model.addAttribute("keyword", keyword);
        } else {
            users = memberService.getAllMembers();
        }

        model.addAttribute("users", users);
        return "admin/users/userList";
    }

    @GetMapping("/users/delete/{memberNo}")
    public String deleteUser(@PathVariable int memberNo) {
        memberService.deleteMember(memberNo);
        return "redirect:/admin/users";
    }

    @GetMapping("/users/edit/{id}")
    public String editUserForm(@PathVariable String id, Model model) {
        MemberDTO user = memberService.getMember(id);
        model.addAttribute("user", user);
        return "admin/users/editForm";
    }

    @PostMapping("/users/edit")
    public String editUser(MemberDTO user) {
        memberService.updateMember(user);
        return "redirect:/admin/users";
    }

    @GetMapping("/users/add")
    public String addUserForm() {
        return "admin/users/addForm";
    }

    @PostMapping("/users/add")
    public String addUser(MemberDTO user) {
        memberService.register(user);
        return "redirect:/admin/users";
    }

    @GetMapping("/categories")
    public String listCategories(Model model) {
        List<CategoryDTO> categories = categoryService.getAll();
        model.addAttribute("categories", categories);
        return "admin/category/list";
    }

    @PostMapping("/categories/add")
    public String addCategory(@RequestParam String name) {
        categoryService.add(name);
        return "redirect:/admin/categories";
    }

    @GetMapping("/categories/delete/{id}")
    public String deleteCategory(@PathVariable int id) {
        categoryService.delete(id);
        return "redirect:/admin/categories";
    }
}
