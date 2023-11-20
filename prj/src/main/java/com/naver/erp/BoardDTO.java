package com.naver.erp;

import java.util.List;
import java.util.Map;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
// BoardDTO 클래스 선언
// 1개의 게시판 글 정보가 저장되는 클래스이다.
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
public class BoardDTO {

	//=============================================================================
	//파라미터명 "b_no"에 대응하는 파라미터값이 저장되는 멤버변수 선언하기
	//파라미터명 "subject"에 대응하는 파라미터값이 저장되는 멤버변수 선언하기
	//파라미터명 "content"에 대응하는 파라미터값이 저장되는 멤버변수 선언하기
	//파라미터명 "writer"에 대응하는 파라미터값이 저장되는 멤버변수 선언하기
	//파라미터명 "email"에 대응하는 파라미터값이 저장되는 멤버변수 선언하기
	//파라미터명 "pwd"에 대응하는 파라미터값이 저장되는 멤버변수 선언하기
	
	//파라미터명 "readcount"에 대응하는 파라미터값이 저장되는 멤버변수 선언하기
	//파라미터명 "reg_date"에 대응하는 파라미터값이 저장되는 멤버변수 선언하기
	//파라미터명 "group_no"에 대응하는 파라미터값이 저장되는 멤버변수 선언하기
	//파라미터명 "print_no"에 대응하는 파라미터값이 저장되는 멤버변수 선언하기
	//파라미터명 "print_level"에 대응하는 파라미터값이 저장되는 멤버변수 선언하기
	//파라미터명 "mom_b_no"에 대응하는 파라미터값이 저장되는 멤버변수 선언하기
	//=============================================================================
	
	private int b_no;
	
	
	//===========================================
	//맴버변수 subject에 저장된 파라미터값의
	//유효성 체크 실행 어노테이션 선언하기
	//<주의> 유효성 체크 실행 결과 메시지는 BindingResult 객체가 관리한다.
	//===========================================
	@NotEmpty(message="제목은 필수 입력입니다.")		//비면안돼
	@NotNull(message="제목은 필수 입력입니다.")			//널이면안돼
	@NotBlank(message="공백으로 구성되면 안됩니다.")		//공백도 데이터야
	@Size(min=2, max=30, message="제목은 2~30자 입니다.")	//입력가능한 문자의 길이
	@Pattern(regexp="^[^><]{2,30}$", message="제목은 2~30자 이고 < 또는 >단어가 들어갈 수 없습니다. 재입력 요망")
	private String subject;
	
	//멤버변수 content에 저장된 파라미터값의 유효성 체크 실행 어노테이션 선언하기
	//<주의> 유효성 체크 실행 결과 메시지는 BindingResult 객체가 관리한다
	@NotEmpty(message="내용은 필수 입력입니다.")		//비면안돼
	@NotNull(message="내용은 필수 입력입니다.")			//널이면안돼
	@NotBlank(message="내용은 공백으로 구성되면 안됩니다.")		//공백도 데이터야
	@Size(min=1, max=500, message="내용은 2~500자 입니다.")	//입력가능한 문자의 길이
	@Pattern(regexp="^[^><]{2,500}$", message="내용은 1~500자 이고 < 또는 >단어가 들어갈 수 없습니다. 재입력 요망")
	private String content;
	

	private String mem_nick;
	private String writer;
	
	
	private String email;
	
	private String pwd;

	
	private int readcount;
	private String reg_date;
	private int group_no;
	private int print_no;
	private int print_level;
	
	
	
	private int mom_b_no;
	
	//=========================================
	//파일 업로드 관련 멤버변수 2개 선언
	//=========================================
	//파일업로드 된 파일을 관리하는 MultipartFile 객체 저장 매개변수 img 선언
	//업로드된 파일의 새 이름을 저장할 img_name 멤버변수 선언
	private MultipartFile img;		//String img 라고 하면 파일명만 가져옴 
	private String img_name;		//파일을 받을때 사용할것
	
	
	//이미지 삭제여부
	private String isdel;
	
	
	

	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getIsdel() {
		return isdel;
	}
	public void setIsdel(String isdel) {
		this.isdel = isdel;
	}
	public int getB_no() {
		return b_no;
	}
	public void setB_no(int b_no) {
		this.b_no = b_no;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	public String getMem_nick() {
		return mem_nick;
	}
	public void setMem_nick(String mem_nick) {
		this.mem_nick = mem_nick;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public int getGroup_no() {
		return group_no;
	}
	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}
	public int getPrint_no() {
		return print_no;
	}
	public void setPrint_no(int print_no) {
		this.print_no = print_no;
	}
	public int getPrint_level() {
		return print_level;
	}
	public void setPrint_level(int print_level) {
		this.print_level = print_level;
	}
	public int getMom_b_no() {
		return mom_b_no;
	}
	public void setMom_b_no(int mom_b_no) {
		this.mom_b_no = mom_b_no;
	}
	public MultipartFile getImg() {
		return img;
	}
	public void setImg(MultipartFile img) {
		this.img = img;
	}
	public String getImg_name() {
		return img_name;
	}
	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
