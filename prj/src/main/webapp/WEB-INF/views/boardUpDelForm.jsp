
<!-- ============================================================================== -->
<!-- JSP기술의 한 종류인 Page Directive를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- ============================================================================== -->
<!-- 현재 이 JSP페이지 실행 후 생성되는 문서는 HTML이고 이 문서 안의 데이터는 UTF-8방식으로 인코딩한다 라고 설정함. -->
<!-- 현재 이 JSP페이지를 저장할때는 UTF-8방식으로 인코딩한다 -->
<!-- 모든 JSP 페이지 상단에 무조건 아래 설정이 들어간다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<!-- JSP 기술의 한 종류인 Include Directive를 이용하여 -->
<!-- common.jsp 파일 내의 소스를 삽입하기 -->
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<%@include file="/WEB-INF/views/common.jsp" %>
   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


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



   function goBoardListForm(){
      document.boardListForm.method="post";
      document.boardListForm.action="/boardList.do";
      document.boardListForm.submit();
   }
   //--------------------------------------------------------------
   //수정 버튼 클릭 시 호출되는 함수 선언
   //--------------------------------------------------------------
   function checkBoardUpForm(){
       var  formObj = $('form[name="boardUpDelForm"]')
       
       
             
         //inputAfterBlankDel( formObj.find("[name='writer']") );
         inputAfterBlankDel( formObj.find("[name='subject']") );
         inputAfterBlankDel( formObj.find("[name='content']") );
             
       
       
       
       
       //--------------------------------------------------------------
      //게시판 입력 양식의 유효성 체크하기
      //--------------------------------------------------------------
       if( !checkSubject(formObj.find("[name='subject']")) )    {return;}
      //--------------------------------------------------------------
      //if( !checkPwd(formObj.find("[name='pwd']")) )       {return;}  이루케 하면안댐
      //--------------------------------------------------------------

      //--------------------------------------------------------------
      if( !checkContent(formObj.find("[name='content']")) )    {return;}
       //if( !checkWriter(formObj.find("[name='writer']")) )    {return;}
    
      //--------------------------------------------------------------
      //수정 여부를 물어보기
      //--------------------------------------------------------------
      if( confirm("정말 수정하시겠습니까?")==false ) { return;}
      
      //--------------------------------------------------------------
      //WAS로 "/boardUpProc.do" URL 주소로 접속하고 얻은
      //수정 실행 결과 정보가 담긴 JSON객체를 받고
      //이 JSON 객체 저장된 데이터 따라 실행구문을 달리 실행하기
      //--------------------------------------------------------------
      ajax(
               //---------------------------
               //WAS로 접속할 주소 설정
               //---------------------------
               "/boardUpProc.do"
               //---------------------------
               //WAS로 접속하는 방법 설정
               //---------------------------
               ,"post"
               //---------------------------
               //입력양식을 끌어안고 있는 form태그 관리 제이쿼리 객체 메위주
               //---------------------------
               ,formObj
               //---------------------------
               //WAS와 통신이 성공했을 때 호출되는 익명함수 설정
               //현재 익명함수의 매개변수로 JSON이 들어온다.
               //JSON안에 수정 실행 결과 정보 담겨있다.
               //---------------------------
               , function( responseJson ){
                  //----------------------------
                  //WAS가 응답해준 JSON에서
                  //경고 문구 꺼내서 변수 errorMsg에 저장하기
                  //수정된 행의 개수 꺼내서 변수 boardUpCnt에 저장하기
                  //----------------------------
                  var errorMsg = responseJson["errorMsg"];
                  var boardUpCnt = responseJson["boardUpCnt"];
                  //----------------------------
                  //경고 문구가 저장된 errorMsg가 비어 있지 않으면
                  //경고 문구를 보이고 함수 중단하기
                  //----------------------------
                  if( errorMsg!=""){
                     alert(errorMsg); return;   //익명함수 responseJson 를 멈추는것임
                  }
                  
                  //----------------------------
                  //수정된 행의 개수가 1이면
                  //----------------------------
                  if( boardUpCnt==1){
                     alert("수정이 성공했습니다.");
                     //---------------
                     //name=boardListForm을 가진 form 태그에 있는
                     //action 속성값에 있는 URL 주소로 WAS에 접속하기
                     //이때 접속 방식은 from 태그에 있는 method의 속성값을 따른다.
                     //즉, 게시물 목록보기 화면으로 이동하기
                     //---------------
                     document.boardListForm.submit();
                  }
                  //----------------------------
                  //수정된 행의 개수가 0이면(즉, 수정할 게시물이 먼저 삭제 된 상황이면)
                  //----------------------------
                  else if( boardUpCnt==0){
                     alert("삭제된 게시물입니다.");
                  }
                  //----------------------------
                  //수정된 행의 개수가 -1이면(즉, 암호가 틀린 상황이면)
                  //----------------------------
                  else if( boardUpCnt==-1){
                     alert("암호가 틀립니다. 재 입력 바랍니다.");
                  }
                  //----------------------------
                  //수정된 행의 개수가 -11이면 (즉, 업로드된 파일의 크기가 너무 크면)
                  //----------------------------
                  else if( boardUpCnt==-11 ){
                     alert("업로드된 파일의 크기는 1000kb 이하이어야합니다.");
                  }
                  //----------------------------
                  //수정된 행의 개수가 -12이면 (즉, 업로드된 파일의 확장자가 틀리면)
                  //----------------------------
                  else if( boardUpCnt==-12 ){
                     alert("파일업로드는 jpg, png, gif 파일만 가능합니다.");
                  }
                  
                  //----------------------------
                  //수정된 행의 개수가 -21이면 (즉, 유효성체크시 에러가 발생했으면)
                  //----------------------------
                  else if( boardUpCnt==-21 ){
                     if(!errorMsg.indexOf("제목") ){
                        $("[name=subject]").val("")
                     }
                     alert(errorMsg);
                  }
                  else{
                     alert("수정 실패 !관리자에게 문의 바랍니다.");
                  }
               }
         );
      
   }
    
   
   //============================================
   //삭제 버튼 누르면 호출되는 함수 선언
   //============================================
   function checkBoardDelForm(){
      //-----------------------------------------------
      //name='boardUpDelForm' 가진 form 태그를 관리하는
      //제이쿼리 객체 생성해서 변수 formObj에 저장하기
      //-----------------------------------------------
      var formObj = $("[name='boardUpDelForm']")
      //-----------------------------------------------
      //암호 가 비었으면 경고하고 함수 중단하기
      //-----------------------------------------------

      
      //-----------------------------------------------
      //삭제 여부를 물어보기
      //-----------------------------------------------
      if( confirm("정말 삭제하시겠습니까?")==false ) {return;}
      
      /**************************************************************
        WAS로 "/boardDelProc.do" URL 주소로 접속하고
        삭제 실행 행의 개수 받고
        삭제 실행 행의 개수 따라 실행 구문을 달리 실행하기
      **************************************************************/
      
      ajax(
            //------------------------------
            //WAS로 접속할 주소 설정
            //------------------------------
            "/boardDelProc.do"
            //------------------------------
            //WAS로 접속하는 방법 설정
            //------------------------------
            ,"post"
            //------------------------------
            //입력 양식을 끌어안고 있는 form 태그 관리 제이쿼리 객ㅊ레 메위주
            //------------------------------
            ,formObj
            //------------------------------
            //WAS와 통신이 성공했을시 호출되는 익명함수 설정
            //현재 익명함수의 매개변수로 삭제 실행 행의 개수가 들어온다.
            //------------------------------
            ,function( boardDelCnt){
               //-----------------------------------------
               //매개변수 boardDelCnt 가 1 이 저장되어있으면
               //즉, 삭제가 성공했으면
               //-----------------------------------------
               if( boardDelCnt==1 ){
                  alert("삭제가 성공했습니다.");
                  document.boardListForm.submit();
               }
               //-----------------------------------------
               //매개변수 boardDelCnt에 2 가 저장되어있으면
               //즉, 자식글이 있어 제목, 컨텐츠만 비우기가 성공했으면
               //-----------------------------------------
               else if( boardDelCnt==2){
                  alert("자식글이 있어 삭제가 안되고 제목,컨텐츠만 비웁니다.");
                  document.boardListForm.submit();
               }
               //-----------------------------------------
               //매개변수 boardDelCnt에 0 이 저장되어있으면
               //즉, 삭제된 게시물이면
               //-----------------------------------------
               else if( boardDelCnt==0){
                  alert("삭제된 게시물입니다.")
                  document.boardListForm.submit();
               }
               //-----------------------------------------
               //매개변수 boardDelCnt에 -1 이 저장되어있으면
               //즉, 암호가 틀리면
               //-----------------------------------------

               else{
                  alert("WAS 접속 실패입니다. 관리자에게 문의바랍니다.")
               }
            }
         );
   
   }
