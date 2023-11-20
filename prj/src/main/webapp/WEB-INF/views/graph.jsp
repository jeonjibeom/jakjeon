
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<html>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.0/dist/Chart.min.js"></script>  
<%@include file="/WEB-INF/views/graphHelper.jsp" %>
<%@include file="/WEB-INF/views/sideBar.jsp" %>
<style>
	.a:link{
		font-weight: bold;
		color: black;
		text-decoration: none;
	}
	.a:visited{
		color: gray;
		text-decoration: none;
	}
	.a:hover{
		text-decoration: underline;
	}
	.a:active{
		color: blue;
	}
</style>
<script>





$(function(){
	window.onpageshow = function(event) {
	    //back 이벤트 일 경우
	    if (event.persisted) {
	              ﻿location.reload(true);﻿
	    }
	}

	//case by JQuery
	$(window).bind("pageshow", function(event) {
	    //back 이벤트 일 경우
	    if (event.originalEvent && event.originalEvent.persisted){
	              //todo
	              ﻿location.reload(true);﻿
	    }
	});
	if(${requestScope.errMsg.length()}>2){
		alert("${requestScope.errMsg}")
		location.replace('/mainWeb.do')
	}

 })
 
function init(){
	   // 검색 누르면 실행되는 함수

}

function search(){
	   //alert("123")
	   document.maingraph1.submit();
}
function search2(recentPickStk_nm){
	//alert(recentPickStk_nm);   
	$("[name=keyword]").val(recentPickStk_nm);
	search();
	   
}

function xxx(obj){
	obj.show();
	obj.nextAll().hide();
	obj.prevAll().hide();
}

function recentPlus(){
	//alert($(".recentPick").val());
	
	ajax(
			   //WAS로 접속할 주소
			   "/recentPickProc2.do"
			   //WAS로 접속할 방법
			   ,"post"
			   //입력양식을 끌어안고 있는 form태그 관리 JQuery 객체 메위주
			   ,$("[name='recentPick']") // 위에다가 form 태그의 메위주를 구해놨음
			   //WAS와의 통신이 성공했을때 호출되는 익명함수.
			   //현재 익명함수의 매개변수로 JSON이 들어온다.
			   //이 JSON안에 수정 실행 결과 정보가 들어있다.
			   ,function(JsonResultMap){
				   //alert("호출성공")
					
				   var insertCnt = JsonResultMap["insertRecentPickStockCnt"];
				   var recentPickStockList = JsonResultMap["recentPickStkMapList"];
				   
				   //alert(insertCnt);
				   //1이 아니면 오류 -
				
				   	
					//alert("호출완료");
				   //alert(recentPickStockList[7].recentPickStk_nm); 셀트리온 출력
				   //alert(recentPickStockList.length)
				   
				  
				   if(recentPickStockList[recentPickStockList.length-1].recentPickNet_change>0){
					   
					   $(".recentList").append("<a class='a' href=\"javascript:search2('"+recentPickStockList[recentPickStockList.length-1].recentPickStk_nm+"')\">"+recentPickStockList[recentPickStockList.length-1].recentPickStk_nm+"</a>"
							   +""
							   +"<span style='float:right; color:red;'>▲"+recentPickStockList[recentPickStockList.length-1].recentPickNet_change+"&nbsp;"+
							   
							   "<img src='/img/minus_square_icon_128806.png' onClick='recentPlus('recentPick${vs.count}')' style='width: 20px; height: 20px; cursor:pointer;'>"
							   
							   +"</span>"+"<br>")

					  
				   }else{
					   $(".recentList").append("<a class='a' href=\"javascript:search2('"+recentPickStockList[recentPickStockList.length-1].recentPickStk_nm+"')\">"+recentPickStockList[recentPickStockList.length-1].recentPickStk_nm+"</a>"
							   +""
							   +"<span style='float:right; color:blue;'>▼"+recentPickStockList[recentPickStockList.length-1].recentPickNet_change+"&nbsp;"+
							   
							   "<img src='/img/minus_square_icon_128806.png' onClick='recentPlus('recentPick${vs.count}')' style='width: 20px; height: 20px; cursor:pointer;'>"
							   
							   +"</span>"+"<br>")
				   }
				
				   					   
				   //alert("진행완료")
				   //alert(recentPickStockList.length)
				   
				   
			   }
	   );
}

