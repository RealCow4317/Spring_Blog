package com.example.blog.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.blog.dao.BoardDAO;
import com.example.blog.dto.BoardDTO;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    private BoardDAO boardDAO;

    @Override
    public List<BoardDTO> getAllBoards() {
        return boardDAO.getAllBoards();
    }

    @Override
    public BoardDTO getBoardById(int id) {
        return boardDAO.getBoardById(id);
    }

    @Override
    public void insertBoard(BoardDTO board) {
        boardDAO.insertBoard(board);
    }

    @Override
    public void updateBoard(BoardDTO board) {
        boardDAO.updateBoard(board);
    }

    @Override
    public void deleteBoard(int id) {
        boardDAO.deleteBoard(id);
    }

    @Override
    public List<BoardDTO> getRecentBoards() {
        return boardDAO.getRecentBoards();
    }
}
