package com.example.blog.service;

import com.example.blog.dao.MemberDAO;
import com.example.blog.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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

    @Override
    public List<MemberDTO> getAllMembers() {
        return memberDAO.getAllMembers();
    }

    @Override
    public void deleteMember(int memberNo) {
        memberDAO.deleteMember(memberNo);
    }

    @Override
    public void updateMember(MemberDTO member) {
        memberDAO.updateMember(member);
    }
    @Override
    public List<MemberDTO> searchMembers(String keyword) {
        return memberDAO.searchMembers(keyword);
    }


}
