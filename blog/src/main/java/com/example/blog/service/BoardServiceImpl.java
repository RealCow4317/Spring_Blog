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

    @Override
    public int countBoards() {
        return boardDAO.countBoards();
    }

    @Override
    public List<BoardDTO> getBoardsByPage(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return boardDAO.getBoardsByPage(pageSize, offset);
    }

    @Override
    public int countSearchBoards(String keyword) {
        return boardDAO.countSearchBoards(keyword);
    }

    @Override
    public List<BoardDTO> searchBoards(String keyword, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return boardDAO.searchBoards(keyword, pageSize, offset);
    }

    @Override
    public int countBoardsByCategory(int categoryId) {
        return boardDAO.countBoardsByCategory(categoryId);
    }

    @Override
    public List<BoardDTO> getBoardsByCategory(int categoryId, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return boardDAO.getBoardsByCategory(categoryId, pageSize, offset);
    }

    @Override
    public int countBoardsByCategoryAndKeyword(int categoryId, String keyword) {
        return boardDAO.countBoardsByCategoryAndKeyword(categoryId, keyword);
    }

    @Override
    public List<BoardDTO> searchBoardsByCategoryAndKeyword(int categoryId, String keyword, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return boardDAO.searchBoardsByCategoryAndKeyword(categoryId, keyword, pageSize, offset);
    }
}
