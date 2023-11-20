package com.naver.erp;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//LoginDAOImp 클래스 선언
   //관용적으로 DAO 단어가 들어간 클래스는 직접 DB연동을 하는 클래스이다.
   //직접 DB연동을 하는 클래스 앞에는 @Repository 라는 어노테이션을 붙인다.
   //직접 DB연동을 하는 클래스는 보통 인터페이스를 구현하여 만든다.
   //여기서는 LoginDAO인터페이스를 구현하여 선언하였다.
@Repository
public class LoginDAOImp implements LoginDAO {

   //SqlSessionTemplate객체를 생성해 멤버변수 sqlSession에 저장
   //@Autowired란 어노테이션을 붙이면 속성변수 자료형에 맞는 
   //SqlSessionTemplate 객체를 생성한 후 
   //객체의 메위주를 속성변수 저장한다.
   
   //SqlSessionTemplate 객체의 기능
         //DB연동시 사용하는 객체이다.
         //xml파일에 있는 SQL구문을 읽어서 DB에 SQL명령을 내린 후
         //그 결과값을 받아오는 객체이다. 그렇게 해주는 메소드가 존재한다.
   
   //=========================
   //@Autowired
   //=========================
         //위와 같은 멤버변수가 선언되면 아래와 같은 과정을 거친다.
            //클래스명에 해당하는 클래스를 찾아서
            //객체화 하고 멤버변수에 객체의 메위주를 저장.
   
   //=========================
   //SqlSessionTemplate 클래스를 찾아 객체화 해서
   //멤버변수 sqlSession 에 객체의 메위주를 저장하기
   //=========================
   @Autowired
   private SqlSessionTemplate sqlSession;
      
   //=========================
   //SqlSessionTemplate  기능
   //=========================
      //DB연동시 사용하는 객체이다.
   
   
   
   //로그인 아이디와 암호의 존재의 개수를 리턴하는 메소드 선언
   //이 메소드는 현재 LoginController 객체 안의 메소드에서 호출하고있다.
   @Override
   public int getLoginIdCnt (
         //로그인 아이디와 암호가 저장된 HashMap 객체가 들어오는 매개변수 선언 변수명은 달리줘도 상관없음
         Map<String,String>idPwd
         ) {
      
      //SqlSessionTemplate 객체의 selectOne 메소드 호출로
      //xml 파일에 있는 select 구문을 호출하여
      //로그인 아이디,암호 존재 개수를 얻기
      
      //=========================
      //selectOne 메소드 특징
      //=========================
            //1행m열의 검색결과를 내놓는 select 구문을 DB에 날리고 
            //1행m열의 결과를 저장하고있는 객체를 리턴하는 메소드이다.
            //<주의>만약 selectOne 메소드의 결과가 2행 이상이면 에러가 터진다.
            //즉, selectOne 메소드 실행 시 작동하는 select문 검색 결과는 1행 이하여야한다.
               //-----------------------------------------
               //selectOne 메소드 실행 결과가 1행1열일 경우
               //-----------------------------------------
                  //int 또는 String 또는 double로 리턴된다
      
               //-----------------------------------------
               //selectOne 메소드 실행 결과가 1행 2열 이상 경우
               //-----------------------------------------
                  //자바의 HashMap객체 또는 DTO객체에 저장해서 리턴된다.
      
      int loginIdCnt = this.sqlSession.selectOne(
            //------------------------------------------
            //실행할 SQL구문의 위치를 문자열로 지정하기.
            //------------------------------------------
            "com.naver.erp.LoginDAO.getLoginIdCnt"      //=> 쿼리문의 위치
               //com.naver.erp.LoginDAO   => xml파일안의 mapper 태그 안의 namespace값을 의미한다.
               //                        com.naver.erp.LoginDAO는 실제 존재하는 인터페이스의 경로이어야한다.
            
               //getLoginIdCnt            => 그 mapper 태그 안의 <~id="getLoginIdCnt">이 태그 내부의 SQL문을 말한다.
               //                        이 <~id="getLoginIdCnt">에 getLoginIdCnt는 인터페이스의 
               //                        메소드 이름하고 일치해야한다.
            
            //실행할 SQL구문에서 사용할 데이터 지정하기
            //밑의 idPwd 변수에는 아이디와 암호가 저장된 HashMap 객체가 들어있다.
            , idPwd      //=> 쿼리문에 참여할 데이터
      );
      //로그인 아이디,암호 존재 개수를 리턴하기
      return loginIdCnt;
   }
   
   @Override
   public String getNick (
         Map<String,String>Nick
         ) {
      String nick = this.sqlSession.selectOne(
            "com.naver.erp.LoginDAO.getNick"      //=> 쿼리문의 위치
            , Nick      //=> 쿼리문에 참여할 데이터
      );
      return nick;
   }
   
   @Override
   public String getName (
         Map<String,String>Name
         ) {
      String name = this.sqlSession.selectOne(
            "com.naver.erp.LoginDAO.getName"      //=> 쿼리문의 위치
            , Name      //=> 쿼리문에 참여할 데이터
      );
      return name;
   }
   
   @Override
   public String getGender (
         Map<String,String>Gender
         ) {
      String gender = this.sqlSession.selectOne(
            "com.naver.erp.LoginDAO.getGender"      //=> 쿼리문의 위치
            , Gender      //=> 쿼리문에 참여할 데이터
      );
      return gender;
   }
   
   @Override
   public String getBirth (
         Map<String,String>Birth
         ) {
      String birth = this.sqlSession.selectOne(
            "com.naver.erp.LoginDAO.getBirth"      //=> 쿼리문의 위치
            , Birth      //=> 쿼리문에 참여할 데이터
      );
      return birth;
   }
   
   @Override
   public String getEmail (
         Map<String,String>Email
         ) {
      String email = this.sqlSession.selectOne(
            "com.naver.erp.LoginDAO.getEmail"      //=> 쿼리문의 위치
            , Email      //=> 쿼리문에 참여할 데이터
      );
      return email;
   }

   
   
   
   
}