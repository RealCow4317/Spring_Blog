package com.example.blog.service;

import com.example.blog.dao.CommentDAO;
import com.example.blog.dto.CommentDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentDAO commentDAO;

    @Override
    public void addComment(CommentDTO comment) {
        commentDAO.addComment(comment);
    }

    @Override
    public void deleteComment(int id) {
        commentDAO.deleteComment(id);
    }

    @Override
    public List<CommentDTO> getCommentsByBoardId(int boardId) {
        return commentDAO.getCommentsByBoardId(boardId);
    }
    @Override
    public CommentDTO getCommentById(int id) {
        return commentDAO.getCommentById(id);
    }

    @Override
    public void updateComment(CommentDTO comment) {
        commentDAO.updateComment(comment);
    }

    public int countByBoardId(int boardId) {
        return commentDAO.countByBoardId(boardId);
    }

}