function minus(formName){
	
	
	//alert("마이너함수 작동")
	ajax(
			   //WAS로 접속할 주소
			   "/minusProc.do"
			   //WAS로 접속할 방법
			   ,"post"
			   //입력양식을 끌어안고 있는 form태그 관리 JQuery 객체 메위주
			   ,$("[name='"+formName+"']") // 위에다가 form 태그의 메위주를 구해놨음
			   //WAS와의 통신이 성공했을때 호출되는 익명함수.
			   //현재 익명함수의 매개변수로 JSON이 들어온다.
			   //이 JSON안에 수정 실행 결과 정보가 들어있다.
			   ,function(JsonResultMap){
				   //alert("호출성공")
					
				   //var insertCnt = JsonResultMap["insertRecentPickStockCnt"];
				   //var recentPickStockList = JsonResultMap["recentPickStockList"];
				   var recentPickStockList = JsonResultMap["recentPickStkMapList"];
				  
				   
				   //alert(recentPickStockList[0].recentPickStk_nm);
				
				   $("[name='"+formName+"']").hide()						   
			   }
	   );
	
	
}

function selectMiniGraph(){
	alert("selectMiniGraph()함수 실행" );
}

function clickDot(a,b,c,d){
	//alert(a);
	//alert(b);
	//alert(c);
	//alert(d);
	$(".clickDot").text("  고가 : "+a+"  저가 : "+b+"  시가 : "+c+"  거래량 : "+d)
	
}
function returnLabel(label){
	return label;	
}

function showDateArticle(label){
	
	$(".dateNews").text(label+" 뉴스");
	
	$(".originalNews").hide();
	//$(".dateNewsSub").show();
	
	
}








</script>

