
<!-- ============================================================================== -->
<!-- JSP기술의 한 종류인 Page Directive를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- ============================================================================== -->
<!-- 현재 이 JSP페이지 실행 후 생성되는 문서는 HTML이고 이 문서 안의 데이터는 UTF-8방식으로 인코딩한다 라고 설정함. -->
<!-- 현재 이 JSP페이지를 저장할때는 UTF-8방식으로 인코딩한다 -->
<!-- 모든 JSP 페이지 상단에 무조건 아래 설정이 들어간다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>

<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<!-- JSP 기술의 한 종류인 Include Directive를 이용하여 -->
<!-- common.jsp 파일 내의 소스를 삽입하기 -->
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<%@include file="/WEB-INF/views/boardDetailFormHelper.jsp"%>
<%@include file="/WEB-INF/views/sideBar.jsp" %>




<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>

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


<script>
	//웹브라우저가 body태그 안
	$(function() {
		init();
	})

	//웹브라우저가 body 태그안을 모두 읽어들인 후 실행할 init()함수 선언하기
	function init() {

		getReplyList();

	}
	//게시판 목록으로 이동
	function goBoardListForm() {
		//name=boardListForm을 가진 form 태그의 action값의 URL주소로 서버에 접속하라
		//form태그 내부의 입력양식들의 입력된 데이터도 서버로 전송된다.
		document.boardListForm.submit();
	}

	//게시판 댓글 쓰기 화면으로 이동하는 함수 선언
	function goBoardRegForm() {

		//name=boardRegForm을 가진 form 태그의 action값의 URL주소로 서버에 접속하라
		//form태그 내부의 입력양식들의 입력된 데이터도 서버로 전송된다.
		//현재는 hidden 태그에 입력된 게시판 번호가 전송된다.
		document.boardRegForm.submit();
	}

	//게시판 댓글 쓰기 화면으로 이동하는 함수 선언
	function goBoardUpDelForm() {

		//name=boardRegForm을 가진 form 태그의 action값의 URL주소로 서버에 접속하라
		//form태그 내부의 입력양식들의 입력된 데이터도 서버로 전송된다.
		//현재는 hidden 태그에 입력된 게시판 번호가 전송된다.
		document.boardUpDelForm.submit();
	}

	/* =============================================================
		댓글 
	============================================================= */

	   // 댓글 입력
	   function insertReply() {
	      var contentObj = $('#txt_reply_content');

	      var content = contentObj.val();
		
	      
	      if (content.trim() == '') {
	         alert("댓글이 공백입니다.");
	         return;
	      }
	      
	      
	      var replyInsertForm = $('[name="replyInsertForm"]');
	      replyInsertForm.find('[name="content"]').val(content);


	      contentObj.val('');

	      // 등록
	      ajax("/replyInsert.do", "post", replyInsertForm,
	            function(responseJson) {

	               // 성공
	               var isSuccess = (responseJson["regCnt"] > 0);

	               if (isSuccess) {
	                  // 댓글 목록 불러오기
	                  getReplyList();
	               } else {
	                  // 실패
	               }
	            });
	   }

	// 댓글 목록 불러오기
	function getReplyList() {
		//replyList.do
		ajax("/replyList.do", "post", $("[name='replyListForm']"), function(
				responseHtml) {
			$('#replyList').html(responseHtml);
		});

	}
	
	// 댓글 수정하기
	   function replyUpdate(r_no){
	      var formObj = $('[name="replyUpDelForm_' + r_no + '"]');
	      var contentObj = formObj.find('[name="content"]');
	      var content = contentObj.val();

	      if (content.trim() == '') {
	         alert("댓글이 공백입니다.");
	         return;
	      }

	      // 수정
	      ajax("/replyUpdate.do", "post", formObj,
	            function(responseJson) {
	               // 성공
	               var isSuccess = (responseJson["regCnt"] > 0);

	               if (isSuccess) {
	                  // 댓글 목록 불러오기
	                  alert('수정되었습니다.')
	               } else {
	                  // 실패
	                  alert('실패하였습니다.')
	               }
	               getReplyList();
	            });
	   }
	
	// 댓글 수정버튼 클릭 시
	function showReplyUpdate(r_no){
		var areaObj = $('#replyUpDelArea_' + r_no);
		areaObj.show();
	}
	
	// 댓글 수정 후 취소 버튼 클릭 시
	function hideReplyUpdate(r_no){ 
		var areaObj = $('#replyUpDelArea_' + r_no);
		areaObj.hide();
	}
	
	// 댓글 삭제하기
	function replyDelete(r_no){
		var isDel = confirm('해당 댓글을 정말 삭제하시겠습니까?');
		
		if(isDel){
			var formObj = $('[name="replyUpDelForm_' + r_no + '"]');
			ajax("/replyDelete.do", "post", formObj,
					function(responseJson) {
						// 성공
						var isSuccess = (responseJson["regCnt"] > 0);

						if (isSuccess) {
							// 댓글 목록 불러오기
							alert('삭제되었습니다.')
						} else {
							// 실패
							alert('실패하였습니다.')
						}
						getReplyList();
					});
		}
	}
