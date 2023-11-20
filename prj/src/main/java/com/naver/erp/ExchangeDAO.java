package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface ExchangeDAO {

	List<Map<String,String>> getExchangeUSDList();
	List<Map<String,String>> getWeekUSDList();
	List<Map<String,String>> getMonthUSDList();
	List<Map<String,String>> getYearUSDList();
	List<Map<String,String>> getExchangeDescList();
	
}