</script>


</head>

<body>

<!-- home > 본문 > 수정화면 -->
   <nav style="-bs-breadcrumb-divider: '&gt;';" aria-label="breadcrumb">
      <ol class="breadcrumb">
         <li class="breadcrumb-item"><a href="mainWeb.do">Home</a></li>
         <li class="breadcrumb-item"><a href="javascript:window.history.back()">게시글</a></li>
         <li class="breadcrumb-item active" aria-current="page">수정하기</li>
      </ol>
   </nav><br/>




      <form name="boardUpDelForm">
      <!-- 타이틀 -->
      <h1>수정/삭제하기</h1>
      <!-- 서브 타이틀 -->
      <h5>게시글 수정/삭제 화면</h5>
      <br />

      <div class="table">
      <table class="table table-bordered">
         
               
               <tr>
                  <th>제 목</th>
                  <td>
                  <!-- ============================================================ -->
                  <input type="text" name="subject" class="subject" size="40" maxlength="35"
                           value="${requestScope.boardDTO.subject}">
                  <!-- ============================================================ -->
                  </td>
               </tr>
               
                            
               
               <tr>
                  <th>내 용</th>
                  <td>
                  <!-- ============================================================ -->
                  <textarea name="content" class="content" rows="13" cols="40"
                           maxlength="500">${requestScope.boardDTO.content}</textarea>
                  <!-- ============================================================ -->
                  </td>
               </tr>
      
                      
                        
               
               <tr class="mb-3">
                  <th>이미지</th>
                  <td>
                  <!-- ============================================================ -->
                  <c:if test="${!empty requestScope.boardDTO.img_name}">
                     <img src="/img/${requestScope.boardDTO.img_name}" height="200px"><br>
                     <input type="checkbox" name="isdel" value="del">기존파일삭제<br>
                     <input type="hidden" name="img_name" value="${requestScope.boardDTO.img_name}">
                     
                  </c:if>
                     
                     <input type="file" name="img">
                  <!-- ============================================================ -->
                  </td>
               </tr>

         <colgroup>
            <col style="width: 30px">
            <col />
            
            
         </colgroup>

      </table>
      </div>
      
      
            <!-- ============================================================ -->
            <input type="hidden" name="b_no" value="${requestScope.boardDTO.b_no}">
            <input type="hidden" name="mem_nick" value="${requestScope.boardDTO.mem_nick}">
            <!-- ============================================================ -->
            <div style="heigth:5px;"></div>
            <!-- ============================================================ -->
            <div class="btn-group">
            <input  class="btn btn-primary" type="button" value="수정" onClick="checkBoardUpForm()">&nbsp;&nbsp;
            <input  class="btn btn-primary" type="button" value="삭제" onClick="checkBoardDelForm()">&nbsp;&nbsp;
            <span  class="btn btn-primary" style="cursor:pointer" onClick="goBoardListForm();">목록</span>
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


