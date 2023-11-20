<!-- mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm  -->
<!-- JSP기술의 한 종류인 [Page Directive]를 이용하여 현 JSP페이지 처리 방식 선언 -->
<!-- mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm  -->
	<!-- 현재 JSP페이지 실행 후 실행되는 문서는 HTML이고 이 문서안의 데이터는 UTF-8방식으로 인코딩한다 라고 설정함 -->
	<!-- 현재 이 JSP페이지를 저장할때는 UTF-8 방식으로 인코딩한다. -->
	<!-- 모든 JSP페이지 상단에 무조건 아래 설정이 들어간다.  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>뉴스 게시판</title>

<script src="/js/jquery-1.11.0.min.js"></script>
<script src="/js/common.js"></script>
<%@include file="/WEB-INF/views/newsListBoardHelper.jsp" %> <!-- 상단 메뉴바 -->
<%@include file="/WEB-INF/views/sideBar.jsp" %>

<style>

	.a:link{
		font-weight: bold;
		color: black;
		text-decoration: none;
	}
	.a:visited{
		color: black;
		text-decoration: none;
	}
	.a:hover{
		color: white;
		text-decoration: underline;
	}
	
	.tbody:hover{
		color: white;
	}
	.a:active{
		color: blue;
	}
	
	.b{
		color: black;
		
		text-decoration: none;
	}
	.b:visited{
		color: black;
		text-decoration: none;
	}
	.b:hover{
		color: white;
	}
	
</style>

