package com.example.blog.controller;

import java.util.List;

import com.example.blog.dto.BoardDTO;
import com.example.blog.dto.CategoryDTO;
import com.example.blog.service.BoardService;
import com.example.blog.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
                       Model model) {

        int pageSize = 10;
        List<BoardDTO> boards;
        int total;

        if (keyword != null && !keyword.isEmpty()) {
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

        model.addAttribute("categoryList", categoryService.getAll()); // 이 코드 빠지면 select는 비어 있음
        model.addAttribute("categoryId", categoryId); // 드롭다운 selected용

        return "board/list";
    }

    @GetMapping("/view/{id}")
    public String view(@PathVariable int id, Model model) {
        BoardDTO board = boardService.getBoardById(id);
        model.addAttribute("board", board);
        return "board/view";
    }


    @GetMapping("/write")
    public String writeForm(Model model) {
        model.addAttribute("categoryList", categoryService.getAll());
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
        model.addAttribute("categoryList", categoryService.getAll());
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
