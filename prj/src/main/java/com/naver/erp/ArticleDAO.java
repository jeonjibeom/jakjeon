package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Mapper
@Transactional
@Service
public interface ArticleDAO {
   
	List<Map<String,String>> getArticleList();
	int getArticleCntAll();
	int getArticleCnt(ArticleDTO articleDTO);
	List<Map<String,String>> searchArticleList(ArticleDTO articleDTO);
	
	int updateReadcount(String title);
	List<Map<String,String>> getTopArticleList();
	List<Map<String,String>> getArticleKeywordList(GraphDTO graphDTO);

}