<body>

	<!------------ 여기서 부터 게시판  ------------------->
	<section class="home-section">
		<div class="home-content">
			<i class="bx bx-menu"></i>
			<div class="wrap1">
				<div class="search1">
				
					<form name="maingraph1" method="post" action="/graph.do">
					<input type="text" name="keyword" class="searchTerm1" placeholder="Search...">
					</form>
					
					 <button type="submit" class="searchButton1" onClick="search();">
						 <i class="fa fa-search"></i>
						</button>
				 </div>
			</div>
			
		</div>
		<!-- -------- 여기 밑 부터 디자인 하면됨 --------------->
		<!------------- 첫째줄 시작--------------->
		<div class="cardBox_1">
			<!---------------첫째줄------------------->
			<div class="card_1">
				<div>
					<div class="numbers_1">${requestScope.kospiListDescMap.kospiListDesc[0].previous_close}</div>
					<div class="cardName_1">KOSPI</div>
				</div>
				<div class="iconBx">
					<ion-icon name="analytics-outline"></ion-icon>
				</div>
			</div>
			<!--------------------------------------------->
			<div class="card_1">
				<div>
					<div class="numbers_1">${requestScope.kosdaqListDescMap.kosdaqListDesc[0].previous_close}</div>
					<div class="cardName_1">KOSDAQ</div>
				</div>
				<div class="iconBx">
					<ion-icon name="trending-down-outline"></ion-icon>
				</div>
			</div>
			<!--------------------------------------------->
			<div class="card_1">
				<div>
					<div class="numbers_1">12,789.48</div>
					<div class="cardName_1">NASDAQ</div>
				</div>
				<div class="iconBx">
					<ion-icon name="trending-up-outline"></ion-icon>
				</div>
			</div>
			<!--------------------------------------------->
			<div class="card_1">
				<div>
					<div class="numbers_1">${requestScope.exchangeDescList[0].USD}</div>
					<div class="cardName_1">환율</div>
				</div>
				<div class="iconBx">
					<ion-icon name="cash-outline"></ion-icon>
				</div>
			</div>
		</div>
		<!------------- 첫째줄 끝--------------->
		<!------------- 둘째줄 시작--------------->
		<div class="cardBox_2">
			<div class="card_2">
				<div style=" margin-left:10%;">
					<form name="recentPick">
					
						<div>
							<span style="font-size: 60px; ">${requestScope.keyword}</span>
							
							<img src="/img/047add1_99902.png" onClick="recentPlus()"
							style="width: 65px; height: 65px; cursor: pointer; margin-bottom: 30px; margin-left: 20px;">
							<br>
							
						</div>

						<p>
							<input type="hidden" name="recentKeyword"
								value="${requestScope.keyword}">






							<c:forEach var="map"
								items="${requestScope.weekStockMap.stockList}" varStatus="vs">

								<c:if test="${map.stk_nm==requestScope.keyword}">

									<input class="recentPickStk_cd" name="recentPickStk_cd"
										type="hidden" value="${map.stk_cd}">
									<input class="recentPickStk_nm" name="recentPickStk_nm"
										type="hidden" value="${map.stk_nm}">
									<input class="recentPickNet_change" name="recentPickNet_change"
										type="hidden" value="${map.net_change}">

								</c:if>



							</c:forEach>
						
							<span style="font-size: 20px; margin-left: 10px;;">전일대비</span>
							
							<c:forEach var="map"
								items="${requestScope.weekStockMap.stockList}" varStatus="vs">
								<c:if test="${map.stk_nm==requestScope.keyword}">
									<c:if test="${map.net_change>0}">
										<span style="color: red">▲${map.net_change} ${map.rate} %</span>
									</c:if>
									<c:if test="${map.net_change<0}">
										<span style="color: blue">▼${map.net_change} ${map.rate} %&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
									</c:if>
								</c:if>
							</c:forEach>
							
							<span class="clickDot" >
							</span>
						
					</form>
					
				</div>
			</div>
			<!--------------------------------------------->
			
			<!--------------------------------------------->
		</div>
		<!------------- 둘째줄 끝--------------->
		<!------------- 셋째줄 시작--------------->

		<!------------- 셋째줄 끝--------------->
		<!------------- 넷째줄 시작--------------->
		
		<div class="cardBox_4">
		
			<div class="card_4">
				<div>
					<div class="week1" onClick="xxx($('.weekChart'))"
						style="width: 270px; height: 70px; border: 1px solid #6a51c2; float: left; cursor: pointer; text-align:center; padding:20px;">1주</div>
					<div class="month1" onClick="xxx($('.monthChart'))"
						style="width: 270px; height: 70px; border: 1px solid #6a51c2; float: left; cursor: pointer; text-align:center; padding:20px;">1개월</div>
					<div class="year1" onClick="xxx($('.yearChart'))"
						style="width: 270px; height: 70px; border: 1px solid #6a51c2; float: left; cursor: pointer; text-align:center; padding:20px;">1년</div>

					<div style="margin-top: 15%;">
						<div class="mainThreeChart"
							style="width: 810px; height: 600px;  float: left;">
							<div class="weekChart"
								style="width: 100%; height: 600px;  float: left; display: none;">
								<canvas id="line_chart"></canvas>
							</div>
							<div class="monthChart"
								style="width: 100%; height: 600px;  float: left; display: none;">
								<canvas id="line_chart2"></canvas>
							</div>
							<div class="yearChart"
								style="width: 100%; height: 600px;  float: left;">
								<canvas id="line_chart3"></canvas>
							</div>

						</div>
					</div>
				</div>
			</div>
			<!--------------------------------------------->
			<div class="card_4_1">
				<div>
					<div
						style="width: 400px; height: 600px;  float: left;">
						<div class="dateNews"
							style="width: 380px; height: 50px; color:#6F61C0; font-weight: bold; font-size: 27px;">관련뉴스</div>
						<div class="dateNewsSub"
							style="width: 380px; height: 500px;">
							<c:forEach var="map"
								items="${requestScope.articleMap.articleKeywordList}" begin="0"
								end="9" varStatus="vs" step="1">
								<hr>
								<div class="originalNews"
									style="width: 400px;  ">
									<a class="a" target="blank" href="${map.link}">${map.title}</a>
								</div>
								

							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			<!--------------------------------------------->
			<div class="card_4_2">
				<div>
					
						<div style="width: 205%; color:#6F61C0; font-size: 20px; font-weight: bold;  float: left; ">
						[관심추가]
						<hr style="width:325px">
						</div><br><br>
						<div class="recentList"
							style="width: 320px; height: 680px; ">


							<c:forEach var="map"
								items="${requestScope.recentPickStkMap.recentPickStkMapList}"
								begin="0" end="10" varStatus="vs" step="1">

								<form name="delete${vs.count}">
									<input type="hidden" name="deleteName"
										value="${map.recentPickStk_nm}">
									<c:if test="${map.recentPickNet_change>0}">
										<%-- <form name="interest${vs.count}" method="post" action="/graph.do"> --%>
										<a class="a" href="javascript:event(search2('${map.recentPickStk_nm}'))">${map.recentPickStk_nm}</a>

										<span style="float: right; color: red; ">▲${map.recentPickNet_change}
										<!-- </form> -->
										<img src="/img/minus_square_icon_128806.png"
											onClick="minus('delete${vs.count}')"
											style="width: 20px; height: 20px; cursor: pointer;">
											</span>
										<br>

									</c:if>

									<c:if test="${map.recentPickNet_change<0}">
										<%-- <form name="interest${vs.count}" method="post" action="/graph.do"> --%>
										<a class="a" href="javascript:event(search2('${map.recentPickStk_nm}'))">${map.recentPickStk_nm}</a>
										<span style="float: right; color: blue;">▼${map.recentPickNet_change}
										<!-- </form> -->
										<img src="/img/minus_square_icon_128806.png"
											onClick="minus('delete${vs.count}')"
											style="width: 20px; height: 20px; cursor: pointer;">
											</span>
										<br>

									</c:if>
								</form>

							</c:forEach>

						</div>

				</div>

			</div>
			<!--------------------------------------------->
		</div>
		<!------------- 넷째줄 끝--------------->
		<!------------- 다섯째줄 시작--------------->
		<div class="cardBox_5">
			<div class="card_5">
				<div>
					<div class="miniGraphOne" style="width:800px; height:500px;  float:left; margin-top:5%; margin-left: 5%" ><canvas id="mini-chart"></canvas></div>
				</div>

			</div>
			<!--------------------------------------------->
			<div class="card_5">
				<div>
					<div class="miniGraphTwo" style="width:800px; height:500px; margin-top:5%;  margin-right: 10%" ><canvas id="mini-chart2"></canvas></div>
				</div>

			</div>
			<!--------------------------------------------->
		</div>
		<!------------- 다섯째줄 끝--------------->
		<!------------- 여섯째줄 시작--------------->
		<div class="cardBox_6">
			<div class="card_6">
				
				<div style="margin-left: 7%;">
				<div style="color: #6F61C0; font-size: 30px; font-weight: bold; text-align:center;">[재무제표]</div>
				<br>
						<table class="t1" style="cursor: auto;">
							<%-- <caption>[새글쓰기]</caption> --%>
							<tr>
								<th bgcolor="#6F61C0" style="color: white;">-</th>
								<th>2019/12</th>
								<th>2020/12</th>
								<th>2021/12</th>
								<th>2022/12</th>
							</tr>
							<tr>
								<th bgcolor="#6F61C0" style="color: white;">매출액</th>

								<c:forEach var="map"
									items="${requestScope.financialStatementsMap.financialStatementsList}"
									varStatus="vs" step="1">

									<c:if test="${map.stk_nm==requestScope.keyword}">

										<td>${map.sales}</td>

									</c:if>

								</c:forEach>

							</tr>
							<tr>
								<th bgcolor="#6F61C0" style="color: white;">매출원가</th>
								<c:forEach var="map"
									items="${requestScope.financialStatementsMap.financialStatementsList}"
									varStatus="vs" step="1">

									<c:if test="${map.stk_nm==requestScope.keyword}">

										<td>${map.sales_cost}</td>

									</c:if>

								</c:forEach>
							</tr>
							<tr>
								<th bgcolor="#6F61C0" style="color: white;">매출총이익</th>
								<c:forEach var="map"
									items="${requestScope.financialStatementsMap.financialStatementsList}"
									varStatus="vs" step="1">

									<c:if test="${map.stk_nm==requestScope.keyword}">

										<td>${map.margin}</td>

									</c:if>

								</c:forEach>
							</tr>
							<tr>
								<th bgcolor="#6F61C0" style="color: white;">판매비와관리비</th>
								<c:forEach var="map"
									items="${requestScope.financialStatementsMap.financialStatementsList}"
									varStatus="vs" step="1">

									<c:if test="${map.stk_nm==requestScope.keyword}">

										<td>${map.sell_admin_cost}</td>

									</c:if>

								</c:forEach>
							</tr>
							<tr>
								<th bgcolor="#6F61C0" style="color: white;">영업이익</th>
								<c:forEach var="map"
									items="${requestScope.financialStatementsMap.financialStatementsList}"
									varStatus="vs" step="1">

									<c:if test="${map.stk_nm==requestScope.keyword}">

										<td>${map.business_profit}</td>

									</c:if>

								</c:forEach>
							</tr>
							<tr>
								<th bgcolor="#6F61C0" style="color: white;">영업이익(발표기준)</th>
								<c:forEach var="map"
									items="${requestScope.financialStatementsMap.financialStatementsList}"
									varStatus="vs" step="1">

									<c:if test="${map.stk_nm==requestScope.keyword}">

										<td>${map.business_profit_official}</td>

									</c:if>

								</c:forEach>
							</tr>
							<tr>
								<th bgcolor="#6F61C0" style="color: white;">금융수익</th>
								<c:forEach var="map"
									items="${requestScope.financialStatementsMap.financialStatementsList}"
									varStatus="vs" step="1">

									<c:if test="${map.stk_nm==requestScope.keyword}">

										<td>${map.financial_returns}</td>

									</c:if>

								</c:forEach>
							</tr>
							<tr>
								<th bgcolor="#6F61C0" style="color: white;">금융원가</th>
								<c:forEach var="map"
									items="${requestScope.financialStatementsMap.financialStatementsList}"
									varStatus="vs" step="1">

									<c:if test="${map.stk_nm==requestScope.keyword}">

										<td>${map.financial_cost}</td>

									</c:if>

								</c:forEach>
							</tr>
							<tr>
								<th bgcolor="#6F61C0" style="color: white;">기타수익</th>
								<c:forEach var="map"
									items="${requestScope.financialStatementsMap.financialStatementsList}"
									varStatus="vs" step="1">

									<c:if test="${map.stk_nm==requestScope.keyword}">

										<td>${map.other_revenues}</td>

									</c:if>

								</c:forEach>
							</tr>
							<tr>
								<th bgcolor="#6F61C0" style="color: white;">기타비용</th>
								<c:forEach var="map"
									items="${requestScope.financialStatementsMap.financialStatementsList}"
									varStatus="vs" step="1">

									<c:if test="${map.stk_nm==requestScope.keyword}">

										<td>${map.ohter_expenses}</td>

									</c:if>

								</c:forEach>
							</tr>
							<tr>
								<th bgcolor="#6F61C0" style="color: white;">종속기업,공동지배기업및관계기업관련손익</th>
								<c:forEach var="map"
									items="${requestScope.financialStatementsMap.financialStatementsList}"
									varStatus="vs" step="1">

									<c:if test="${map.stk_nm==requestScope.keyword}">

										<td>${map.control_firms_profit}</td>

									</c:if>

								</c:forEach>
							</tr>
							<tr>
								<th bgcolor="#6F61C0" style="color: white;">세전계속사업이익</th>
								<c:forEach var="map"
									items="${requestScope.financialStatementsMap.financialStatementsList}"
									varStatus="vs" step="1">

									<c:if test="${map.stk_nm==requestScope.keyword}">

										<td>${map.pre_tax_con_business_profit}</td>

									</c:if>

								</c:forEach>
							</tr>
							<tr>
								<th bgcolor="#6F61C0" style="color: white;">법인세비용</th>
								<c:forEach var="map"
									items="${requestScope.financialStatementsMap.financialStatementsList}"
									varStatus="vs" step="1">

									<c:if test="${map.stk_nm==requestScope.keyword}">

										<td>${map.corporate_tax}</td>

									</c:if>

								</c:forEach>
							</tr>
							<tr>
								<th bgcolor="#6F61C0" style="color: white;">계속영업이익</th>
								<c:forEach var="map"
									items="${requestScope.financialStatementsMap.financialStatementsList}"
									varStatus="vs" step="1">

									<c:if test="${map.stk_nm==requestScope.keyword}">

										<td>${map.con_operating_profit}</td>

									</c:if>

								</c:forEach>
							</tr>
							<tr>
								<th bgcolor="#6F61C0" style="color: white;">중단영업이익</th>
								<c:forEach var="map"
									items="${requestScope.financialStatementsMap.financialStatementsList}"
									varStatus="vs" step="1">

									<c:if test="${map.stk_nm==requestScope.keyword}">

										<td>${map.interrupted_oreration_profit}</td>

									</c:if>

								</c:forEach>
							</tr>
							<tr>
								<th bgcolor="#6F61C0" style="color: white;">당기순이익</th>
								<c:forEach var="map"
									items="${requestScope.financialStatementsMap.financialStatementsList}"
									varStatus="vs" step="1">

									<c:if test="${map.stk_nm==requestScope.keyword}">

										<td>${map.net_income}</td>

									</c:if>

								</c:forEach>
							</tr>
							<tr>
								<th bgcolor="#6F61C0" style="color: white;">지배주주순이익</th>
								<c:forEach var="map"
									items="${requestScope.financialStatementsMap.financialStatementsList}"
									varStatus="vs" step="1">

									<c:if test="${map.stk_nm==requestScope.keyword}">

										<td>${map.control_income}</td>

									</c:if>

								</c:forEach>
							</tr>
							<tr>
								<th bgcolor="#6F61C0" style="color: white;">비지배주주순이익</th>
								<c:forEach var="map"
									items="${requestScope.financialStatementsMap.financialStatementsList}"
									varStatus="vs" step="1">

									<c:if test="${map.stk_nm==requestScope.keyword}">

										<td>${map.non_control_income}</td>

									</c:if>

								</c:forEach>
							</tr>




						</table>
					
				</div>
			</div>
			<!--------------------------------------------->
		</div>
		<!------------- 여섯째줄 끝--------------->
	</section>
	<!-- 펼쳐지는 자스 -->
		<!-- 삭제하면 화면 움직이는거 안됨 -->
	<script>
        let arrow = document.querySelectorAll(".arrow");
        for (var i = 0; i < arrow.length; i++) {
            arrow[i].addEventListener("click", (e)=>{
                let arrowParent = e.target.parentElement.parentElement;
                console.log(arrowParent);
                arrowParent.classList.toggle("showMenu");
            });
        }

        let sidebar = document.querySelector(".sidebar");
        let sidebarBtn = document.querySelector(".bx-menu");
        sidebarBtn.addEventListener("click",()=>{
            sidebar.classList.toggle("close");
        });
    </script>
