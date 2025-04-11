package com.example.blog.dao;

import java.util.List;
import com.example.blog.dto.BoardDTO;

public interface BoardDAO {
    List<BoardDTO> getAllBoards();
    BoardDTO getBoardById(int id);
    void insertBoard(BoardDTO board);
    void updateBoard(BoardDTO board);
    void deleteBoard(int id);
    List<BoardDTO> getRecentBoards();
}
