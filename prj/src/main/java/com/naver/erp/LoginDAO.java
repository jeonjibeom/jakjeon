package com.naver.erp;

import java.util.List;
import java.util.Map;

//LoginDAO 인터페이스 선언

/*
 * 스프링에서 관용적으로 인터페이스 이름에 DAO가 들어가면
 * 이 인터페이스를 구현한 클래스가 만들어질것이고
 * 이 클래스는 직접 DBㅇ녀동에 사용될 메소드를 소유하게 될 것이다.
 * 특이 xml에 SQL 구문을 저장하고 사요할 경우
 * 이 인터페이스의 구조와 xml 파일안의 구조가 동일할 것이다.
 */
public interface LoginDAO {
   
   //로그인 아이디와 암호 존재의 개수를 리턴하는 메소드 선언
   public int getLoginIdCnt( Map<String,String> idPwd );
   public String getNick( Map<String, String> Nick);
   
   public String getName( Map<String, String> Name);
   public String getGender( Map<String, String> Gender);
   public String getBirth( Map<String, String> Birth);
   public String getEmail( Map<String, String> Email);
   
   
//
//   List<Map<String,String>> getJoinList( JoinList );
//   
}