</body>
<script>

///로직







//주에 대한 거 뽑기.
//////////////////////////////////////////////////////////////////////////

		//주 날짜 뽑기
		var weekArr = [];
		var weekArticle = [];
		var cnt = 0;
		<c:forEach var="map" items="${requestScope.allDateMap.weekDateList}" varStatus="vs">		
			
			weekArr.push("${map.week_date}");
			
			
			<c:forEach var="map" items="${requestScope.articleMap.articleKeywordList}" varStatus="vs">
		
				<c:if test="${map.week_date==map2.reg_date}">
				
					cnt++;
				
				</c:if>

			</c:forEach>
		
		</c:forEach>
		
		//alert("${requestScope.articleMap.articleKeywordList[0]}")
		//alert(cnt);
		
		//alert("${requestScope.articleMap.articleKeywordList[0].title}");
		//alert(weekArticle);
		
		
		
		///주 날짜에 대응하는 c-prc값 뽑기.\
		var weekArrStk = [];
		<c:forEach var="map" items="${requestScope.weekAllStockMap.weekAllStockList}" varStatus="vs">
		
			<c:if test="${map.stk_nm==requestScope.keyword}">
				weekArrStk.push("${map.c_prc}")
			
				
			</c:if>
			
		
		
		</c:forEach>


		//alert(weekArr);

		
