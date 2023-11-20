<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="./css/style3.css" rel="stylesheet">
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
   $(function() {
      init();
   });
   function init() {
      //테스트가 끝나면 주석처리
      var formObj = $("[name='boardRegForm']");

      formObj.find("[name='subject']").val("제목x");
      formObj.find("[name='content']").val("아무내용");

   }
   //----------------------------------------
   // 목록보기 버튼을 클릭하면 호출되는 함수
   //----------------------------------------
   function goBoardListForm() {
      // name=boardListForm  을 가지 form 태그의 
      // action 값의 URL 주소로 WAS에 접속하기
      document.boardListForm.submit();
   }
   //----------------------------------------
   // 저장 버튼을 클릭하면 호출되는 함수
   //----------------------------------------
   function checkBoardRegForm() {
      //*******************************************
      // name='boardRegForm' 가진 form 태그를 관리하는
      // JQuery 객체 생성해서 변수 formObj 에 저장하기 
      //*******************************************
      var formObj = $("[name='boardRegForm']");

      inputAfterBlankDel(formObj.find("[name='mem_nick']"));
      inputAfterBlankDel(formObj.find("[name='subject']"));
      inputAfterBlankDel(formObj.find("[name='content']"));

      /* 잠깐 주석
      //******************************************************
      // 게시판 입력 양식의 유효성 체크하기
      //******************************************************
      if( !checkSubject(formObj.find("[name='subject']"))  ) { return; }
      if( !checkEmail(formObj.find("[name='email']"))  )     { return; }
      if( !checkPwd(formObj.find("[name='pwd']"))  )         { return; }
      if( !checkContent(formObj.find("[name='content']"))  ) { return; }
      if( !checkWriter(formObj.find("[name='writer']"))  )   { return; }
       */

      //******************************************************
      // 저장 여부를 물어보기
      //******************************************************
      if (confirm("정말 등록하시겠습니까?") == false) {
         return;
      }

      //*******************************************
      // WAS 로 "/boardRegProc.do" URL 주소로 접속하고
      // 입력 실행 결과 정보가 담긴 [JSON]을 받고 
      // 이 [JSON] 저장된 데이터 따라 실행구문을 달리 실행하기
      //*******************************************
      ajax(
      //-------------------------------
      // WAS 로 접속할 주소 설정
      //-------------------------------
      "/boardRegProc.do"
      //-------------------------------
      // WAS 로 접속하는 방법 설정. get 또는 post
      //-------------------------------
      , "post"
      //-------------------------------
      // 입력 양식을 끌어안고 있는 form 태그 관리 JQuery 객체 메위주
      //-------------------------------
      , formObj
      //-------------------------------
      // WAS 와 통신이 성공했을 호출되는 익명함수 설정.
      // 현재 익명함수의 매개 변수로 JSON 이 들어온다.
      // JSON 안에 입력 실행 결과 정보 담겨 있다.
      //-------------------------------
      , function(responseJson) {
         //---------------------------------
         // WAS가 응답해준 JSON 에서 
         // 경고 문구 꺼내서 변수 errorMsg 에 저장하기
         // 입력된 행의 개수 꺼내서 변수 boardRegCnt 에 저장하기
         //---------------------------------
         var errorMsg = responseJson["errorMsg"];
         var boardRegCnt = responseJson["boardRegCnt"];

         //---------------------------------
         // 변수 errorMsg 안에 경고 문구가 없고 
         // 변수 boardRegCnt  입력 성공 행의 개수가 1이면, 
         // 즉 입력이 성공했으면
         //---------------------------------
         if (errorMsg == "" && boardRegCnt == 1) {
            alert("${empty param.mom_b_no?'새글':'댓글'}쓰기 성공!");
            goBoardListForm();
         }

         //----------------------------
         //수정된 행의 개수가 -11이면 (즉, 업로드된 파일의 크기가 너무 크면)
         //----------------------------
         else if (boardRegCnt == -11) {
            alert("업로드된 파일의 크기는 1000kb 이하이어야합니다.");
         }
         //----------------------------
         //수정된 행의 개수가 -12이면 (즉, 업로드된 파일의 확장자가 틀리면)
         //----------------------------
         else if (boardRegCnt == -12) {
            alert("파일업로드는 jpg, png, gif 파일만 가능합니다.");
         }

         //----------------------------
         //수정된 행의 개수가 -21이면 (즉, 유효성체크시 에러가 발생했으면)
         //----------------------------
         else if (boardRegCnt == -21) {
            if (errorMsg.indexOf("제목") >= 0) {
               $("[name=subject]").val("")
            }
            alert(errorMsg);
         }

         else {
            alert(errorMsg + ". ${empty param.mom_b_no?'새글':'댓글'}쓰기 실패!");
         }

      });
   }
</script>


</head>

<body>

   <form name="boardRegForm">

      <!-- 타이틀 -->
      <h1>새 글쓰기</h1>
      <!-- 서브 타이틀 -->
     
      <br />

      <table class="table table-bordered">

         <tr><!--  근딩 로그인했으니 자동 입력이고 변경 안되야할듯 -->
               <!-- ============================================================ -->
               <input type="hidden" name="mem_nick" class="mem_nick" size="10" maxlength="15"
                           value="${sessionScope.mem_nick}">
               <!-- ============================================================ -->
         </tr>






      <!-- 게시판 번호가 저장되는 입력 양식 태그 선언하기 -->
      



         <tr>
            <th>제 목</th>
            <td>
               <!-- ============================================================ -->
               <input type="text" name="subject" class="subject" size="40"
               maxlength="35"><!-- ============================================================ -->
               <input type="hidden" name="c_no" value="2">
            </td>
         </tr>


         <tr>
            <th>내 용</th>
            <td>
               <!-- ============================================================ -->
               <textarea name="content" class="content" rows="13" cols="40"
                  maxlength="500"></textarea> <!-- ============================================================ -->
            </td>
         </tr>

            <tr>
               <th>이미지</th>
               <td>
               <!-------------------------------------------------------->
               <input type="file" name="img">
               <!-------------------------------------------------------->
               </td>
            </tr>

<!--          <tr class="mb-3">
            <th>이미지</th>
            <label for="formFile" class="form-label"></label>
            <td><input class="form-control form-control-sm" type="file"
               id="formFile"></td>
         </tr> -->
         <!-- ============================================================ -->
         <c:if test="${!empty param.mom_b_no}">
            <input type="hidden" name="mom_b_no" value="${param.mom_b_no}">
         </c:if>
         <!-- ============================================================ -->

         <colgroup>
            <col style="width: 100px" />
            <col />
         </colgroup>

      </table>



      <div class="btn-group">
         <a onClick="checkBoardRegForm();" class="btn btn-primary active" aria-current="page">저장</a> &nbsp;&nbsp;
         <input type="reset" class="btn btn-primary"> &nbsp;&nbsp;
         <a onClick="goBoardListForm();" class="btn btn-primary">목록</a>
      </div>
   </form>





   <!-- ============================================================ -->
   <!-- WAS에 "/boardList.do" URL주소로 접속하기 위한 form 태그 선언 -->
   <!-- ============================================================ -->
   <form name="boardListForm" method="post" action="/boardList.do">
   </form>









</body>
</html>


<!-- 
      ${requestScope.boardDTO.writer} <br>
      ${requestScope.boardDTO.subject} <br>
      ${requestScope.boardDTO.email} <br>
      ${requestScope.boardDTO.content} <br>
      ${requestScope.boardDTO.writer} <br>
      ${requestScope.boardDTO.writer} <br>
    -->


