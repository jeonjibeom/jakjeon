package com.naver.erp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.json.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpRequestInitializer;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.youtube.YouTube;
import com.google.api.services.youtube.model.Channel;
import com.google.api.services.youtube.model.ChannelListResponse;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Map;

import javax.print.attribute.HashAttributeSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.boot.autoconfigure.cassandra.CassandraProperties.Request;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpRequestInitializer;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.youtube.YouTube;
import com.google.api.services.youtube.model.Channel;
import com.google.api.services.youtube.model.ChannelListResponse;


@Controller
public class MainController {

	@Autowired
	private BoardDAO boardDAO;
	@Autowired
	private KospiDaqDAO kospiDaqDAO;
	@Autowired
	private StockDAO stockDAO;
	@Autowired
	private ArticleDAO articleDAO;
	@Autowired
	private ExchangeDAO exchangeDAO;
	@Autowired
	private DateDAO dateDAO;
	@Autowired
	private DictionaryDAO dictionaryDAO;
		

	@RequestMapping(value = "/graph.do")
	public ModelAndView boardDetailForm(
		GraphDTO graphDTO //검색 키워드 받기위한 코드
		,HttpSession session
		
	) {

		
		session.setAttribute("selectPageNo", 1);
		
		Map<String, Object> weekStockMap = getWeekStockMap();
		
		
		ModelAndView mav = new ModelAndView();
		 
		Map<String, Object> allDateMap = getAllDateMap();
		Map<String, Object> weekAllStockMap = getWeekAllStockList();
		Map<String, Object> monthAllStockMap = getMonthAllStockList();
		Map<String, Object> yearAllStockMap = getYearAllStockList();
		Map<String, Object> recentPickStkMap = getRecentPickStkList();
		Map<String, Object> articleMap = getArticleKeywordList(graphDTO);

		Map<String, Object> serveralRateMap = getSeveral_rate();
		Map<String, Object> financialStatementsMap = getFinancialStatements();
		
		Map<String, Object> kospiListDescMap = getKospiListDescMap();
		Map<String, Object> kosdaqListDescMap = getKosdaqListDescMap();
		List<Map<String, String>> exchangeDescList = getExchangeDescList();

		
		
				
		 
		

		String errMsg = "";
		
		
		mav.addObject("weekStockMap", weekStockMap);
		mav.addObject("keyword",graphDTO.getKeyword());
		mav.addObject("AllStockCdAndNmMap",getAllStockCdAndNmMap());
		mav.addObject("allDateMap",allDateMap);//여기에 주 월 년의 날짜가 들어있다.
		mav.addObject("weekAllStockMap",weekAllStockMap);
		mav.addObject("monthAllStockMap",monthAllStockMap);
		mav.addObject("yearAllStockMap",yearAllStockMap);
		mav.addObject("recentPickStkMap", recentPickStkMap);
		mav.addObject("serveralRateMap", serveralRateMap);
		mav.addObject("financialStatementsMap", financialStatementsMap);
		mav.addObject("articleMap", articleMap);
		
		mav.addObject("kospiListDescMap", kospiListDescMap);// 
		mav.addObject("kosdaqListDescMap", kosdaqListDescMap);// 
		mav.addObject("exchangeDescList", exchangeDescList);// 
	
		
		//검색 키워드 확인
		if(checkKeywordInStk(graphDTO.getKeyword())==1) {
			System.out.println("키워드 확인완료");
			mav.addObject("errMsg",errMsg);
			mav.setViewName("graph.jsp");
		}else {
			errMsg = "주식리스트에 있는 주식 검색 요망";
			mav.addObject("errMsg",errMsg);
			mav.setViewName("graph.jsp");
		}
		//System.out.println(articleMap);
		
		
		//System.out.println(getAllStockCdAndNmMap().stk_nm);
		//System.out.println(serveralRateMap.get("serveralRateList"));	
		//System.out.println(getSeveral_rate());
		// **************************************************************
		// ModelAndView객체 리턴
		// **************************************************************

		return mav;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public int checkKeywordInStk(String keyword) {
		List<Map<String, String>> allStockList = getAllStockCdAndNmMap();
		for(int i = 0 ; i < allStockList.size() ; i++) {
			if(keyword.equals(allStockList.get(i).get("stk_nm"))) {
			
				
				return 1;
			}
			
		}
		return 0;
		
	}	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public Map<String, Object> getFinancialStatements( // kosdaq 리스트 가져오기..

	) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, String>> financialStatementsList;

		financialStatementsList = this.stockDAO.getFinancial_statements();

		resultMap.put("financialStatementsList", financialStatementsList);
		//resultMap.put("kosdaqListCnt", kosdaqList.size());
		return resultMap;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public Map<String, Object> getSeveral_rate( // 보드 리스트 가져오기..

	) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		

		List<Map<String, String>> serveralRateList = this.stockDAO.getSeveral_rate();
		

		resultMap.put("serveralRateList", serveralRateList);

		
		return resultMap;
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public Map<String, Object> getArticleKeywordList( // 보드 리스트 가져오기..
				GraphDTO graphDTO
			) {

		
				Map<String, Object> resultMap = new HashMap<String, Object>();
				

				List<Map<String, String>> articleKeywordList = this.articleDAO.getArticleKeywordList(graphDTO);
				

				resultMap.put("articleKeywordList", articleKeywordList);

				
				return resultMap;
			}
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public Map<String, Object> getAllDateMap( // 보드 리스트 가져오기..

	) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		

		List<Map<String, String>> weekDateList = this.dateDAO.getWeekDateList();
		List<Map<String, String>> monthDateList = this.dateDAO.getMonthDateList();
		List<Map<String, String>> yearDateList = this.dateDAO.getYearDateList();
		

		resultMap.put("weekDateList", weekDateList);
		resultMap.put("monthDateList", monthDateList);
		resultMap.put("yearDateList", yearDateList);
		
		return resultMap;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public List<Map<String, String>> getAllStockCdAndNmMap( // 보드 리스트 가져오기..

	) {

		//Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, String>> AllStockCdAndNmList;

		AllStockCdAndNmList = this.stockDAO.getAllStockCdAndNm();

		//AllStockCdAndNmMap.put("AllStockCdAndNmMap", AllStockCdAndNmMap);
		return AllStockCdAndNmList;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public Map<String, Object> getKospiMap( // kospi 리스트 가져오기..

	) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, String>> kospiList;

		kospiList = this.kospiDaqDAO.getKospiList();

		
		resultMap.put("kospiList", kospiList);
		//System.out.println(kospiList);
		resultMap.put("kospiListCnt", kospiList.size());
		return resultMap;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public Map<String, Object> getKosdaqMap( // kosdaq 리스트 가져오기..

	) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, String>> kosdaqList;

		kosdaqList = this.kospiDaqDAO.getKosdaqList();

		resultMap.put("kosdaqList", kosdaqList);
		resultMap.put("kosdaqListCnt", kosdaqList.size());
		return resultMap;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public Map<String, Object> getKospiListDescMap( // kospi 리스트 가져오기..

	) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, String>> kospiListDesc;

		kospiListDesc = this.kospiDaqDAO.getKospiListDesc();

		//System.out.println(kospiListDesc);
		resultMap.put("kospiListDesc", kospiListDesc);
		//System.out.println(kospiList);
		//resultMap.put("kospiListCnt", kospiList.size());
		return resultMap;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public List<Map<String, String>> getExchangeDescList( // kospi 리스트 가져오기..

	) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, String>> exchangeDescList;

		exchangeDescList = this.exchangeDAO.getExchangeDescList();

		return exchangeDescList;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public Map<String, Object> getKosdaqListDescMap( // kospi 리스트 가져오기..
	
	) {
	
	Map<String, Object> resultMap = new HashMap<String, Object>();
	List<Map<String, String>> kosdaqListDesc;
	
	kosdaqListDesc = this.kospiDaqDAO.getKosdaqListDesc();
	
	
	resultMap.put("kosdaqListDesc", kosdaqListDesc);
	//System.out.println(kospiList);
	//resultMap.put("kospiListCnt", kospiList.size());
	return resultMap;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public Map<String, Object> getWeekAllStockList( // 최근 한주의 주식 모두 받기.

	) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, String>> WeekAllStockList;

		WeekAllStockList = this.stockDAO.getWeekAllStockList();

		resultMap.put("weekAllStockList", WeekAllStockList);
		resultMap.put("weekAllStockListCnt", WeekAllStockList.size());
		return resultMap;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public Map<String, Object> getMonthAllStockList( // 최근 한주의 주식 모두 받기.

	) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, String>> monthAllStockList;

		monthAllStockList = this.stockDAO.getMonthAllStockList();

		resultMap.put("monthAllStockList", monthAllStockList);
		resultMap.put("monthAllStockListCnt", monthAllStockList.size());
		return resultMap;
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public Map<String, Object> getYearAllStockList( // 최근 한주의 주식 모두 받기.

	) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, String>> yearAllStockList;

		yearAllStockList = this.stockDAO.getYearAllStockList();

		resultMap.put("yearAllStockList", yearAllStockList);
		resultMap.put("yearAllStockListCnt", yearAllStockList.size());
		return resultMap;
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public Map<String, Object> getWeekStockMap( // 

	) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, String>> stockList;

		stockList = this.stockDAO.getWeekStockList();

		resultMap.put("stockList", stockList);
		resultMap.put("stockListCnt", stockList.size());
		return resultMap;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public Map<String, Object> getStockRateAscMap( // kosdaq 리스트 가져오기..

	) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, String>> stockRateAscList;

		stockRateAscList = this.stockDAO.getWeekStockRateAscList();

		resultMap.put("stockRateAscList", stockRateAscList);
		resultMap.put("stockRateAscListCnt", stockRateAscList.size());
		return resultMap;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public Map<String, Object> getStockMarketDescMap( // kosdaq 리스트 가져오기..

	) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, String>> stockMarketDescList;

		stockMarketDescList = this.stockDAO.getWeekMarketDescList();

		resultMap.put("stockMarketDescList", stockMarketDescList);
		resultMap.put("stockMarketDescListCnt", stockMarketDescList.size());
		return resultMap;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public Map<String, Object> getArticleResultMap() {

		Map<String, Object> articleResultMap = new HashMap<String, Object>();

		List<Map<String, String>> articleList;

		articleList = this.articleDAO.getArticleList();

		articleResultMap.put("articleList", articleList);

		return articleResultMap;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public Map<String, Object> getWeekMarketAmountDescList() {

		Map<String, Object> stockMarketAmountDescResultMap = new HashMap<String, Object>();

		List<Map<String, String>> getWeekMarketAmountDescList;

		getWeekMarketAmountDescList = this.stockDAO.getWeekMarketAmountDescList();

		stockMarketAmountDescResultMap.put("getWeekMarketAmountDescList", getWeekMarketAmountDescList);

		return stockMarketAmountDescResultMap;
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public Map<String, Object> getRecentPickStkList() {

		Map<String, Object> recentPickStkMap = new HashMap<String, Object>();

		List<Map<String, String>> recentPickStkMapList;

		recentPickStkMapList = this.stockDAO.getRecentPickStockList();

		recentPickStkMap.put("recentPickStkMapList", recentPickStkMapList);
	

		return recentPickStkMap;
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	public Map<String, Object> getExchangeMap( // 환율 리스트 가져오기..

	) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, String>> exchangeList;
		List<Map<String, String>> exchangeWeekList;
		List<Map<String, String>> exchangeMonthList;
		List<Map<String, String>> exchangeYearList;

		exchangeList = this.exchangeDAO.getExchangeUSDList();
		exchangeWeekList = this.exchangeDAO.getWeekUSDList();
		exchangeMonthList = this.exchangeDAO.getMonthUSDList();
		exchangeYearList = this.exchangeDAO.getYearUSDList();

		resultMap.put("exchangeList", exchangeList);
		resultMap.put("exchangeListCnt", exchangeList.size());
		//////////////////////////////////////////////////////////////
		resultMap.put("exchangeWeekList", exchangeWeekList);
		resultMap.put("exchangeWeekListCnt", exchangeWeekList.size());
		//////////////////////////////////////////////////////////////
		resultMap.put("exchangeMonthList", exchangeMonthList);
		resultMap.put("exchangeMonthListCnt", exchangeMonthList.size());
		//////////////////////////////////////////////////////////////
		resultMap.put("exchangeYearList", exchangeYearList);
		resultMap.put("exchangeYearListCnt", exchangeYearList.size());

		return resultMap;
	}

	@RequestMapping(value = "/mainWeb.do")
	public ModelAndView MainWeb(
			HttpSession session
	) {
		
		session.setAttribute("selectPageNo", 1);
		
		
		
		ModelAndView mav = new ModelAndView();

		Map<String, Object> kospiMap = getKospiMap();
		Map<String, Object> kosdaqMap = getKosdaqMap();
		Map<String, Object> stockMap = getWeekStockMap();
		Map<String, Object> stockRateAscMap = getStockRateAscMap();
		Map<String, Object> stockMarketDescMap = getStockMarketDescMap();
		Map<String, Object> articleMap = getArticleResultMap();
		Map<String, Object> stockMarketAmountDescMap = getWeekMarketAmountDescList();
		Map<String, Object> recentPickStkMap = getRecentPickStkList();
		Map<String, Object> kospiListDescMap = getKospiListDescMap();
		Map<String, Object> kosdaqListDescMap = getKosdaqListDescMap();
		List<Map<String, String>> exchangeDescList = getExchangeDescList();

		
		
		
		Map<String, Object> exchangeMap = getExchangeMap();// 최유리

		mav.setViewName("mainWeb.jsp");

		mav.addObject("kospiMap", kospiMap);
		mav.addObject("kosdaqMap", kosdaqMap);
		mav.addObject("stockMap", stockMap);
		mav.addObject("stockRateAscMap", stockRateAscMap);
		mav.addObject("stockMarketDescMap", stockMarketDescMap);
		mav.addObject("articleMap", articleMap);
		mav.addObject("stockMarketAmountDescMap", stockMarketAmountDescMap);
		mav.addObject("recentPickStkMap", recentPickStkMap);

		mav.addObject("exchangeMap", exchangeMap);// 최유리
		mav.addObject("kospiListDescMap", kospiListDescMap);// 
		mav.addObject("kosdaqListDescMap", kosdaqListDescMap);// 
		mav.addObject("exchangeDescList", exchangeDescList);// 
		

		// System.out.println(stockMarketAmountDescResultMap);
		//
		// System.out.println(stockRateAscMap);
		// System.out.println(kospiMap);
		// **************************************************************
		// ModelAndView객체 리턴
		// **************************************************************

		return mav;
	}

	
	// ============================================================================================================================================
	@RequestMapping(value = "searchResultBoard.do")
	public ModelAndView searchResultBoard(

	) {

		// Map<String,Object> boardMap = getBoardSearchResultMap();

		ModelAndView mav = new ModelAndView();
		mav.setViewName("searchResultBoard.jsp");

		// mav.addObject("boardMap",boardMap);

		// **************************************************************
		// ModelAndView객체 리턴
		// **************************************************************

		return mav;
	}
	// ============================================================================================================================================
	
	  @RequestMapping( value="/recentPickProc.do" ,method=RequestMethod.POST
	  ,produces="application/json;charset=UTF-8" )
	  
	  @ResponseBody public Map<String, Object> recentPickProc( 
		  StockDTO stockDTO
		  
	  
	  ) {
		  //아래 한줄이 디비에 넣기 + 눌럿을때.
		  int insertRecentPickStockCnt = stockDAO.insertRecentPickStock(stockDTO);
		  //System.out.println(stockDTO.getRecentPickStk_cd());
		  //System.out.println(stockDTO.getRecentPickStk_nm());
		  //System.out.println(stockDTO.getRecentPickNet_change());
		  
		  //여기부터는 받아와서 뿌려주기.
		  Map<String, Object> resultMap = new HashMap<String, Object>();
		  List<Map<String, String>> recentPickStockList;
		  
		  recentPickStockList = this.stockDAO.getRecentPickStockList();//
		  //되는코드
		  	//System.out.println(recentPickStockList.size());
		  	//System.out.println(recentPickStockList.get(0).get("recentPickNet_change"));
		  //System.out.println(((""+stockDTO.getRecentPickStk_cd()).getClass().getSimpleName()));
		 
		  
		  for(int i=0 ; i<recentPickStockList.size();i++) {
			if(recentPickStockList.get(i).get("recentPickStk_nm").equals(stockDTO.getRecentPickStk_nm())) { 
					 //System.out.println("중복"); 
					 //System.out.println(recentPickStockList.get(i).get("recentPickStk_nm"));
					 stockDAO.deleteRecentPickStock(stockDTO);
					 stockDAO.insertRecentPickStock(stockDTO);
					 break;
			}
		  }
		  //System.out.println(recentPickStockList.get(2).get("recentPickStk_nm"));
		  
		  
		  
		  resultMap.put("insertRecentPickStockCnt", insertRecentPickStockCnt);
		  resultMap.put("recentPickStockList", recentPickStockList);
		  
		  //System.out.println(recentPickStockList);
		  
		  
		  return resultMap;
	  }
	  
	  
	  
	// ============================================================================================================================================
		@RequestMapping(value = "error.do")
		public ModelAndView errorPage(

		) {

			// Map<String,Object> boardMap = getBoardSearchResultMap();

			ModelAndView mav = new ModelAndView();
			mav.setViewName("error.jsp");

			// mav.addObject("boardMap",boardMap);

			// **************************************************************
			// ModelAndView객체 리턴
			// **************************************************************

			return mav;
		}
		// ============================================================================================================================================
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  @RequestMapping( value="/recentPickProc2.do" ,method=RequestMethod.POST
				,produces="application/json;charset=UTF-8" )

		@ResponseBody public Map<String, Object> recentPickProc2( 
				GraphDTO graphDTO
				,StockDTO stockDTO
				
		) {
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			//최근 디비 추가 목록에 한줄 추가
			int insertRecentPickStockCnt = stockDAO.insertRecentPickStock(stockDTO);
			
			  //여기부터는 받아와서 뿌려주기.
		
			  
			  List<Map<String, String>> recentPickStockList;
			  
			  recentPickStockList = this.stockDAO.getRecentPickStockList();//

			for(int i=0 ; i<recentPickStockList.size();i++) {
				if(recentPickStockList.get(i).get("recentPickStk_nm").equals(stockDTO.getRecentPickStk_nm())) { 
					//System.out.println("중복"); 
					//System.out.println(recentPickStockList.get(i).get("recentPickStk_nm"));
					stockDAO.deleteRecentPickStock(stockDTO);
					stockDAO.insertRecentPickStock(stockDTO);
					break;
				}
			}			


	
//			System.out.println(graphDTO.getRecentKeyword());

			resultMap.put("recentPickStkMapList", recentPickStockList);
			resultMap.put("insertRecentPickStockCnt", insertRecentPickStockCnt);
			
			
//			System.out.println(stockDTO.getRecentPickStk_cd());
//			System.out.println(stockDTO.getRecentPickStk_nm());
//			System.out.println(stockDTO.getRecentPickNet_change());
			//System.out.println(recentPickStkMapList);

			return resultMap;
		}
	  
	  
	  
	  @RequestMapping( value="/minusProc.do" ,method=RequestMethod.POST
				,produces="application/json;charset=UTF-8" )

		@ResponseBody public Map<String, Object> minusProc( 
				StockDTO stockDTO
				
		) {
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			
			//최근 디비 추가 목록에 한줄 추가
			System.out.println(stockDTO.getDeleteName());
			int minusCnt = stockDAO.minusPick(stockDTO);
			  //여기부터는 받아와서 뿌려주기.
			List<Map<String, String>> recentPickStockList;
			recentPickStockList = this.stockDAO.getRecentPickStockList();//


			resultMap.put("recentPickStkMapList", recentPickStockList);
		

			return resultMap;
		}	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  @RequestMapping( value="/newsListBoard.do")
		public ModelAndView boardList( 
				
				ArticleDTO 	articleDTO
				,HttpSession session
		){

		  
		  
		  System.out.println(articleDTO.getSelectPageNo()+"===========");
		  if(articleDTO.getSelectPageNo()!=0) { 
			  session.setAttribute("selectPageNo",articleDTO.getSelectPageNo()); 
		  }else {
			  session.setAttribute("selectPageNo",0); 
		  }

		  	articleDTO.setSelectPageNo((int)session.getAttribute("selectPageNo"));
		  	System.out.println(articleDTO.getSelectPageNo());
		  	//System.out.println(articleDTO.getSelectPageNo());
			Map<String,Object> articleMap = getArticleResultMap(articleDTO);
			
			
			//articleMap.put("selectPageNo", session.getAttribute("selectPageNo"));
			//System.out.println(articleDTO.getTitle()); 들어옴 확인 완료
			
			//articleDAO.updateReadcount(articleDTO);
			//System.out.println(resultCnt);
			articleDAO.updateReadcount(articleDTO.getTitle());
			
			
			
			//System.out.println(session.getAttribute("selectPageNo"));
			
			List<Map<String,String>> articleTopMap = articleDAO.getTopArticleList();
			
			Map<String, Object> kospiListDescMap = getKospiListDescMap();
			Map<String, Object> kosdaqListDescMap = getKosdaqListDescMap();
			List<Map<String, String>> exchangeDescList = getExchangeDescList();
			
			ModelAndView mav = new ModelAndView();
			mav.setViewName( "newsListBoard.jsp" );
			mav.addObject(   "articleMap" , articleMap     );
			mav.addObject(   "articleTopMap" , articleTopMap     );
			mav.addObject("kospiListDescMap", kospiListDescMap);// 
			mav.addObject("kosdaqListDescMap", kosdaqListDescMap);// 
			mav.addObject("exchangeDescList", exchangeDescList);// 
			
			
			return  mav;
		}
	  
	  
	  
	  
	  
	  
	  
	  
	  
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	  public Map<String,Object> getArticleResultMap(
			  ArticleDTO articleDTO
			  ){

		  Map<String,Object> articleResultMap = new HashMap<String,Object>();

		  List<Map<String,String>> searchArticleList;

		  int articleListCnt;

		  int articleListCntAll;

		  Map<String,Integer> pagingMap;

		  articleListCntAll = this.articleDAO.getArticleCntAll();

		  articleListCnt = this.articleDAO.getArticleCnt(articleDTO);

		  pagingMap = Util.getPagingMap(
				  articleDTO.getSelectPageNo()
				  , articleDTO.getRowCntPerPage()
				  , articleListCnt
				  );

		  articleDTO.setSelectPageNo((int)pagingMap.get("selectPageNo"));
		  articleDTO.setRowCntPerPage((int)pagingMap.get("rowCntPerPage"));
		  articleDTO.setBegin_rowNo((int)pagingMap.get("begin_rowNo"));
		  articleDTO.setEnd_rowNo((int)pagingMap.get("end_rowNo"));

		  searchArticleList = this.articleDAO.searchArticleList(articleDTO);

		  articleResultMap.put("searchArticleList", searchArticleList);
		  articleResultMap.put("articleListCnt", articleListCnt);
		  articleResultMap.put("articleListCntAll", articleListCntAll);
		  articleResultMap.put("articleDTO", articleDTO);

		  articleResultMap.put("begin_pageNo", pagingMap.get("begin_pageNo"));
		  articleResultMap.put("end_pageNo", pagingMap.get("end_pageNo"));
		  articleResultMap.put("selectPageNo", pagingMap.get("selectPageNo"));
		  articleResultMap.put("last_pageNo", pagingMap.get("last_pageNo"));
		  articleResultMap.put("begin_serialNo_asc", pagingMap.get("begin_serialNo_asc"));
		  articleResultMap.put("begin_serialNo_desc", pagingMap.get("begin_serialNo_desc"));
		  
		  articleResultMap.put("nextPage", pagingMap.get("nextPage"));
          articleResultMap.put("prevPage", pagingMap.get("prevPage"));

		  return articleResultMap;
	  }


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////사전 


	  public Map<String,Object>	searchStockMap(
			  DictionaryDTO dictionaryDTO
			  ){



		  Map<String,Object> stockMap = new HashMap<String,Object>();
		  List<Map<String,String>> searchStockList;

		  int stockDictionaryCnt;
		  int stockDictionaryCntAll;

		  Map<String,Integer> pagingMap;

		  stockDictionaryCntAll = this.dictionaryDAO.getStockDictionaryCntAll();
		  stockDictionaryCnt = this.dictionaryDAO.getStockDictionaryCnt(dictionaryDTO);

		  pagingMap = Util.getStockPagingMap(
				  dictionaryDTO.getSelectPageNo()
				  , dictionaryDTO.getRowCntPerPage()
				  , stockDictionaryCnt
				  );

		  dictionaryDTO.setSelectPageNo((int)pagingMap.get("selectPageNo"));
		  dictionaryDTO.setRowCntPerPage((int)pagingMap.get("rowCntPerPage"));
		  dictionaryDTO.setBegin_rowNo((int)pagingMap.get("begin_rowNo"));
		  dictionaryDTO.setEnd_rowNo((int)pagingMap.get("end_rowNo"));

		  searchStockList = this.dictionaryDAO.searchStockDictionary(dictionaryDTO);

		  stockMap.put("searchStockList", searchStockList);
		  stockMap.put("stockDictionaryCnt", stockDictionaryCnt);
		  stockMap.put("stockDictionaryCntAll", stockDictionaryCntAll);
		  stockMap.put("dictionaryDTO", dictionaryDTO);

		  stockMap.put("begin_pageNo", pagingMap.get("begin_pageNo"));
		  stockMap.put("end_pageNo", pagingMap.get("end_pageNo"));
		  stockMap.put("selectPageNo", pagingMap.get("selectPageNo"));
		  stockMap.put("last_pageNo", pagingMap.get("last_pageNo"));
		  stockMap.put("begin_serialNo_asc", pagingMap.get("begin_serialNo_asc"));
		  stockMap.put("begin_serialNo_desc", pagingMap.get("begin_serialNo_desc"));

		  return stockMap;
	  }
	  /////////////////////////////////////////////////////////유튜브

	  /////////////////////////////////////////////////////////유튜브
		 
		 public Map<String, Object> getYoutubeMap() throws IOException{
				 
			
			 Map<String,Object> youtubeMap=new HashMap<String,Object>();
			 String apiKey = "AIzaSyCRuTfiPujuJaMAqnq_U9owfW5tuaoL350";
					     
					     
					       try {
					            // YouTube API 초기화
					            HttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();
					            JsonFactory jsonFactory = JacksonFactory.getDefaultInstance();
					           
					            
					            // HttpRequestInitializer를 사용하여 API 키를 설정
					            HttpRequestInitializer requestInitializer = new HttpRequestInitializer() {
					                @Override
					                public void initialize(com.google.api.client.http.HttpRequest request) {
					                    // API 키를 설정
					                    request.getHeaders().set("X-Goog-Api-Key", apiKey);
					                }
					            };
					            
					            YouTube youtube = new YouTube.Builder(httpTransport, jsonFactory, requestInitializer)
					                .setApplicationName("Your-Application-Name")
					                .build();
					            // 특정 채널 ID 설정
					            String channelId = "UCwXOKS-z1t9u6Axmm3blXug";
					            // 채널 정보 가져오기
					            YouTube.Channels.List channelsRequest = youtube.channels().list("snippet,statistics,brandingSettings");
					            channelsRequest.setId(channelId);
					            ChannelListResponse channelsResponse = channelsRequest.execute();
					            Channel channel = channelsResponse.getItems().get(0);
					         
					            youtubeMap.put("title", channel.getSnippet().getTitle());
					            youtubeMap.put("description", channel.getSnippet().getDescription());
					            youtubeMap.put("subscriberCount", channel.getStatistics().getSubscriberCount());
					            youtubeMap.put("img", channel.getSnippet().getThumbnails().getDefault().getUrl());
					            youtubeMap.put("link", channel.getSnippet().getCustomUrl());
					           
					         } catch (Exception e) {
					            e.printStackTrace();
					        }
					       try {
					            // YouTube API 초기화
					            HttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();
					            JsonFactory jsonFactory = JacksonFactory.getDefaultInstance();
					           
					            
					            // HttpRequestInitializer를 사용하여 API 키를 설정
					            HttpRequestInitializer requestInitializer = new HttpRequestInitializer() {
					                @Override
					                public void initialize(com.google.api.client.http.HttpRequest request) {
					                    // API 키를 설정
					                    request.getHeaders().set("X-Goog-Api-Key", apiKey);
					                }
					            };
					            
					            YouTube youtube = new YouTube.Builder(httpTransport, jsonFactory, requestInitializer)
					                .setApplicationName("Your-Application-Name")
					                .build();
					            // 특정 채널 ID 설정
					            String channelId = "UCYMWMtXQPtWHKcxeay8cMuQ";
					            // 채널 정보 가져오기
					            YouTube.Channels.List channelsRequest = youtube.channels().list("snippet,statistics,brandingSettings");
					            channelsRequest.setId(channelId);
					            ChannelListResponse channelsResponse = channelsRequest.execute();
					            Channel channel = channelsResponse.getItems().get(0);
					         
					            youtubeMap.put("title1", channel.getSnippet().getTitle());
					            youtubeMap.put("description1", channel.getSnippet().getDescription());
					            youtubeMap.put("subscriberCount1", channel.getStatistics().getSubscriberCount());
					            youtubeMap.put("img1", channel.getSnippet().getThumbnails().getDefault().getUrl());
					            youtubeMap.put("link1", channel.getSnippet().getCustomUrl());
					           
					         } catch (Exception e) {
					            e.printStackTrace();
					        }
					       try {
					            // YouTube API 초기화
					            HttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();
					            JsonFactory jsonFactory = JacksonFactory.getDefaultInstance();
					           
					            
					            // HttpRequestInitializer를 사용하여 API 키를 설정
					            HttpRequestInitializer requestInitializer = new HttpRequestInitializer() {
					                @Override
					                public void initialize(com.google.api.client.http.HttpRequest request) {
					                    // API 키를 설정
					                    request.getHeaders().set("X-Goog-Api-Key", apiKey);
					                }
					            };
					            
					            YouTube youtube = new YouTube.Builder(httpTransport, jsonFactory, requestInitializer)
					                .setApplicationName("Your-Application-Name")
					                .build();
					            // 특정 채널 ID 설정
					            String channelId = "UCT2ZyrFL2JyLIdwwTUG_zpg";
					            // 채널 정보 가져오기
					            YouTube.Channels.List channelsRequest = youtube.channels().list("snippet,statistics,brandingSettings");
					            channelsRequest.setId(channelId);
					            ChannelListResponse channelsResponse = channelsRequest.execute();
					            Channel channel = channelsResponse.getItems().get(0);
					         
					            youtubeMap.put("title2", channel.getSnippet().getTitle());
					            youtubeMap.put("description2", channel.getSnippet().getDescription());
					            youtubeMap.put("subscriberCount2", channel.getStatistics().getSubscriberCount());
					            youtubeMap.put("img2", channel.getSnippet().getThumbnails().getDefault().getUrl());
					            youtubeMap.put("link2", channel.getSnippet().getCustomUrl());
					           
					         } catch (Exception e) {
					            e.printStackTrace();
					        }
					       try {
					            // YouTube API 초기화
					            HttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();
					            JsonFactory jsonFactory = JacksonFactory.getDefaultInstance();
					           
					            
					            // HttpRequestInitializer를 사용하여 API 키를 설정
					            HttpRequestInitializer requestInitializer = new HttpRequestInitializer() {
					                @Override
					                public void initialize(com.google.api.client.http.HttpRequest request) {
					                    // API 키를 설정
					                    request.getHeaders().set("X-Goog-Api-Key", apiKey);
					                }
					            };
					            
					            YouTube youtube = new YouTube.Builder(httpTransport, jsonFactory, requestInitializer)
					                .setApplicationName("Your-Application-Name")
					                .build();
					            // 특정 채널 ID 설정
					            String channelId = "UCaQREsefLy-W8ruWcJ7IDtg";
					            // 채널 정보 가져오기
					            YouTube.Channels.List channelsRequest = youtube.channels().list("snippet,statistics,brandingSettings");
					            channelsRequest.setId(channelId);
					            ChannelListResponse channelsResponse = channelsRequest.execute();
					            Channel channel = channelsResponse.getItems().get(0);
					         
					            youtubeMap.put("title3", channel.getSnippet().getTitle());
					            youtubeMap.put("description3", channel.getSnippet().getDescription());
					            youtubeMap.put("subscriberCount3", channel.getStatistics().getSubscriberCount());
					            youtubeMap.put("img3", channel.getSnippet().getThumbnails().getDefault().getUrl());
					            youtubeMap.put("link3", channel.getSnippet().getCustomUrl());
					           
					         } catch (Exception e) {
					            e.printStackTrace();
					        }
					      
					       return youtubeMap;
					      
			}
	  
	///////////////////////////////////////////////////////////////////
	
	@RequestMapping (value="stockDictionary.do")
	public ModelAndView stockDictionary(
			DictionaryDTO 	dictionaryDTO
			,HttpSession session
			,@RequestParam(value="keyword", required=false) String keyword
			,HttpServletResponse response
	
			) throws IOException {
		
		
		session.setAttribute("selectPageNo", 1);
	
		Map<String,Object> stockMap = searchStockMap(dictionaryDTO);
		Map<String,Object> youtubeMap = getYoutubeMap();
		
		Map<String, Object> kospiListDescMap = getKospiListDescMap();
		Map<String, Object> kosdaqListDescMap = getKosdaqListDescMap();
		List<Map<String, String>> exchangeDescList = getExchangeDescList();

	
	
	
		ModelAndView mav = new ModelAndView();
		mav.setViewName("stockDictionary.jsp");
		mav.addObject(   "stockMap" , stockMap     );
		mav.addObject(   "youtubeMap" , youtubeMap  );
		
		mav.addObject("kospiListDescMap", kospiListDescMap);// 
		mav.addObject("kosdaqListDescMap", kosdaqListDescMap);// 
		mav.addObject("exchangeDescList", exchangeDescList);// 
		
		
		session.setAttribute( "keyword", keyword );
		if(keyword==null){
	
			Cookie cookie1 = new Cookie("keyword",null);
			cookie1.setMaxAge(0);
			response.addCookie(cookie1);
		}
		else {
			Cookie cookie1 = new Cookie("keyword",keyword);
			// Cookie 객체에 저장된 쿠키의 수명은 60*60*24으로 하기
			cookie1.setMaxAge(60*60*24);
			response.addCookie(cookie1);
	
		}
	
		return  mav;
	
	}
	
	
	
	

	  
	  
	  
	  
	  
	  
	  
	  
	 

}
