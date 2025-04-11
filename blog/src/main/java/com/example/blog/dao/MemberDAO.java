package com.example.blog.dao;

import com.example.blog.dto.MemberDTO;

public interface MemberDAO {
    void insertMember(MemberDTO member);           // 회원가입
    MemberDTO loginMember(MemberDTO member);       // 로그인
    MemberDTO getMemberById(String id);            // ID로 조회 (마이페이지 등)
}
