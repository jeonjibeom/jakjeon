<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고,이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다 라고 설정함 -->
<!-- 현재 이 JSP 페이지를 저장할때는 UTF-8 방식으로 인코딩 한다 -->
<!-- 모든 JSP 페이지 상단에 무조건 아래 설정이 들어간다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>

<%@include file="/WEB-INF/views/common.jsp"%>




<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주식용어백과</title>


<link href="./style3.css" rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>


<script type="text/javascript">
//body 태그 안의 모든 내용을 읽어들인 이후 init 함수 호출
$(function () { init(); });
// body 태그 안의 모든 내용을 읽어들인 이후 실행할 자스 코딩 설정
function init() {
}


/**
 * 헤더를 클릭하면 호출되는 함수 sortThClick 선언하기
 * 헤더를 클릭하면 정렬 의지를 히든 태그에 담고 다시 검색을 하는 과정을 거친다.
 * @param ascDesc 매개변수로 정렬의미의 문자가 들어오는 매개변수
 */
function sortThClick(ascDesc) {
  // name='sort' 를 가진 태그에 정렬의미가 담겨있는 문자를 저장하기
  $("[name='boardSearchForm'] [name='sort']").val(ascDesc);
  // search 함수 호출하기(정렬 또한 검색의 일부분이기때문)
  freeSearch();
}

//검색 버튼 클릭 시 호출되는 함수 search 선언
function search() {
  // WAS 와 비동기 방식으로 "/boardList.do" URL 주소로 접속하고 얻은 HTML 문서에서 필요한 데이터를 캐치해서 현 화면에 반영하기
  ajax(
    // WAS 에 접속할 때 사용할 URL 주소 지정
    "/boardList.do"
    // WAS 에 전송할 파라미터값을 보내는 방법 지정
    , "post"
    // 파라미터값을 내포한 form 태그 관리하는 JQuery 객체
    , $("[name='boardSearchForm']")
    // WAS 와 통신한 후 WAS의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
    // 익명 함수의 매개변수에는 WAS가 보내온 HTML 문자열이 들어온다.
    , function (responseHtml) {
      // 매개변수로 들어오는 HTML 문자열을 관리하는 JQuery 객체 생성하여 변수 obj 에 저장하기
      var obj = $(responseHtml);
      // JQuery 객체가 관리하는 HTML 태그 문자열에서 class = 'searchResultCnt' 가진 
      // 태그 내부 문자열 얻어 변수 searchResultCnt에 저장하기
      var searchResultCnt = obj.find(".searchResultCnt").html();
      // JQuery 객체가 관리하는 HTML 태그 문자열에서 class = 'searchResult' 가진 
      // 태그 내부 문자열 얻어 변수 searchResult에 저장하기
      var searchResult = obj.find(".searchResult").html();
      // JQuery 객체가 관리하는 HTML 태그 문자열에서 class = 'pageNos' 가진 
      // 태그 내부 문자열 얻어 변수 pageNos에 저장하기
      var pageNos = obj.find(".pageNos").html();
      // class='searchResultCnt' 를 가진 태그 내부에 JQuery 객체가 관리하는
      // 태그 문자열에서 class='searchResultCnt' 가진 태그 내부 데이터를 덮어쓰기
      $(".searchResultCnt").html(searchResultCnt);
      // class='searchResult' 를 가진 태그 내부에 JQuery 객체가 관리하는
      // 태그 문자열에서 class='searchResult' 가진 태그 내부 데이터를 덮어쓰기
      $(".searchResult").html(searchResult);
      // class='pageNos' 를 가진 태그 내부에 JQuery 객체가 관리하는
      // 태그 문자열에서 class='pageNos' 가진 태그 내부 데이터를 덮어쓰기
      $(".pageNos").html(pageNos);

    }
  );
}
//=====================================================================
//게시판 상세 화면으로 이동하는 함수 goBoardDetailForm()선언.
//게시판 행을 버튼 클릭 시 호출되는 함수이다.
//=====================================================================
function goBoardDetailForm(b_no) {
  $("[name='boardDetailForm'] [name='b_no']").val(b_no);

  document.boardDetailForm.submit();
}


function pageNoClick(clickPageNo){
  // 변수 formObj 선언하고 name='boardSearchForm' 를 가진 form 태그 관리 JQuery 객체의 메위주를 저장하기
  var formObj=$("[name='boardSearchForm']");
  // name='selectPageNo' 를 가진 태그의 value 값에 매개변수로 들어오는 클릭한 페이지 번호 저장하기
  // 즉, <input type="hidden" name="selectPageNo" value="1"> 태그의 value 값에 [클릭한 페이지 번호]를 저장하기
  formObj.find("[name='selectPageNo']").val(clickPageNo);
  // search 함수 호출하기
  search();
}
</script>


