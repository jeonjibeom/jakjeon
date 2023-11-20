package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;


//그래프에 사용할 코스피 코스닥 이름 뽑아내기.
@Mapper
public interface KospiDaqDAO {

	

	List<Map<String,String>> getKospiList();
	List<Map<String,String>> getKosdaqList();
	List<Map<String,String>> getKospiListDesc();
	List<Map<String,String>> getKosdaqListDesc();
	
}