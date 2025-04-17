package com.example.blog.controller;

import java.util.List;

import com.example.blog.dto.BoardDTO;
import com.example.blog.dto.CategoryDTO;
import com.example.blog.dto.MemberDTO;
import com.example.blog.service.BoardService;
import com.example.blog.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardService boardService;

    @Autowired
    private CategoryService categoryService;


    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int page,
                       @RequestParam(required = false) String keyword,
                       @RequestParam(required = false) Integer categoryId,
                       HttpSession session,
                       Model model) {

        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/login";
        }

        int pageSize = 10;
        List<BoardDTO> boards;
        int total;

        if (keyword != null && !keyword.isEmpty() && categoryId != null) {
            boards = boardService.searchBoardsByCategoryAndKeyword(categoryId, keyword, page, pageSize);
            total = boardService.countBoardsByCategoryAndKeyword(categoryId, keyword);
            model.addAttribute("keyword", keyword);
            model.addAttribute("selectedCategory", categoryId);
        } else if (keyword != null && !keyword.isEmpty()) {
            boards = boardService.searchBoards(keyword, page, pageSize);
            total = boardService.countSearchBoards(keyword);
            model.addAttribute("keyword", keyword);
        } else if (categoryId != null) {
            boards = boardService.getBoardsByCategory(categoryId, page, pageSize);
            total = boardService.countBoardsByCategory(categoryId);
            model.addAttribute("selectedCategory", categoryId);
        } else {
            boards = boardService.getBoardsByPage(page, pageSize);
            total = boardService.countBoards();
        }

        int totalPages = (int) Math.ceil((double) total / pageSize);
        model.addAttribute("boards", boards);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("categoryList", categoryService.getAll());
        model.addAttribute("categoryId", categoryId);

        return "board/list";
    }


    @GetMapping("/view/{id}")
    public String view(@PathVariable int id, HttpSession session, Model model) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/login";
        }

        BoardDTO board = boardService.getBoardById(id);
        model.addAttribute("board", board);
        model.addAttribute("loginUser", loginUser);
        return "board/view";
    }


    @GetMapping("/write")
    public String writeForm(HttpSession session, Model model) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/login";
        }

        model.addAttribute("categoryList", categoryService.getAll());
        model.addAttribute("writerId", loginUser.getId()); // 작성자 ID 넘기기
        return "board/write";
    }

    @PostMapping("/write")
    public String write(BoardDTO board, HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/login";
        }

        board.setWriter(loginUser.getId()); // 로그인한 유저 ID를 작성자로 설정
        boardService.insertBoard(board);
        return "redirect:/board/list";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable int id, HttpSession session, Model model) {
        BoardDTO board = boardService.getBoardById(id);
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");

        if (loginUser == null || !loginUser.getId().equals(board.getWriter())) {
            return "redirect:/board/view/" + id; // 권한 없으면 돌아감
        }

        model.addAttribute("board", board);
        model.addAttribute("categoryList", categoryService.getAll());
        return "board/edit";
    }

    @PostMapping("/edit")
    public String edit(BoardDTO board, HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        BoardDTO original = boardService.getBoardById(board.getId());

        if (loginUser == null || !loginUser.getId().equals(original.getWriter())) {
            return "redirect:/board/view/" + board.getId();
        }

        boardService.updateBoard(board);
        return "redirect:/board/view/" + board.getId();
    }


    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id, HttpSession session) {
        BoardDTO board = boardService.getBoardById(id);
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");

        if (loginUser == null || !loginUser.getId().equals(board.getWriter())) {
            return "redirect:/board/view/" + id;
        }

        boardService.deleteBoard(id);
        return "redirect:/board/list";
    }
}
