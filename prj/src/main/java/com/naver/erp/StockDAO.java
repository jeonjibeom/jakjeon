package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Mapper
@Service
@Transactional
public interface StockDAO {

	
	List<Map<String,String>> getWeekStockList();
	//List<Map<String,String>> getBoardList(BoardSearchDTO boardSerachDTO);
	List<Map<String,String>> getWeekStockRateAscList();
	
	List<Map<String,String>> getWeekMarketDescList();
	
	List<Map<String,String>> getWeekMarketAmountDescList();
	
	int insertRecentPickStock(StockDTO stockDTO);
	List<Map<String,String>> getRecentPickStockList();
	int deleteRecentPickStock(StockDTO stockDTO);
	
	int minusPick(StockDTO stockDTO);
	
	
	//코드 전체 번호와 이름
	List<Map<String,String>> getAllStockCdAndNm();
	
	//한주의 모든 주식 리스트 받기
	List<Map<String,String>> getWeekAllStockList();
	//한달의 모든 주식 리스트 받기
	List<Map<String,String>> getMonthAllStockList();
	//일년의 모든 주식 리스트 받기
	List<Map<String,String>> getYearAllStockList();
	
	
	//minigraph 데이터 리스트 받기
	List<Map<String,String>> getSeveral_rate();
	
	//FINANCIAL_STATEMENTS 데이터 리스트 받기
	List<Map<String,String>> getFinancial_statements();
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}