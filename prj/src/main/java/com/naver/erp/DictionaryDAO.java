package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DictionaryDAO {

	
	List<Map<String,String>> getStockDictionaryList();
	int getStockDictionaryCntAll();
	int getStockDictionaryCnt(DictionaryDTO dictionaryDTO);
	List<Map<String,String>> searchStockDictionary(DictionaryDTO dictionaryDTO);
}
