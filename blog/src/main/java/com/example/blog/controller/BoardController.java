package com.example.blog.controller;

import java.util.List;

import com.example.blog.dto.BoardDTO;
import com.example.blog.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardService boardService;

    // ✅ 페이징 적용된 게시글 목록
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int page, Model model) {
        int pageSize = 5;
        int total = boardService.countBoards();
        int totalPages = (int) Math.ceil((double) total / pageSize);

        List<BoardDTO> boards = boardService.getBoardsByPage(page, pageSize);

        model.addAttribute("boards", boards);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "board/list";
    }

    @GetMapping("/view/{id}")
    public String view(@PathVariable int id, Model model) {
        BoardDTO board = boardService.getBoardById(id);
        model.addAttribute("board", board);
        return "board/view";
    }

    @GetMapping("/write")
    public String writeForm() {
        return "board/write";
    }

    @PostMapping("/write")
    public String write(BoardDTO board) {
        boardService.insertBoard(board);
        return "redirect:/board/list";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable int id, Model model) {
        BoardDTO board = boardService.getBoardById(id);
        model.addAttribute("board", board);
        return "board/edit";
    }

    @PostMapping("/edit")
    public String edit(BoardDTO board) {
        boardService.updateBoard(board);
        return "redirect:/board/view/" + board.getId();
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id) {
        boardService.deleteBoard(id);
        return "redirect:/board/list";
    }
}
