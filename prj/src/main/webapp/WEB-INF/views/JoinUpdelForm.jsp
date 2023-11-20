
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
<%@include file="/WEB-INF/views/JoinUpDelFormHelper.jsp" %>
   
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
$(function() {
   init();
});
function init() {
   //테스트가 끝나면 주석처리
   var formObj = $("[name='JoinUpdelForm']");
   
   
   
   // 닉네임 변경시 중복체크 초기화
   var $nick = formObj.find("[name='mem_nick']");
   $nick.change(function() {
      $nick.attr('data-duplication', false);
   });
   

    //formObj.find("[name='mem_nick']").val();
   //formObj.find("[name='mem_id']").val("abcd");
   //formObj.find("[name='mem_pwd']").val();
   //formObj.find("[name='mem_name']").val();
   //formObj.find("[name='mem_gender']").val();
   //formObj.find("[name='mem_birth']").val();
   //formObj.find("[name='mem_email']").val();

}

//----------------------------------------
// 목록보기 버튼을 클릭하면 호출되는 함수
//----------------------------------------
function goLoginForm() {
   // name=boardListForm  을 가지 form 태그의 
   // action 값의 URL 주소로 WAS에 접속하기
   document.loginForm.submit();
}


function checkJoinUpdelForm(){

   /* 비밀번호 유효성 검사 */
   if (JoinUpdelForm.mem_pwd.value.length == 0) {
      alert("비밀번호가 누락됐습니다.");
      joinForm.mem_pwd.focus();
      return;
   }

   // 입력한 암호 읽어와서 변수 mem_pwd 에 저장하기
   // 만약에 변수 mem_pwd 에 문자가 아닌 데이터가 있다면 "" 로 갱신하기
   // 변수 mem_pwd 안의 앞뒤 공백 제거하기
   var mem_pwd = $("[name='mem_pwd']").val();
   if (typeof (mem_pwd) != "string") {
      mem_pwd = "";
   }
   mem_pwd = $.trim(mem_pwd);

   // 만약에 암호가 비어있으면 경고하고 함수 중단
   if (mem_pwd == "") {
      alert("비밀번호가 공백으로 비어 있습니다.");
      JoinUpdelForm.mem_pwd.focus();
      return;
   }
   // 비밀번호 입력가능 길이
   if (JoinUpdelForm.mem_pwd.value.length<3 || JoinUpdelForm.mem_pwd.value.length>8) {
      alert("비밀번호는 3자 ~ 8자 여야합니다.");
      return;
   }
   var mem_pwd_re = $("[name='mem_pwd_re']").val();

   if (mem_pwd !== mem_pwd_re) {
      alert("비밀번호와 비밀번호 확인이 동일하지 않습니다.");
      return;
   }





   // 입력한 생년월일 읽어와서 변수 mem_birth 에 저장하기
   // 만약에 변수 mem_birth 에 문자가 아닌 데이터가 있다면 "" 로 갱신하기
   // 변수 mem_birth 안의 앞뒤 공백 제거하기
   var mem_birth = $("[name='mem_birth']").val();
   if (typeof (mem_birth) != "string") {
      mem_birth = "";
   }
   mem_birth = $.trim(mem_birth);

   // 생년월일 입력가능 길이
   if (JoinUpdelForm.mem_birth.value.length != 8) {
      alert("생년월일 8자리를 입력해주세요.");
      return;
   }

   // 만약에 생년월일 비어있으면 경고하고 함수 중단
   if (mem_birth == "") {
      alert("생년월일이 공백으로 비어 있습니다.");
      JoinUpdelForm.mem_birth.focus();
      return;
   }

   /* 이메일 유효성 검사 */
   if (JoinUpdelForm.mem_email.value.length == 0) {
      alert("이메일이 누락됐습니다.");
      JoinUpdelForm.mem_email.focus();
      return;
   }

   // 입력한 이메일 읽어와서 변수 mem_email 에 저장하기
   // 만약에 변수 mem_email 에 문자가 아닌 데이터가 있다면 "" 로 갱신하기
   // 변수 mem_email 안의 앞뒤 공백 제거하기
   var mem_email = $("[name='mem_email']").val();
   if (typeof (mem_email) != "string") {
      mem_email = "";
   }
   mem_email = $.trim(mem_email);

   // 만약에 이메일이 비어있으면 경고하고 함수 중단
   if (mem_email == "") {
      alert("이메일이 공백으로 비어 있습니다.");
      JoinUpdelForm.mem_email.focus();
      return;
   }

   if (!checkEmail($("[name='mem_email']"))) {
      return;
   }
   
   
   if (confirm("개인정보를 수정 하시겠습니까?") == false) {
      return;
   }
   alert("수정 성공!")
   alert("다시 로그인해 주세요.")
   document.JoinUpdelForm.submit();
}





