<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
JSP기술의 한 종류인 Include Directive 를 사용하여
	common.jsp 파일 내의 소스를 삽입하기
	 mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm -->
<%@include file="/WEB-INF/views/mainWebHelper.jsp" %>
<%@include file="/WEB-INF/views/sideBar.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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










   // body 태그 안의 모든 내용을 읽어들인 후 init 함수 호출
   $(function(){
	   //alert("${requestScope.kospiListDescMap.kospiListDesc[0].previous_close}")exchangeDesc"exchangeDescList"();
	   
	   //alert("${requestScope.exchangeDescList}")
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
		});﻿

	  init();
	   
	   
   })
   // body 태그 안의 모든 내용을 읽어들인 후 호출한 JavaScript 코딩 설정
   function init(){
	   
	   
	   piDaq();
	   exchangeClick();
	   $(".1").show() //처음 코스피 그래프 보이기
	   $(".highRateSub").show(); //threeList중 상승 보이기
	   $(".downList").show() // fiveList 자식 태그중 처음에 하락 보이기	   
   
   }
   
   // 검색 누르면 실행되는 함수
   function search(){
	   
	   document.maingraph.submit();
   }
   function search2(recentPickStk_nm){
		//alert(recentPickStk_nm);   
		$("[name=keyword]").val(recentPickStk_nm);
		search();
		   
	}

   //Menu2 누르면 실행 -> searchResultBoard로 가게 만듬.
   function goMenu2(){
	   //alert("Menu2");
	   document.searchResultBoard.submit();
   }
   //Menu3 누르면 실행 -> newsListBoard로 가게 만듬.
   function goMenu3(){
	   //alert(123);
	   document.newsListBoard.submit();
   }
   function piDaq(){
	   var obj = $("#kospiDaqGraph")
	   
	   
	   obj.find("tr:odd").hide();
	   

        //JQuert객체 관리하는 태그의 후손 태그중 
        //        홀수 tr을 관리하는 jQuery 객체 생성하고
        //        hover메소드를 호출하여 홀수 tr에 마우스를 댔을 때 짝수 tr 보이게 하고
        //                              마우스를 빼면 짝수 tr 감추기.
        obj.find("tr:even").hover(
            function(){//마우스 댓을때
                //마우스를 가져다 댄놈의 tr태그 보이기.
                obj.find("tr:odd").hide();
                $(this).next().show();
                /////////////////////////////////////////////////////////////////
            	//alert(1)
				//alert('${requestScope.kospiMap}')
				
            }
            ,function(){//마우스 뺐을때
                //$(this).next().hide();
            }

        )
        
       // 아래 highRowRateGraph
       
	  	
        $(".rowRateSub").hide();
        $(".marketRateSub").hide();
        
        $(".highRate").hover(
                function(){//마우스 댓을때
                    //마우스를 가져다 댄놈의 tr태그 보이기.
                   	$(".highRateSub").show();
                   	$(".rowRateSub").hide();
                   	$(".marketRateSub").hide();
                    /////////////////////////////////////////////////////////////////
                	//alert(1)
    				//alert('${requestScope.kospiMap}')
                   	
                }
                ,function(){//마우스 뺐을때
                    //$(this).next().hide();
                }

            )
       	$(".rowRate").hover(
                function(){//마우스 댓을때
                    //마우스를 가져다 댄놈의 tr태그 보이기.
                   	$(".highRateSub").hide();
                   	$(".rowRateSub").show();
                   	$(".marketRateSub").hide();
                    /////////////////////////////////////////////////////////////////
                	//alert(1)
    				//alert('${requestScope.kospiMap}')
    				
                }
                ,function(){//마우스 뺐을때
                    //$(this).next().hide();
                }

        )
        
       	$(".marketRate").hover(
                function(){//마우스 댓을때
                    //마우스를 가져다 댄놈의 tr태그 보이기.
                    $(".marketRateSub").show();
                   	$(".highRateSub").hide();
                   	$(".rowRateSub").hide();
                   	//alert(${requestScope.stockMap.stockList[0].market})
                   	
                    /////////////////////////////////////////////////////////////////
                	//alert(1)
    				//alert('${requestScope.kospiMap}')
    				
                }
                ,function(){//마우스 뺐을때
                	//$(this).next().hide();
                	
                	
                }

        )    

        
	   
   }
   function exchangeClick(){
		 

	  	$(".1weekSub").hide();
      $(".1monthSub").hide();
      $(".1yearSub").hide();
      
      $(".week1").mouseup(
              function(){//마우스 댓을때
                  //마우스를 가져다 댄놈의 tr태그 보이기.
                  	
                 	$(".1weekSub").show();
                 	$(".1monthSub").hide();
                 	$(".1yearSub").hide();
                 	$(".exchange").hide();
                  /////////////////////////////////////////////////////////////////
              	
  				//alert('${requestScope.kospiMap}')
  				
              }
             

          )
     	$(".month1").mouseup(
              function(){//마우스 댓을때
                  //마우스를 가져다 댄놈의 tr태그 보이기.
                 	$(".1weekSub").hide();
                 	$(".1monthSub").show();
                 	$(".1yearSub").hide();
                 	$(".exchange").hide();
                  /////////////////////////////////////////////////////////////////
              	
  				//alert('${requestScope.kospiMap}')
  				
              }
              

      )
      
     	$(".year1").mouseup(
              function(){//마우스 댓을때
                  //마우스를 가져다 댄놈의 tr태그 보이기.
                  $(".1weekSub").hide();
                 	$(".1monthSub").hide();
                 	$(".1yearSub").show();
                 	$(".exchange").hide();
                  /////////////////////////////////////////////////////////////////
              	
  				//alert('${requestScope.kospiMap}')
  				
              }
              
  	)
  }


   function showList(obj){
	   
	   obj.show();
	   
	   //alert($(".fiveList").children().length); //71개 나옴
   
		/*   
		$(".fiveList").children().each(
			function(i){
				if($(this).attr("class")!=(obj.attr("class"))){
					$(this).hide();
				}
			}		
		
		)
		*/
		$(".fiveList").children().each(
				function(i){
					if( $(this).is(obj)==false ){
						$(this).hide();
					}
				}		
			
			) 
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
	function clickNews(title){
		
		
		$(".title").text(title);
		$(".title").val(title);
		
		 ajax(
				"/newsListBoard.do"
				,"post"
				, $("[name='articleListBoard']")
				, function(cnt){
					
				
				}
		); 
	}
   

</script>
</head>
<body>
	
	<!------------ 여기서 부터 게시판  ------------------->
	<section class="home-section">
		<div class="home-content">
			<i class="bx bx-menu"></i>
			<div class="wrap1">
				<div class="search1">
				
					<form name="maingraph" method="post" action="/graph.do">
					<input type="text" name="keyword" class="searchTerm1" placeholder="Search...">
					</form>
					
					 <button type="submit" class="searchButton1" onClick="search();">
						 <i class="fa fa-search"></i>
						</button>
				 </div>
			</div>
			
		</div>
		<form name="articleListBoard">
			<input type="hidden" class="title" name="title">
		</form>
		<!-- -------- 여기 밑 부터 디자인 하면됨 --------------->
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
		<!----------------첫째줄 끝------------------>
		<!----------------둘째줄 시작------------------>
		<div class="cardBox_2">
			<div class="card_2">
				<div>
					<div
						style="width: 500px; height: 400px;   margin-left: 5%; margin-top: 3%;">
						<div style="height: 10px"></div>
						<table>
							<tr>
								<td><h3>주요 뉴스<div style="height: 15px"></div></h3></td>
								
							</tr>
							
							<c:forEach var="article"
								items="${requestScope.articleMap.articleList}" varStatus="vs"
								end="7">
								<tr>
									
									<td style="width: 500px"><li><a 
											href="${article.link}" class="a" target="blank" onClick="clickNews('${article.title}')" >${article.title}<div style="height: 5px"></a></li></td>
									<!-- <td style="cursor:pointer" onclick="goArticleDetail(${article.article_no})"><li>${article.title}</li></td> -->
								</tr>
							</c:forEach>
						</table>
						<div style="height: 15px"></div>
						<center>
						<span style="cursor: pointer; margin-left: -11%"
							onclick="location.replace('/newsListBoard.do')" >[더보기]</span>
						</center>
					</div>
				</div>
				
			</div>
			<!-- ------------------------------------- -->
			<div class="card_2">
				<div>
					<form name="kospiForm">
						<div class="kospi"
							style="width: 500px; height: 400px;  float: left; margin-left: 2%; margin-top: 3%;">
							<table id="kospiDaqGraph" class="kospiDaqGraph" border=0
								cellspacing=0 cellpadding=5 width="100%" height="100px">
								<tr bgcolor="#EC407A">
									<td><b>KOSPI</b></td>
								</tr>
								<tr bgcolor="#fff" class="1">
									<td>
										<div style="width: 100%; height: 100%; ">
											<canvas id="line-chart"></canvas>

										</div>
									</td>
								</tr>
								<tr bgcolor="#AB47BC">
									<td><b>KOSDAQ</b></td>
								</tr>
								<tr bgcolor="#fff">
									<td>
										<div style="width: 100%; height: 100%; ">
											<canvas id="line-chart2"></canvas>
										</div>
									</td>
								</tr>
								


							</table>
						</div>
					</form>
				</div>
			</div>

			<!-- ------------------------------------- -->
			<div class="card_2">
				<div>
					<div 
						style="width: 480px; height: 400px; margin-left: 5%;margin-top: 2%;">

						<div class="highRate"
							style="width: 159px; height: 50px; border: 1px solid #6a51c2; text-align:center; float: left; padding:11px;">
							상승률순위<i class='bx bx-up-arrow-alt'></i></div>


						<div class="rowRate"
							" style="width: 159px; height: 50px; border: 1px solid #6a51c2;  text-align:center; float: left; padding:11px">
							하락률순위<i class='bx bx-down-arrow-alt'></i>
						</div>
						<div class="marketRate"
							style="width: 159px; height: 50px; border: 1px solid #6a51c2;  text-align:center; float: left; padding:11px">
							거래량상위</div>



						<div class="highRateSub"
							style="width: 480px; height: 300px;  float: left;">
							<c:forEach var="map" items="${requestScope.stockMap.stockList}"
								begin="0" end="7" varStatus="vs" step="1">

								<div style=" margin-top: 3%;">
									<c:if test="${map.rate>=0}">
										<span style="font-weight: bold;">${vs.count}. ${map.stk_nm} &nbsp;&nbsp;&nbsp;&nbsp;
											</span><span style="float: right; color: red;">▲ ${map.rate} %</span>
									</c:if>


								</div>


							</c:forEach>

						</div>
						<div class="rowRateSub"
							style="width: 480px; height: 300px;  float: right; ">

							<c:forEach var="map"
								items="${requestScope.stockRateAscMap.stockRateAscList}"
								begin="0" end="7" varStatus="vs" step="1">

								<div style=" margin-top: 3%;">
									<c:if test="${map.rate<0}">
										<span style="font-weight: bold;">${vs.count}. ${map.stk_nm} &nbsp;&nbsp;&nbsp;&nbsp;
											</span><span style="float: right; color: blue">▼ ${map.rate} %</span>
									</c:if>
								</div>


							</c:forEach>
						</div>
						<div class="marketRateSub"
							style="width: 480px; height: 300px;  float: right; ">

							<c:forEach var="map"
								items="${requestScope.stockMarketDescMap.stockMarketDescList}"
								begin="0" end="7" varStatus="vs" step="1">

								<div style=" margin-top: 3%;">
									<span style="font-weight: bold;">${vs.count}. ${map.stk_nm} &nbsp;&nbsp;&nbsp;&nbsp;
											</span><span style="float: right;">${map.market} 주</span>
								</div>


							</c:forEach>


						</div>

					</div>
				</div>
			</div>
		</div>
		<!-- -------------둘째줄 끝----------------- -->
		<!----------------셋째줄 시작------------------>
		<div class="cardBox_3">
			<div class="card_3">
				<div>
					<div
						style="width: 800px; height: 480px;  float: left; margin-left: 6%; margin-top: 3%;">

						<div class="week1"
							style="width: 265px; height: 50px;   float: left; cursor: pointer; border: 1px solid #6a51c2;  text-align:center; padding:11px; float: left; ">
							일주일</div>
						<div class="month1"
							style="width: 265px; height: 50px; float: left; cursor: pointer; border: 1px solid #6a51c2;  text-align:center; float: left; padding:11px">
							한달</div>

						<div class="year1"
							" style="width: 265px; height: 50px; float: left; cursor: pointer; border: 1px solid #6a51c2;  text-align:center; float: left; padding:11px">
							일년</div>

						<div class="exchange"
							style="width: 100%; height: 100%;  float: center;">
							<canvas id="line-chart5"></canvas>
						</div>
						<div class="1weekSub"
							style="width: 100%; height: 100%;  float: center;">
							<canvas id="line-chart6"></canvas>
						</div>
						<div class="1monthSub"
							style="width: 100%; height: 100%;  float: center;">
							<canvas id="line-chart7"></canvas>
						</div>
						<div class="1yearSub"
							style="width: 100%; height: 100%`; float: center;">
							<canvas id="line-chart8"></canvas>
						</div>

					</div>
				</div>
			</div>
			<!-- ------------------------------------- -->
			<div class="card_3_1">
				<div>
					<div 
						style="width: 410px; height: 400px;   margin-top: 3%; color: #8000FF;
	font-weight: bold;">
						[관심추가]
						<hr style="width:90%">
						<div style="height: 10px;"></div>
						<div class="recentList"
							style="width: 90%; height: 400px; ">


							<c:forEach var="map"
								items="${requestScope.recentPickStkMap.recentPickStkMapList}"
								begin="0" end="10" varStatus="vs" step="1">


								<form name="delete${vs.count}">
									<input type="hidden" name="deleteName"
										value="${map.recentPickStk_nm}">

									<c:if test="${map.recentPickNet_change>0}">
									<div style="width: 100%; ">
										<a class="a" href="javascript:event(search2('${map.recentPickStk_nm}'))">${map.recentPickStk_nm}</a>
										<span style="float: right; color: red;">
										▲${map.recentPickNet_change}
											<img src="/img/minus_square_icon_128806.png"
											onClick="minus('delete${vs.count}')"
											style="width: 20px; height: 20px; cursor: pointer;">
										</div>
										</span>
										<div style="height: 5px;"></div>

									</c:if>

									<c:if test="${map.recentPickNet_change<0}">
										<div style="width: 100%; ">
										<a class="a" href="javascript:event(search2('${map.recentPickStk_nm}'))">${map.recentPickStk_nm}</a>
										<span style="float: right; color: blue;">
										▼${map.recentPickNet_change}
										<img src="/img/minus_square_icon_128806.png"
											onClick="minus('delete${vs.count}')"
											style="width: 20px; height: 20px; cursor: pointer;">
										</div>
										</span>
										<div style="height: 5px;"></div>
									</c:if>
								</form>

							</c:forEach>






							<%-- ${requestScope.recentPickStkMap.recentPickStkMapList[0].recentPickStk_nm} --%>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- -------------셋째줄 끝----------------- -->
		
		<!----------------넷째줄 시작------------------>
		<div class="cardBox_4">
			<div class="card_4">
				<div>
					<div>

						<div class="up" onClick="showList($('.upList'))"
							style="margin-left: 10%; width: 100px; height: 50px; border: 1px solid #6a51c2;  text-align:center; padding:11px; float: left; margin-top: 1%; cursor: pointer;">
							상승</div>
						<div class="zero" onClick="showList($('.midList'))"
							style="width: 100px; height: 50px; border: 1px solid #6a51c2;  text-align:center; padding:11px; float: left; margin-top: 1%; cursor: pointer;">
							보합</div>
						<div class="down" onClick="showList($('.downList'))"
							style="width: 100px; height: 50px; border: 1px solid #6a51c2;  text-align:center; padding:11px; float: left; margin-top: 1%; cursor: pointer;">
							하락</div>
						<div class="marketAmount" onClick="showList($('.marketList'))"
							style="width: 100px; height: 50px; border: 1px solid #6a51c2;  text-align:center; padding:11px; float: left; margin-top: 1%; cursor: pointer;">
							거래량</div>

						<div class="marketPrice" onClick="showList($('.marketCapitalList'))"
							style="width: 100px; height: 50px; border: 1px solid #6a51c2; text-align:center; padding:11px; float: left; margin-top: 1%; cursor: pointer;">
							시가총액</div>
						<div style="width: 100%;  float: left;">
								<table class="t1">
									<tr style="font-weight: bold;">
										<td>순위</td>
										<td>종목명</td>
										<td>전일비</td>
										<td>등락률</td>
										<td>거래량</td>
										<td>시가총액(백만)</td>
										
									</tr>
								</table>
							</div>
						<div class="fiveList"
							style="width: 80%; height: 380px;  float: left; margin-left: 10%; ">


							
							<!-- 상승 누르면 나올거 -->
							<c:forEach var="map" items="${requestScope.stockMap.stockList}"
								begin="0" end="7" varStatus="vs" step="1">
								<c:if test="${map.rate>0}">
									<div class="upList"style="border: 1px solid #DFC0FF; display: none;">
										
										<table class="t1">
										
											<tr>
												<td>${vs.count}</td>
												<td>${map.stk_nm}</td>
												<td>▲${map.net_change}</td>
												<td>+${map.rate} %</td>
												<td>${map.market}주</td>
												<td>${map.market_capital/1000000}</td>
											</tr>
											
										
										</table>
								


									</div>
								</c:if>
							</c:forEach>
							<!-- 상승 누르면 나올거 -->

							<!-- 하락 누르면 나올거 -->
							<c:forEach var="map"
								items="${requestScope.stockRateAscMap.stockRateAscList}"
								begin="0" end="10" varStatus="vs" step="1">
								<c:if test="${map.rate<0}">
									<div class="downList"
										style="border: 1px solid #DFC0FF; display: none;">

										<table class="t1">
											<tr>
												<td>${vs.count}</td>
												<td>${map.stk_nm}</td>
												<td>▼${map.net_change}</td>
												<td>${map.rate} %</td>
												<td>${map.market}주</td>
												<td>${map.market_capital/1000000}</td>
											</tr>
											
										
										</table>

									</div>
								</c:if>
							</c:forEach>
							<!-- 상승 누르면 나올거 -->

							<!-- 보합 누르면 나올거 -->
							<c:forEach var="map"
								items="${requestScope.stockRateAscMap.stockRateAscList}"
								varStatus="vs" step="1">
								<c:if test="${map.rate==0}">
									<div class="midList"
										style="border: 1px solid #DFC0FF; display: none;">

										<div>
											<table class="t1">
											<tr>
												<td>◾ ${map.stk_nm}</td>
												<td>${map.net_change}</td>
												<td>${map.rate} %</td>
												<td>${map.market}주</td>
												<td>${map.market_capital/1000000}</td>
											</tr>
											
											
											
						 
											
											</table>
										</div>

									</div>
								</c:if>
							</c:forEach>
							<!-- 보합 누르면 나올거 -->

							<!-- 거래량 누르면 나올거 -->
							<c:forEach var="map"
								items="${requestScope.stockMarketDescMap.stockMarketDescList}"
								begin="0" end="10" varStatus="vs" step="1">

								<div class="marketList"
									style="border: 1px solid #DFC0FF; display: none;">

									<div>
										<table class="t1">
											<tr>
												<td>${vs.count}</td>
												<td>${map.stk_nm}</td>
												<td><c:if test="${map.net_change>0}">▲</c:if> <c:if
														test="${map.net_change<0}">▼</c:if> ${map.net_change}</td>
												<td>${map.rate}%</td>
												<td>${map.market}주</td>
												<td>${map.market_capital/1000000}</td>
											</tr>



										</table>
									</div>

								</div>
							</c:forEach>
							<!-- 거래량 누르면 나올거 -->

							<!-- 시가총액 누르면 나올거 -->
							<c:forEach var="map"
								items="${requestScope.stockMarketAmountDescMap.getWeekMarketAmountDescList}"
								begin="0" end="10" varStatus="vs" step="1">

								<div class="marketCapitalList"
									style="border: 1px solid #DFC0FF; display: none;">

									<div>
										<table class="t1">
											<tr>
												<td>${vs.count}</td>
												<td>${map.stk_nm}</td>
												<td><c:if test="${map.net_change>0}">▲</c:if> <c:if
														test="${map.net_change<0}">▼</c:if> ${map.net_change}
												</td>
												<td>${map.rate}%</td>
												<td>${map.market}주</td>
												<td>${map.market_capital/1000000}</td> 
											</tr>



										</table>
									</div>

								</div>
							</c:forEach>
							<!-- 시가총액 누르면 나올거 -->

						</div>


					</div>
				</div>
			</div>
		</div>
		<!-- -------------넷째줄 끝----------------- -->




		<form name="newsListBoard" method="post" action="/newsListBoard.do"></form>

		<form name="searchResultBoard" method="post" action="/searchResultBoard.do"></form>




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
	<!-- 삭제하면 화면 움직이는거 안됨 -->
</body>
<script>
	var arr = [];
	<c:forEach var="map" items="${requestScope.kospiMap.kospiList}" varStatus="vs">


		
			arr.push("${map.reg_date}")
		
			
	
	</c:forEach>
		
	var arr2 = [];
	<c:forEach var="map" items="${requestScope.kospiMap.kospiList}" varStatus="vs">
		
			arr2.push("${map.previous_close}")
		
	</c:forEach>
//////////////////////////////


	var arr3 = [];
	<c:forEach var="map" items="${requestScope.kosdaqMap.kosdaqList}" varStatus="vs">


		
			arr3.push("${map.reg_date}")
		
			
	
	</c:forEach>
		
	var arr4 = [];
	<c:forEach var="map" items="${requestScope.kosdaqMap.kosdaqList}" varStatus="vs">
		
			arr4.push("${map.previous_close}")
		
	</c:forEach>
			
			

	////////////////////////////////////////////////////////////////////////////////////////////////////모든 환율 날짜			
	var exchangeAlldate = [];
	<c:forEach var="map" items="${requestScope.exchangeMap.exchangeList}" varStatus="vs">
	
	exchangeAlldate.push("${map.REG_DATE}")
	
	</c:forEach>
	////////////////////////////////////////////////////////////////////////////////////////////////////	모든 환율 시세
	var exchangeAll = [];
	<c:forEach var="map" items="${requestScope.exchangeMap.exchangeList}" varStatus="vs">
		
	exchangeAll.push("${map.USD}")
		
	</c:forEach>
	////////////////////////////////////////////////////////////////////////////////////////////////////일주일치로 나눈 환율 날짜
	var exchangeWeekdate = [];
	<c:forEach var="map" items="${requestScope.exchangeMap.exchangeWeekList}" varStatus="vs">
	
	exchangeWeekdate.push("${map.REG_DATE}")
	
	</c:forEach>
	////////////////////////////////////////////////////////////////////////////////////////////////////일주일 환율 시세
	var exchangeWeek = [];
	<c:forEach var="map" items="${requestScope.exchangeMap.exchangeWeekList}" varStatus="vs">
		
	exchangeWeek.push("${map.USD}")
		
	</c:forEach>
	////////////////////////////////////////////////////////////////////////////////////////////////////한달 환율 날짜
	var exchangeMonthdate = [];
	<c:forEach var="map" items="${requestScope.exchangeMap.exchangeMonthList}" varStatus="vs">
	
	exchangeMonthdate.push("${map.REG_DATE}")
	
	</c:forEach>
	
	////////////////////////////////////////////////////////////////////////////////////////////////////한달 환율 시세
	var exchangeMonth = [];
	<c:forEach var="map" items="${requestScope.exchangeMap.exchangeMonthList}" varStatus="vs">
		
	exchangeMonth.push("${map.USD}")
		
	</c:forEach>
	////////////////////////////////////////////////////////////////////////////////////////////////////일년 환율 날짜
	var exchangeYeardate = [];
	
	<c:forEach var="map" items="${requestScope.exchangeMap.exchangeYearList}" varStatus="vs">
	
	exchangeYeardate.push("${map.REG_DATE}")
	
	</c:forEach>
	////////////////////////////////////////////////////////////////////////////////////////////////////일년 환율 시세
	var exchangeYear = [];
	<c:forEach var="map" items="${requestScope.exchangeMap.exchangeYearList}" varStatus="vs">
		
	exchangeYear.push("${map.USD}")
		
	</c:forEach>
		
				
			
			
			
			
		
		
	
	new Chart(document.getElementById("line-chart"), {
	    type: 'line',
	    data: {
	      labels: arr,
	      datasets: [{ 
	          data: arr2,
	          label: "코스피",
	          borderColor: "#EC407A",
	          fill: false
	        }
	      ]
	    },
	    options: {
	      title: {
	        display: true,
	        text: '일봉차트'
	      }
	    }
	  });
///////////////////////////////////////////////////////////////////////////////////
	new Chart(document.getElementById("line-chart2"), {
	    type: 'line',
	    data: {
	      labels: arr3,
	      datasets: [{ 
	          data: arr4,
	          label: "코스닥",
	          borderColor: "#AB47BC",
	          fill: false
	        }
	      ]
	    },
	    options: {
	      title: {
	        display: true,
	        text: '일봉차트'
	      }
	    }
	  });
	  
	new Chart(document.getElementById("line-chart5"), {
	    type: 'line',
	    data: {
	      labels: exchangeAlldate,
	      datasets: [{ 
	          data: exchangeAll,
	          label: "USD환율",
	          borderColor: '#6F61C0',
	          backgroundColor: '#6F61C0',
	          borderWidth: 1,
	          cubicInterpolationMode: 'monotone',
	          pointRadius: 0,
	          pointHoverRadius: 1,
	          pointStyle: 'circle',
	          fill: false,
	         
	        }
	      ]
	    },
	    options: {
	        plugins: {
	            tooltip: {
	                usePointStyle: true,
	                callbacks: {
	                    labelPointStyle: function(context) {
	                        return {
	                            pointStyle: 'triangle',
	                            rotation: 0
	                        };
	                    }
	                }
	            }
	        }
	    }
	});
		 
	////////////////////////////////////////////////////////////////////////
	new Chart(document.getElementById("line-chart6"), {
	    type: 'line',
	    data: {
	      labels: exchangeWeekdate,
	      datasets: [{ 
	          data: exchangeWeek,
	          label: "일주일환율",
	          borderColor: '#6F61C0',
	          backgroundColor: '#6F61C0',
	          borderWidth: 1,
	          pointStyle: 'circle',
	          pointRadius: 1,
	          pointHoverRadius: 5,
	          fill: false
	        }
	      ]
	    },
	    options: {
	      title: {
	        display: true,
	        text: '환율'
	      }
	    }
	  });
	////////////////////////////////////////////////////////////////////////
	new Chart(document.getElementById("line-chart7"), {
	    type: 'line',
	    
	    data: {
	      labels: exchangeMonthdate,
	      datasets: [{ 
	          data: exchangeMonth,
	          label: "한달환율",
	          borderColor: '#6F61C0',
	          backgroundColor: '#6F61C0',
	          borderWidth: 1,
	          pointStyle: 'circle',
	          pointRadius: 1,
	          pointHoverRadius: 5,
	          fill: false
	        }
	      ]
	    },
	    options: {
	      title: {
	        display: true,
	        text: '환율'
	      }
	    }
	  });
	////////////////////////////////////////////////////////////////////////
	new Chart(document.getElementById("line-chart8"), {
	    type: 'line',
	    data: {
	      labels: exchangeYeardate,
	      datasets: [{ 
	          data: exchangeYear,
	          label: "일년환율",
	          borderColor: '#6F61C0',
	          backgroundColor: '#6F61C0',
	          borderWidth: 1,
	          pointStyle: 'circle',
	          pointRadius: 0,
	          pointHoverRadius: 5,
	          fill: false
	        }
	      ]
	    },
	    options: {
	    		legend:{
	    			display:false,
	    		},
	    		tooltips:{
	    			enabled:false,
	    		},
	    		hover:{
	    			animationDuration:0,
	    		},
	      title: {
	        display: true,
	        text: '환율'
	      }
	    }
	  });
	////////////////////////////////////////////////////////////////////////	  
	  
	  

</script>


</html>