package com.example.blog.service;

import com.example.blog.dto.MemberDTO;

public interface MemberService {
    void register(MemberDTO member);
    MemberDTO login(MemberDTO member);
    MemberDTO getMember(String id);
}