//월에 대한 거 뽑기.
//////////////////////////////////////////////////////////////////////////

		//월 날짜 뽑기
		var monthArr = [];
		<c:forEach var="map" items="${requestScope.allDateMap.monthDateList}" varStatus="vs">
		
			
		
			
			monthArr.push("${map.month_date}");
			
				
		
		</c:forEach>
		
		//월 날짜에 대응하는 c-prc값 뽑기.\
		var monthArrStk = [];
		<c:forEach var="map" items="${requestScope.monthAllStockMap.monthAllStockList}" varStatus="vs">
		
			<c:if test="${map.stk_nm==requestScope.keyword}">
				monthArrStk.push("${map.c_prc}")
				
				
			</c:if>
			
	
		
		</c:forEach>

		
//년에 대한 거 뽑기.
//////////////////////////////////////////////////////////////////////////

		//월 날짜 뽑기
		var yearArr = [];
		<c:forEach var="map" items="${requestScope.allDateMap.yearDateList}" varStatus="vs">
		
			
		
			
			yearArr.push("${map.year_date}");
			
				
		
		</c:forEach>
		
		//월 날짜에 대응하는 c-prc값 뽑기.\
		var yeaArrStk = [];
		<c:forEach var="map" items="${requestScope.yearAllStockMap.yearAllStockList}" varStatus="vs">
		
			<c:if test="${map.stk_nm==requestScope.keyword}">
				yeaArrStk.push("${map.c_prc}")
				
				
			</c:if>
			
	
		
		</c:forEach>	
		
