package com.example.blog.service;

import com.example.blog.dao.MemberDAO;
import com.example.blog.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberDAO memberDAO;

    @Override
    public void register(MemberDTO member) {
        memberDAO.insertMember(member);
    }

    @Override
    public MemberDTO login(MemberDTO member) {
        return memberDAO.loginMember(member);
    }

    @Override
    public MemberDTO getMember(String id) {
        return memberDAO.getMemberById(id);
    }
}
