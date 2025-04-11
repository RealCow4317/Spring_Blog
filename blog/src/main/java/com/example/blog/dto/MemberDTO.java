package com.example.blog.dto;

public class MemberDTO {
    private int memberNo;        // 기본키
    private String id;           // 로그인 ID (username → id로 변경)
    private String password;
    private String name;
    private String email;

    // Getters/Setters
    public int getMemberNo() { return memberNo; }
    public void setMemberNo(int memberNo) { this.memberNo = memberNo; }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}
