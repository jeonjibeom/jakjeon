package com.naver.erp;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
// BoardDTO 클래스 선언
// 1개의 게시판 글 정보가 저장되는 클래스이다.
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
public class JoinDTO {


   private int mem_no;
   
   //===========================================
   //맴버변수 subject에 저장된 파라미터값의
   //유효성 체크 실행 어노테이션 선언하기
   //<주의> 유효성 체크 실행 결과 메시지는 BindingResult 객체가 관리한다.
   //===========================================
   @NotEmpty(message="닉네임은 필수 입력입니다.")      //비면안돼
   @NotNull(message="닉네임은 필수 입력입니다.")         //널이면안돼
   @NotBlank(message="공백으로 구성되면 안됩니다.")      //공백도 데이터야
   @Size(min=2, max=8, message="닉네임은 2~8자 입니다.")   //입력가능한 문자의 길이
   @Pattern(regexp="^[^><]{2,8}$", message="닉네임은 2~8자 이고 < 또는 >단어가 들어갈 수 없습니다. 재입력 요망")
   private String mem_nick;
   
   
   
   //멤버변수 content에 저장된 파라미터값의 유효성 체크 실행 어노테이션 선언하기
   //<주의> 유효성 체크 실행 결과 메시지는 BindingResult 객체가 관리한다
   @NotEmpty(message="아이디는 필수 입력입니다.")      //비면안돼
   @NotNull(message="아이디는 필수 입력입니다.")         //널이면안돼
   @NotBlank(message="아이디는 공백으로 구성되면 안됩니다.")      //공백도 데이터야
   @Size(min=2, max=12, message="아이디는 2~12자 입니다.")   //입력가능한 문자의 길이
   @Pattern(regexp="^[^><]{2,12}$", message="아이디는 2~12자 이고 < 또는 >단어가 들어갈 수 없습니다. 재입력 요망")
   private String mem_id;
   
   //멤버변수 pwd에 저장된 파라미터값의 유효성 체크 실행 어노테이션 선언하기
   //<주의> 유효성 체크 실행 결과 메시지는 BindingResult 객체가 관리한다
   @NotEmpty(message="암호는 필수 입력입니다.")      //비면안돼
   @NotNull(message="암호는 필수 입력입니다.")         //널이면안돼
   @NotBlank(message="암호는 공백으로 구성되면 안됩니다.")      //공백도 데이터야
   @Pattern(regexp="^[0-9a-z]{12}$", message="암호는 영소문 또는 숫자로 구성되고 12자 입력 해야합니다.")
   private String mem_pwd;
   
   
   
   //멤버변수 writer에 저장된 파라미터값의 유효성 체크 실행 어노테이션 선언하기
   //<주의> 유효성 체크 실행 결과 메시지는 BindingResult 객체가 관리한다
   @NotEmpty(message="작성자명은 필수 입력입니다.")      //비면안돼
   @NotNull(message="작성자명은 필수 입력입니다.")         //널이면안돼
   @NotBlank(message="작성자명은 공백으로 구성되면 안됩니다.")      //공백도 데이터야
   @Size(min=2, max=15, message="작성자명은 2~15자입니다.")   //입력가능한 문자의 길이
   @Pattern(regexp="^[가-힣a-zA-Z]{2,15}$", message="작성자명은 2~15자 이고 영소대문자,한글로만 구성되야 합니다.")
   private String mem_name;
   
   
   //멤버변수 writer에 저장된 파라미터값의 유효성 체크 실행 어노테이션 선언하기
   //<주의> 유효성 체크 실행 결과 메시지는 BindingResult 객체가 관리한다
   @NotEmpty(message="작성자명은 필수 입력입니다.")      //비면안돼
   @NotNull(message="작성자명은 필수 입력입니다.")         //널이면안돼
   @NotBlank(message="작성자명은 공백으로 구성되면 안됩니다.")      //공백도 데이터야
   @Size(min=2, max=15, message="작성자명은 2~15자입니다.")   //입력가능한 문자의 길이
   @Pattern(regexp="^[가-힣a-zA-Z]{2,15}$", message="작성자명은 2~15자 이고 영소대문자,한글로만 구성되야 합니다.")
   private String mem_gender;
   
   
   //<주의> 유효성 체크 실행 결과 메시지는 BindingResult 객체가 관리한다
   @NotEmpty(message="작성자명은 필수 입력입니다.")      //비면안돼
   @NotNull(message="작성자명은 필수 입력입니다.")         //널이면안돼
   @NotBlank(message="작성자명은 공백으로 구성되면 안됩니다.")      //공백도 데이터야
   @Size(min=2, max=15, message="작성자명은 2~15자입니다.")   //입력가능한 문자의 길이
   @Pattern(regexp="^[가-힣a-zA-Z]{2,15}$", message="작성자명은 2~15자 이고 영소대문자,한글로만 구성되야 합니다.")
   private String mem_birth;
   

   
   //멤버변수 email에 저장된 파라미터값의 유효성 체크 실행 어노테이션 선언하기
   //<주의> 유효성 체크 실행 결과 메시지는 BindingResult 객체가 관리한다
   @NotEmpty(message="이메일은 필수 입력입니다.")      //비면안돼
   @NotNull(message="이메일은 필수 입력입니다.")         //널이면안돼
   @NotBlank(message="이메일은 공백으로 구성되면 안됩니다.")      //공백도 데이터야
   @Size(min=2, max=15, message="작성자명은 2~15자입니다.")   //입력가능한 문자의 길이
   @Pattern(regexp="^([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\\.[0-9a-zA-Z_-]+){1,2}$", message="이메일 형식에 맞지않습니다. 재입력요망")
   private String mem_email;

   

   private String mem_joindate;



   public int getMem_no() {
      return mem_no;
   }



   public void setMem_no(int mem_no) {
      this.mem_no = mem_no;
   }



   public String getMem_nick() {
      return mem_nick;
   }



   public void setMem_nick(String mem_nick) {
      this.mem_nick = mem_nick;
   }



   public String getMem_id() {
      return mem_id;
   }



   public void setMem_id(String mem_id) {
      this.mem_id = mem_id;
   }



   public String getMem_pwd() {
      return mem_pwd;
   }



   public void setMem_pwd(String mem_pwd) {
      this.mem_pwd = mem_pwd;
   }



   public String getMem_name() {
      return mem_name;
   }



   public void setMem_name(String mem_name) {
      this.mem_name = mem_name;
   }



   public String getMem_gender() {
      return mem_gender;
   }



   public void setMem_gender(String mem_gender) {
      this.mem_gender = mem_gender;
   }



   public String getMem_birth() {
      return mem_birth;
   }



   public void setMem_birth(String mem_birth) {
      this.mem_birth = mem_birth;
   }



   public String getMem_email() {
      return mem_email;
   }



   public void setMem_email(String mem_email) {
      this.mem_email = mem_email;
   }



   public String getMem_joindate() {
      return mem_joindate;
   }



   public void setMem_joindate(String mem_joindate) {
      this.mem_joindate = mem_joindate;
   }


   

   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
}