////////////////////////////////////////////////////////////////////////////////////
// mini 그래프 데이터 추출.
		
		
		
		var sales = [];
		var business_profit = [];
		var pre_tax_profit = [];
		var net_profit = [];
		
		var sales_rate = [];
		var business_profit_rate = [];
		var eitda_rate = [];
		var net_profit_rate = [];	
		var debt_rate = [];
		
		
		<c:forEach var="map" items="${requestScope.serveralRateMap.serveralRateList}" varStatus="vs">
		
			<c:if test="${map.stk_nm==requestScope.keyword}">
			
				sales.push("${map.sales}");
				business_profit.push("${map.business_profit}");
				pre_tax_profit.push("${map.pre_tax_profit}");
				net_profit.push("${map.net_profit}");
				
				sales_rate.push("${map.sales_rate}");
				business_profit_rate.push("${map.business_profit_rate}");
				eitda_rate.push("${map.eitda_rate}");
				net_profit_rate.push("${map.net_profit_rate}");	
				debt_rate.push("${map.debt_rate}");	
			</c:if>

		
		</c:forEach>
		
		
		
		
		
		
		
		
 ////////////////////////////////////////////////////////////////////////////
 
 var year_h_prc = [];
 var year_l_prc = [];
 var year_o_prc = [];
 var year_market = [];
 <c:forEach var="map" items="${requestScope.yearAllStockMap.yearAllStockList}" varStatus="vs">
		
			<c:if test="${map.stk_nm==requestScope.keyword}">
				//yeaArrStk.push("${map.c_prc}"); 한번더 넣으면 안됨
				year_h_prc.push("${map.h_prc}")
				year_l_prc.push("${map.l_prc}")
				year_o_prc.push("${map.o_prc}")
				year_market.push("${map.market}")
				
			</c:if>
			
	
		