<script>
$(function(){
	
	//alert("${requestScope.articleTopMap[0].title}")
	//alert("${articleDTO.getKeyword()}")
	//alert("${SessionScope.selectPageNo}")
 })
	
		   
		   function pageNoClick(clickPageNo){
				
		      var formObj = $("[name='articleListBoard']");
		      formObj.find("[name='selectPageNo']").val(clickPageNo);
		      //alert($("[name='selectPageNo']").val())
		      
		      search();
		      alert("${articleMap.selectPageNo}")
		   }
	function search(){
		//alert($("[name='selectPageNo']").val())
		ajax(
				"/newsListBoard.do"
				,"post"
				, $("[name='articleListBoard']")
				, function(responseHtml){
					var obj = $(responseHtml);
					var searchResultCnt = obj.find(".searchResultCnt").html();
					var searchResult = obj.find(".searchResult").html();
					var pageNos = obj.find(".pageNos").html();
					$(".searchResultCnt").html(searchResultCnt);
					$(".searchResult").html(searchResult);
					$(".pageNos").html(pageNos);
					
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
					$(".title").val("");
					search();
					
				}
		); 
	}
	
	function goGraphBtn(){
		document.goGraph.submit();
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
				
					<form name="goGraph" method="post" action="/graph.do">
					<input type="text" name="keyword" class="searchTerm1" placeholder="Search...">
					</form>
					
					 <button type="submit" class="searchButton1" onClick="goGraphBtn();">
						 <i class="fa fa-search"></i>
						</button>
				 </div>
			</div>
			

		</div>
		<!-- -------- 여기 밑 부터 디자인 하면됨 --------------->
		<div class="cardBox">
			<div class="card">
				<div>
					<div class="numbers">${requestScope.kospiListDescMap.kospiListDesc[0].previous_close}</div>
					<div class="cardName">KOSPI</div>
				</div>
				<div class="iconBx">
					<ion-icon name="analytics-outline"></ion-icon>
				</div>
			</div>
			<!--------------------------------------------->
			<div class="card">
				<div>
					<div class="numbers">${requestScope.kosdaqListDescMap.kosdaqListDesc[0].previous_close}</div>
					<div class="cardName">KOSDAQ</div>
				</div>
				<div class="iconBx">
					<ion-icon name="trending-down-outline"></ion-icon>
				</div>
			</div>
			<!--------------------------------------------->
			<div class="card">
				<div>
					<div class="numbers">12,789.48</div>
					<div class="cardName">NASDAQ</div>
				</div>
				<div class="iconBx">
					<ion-icon name="trending-up-outline"></ion-icon>
				</div>
			</div>
			<!--------------------------------------------->
			<div class="card">
				<div>
					<div class="numbers">${requestScope.exchangeDescList[0].USD}</div>
					<div class="cardName">Earning</div>
				</div>
				<div class="iconBx">
					<ion-icon name="cash-outline"></ion-icon>
				</div>
			</div>
		</div>
		<!------KOSPI 부분 끝-------------->
		<form name="articleListBoard">
			<div class="details">
				<!-- 메인 스타트 부분 -->
				<div class="recentOrders">
					<div class="cardHeader">
						<h2>주요 뉴스</h2>
					</div>
					<div class="searchResult">
						<table>
						<thead>
							<th>글번호</th>
							<th>제목</th>
							<th>조회수</th>
							<th>날짜</th>
							[ ${requestScope.articleMap.articleListCntAll}개의 글 중
										${requestScope.articleMap.articleListCnt}개 ]
						</thead>
							<c:forEach var="article"
								items="${requestScope.articleMap.searchArticleList}"
								varStatus="vs">
								<tr>
									<td>${requestScope.articleMap.begin_serialNo_desc-vs.index}</td>
									<td onClick="clickNews('${article.title}')"><a
										href="${article.link}" class="a" target="blank">${article.title}</a>

									</td>

									<td>${article.readcount}</td>
									<td>${article.reg_date}</td>
								</tr>
							</c:forEach>

						</table>
						<div style="height: 20px"></div>
						<center>
							
								
								 <div class="wrap">
									  <div class="search">
									     <input type="text" name="keyword" value="${articleDTO.getKeyword()}" class="searchTerm" placeholder="Search...">
									     <button type="submit" class="searchButton" onClick="search()">&nbsp;&nbsp;
									       <i style="margin-left:-45%" class="fa fa-search"></i>
									    </button>
									  </div>
								</div>

								
								<input type="hidden" class="title" name="title"></input>
								<div class="searchResultCnt">

								<input type="hidden" name="rowCntPerPage" value="15">

								</div>

								<input type="hidden" name="selectPageNo" value="${articleMap.selectPageNo}">
								<input type="hidden" value="${articleMap.selectPageNo}">
							

							<div class="pageNos" style="margin-left: -10%;">
								<span style="cursor: pointer" onClick="pageNoClick(1)">&lt;&lt;</span>&nbsp;&nbsp;

								<span style="cursor: pointer"
									onClick="pageNoClick(${requestScope.articleMap.prevPage})">&lt;</span>&nbsp;&nbsp;

								<c:forEach var="pageNo"
									begin="${requestScope.articleMap.begin_pageNo}"
									end="${requestScope.articleMap.end_pageNo}">
									<c:if test="${requestScope.articleMap.selectPageNo==pageNo}">
							            ${pageNo}
							         </c:if>
									<c:if test="${requestScope.articleMap.selectPageNo!=pageNo}">
										<span style="cursor: pointer" onClick="pageNoClick(${pageNo})">[${pageNo}]</span>
									</c:if>
								</c:forEach>
								&nbsp;&nbsp; <span style="cursor: pointer"
									onClick="pageNoClick(${requestScope.articleMap.nextPage})">&gt;</span>&nbsp;&nbsp;

								<span style="cursor: pointer"
									onClick="pageNoClick(${requestScope.articleMap.last_pageNo})">&gt;&gt;</span>
							</div>
							 <input type="hidden" name="selectPageNo" value="0">
							
						</center>
					</div>
				</div>
				<!-- 메인 끝 부분 -->
				<!-- 서브 스타트 지점 -->
				<div class="recentOrders">
					<div class="cardHeader">
						<h2>[인기]</h2>
					</div>
					<table>
						<tbody>
							<c:forEach var="article" items="${requestScope.articleTopMap}"
								begin="0" end="14" varStatus="vs">
								<tr>
									<td>
										<div style="float: left;">${vs.count}.
											<a class="a" target="blank" onClick="clickNews('${article.title}')" href="${article.link}">${article.title}</a>
										</div>
									</td>
								</tr>
							</c:forEach>
							</tbody>
					</table>
					<!-- 이 부분이 sub Board List 파트임  -->
				
				<!-- 서브 끝 지점 -->
				</div>
			</div>
		</form>
	</section>
	
	
	<!-- 지우면 안된다 -->
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
</html>