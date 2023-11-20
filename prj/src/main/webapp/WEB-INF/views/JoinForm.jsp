<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고,이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다 라고 설정함 -->
<!-- 현재 이 JSP 페이지를 저장할때는 UTF-8 방식으로 인코딩 한다 -->
<!-- 모든 JSP 페이지 상단에 무조건 아래 설정이 들어간다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<!-- JSP 기술의 한 종류인 [Include Directive]를 이용하여 -->
<!-- common.jsp 파일 내의 소스를 삽입하기 -->
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<%@include file="/WEB-INF/views/JoinHelper.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>회원가입</title>

<script>
   $(function() {
      init();
   });
   function init() {

      //"mem_nick"
      var formObj = $("[name='joinForm']");

      // 닉네임 변경시 중복체크 초기화
      var $nick = formObj.find("[name='mem_nick']");
      $nick.change(function() {
         $nick.attr('data-duplication', false);
      });

      // 아이디 변경시 중복체크 초기화
      var $id = formObj.find("[name='mem_id']");
      $id.change(function() {
         $id.attr('data-duplication', false);
      });

   }

   //----------------------------------------
   // 목록보기 버튼을 클릭하면 호출되는 함수
   //----------------------------------------
   function goLoginForm() {
      // name=LoginForm  을 가지 form 태그의 
      // action 값의 URL 주소로 WAS에 접속하기
      document.loginForm.submit();
   }

   function checkJoinForm() {

   
      //닉네임 중복체크 요청
      var isNickDuplication = $("[name='mem_nick']").data('duplication');
      if (isNickDuplication !== true) {
         alert("닉네임 중복체크가 필요합니다.");
         return;
      }

      
      
      //아이디 중복체크 요청
      var isIdDuplication = $("[name='mem_id']").data('duplication');
      if (isIdDuplication !== true) {
         alert("아이디 중복체크가 필요합니다.");
         return;
      }

      
      
      
      /* 비밀번호 유효성 검사 */
      if (joinForm.mem_pwd.value.length == 0) {
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
         joinForm.mem_pwd.focus();
         return;
      }
      // 비밀번호 입력가능 길이
      if (joinForm.mem_pwd.value.length<3 || joinForm.mem_pwd.value.length>8) {
         alert("비밀번호는 3자 ~ 8자 여야합니다.");
         return;
      }
      var mem_pwd_re = $("[name='mem_pwd_re']").val();

      if (mem_pwd !== mem_pwd_re) {
         alert("비밀번호와 비밀번호 확인이 동일하지 않습니다.");
         return;
      }

      /* 이름 유효성 검사 */
      if (joinForm.mem_name.value.length == 0) {
         alert("이름이 누락됐습니다.");
         joinForm.mem_name.focus();
         return;
      }

      // 입력한 이름 읽어와서 변수 mem_name 에 저장하기
      // 만약에 변수 mem_name 에 문자가 아닌 데이터가 있다면 "" 로 갱신하기
      // 변수 mem_name 안의 앞뒤 공백 제거하기
      var mem_name = $("[name='mem_name']").val();
      if (typeof (mem_name) != "string") {
         mem_name = "";
      }
      mem_name = $.trim(mem_name);

      // 만약에 이름가 비어있으면 경고하고 함수 중단
      if (mem_name == "") {
         alert("이름이 공백으로 비어 있습니다.");
         joinForm.mem_name.focus();
         return;
      }

      // 이름 입력가능 길이
      if (joinForm.mem_name.value.length<2 || joinForm.mem_name.value.length>10) {
         alert("이름은 2자 ~ 10자 여야합니다.");
         return;
      }
      
      if (!checkName($("[name='mem_name']"))) {
         return;
      }
      

      /* 성별체크 유효성 검사 */
      if ($("input[name=mem_gender]:radio:checked").length < 1) {
         alert("성별체크가 누락됐습니다.");
         return;
      }

      /* 생년월일 유효성 검사 */
      if (joinForm.mem_birth.value.length == 0) {
         alert("생년월일이 누락됐습니다.");
         joinForm.mem_birth.focus();
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
      if (joinForm.mem_birth.value.length != 8) {
         alert("생년월일 8자리를 입력해주세요.");
         return;
      }

      // 만약에 생년월일 비어있으면 경고하고 함수 중단
      if (mem_birth == "") {
         alert("생년월일이 공백으로 비어 있습니다.");
         joinForm.mem_birth.focus();
         return;
      }
      if (!checkBirth($("[name='mem_birth']").val())) {
          alert("생년월일이 올바르지 않습니다."); 
          return;
       }
      /* 이메일 유효성 검사 */
      if (joinForm.mem_email.value.length == 0) {
         alert("이메일이 누락됐습니다.");
         joinForm.mem_email.focus();
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
         joinForm.mem_email.focus();
         return;
      }

      if (!checkEmail($("[name='mem_email']"))) {
         return;
      }
      
      //회원가입 최종 확인창
      if (confirm("회원가입 하시겠습니까?") == false) {
         return;
      }
      alert("회원가입 성공!")
      
      
      document.joinForm.submit();
   }
   
   
   
   
   
   //===================================
   //닉네임 유효성 체크와 중복 체크 부분
   //===================================
   function checkNickDuplication() {
      var $nick = $('[name="mem_nick"]');

      var nick = $nick.val();

      
      /* 닉네임 유효성 검사 */
      if (joinForm.mem_nick.value.length == 0) {
         alert("닉네임이 누락됐습니다.");
         joinForm.mem_nick.focus(); // 포커스를 이동시켜 바로 입력할 수 있게
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
      if (joinForm.mem_nick.value.length<2 || joinForm.mem_nick.value.length>8) {
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
   
   //===================================
   //아이디 유효성 체크와 중복 체크 부분
   //===================================
   function checkIdDuplication() {
      var $id = $('[name="mem_id"]');
      
      
      /* 아이디 유효성 체크 검사 */
      if (joinForm.mem_id.value.length == 0) {
         alert("아이디가 누락됐습니다.");
         joinForm.mem_id.focus();
         return;
      }

      // 입력한 아이디 읽어와서 변수 mem_id 에 저장하기
      // 만약에 변수 mem_id 에 문자가 아닌 데이터가 있다면 "" 로 갱신하기
      // 변수 mem_id 안의 앞뒤 공백 제거하기
      var mem_id = $("[name='mem_id']").val();
      if (typeof (mem_id) != "string") {
         mem_id = "";
      }
      mem_id = $.trim(mem_id);

      // 만약에 아이디 비어있으면 경고하고 함수 중단
      if (mem_id == "") {
         alert("아이디가 공백으로 비어 있습니다.");
         joinForm.mem_id.focus();
         return;
      }
      
      /* 아이디 입력가능 길이
      if (joinForm.mem_id.value.length<6 || joinForm.mem_id.value.length>12) {
         alert("아이디는 6자 ~ 12자 여야합니다.");
         return;
      }
      */
      
      //아이디 유효성체크
      if (!checkID($("[name='mem_id']"))) {
         return;
      }

      // 호출
      $.ajax({
         url : '/checkIdDuplication.do?mem_id=' + $id.val(),
         type : 'get',
         success : function(responseData) {
            if (responseData.isDuplication) {
               $id.data('duplication', false);
               alert('사용중인 아이디입니다.');
            } else {
               $id.data('duplication', true);
               alert('사용 가능한 아이디입니다.');
            }
         },
         error : function() {
            $id.data('duplication', false);
            alert("웹서버 접속 실패! 관리자에게 문의 바랍니다.");
         }
      });
   }
</script>


</head>
<body>
   <div class="wrapper">
        <form name="joinForm" action="/joinProc.do" method="post">
            <h1>Register</h1>
            <div class="input-box">
                <input type="text" placeholder="NickName" name="mem_nick" required>
                <i class='bx bxs-user' style="cursor: pointer;" name="nick_check"
					onclick="checkNickDuplication();"></i>
            </div>             
            <!--------------------------------------------------->
            <div class="input-box">
                <input type="text" name="mem_id" placeholder="ID" required>
                <i class='bx bxs-user' style="cursor: pointer;"  name="id_check"
					onclick="checkIdDuplication();"></i>
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
                <input type="text" name="mem_name" placeholder="Name" required>
            </div> 
            <!--------------------------------------------------->            
            <div class="mb-3">
                <!--<label for="userSex" class="form-label">성별</label>-->
                <div class="form_toggle row-vh d-flex flex-row justify-content-between" >
                   <div class="form_radio_btn radio_male">
                      <input id="radio-1" type="radio" name="mem_gender" value="남" checked>
                      <label for="radio-1">　Male　</label>
                      <input id="radio-2" type="radio" name="mem_gender" value="여">
                      <label for="radio-2">Female</label>
                   </div>
                </div>
             </div>
            <!---------------------------------------------------> 
            <!-- 11.03 생년월일 변경  -->
            <div class="input-box">
                <label for="mem_birth"></label>
               <input type="text" class="form-control" id="checkBirth" name="mem_birth" placeholder="생년월일 ex) 19990415" required>
               <div class="check_font" id="checkBirth"></div>
            </div>
            <!--------------------------------------------------->
            <div class="input-box">
                <input type="email" name="mem_email" placeholder="Email (Ex aaa@abcd.com)" required>
            </div>
            <!--------------------------------------------------->            


            <!--------------------------------------------------->
            <button type="button" class="btn" onClick="checkJoinForm();">Register</button>
            <div class="register-link">
                <p>You have an account? <a href="loginForm.do" onClick="goLoginForm();">Login</a></p>
            </div>
        </form>
    </div>
</body>
</html>
