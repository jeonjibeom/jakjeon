package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Mapper
@Service
@Transactional
public interface JoinDAO {
   
   //======================================================
   //게시판 글 입력 후 입력 적용 행의 개수 리턴하는 메소드 선언
   //======================================================
   public void insertJoin(JoinDTO joinDTO);
   
   

   public void updateJoin(JoinDTO joinDTO);
   
   
   
   
   public int checkNickDuplication(String mem_nick);
   
   public int checkIdDuplication(String mem_id);
}