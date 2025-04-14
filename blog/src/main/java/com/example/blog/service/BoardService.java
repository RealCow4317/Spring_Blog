package com.example.blog.service;

import java.util.List;
import com.example.blog.dto.BoardDTO;

public interface BoardService {
    List<BoardDTO> getAllBoards();
    BoardDTO getBoardById(int id);
    void insertBoard(BoardDTO board);
    void updateBoard(BoardDTO board);
    void deleteBoard(int id);
    List<BoardDTO> getRecentBoards();

    int countBoards();
    List<BoardDTO> getBoardsByPage(int page, int pageSize);

}
