package com.example.blog.controller;

import java.util.List;

import com.example.blog.dto.BoardDTO;
import com.example.blog.dto.CategoryDTO;
import com.example.blog.dto.CommentDTO;
import com.example.blog.dto.MemberDTO;
import com.example.blog.service.BoardService;
import com.example.blog.service.CategoryService;
import com.example.blog.service.CommentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/board")
public class BoardController {

    private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

    @Autowired
    private BoardService boardService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private CommentService commentService;


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

        logger.debug("[LIST] page={}, keyword='{}', categoryId={}", page, keyword, categoryId);

        int pageSize = 10;
        List<BoardDTO> boards;
        int total;

        if (keyword != null && !keyword.isEmpty() && categoryId != null) {
            boards = boardService.searchBoardsByCategoryAndKeyword(categoryId, keyword, page, pageSize);
            total = boardService.countBoardsByCategoryAndKeyword(categoryId, keyword);
            logger.debug("검색(카테고리+키워드) 결과: {}건", boards.size());
        } else if (keyword != null && !keyword.isEmpty()) {
            boards = boardService.searchBoards(keyword, page, pageSize);
            total = boardService.countSearchBoards(keyword);
            logger.debug("검색(키워드) 결과: {}건", boards.size());
        } else if (categoryId != null) {
            boards = boardService.getBoardsByCategory(categoryId, page, pageSize);
            total = boardService.countBoardsByCategory(categoryId);
            logger.debug("검색(카테고리) 결과: {}건", boards.size());
        } else {
            boards = boardService.getBoardsByPage(page, pageSize);
            total = boardService.countBoards();
            logger.debug("전체 게시글 조회 결과: {}건", boards.size());
        }

        for (BoardDTO board : boards) {
            int count = commentService.countByBoardId(board.getId());
            board.setCommentCount(count);
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
    public String view(@PathVariable int id, Model model, HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/login";
        }

        logger.debug("[VIEW] 게시글 ID: {}", id);

        BoardDTO board = boardService.getBoardById(id);
        List<CommentDTO> comments = commentService.getCommentsByBoardId(id);

        model.addAttribute("board", board);
        model.addAttribute("comments", comments);

        return "board/view";
    }

    @GetMapping("/write")
    public String writeForm(HttpSession session, Model model) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/login";
        }

        model.addAttribute("categoryList", categoryService.getAll());
        model.addAttribute("writerId", loginUser.getId());
        return "board/write";
    }

    @PostMapping("/write")
    public String write(BoardDTO board, HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/login";
        }

        board.setWriter(loginUser.getId());
        logger.debug("[WRITE] 작성자: {}, 제목: {}", loginUser.getId(), board.getTitle());

        boardService.insertBoard(board);
        return "redirect:/board/list";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable int id, HttpSession session, Model model) {
        BoardDTO board = boardService.getBoardById(id);
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");

        if (loginUser == null || !loginUser.getId().equals(board.getWriter())) {
            return "redirect:/board/view/" + id;
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

        logger.debug("[EDIT] 수정자: {}, 게시글 ID: {}", loginUser.getId(), board.getId());

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

        logger.debug("[DELETE] 삭제자: {}, 게시글 ID: {}", loginUser.getId(), id);

        boardService.deleteBoard(id);
        return "redirect:/board/list";
    }
}
