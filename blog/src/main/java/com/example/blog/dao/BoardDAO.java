package com.example.blog.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.example.blog.dto.BoardDTO;

public interface BoardDAO {
    List<BoardDTO> getAllBoards();
    BoardDTO getBoardById(int id);
    void insertBoard(BoardDTO board);
    void updateBoard(BoardDTO board);
    void deleteBoard(int id);
    List<BoardDTO> getRecentBoards();

    int countBoards();

    List<BoardDTO> getBoardsByPage(
            @Param("limit") int limit,
            @Param("offset") int offset
    );

}