</head>
<body>


	<!-- home > 자유게시판 -->
	<nav style="-bs-breadcrumb-divider: '&gt;';" aria-label="breadcrumb">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="loginForm.do">Home</a></li>
			<li class="breadcrumb-item active" aria-current="page">주식용어백과</li>
		</ol>
	</nav>






	<!-- 제목 -->
	<h1>주식용어백과</h1>
	<!-- 소제목 -->
	<h5>주식관련 용어</h5>
	<br>




	<!-- start of - 검색란 -->
	<form name="stockSearchForm">
		<div class="row">
			<div class="col">
				<div class="input-group mb-1">
					<input type="text" class="form-control" 
						name="keyword1"
						placeholder="검색어를 입력하세요"
						style="width: 100px;">
					<button class="btn btn-outline-secondary" type="button"
						id="button-addon2" onclick="search()">검색</button>
				</div>
			</div>
			<div class="col"></div>
			<div class="col"></div>
		</div>
		<input type="hidden" name="selectPageNo" value="1">
	</form>
	<!-- end of - 검색란 -->





	<div style="height: 10px"></div>

	<!-- 클릭한 페이지 번호가 저장되는 [입력 양식 태그] 선언 -->
	<!-- 개발 과정 중에는 hidden 태그를 text 로 바꾸어서 직접 보면서 코딩하는게 좋다. -->
	<!-- ---------------------------------------- -->
	<input type="hidden" name="selectPageNo" value="1">
	<!-- ---------------------------------------- -->



	<!-- =================================== 
       			게시판 총 개수 출력하기
          ===================================  -->
	<div class="col" style="text-align: left;">
		<span class="searchResultCnt"> 전체 게시글 수 :
			${requestScope.boardMap.boardListCnt}/${requestScope.boardMap.boardListCntAll} </span>
	</div>












	<!-- =================================== 
          게시판 검색 결과물 출력하기
          ===================================  -->
	<div>
		<table class="table table-striped searchResult">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>등록일</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach var="board" items="${requestScope.boardMap.boardList}"
					varStatus="vs">

					<tr style="cursor: pointer;"
						onClick="goBoardDetailForm(${board.b_no})">


						<!-- 단순 역순 번호 출력 게시판의 고유 번호가 절대 아님 -->
						<td>${requestScope.boardMap.begin_serialNo_desc-vs.index}</td>


						<td>
							<!-- ============================================================== -->
							<!-- 들여쓰기 레벨 단계 번호 만큼 &nbsp;&nbsp;를 표현하기--> <!-- ============================================================== -->
							<c:forEach var="no" begin="1" end="${board.print_level}">
        	 		&nbsp;&nbsp;
        	 	</c:forEach> <!-- ============================================================== -->
							<!-- 만약에 들여쓰기 레벨 단계 번호가 0 보다 크면 문자 ㄴ 표현하기 --> <!-- ============================================================== -->
							<c:if test="${board.print_level>0}">
        	 		ㄴ
        	 	</c:if> ${board.subject}
						</td>


						<td>${board.writer}</td>
						<td>${board.readcount}</td>
						<td>${board.reg_date}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

	</div>

	<!-- =================================== 
          게시판 페이징 번호 출력하기
          ===================================  -->
	<nav aria-label="Page navigation example">

		<ul class="pagination pageNos">
			<!-- 처음 -->
			<li class="page-item"><a class="page-link"
				href="javascript:pageNoClick(1)"> <span aria-hidden="true">&lt;&lt;</span>
			</a></li>
			<!-- 이전 -->
			<li class="page-item"><a class="page-link"
				href="javascript:pageNoClick(${requestScope.boardMap.selectPageNo}-1)">
					<span aria-hidden="true">&lt;</span>
			</a></li>

			<!-- 번호 For 문 -->
			<c:forEach var="pageNo" begin="${requestScope.boardMap.begin_pageNo}"
				end="${requestScope.boardMap.end_pageNo}">
				<!-- 만약에 [선택한 페이지 번호]와 [화면에 출력할 페이지 번호]가 같으면 -->
				<c:if test="${requestScope.boardMap.selectPageNo==pageNo}">
					<li class="page-item active"><a class="page-link"
						href="javascript:void(0)">${pageNo}</a></li>
				</c:if>
				<c:if test="${requestScope.boardMap.selectPageNo!=pageNo}">
					<li class="page-item"><a class="page-link"
						href="javascript:pageNoClick(${pageNo})">${pageNo}</a></li>
				</c:if>
			</c:forEach>

			<!-- 다음 -->
			<li class="page-item"><a class="page-link"
				href="javascript:pageNoClick(${requestScope.boardMap.selectPageNo}+1)">
					<span aria-hidden="true">&gt;</span>
			</a></li>
			<!-- 마지막 -->
			<li class="page-item"><a class="page-link"
				href="javascript:pageNoClick(${requestScope.boardMap.last_pageNo})">
					<span aria-hidden="true">&gt;&gt;</span>
			</a></li>
		</ul>
	</nav>


	<div>
		<a href="/boardRegForm.do" class="btn btn-lg btn-primary">새글쓰기</a> <a
			href="/loginForm.do" class="btn btn-secondary btn-lg">메인으로</a>

	</div>



	<!-- ======================================================================== -->
	<!-- 게시판 상세보기 화면 이동을 위한 form 태그 선언하기 -->
	<!-- ======================================================================== -->
	<form name="boardDetailForm" action="/boardDetailForm.do" post="post">

		<!-- 게시판 번호가 저장되는 입력 양식 태그 선언하기 -->
		<input type="hidden" name="b_no">

	</form>

</body>
</html>