</c:forEach>

var month_h_prc = [];
var month_l_prc = [];
var month_o_prc = [];
var month_market = [];
<c:forEach var="map" items="${requestScope.monthAllStockMap.monthAllStockList}" varStatus="vs">
		
			<c:if test="${map.stk_nm==requestScope.keyword}">
				//yeaArrStk.push("${map.c_prc}"); 한번더 넣으면 안됨
				month_h_prc.push("${map.h_prc}")
				month_l_prc.push("${map.l_prc}")
				month_o_prc.push("${map.o_prc}")
				month_market.push("${map.market}")
				
			</c:if>
			
	
		
</c:forEach>


var week_h_prc = [];
var week_l_prc = [];
var week_o_prc = [];
var week_market = [];
<c:forEach var="map" items="${requestScope.weekAllStockMap.weekAllStockList}" varStatus="vs">
		
			<c:if test="${map.stk_nm==requestScope.keyword}">
				//yeaArrStk.push("${map.c_prc}"); 한번더 넣으면 안됨
				week_h_prc.push("${map.h_prc}")
				week_l_prc.push("${map.l_prc}")
				week_o_prc.push("${map.o_prc}")
				week_market.push("${map.market}")
				
			</c:if>
			
	
		
</c:forEach>







 
 
 var context = document
        .getElementById('line_chart3')
        .getContext('2d');

 
 var line_chart3 = new Chart(context, {
		    type: 'line',
		    data: {
		      labels: yearArr,
		      datasets: [{ 
		          data: yeaArrStk,
		          label: "${requestScope.boardMap.boardList[0].subject}",
		          borderColor: "#6F61C0",
		          fill: false
		          ,lineTension : 0
		          ,pointBorderWidth: 5
		        }
		      ]
		    },
		    options: {
		        title: {
		          display: true
		        }
		      }
		  });
	

    document.getElementById("line_chart3").onclick = function(evt) {
    	
        var activePoints = line_chart3.getElementsAtEvent(evt);
    	
        if(activePoints.length > 0)
        {
            var clickedElementindex = activePoints[0]["_index"];
            
            clickDot(year_h_prc[clickedElementindex],year_l_prc[clickedElementindex],year_o_prc[clickedElementindex],year_market[clickedElementindex]);
            //alert(year_h_prc[clickedElementindex])
           
            
            var label = line_chart3.data.labels[clickedElementindex];
          
            console.log("label : " + label);

            var value = line_chart3.data.datasets[0].data[clickedElementindex];
            console.log("value : " + value);
        }
    }

////////////////////////////////////////////////////////////////////////////////////
 var context2 = document
        .getElementById('line_chart2')
        .getContext('2d');

 
 var line_chart2 = new Chart(context2, {
		    type: 'line',
		    data: {
		      labels: monthArr,
		      datasets: [{ 
		          data: monthArrStk,
		          label: "${requestScope.boardMap.boardList[0].subject}",
		          borderColor: "#6F61C0",
		          fill: false
		          ,lineTension : 0
		          ,pointBorderWidth: 5
		        }
		      ]
		    },
		    options: {
		        title: {
		          display: true
		        }
		      }
		  });
	

    document.getElementById("line_chart2").onclick = function(evt) {
    	
        var activePoints = line_chart2.getElementsAtEvent(evt);
    	
        if(activePoints.length > 0)
        {
            var clickedElementindex = activePoints[0]["_index"];
            
            clickDot(month_h_prc[clickedElementindex],month_l_prc[clickedElementindex],month_o_prc[clickedElementindex],month_market[clickedElementindex]);
            //alert(year_h_prc[clickedElementindex])
            
            var label = line_chart2.data.labels[clickedElementindex];
            console.log("label : " + label);

            var value = line_chart2.data.datasets[0].data[clickedElementindex];
            console.log("value : " + value);
        }
    }

////////////////////////////////////////////////////////////////////////////////////
		//Week꺼!!