//===================================
//닉네임 유효성 체크와 중복 체크 부분
//===================================
function checkNickDuplication() {
   var $nick = $('[name="mem_nick"]');

   var nick = $nick.val();

   
   /* 닉네임 유효성 검사 */
   if (JoinUpdelForm.mem_nick.value.length == 0) {
      alert("닉네임이 누락됐습니다.");
      JoinUpdelForm.mem_nick.focus(); // 포커스를 이동시켜 바로 입력할 수 있게
      return;
   }

   // 입력한 닉네임 읽어와서 변수 mem_nick 에 저장하기
   // 만약에 변수 mem_nick 에 문자가 아닌 데이터가 있다면 "" 로 갱신하기
   // 변수 mem_nick 안의 앞뒤 공백 제거하기
   var mem_nick = $("[name='mem_nick']").val();
   if (typeof (mem_nick) != "string") {
      mem_nick = "";
   }
   mem_nick = $.trim(mem_nick);

   // 만약에 닉네임이 비어있으면 경고하고 함수 중단
   if (mem_nick == "") {
      alert("닉네임이 공백으로 비어 있습니다.");
      return;
   }

   // 닉네임 입력가능 길이
   if (JoinUpdelForm.mem_nick.value.length<2 || JoinUpdelForm.mem_nick.value.length>8) {
      alert("닉네임은 2자 ~ 8자 여야합니다.");
      return;
   }
   
   
   // 호출
   $.ajax({
      url : '/checkNickDuplication.do?mem_nick=' + nick,
      type : 'get',
      success : function(responseData) {
         if (responseData.isDuplication) {
            $nick.data('duplication', false);
            alert('사용중인 닉네임입니다.');
         } else {
            $nick.data('duplication', true);
            alert('사용 가능한 닉네임입니다.');
         }
      },
      error : function() {
         $nick.data('duplication', false);
         alert("웹서버 접속 실패! 관리자에게 문의 바랍니다.");
      }
   });
}

</script>




</head>
<body>
   <div class="wrapper">
        <form name="JoinUpdelForm" action="/JoinUpdelProc.do" method="post">
            <h1>MyPage</h1>
            <div class="input-box">
                <input type="hidden" placeholder="NickName" name="mem_nick"  value="${sessionScope.mem_nick}">
                <input type="text" disabled placeholder="NickName" name="mem_nick" required value="${sessionScope.mem_nick}">
                <input type="hidden" placeholder="NickName" name="mem_nick"  value="${sessionScope.mem_nick}">
            </div>             
            <!--------------------------------------------------->
            <div class="input-box">
                <input type="text" disabled name="mem_id" placeholder="ID" required value="${sessionScope.mem_id}">
                <input type="hidden"  name="mem_id" placeholder="ID"  value="${sessionScope.mem_id}">
            </div>
            <!--------------------------------------------------->
            <div class="input-box">
                <input type="password" name="mem_pwd" placeholder="PW" required>
            </div> 
            <!--------------------------------------------------->
            <div class="input-box">
                <input type="password" name="mem_pwd_re" placeholder="PW_RE_Check" required>
            </div> 
            <!--------------------------------------------------->
            <div class="input-box">
                <input type="text" name="mem_name" placeholder="Name" required value="${sessionScope.mem_name}" disabled>
                <input type="hidden" name="mem_name" placeholder="Name"  value="${sessionScope.mem_name}">
                <input type="hidden" name="mem_gender" value="${sessionScope.mem_gender}">
                <input type="hidden" name="mem_birth" value="${sessionScope.mem_birth}">
            </div> 
            <!--------------------------------------------------->            
     
            <!--------------------------------------------------->
            <div class="input-box">
                <input type="email" name="mem_email" placeholder="Email (Ex aaa@abcd.com)"  value="${sessionScope.mem_email}">
            </div>
            <!--------------------------------------------------->            


            <!--------------------------------------------------->
            <button type="button" class="btn" onClick="checkJoinUpdelForm();" aria-current="page">Change</button>
            
            <div class="register-link">
            </div>
        </form>
    </div>
    
    <!-- ============================================================ -->
<!-- WAS에 "/loginForm.do" URL주소로 접속하기 위한 form 태그 선언 -->
<!-- ============================================================ -->
<form name="loginForm" method="post" action="/loginForm.do"></form>

    
</body>
</html>