</script>



</head>

<body>
	
	<!------------ 여기서 부터 게시판  ------------------->
	<section class="home-section">
		<div class="home-content">
			<i class="bx bx-menu"></i>
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
			<!--- 메인 --->
			<div class="main">
					<div class="toggle">
						
					</div>
			</div>
			
			<!--- 메인 --->
			<!-- order details list -->
				<div class="details">
					<div class="recentOrders">
						<div class="cardHeader">
							<h2>전체 게시판</h2>
							<!--<a href="#" class="btn">View All</a> -->
							<c:if test="${sessionScope.mem_nick==boardDTO.mem_nick}"> 
							<span class="writerbtn" style="cursor: pointer" onClick="goBoardUpDelForm();"> 수정/삭제 </span>
							</c:if>
							<span class="writerbtn" style="cursor: pointer" onClick="goBoardListForm();">목록보기 </span>
						</div>
						<!--- 테이블 시작점 --->
			<div class="col content_area" align="center">
				<form name="boardDetailForm" >
					<table  class="table searchResult">
					<thead>
						<tr>
							<tr>
							<td>닉네임</td>
							<td>
								<!-- EL 문법으로 HttpServletRequest 객체에 키값 boardDTO로
							저장된 객체의 멤버변수 mem_nick의 저장값 표현하기 --> ${requestScope.boardDTO.mem_nick}
							</td>
						</tr>


						<tr>
							<td>제 목</td>
							<td>
								<!-- EL 문법으로 HttpServletRequest 객체에 키값 boardDTO로
							저장된 객체의 멤버변수 subject의 저장값 표현하기 -->
								${requestScope.boardDTO.subject}
							</td>
						</tr>


						<tr>
							<td>조회수</td>
							<td>
								<!-- EL 문법으로 HttpServletRequest 객체에 키값 boardDTO로
							저장된 객체의 멤버변수 readcount의 저장값 표현하기 -->
								${requestScope.boardDTO.readcount}
							</td>
						</tr>
						<tr>
						<td>내 용</td>
						<td><span>${requestScope.boardDTO.content}</span></td>
						</tr>
						<tr>
							<td>이 미 지</td>
									<!--  이미지 파일 코드 -->
									<td><c:if test="${!empty requestScope.boardDTO.img_name}">
									<img src="/img/${requestScope.boardDTO.img_name}"
										height="200px">
									</c:if>
								<br>
								<!--  내용 코드 -->
								</td>

						</tr>
					</table>
				</form>
				<div style="heigth: 5px;"></div>
				<!-- ================================================= -->
				<!-- 파라미터명 mom_b_no에 대응하는 파라미터값 입력 양식에 삽입하기 이거 뭔데 답글땜에 필요한거임? -->
				<input type="hidden" name="mom_b_no" value="${param.mom_b_no}">
				<!-- ================================================= -->
			</div>
				<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
				<!--- 게시판 검색 조건 관련 태그 선언하기.-->
				<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
				<div class="searchResult">
					<!-- 게시판 목록 보기  -->
					<!-- ================================================= -->
					<!-- 파라미터명 mom_b_no에 대응하는 파라미터값 입력 양식에 삽입하기 이거 뭔데 답글땜에 필요한거임? -->
					<input type="hidden" name="mom_b_no" value="${param.mom_b_no}">
					<!-- ================================================= -->
					<!-- <input type="button" value="댓글쓰기" onClick="goBoardRegForm();"> -->
					</div>
				</div>
					<!-- 댓글쓰기 -->
					<div class="recentCustomers">
						<div class="cardHeader" style="margin-bottom: 10px">
							<h2>Comment</h2>
						</div>
										<span class="form-commentInfo">
						<textarea class="form-control" id="txt_reply_content" id="comment-input"
							placeholder="댓글을 입력하세요." style="width: 100%" rows="3" cols="60"></textarea>
							<br>
						<button class="writerbtn" type="button" style="width: 100%"
							onclick="insertReply();" style="margin-top: 0.5em;">등록</button>
							&nbsp;
					</span>
						<!-- 댓글 목록 -->
					<form name="replyListForm">
						<input type="hidden" name="b_no"
							value="${requestScope.boardDTO.b_no}">
					</form>
					<div class="col" id="replyList"></div>
							
								<!-- <td width="60px"><div class="imgBx"><img src="user.png"></div></td>
                                <td><h4>ShinBihan<br><span>Korea</span></h4></td>  -->
								<!-- 댓글 영역 -->
				<div name="zzz" align="center">
				<br>
				<!-- 댓글 입력 -->
					<div class="input-group mb-3" id="form-commentInfo">

					</div>
					<form name="replyInsertForm">
						<input type="hidden" name="b_no"
							value="${requestScope.boardDTO.b_no}"> <input
							type="hidden" name="u_id" value="${sessionScope.mem_id }">
						<!-- 세션에서 사용자 아이디 -->
						<input type="hidden" name="u_name" value="${sessionScope.mem_nick }">
						<!-- 세션에서 사용자 정보 중 이름 -->
						<input type="hidden" name="content">
					</form>
				</div>
				</div>
			</div>


	<!--------------------------------------- 삭제하면 안됨 --------------------------------->
	<!-- ========================================================== -->
	<!-- WAS에 "/boardList.do URL주소로 접속하기 위한 form 태그 선언 -->
	<!-- ========================================================== -->
	<form name="boardListForm" method="post" action="/boardList.do">
	</form>

	<!-- ========================================================== -->
	<!-- WAS에 "/boardUpDel.do URL주소로 접속하기 위한 form 태그 선언 -->
	<!-- ========================================================== -->
	<form name="boardUpDelForm" method="post" action="/boardUpDelForm.do">

		<!-- WAS에 "/boardUpDelForm.do" URL 주소로 접속할 때 가져갈 데이터 저장 목적의 hidden 태그 선언 -->
		<!-- 현재 이 hidden 태그는 수정삭제 할 게시판의 고유번호가 저장되어있따. -->
		<input type="hidden" name="b_no" value="${requestScope.boardDTO.b_no}">
	</form>


	<!-- ========================================================== -->
	<!-- WAS에 "//boardRegForm.do URL주소로 접속하기 위한 form 태그 선언 -->
	<!-- ========================================================== -->
	<form name="boardRegForm" method="post" action="/boardRegForm.do">


		<!-- WAS에 "//boardRegForm.do" URL 주소로 접속할 때 가져갈 데이터 저장 목적의 hidden 태그 선언 -->
		<!-- 현재 이 hidden 태그는 수정삭제 할 게시판의 고유번호가 저장되어있따. -->
		<input type="hidden" name="mom_b_no"
			value="${requestScope.boardDTO.b_no}">
	</form>
	
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
</html>