////////////////////////////////////////////////////////////////////////////////////
 var context3 = document
        .getElementById('line_chart')
        .getContext('2d');

//var weekArticle = [];//weekArr

 var line_chart = new Chart(context3, {
		    type: 'line',
		    data: {
		      labels: weekArr,
		      datasets: [{ 
		          data: weekArrStk,
		          label: "${requestScope.boardMap.boardList[0].subject}",
		          borderColor: "#6F61C0",
		          fill: false
		          ,lineTension : 0
		          ,pointBorderWidth: 5
		        }
		      ]
		    },
		    options: {
		        title: {
		          display: true
		        }
		      }
		  });
	

    document.getElementById("line_chart").onclick = function(evt) {
    	
        var activePoints = line_chart.getElementsAtEvent(evt);
    	
        if(activePoints.length > 0)
        {
            var clickedElementindex = activePoints[0]["_index"];
            
            clickDot(week_h_prc[clickedElementindex],week_l_prc[clickedElementindex],week_o_prc[clickedElementindex],week_market[clickedElementindex]);
            //alert(year_h_prc[clickedElementindex])
            
            var label = line_chart.data.labels[clickedElementindex]; //이게 날짜
            
            //alert(label);
           	showDateArticle(label);
           	//alert(typeof "${requestScope.articleMap.articleKeywordList[0].title}")
			$(".dateNewsSub").text("") //칸 비우기~
			
			var cnt=0;
           	<c:forEach var="map" items="${requestScope.articleMap.articleKeywordList}" varStatus="vs">
    			//<div class="dateNewsSub" style="width:600px; height:50px; border:1px solid blue; margin-left: 10px; display: none;"><li><a href="${map.link}">${map.title}</a></li></div>
				
    			
				if( label=="${map.reg_date}" && cnt<=7) {
					//alert("${empty map.title?0:2}")
					cnt++;
					$(".dateNewsSub").append("<div><hr><a class='a' href='${map.link}'>${map.title}</a></div>");
					

				}
				
			
			</c:forEach>
			$(".dateNewsSub").append("<hr>")
			
            console.log("label : " + label);
            

            var value = line_chart.data.datasets[0].data[clickedElementindex];
            console.log("value : " + value);
        }
    }

////////////////////////////////////////////////////////////////////////////////////













  ////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
 new Chart(document.getElementById("mini-chart"), {
    type: 'bar',
    data: {
      labels: ['19.12','20.12','21.12','22.12'],
      datasets: [
    	  {
          label: '매출액',
          backgroundColor: "#6F61C0",
          borderColor: "#1E90FF",
          data: sales
      	  }
    	  , 
      	  {
          label: '영업이익',
          backgroundColor: "#F7464A",
          borderColor: "#F7464A",
          data: business_profit
      	  }
    	  ,
    	  {
              label: '세전이익',
              backgroundColor: "#1E0DD",
              borderColor: "#1E0DD",
              data: pre_tax_profit
          }
    	  ,
    	  {
              label: '순이익',
              backgroundColor: "green",
              borderColor: "green",
              data: net_profit
          	}
    	  
    	]
    },
    options: {
      title: {
        display: true
      }
    }
  });
  ////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
new Chart(document.getElementById("mini-chart2"), {
    type: 'line',
    data: {
      labels: ['19.12','20.12','21.12','22.12'],
      datasets: [
    	  {
          label: '매출액증가율',
          backgroundColor: "#1E90FF",
          borderColor: "#1E90FF",
          data: sales_rate,
          fill: false
          ,lineTension : 0
          
      	  }
    	  , 
      	  {
          label: '영업이익증가율',
          backgroundColor: "#F7464A",
          borderColor: "#F7464A",
          data: business_profit_rate
          ,fill: false
          ,lineTension : 0
      	  }
    	  ,
    	  {
              label: 'EBITDA증가율',
              backgroundColor: "#1E0DD",
              borderColor: "#1E0DD",
              data: eitda_rate
              ,fill: false
              ,lineTension : 0
          }
    	  ,
    	  {
              label: '순이익증가율',
              backgroundColor: "green",
              borderColor: "green",
              data: net_profit_rate
              ,fill: false
              ,lineTension : 0
          	}
    	  ,
    	  {
              label: '부채증가율',
              backgroundColor: "#6000a0",
              borderColor: "#6000a0",
              data: debt_rate
              ,fill: false
              ,lineTension : 0
          	}
    	]
    },
    options: {
      title: {
        display: true
        
      }
    }
  });
  ////////////////////////////////////////////////////////////////////////////
</script>
</html>