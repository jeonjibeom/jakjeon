

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<!-- JSP 기술의 한 종류인 Include Directive를 이용하여 -->
<!-- common.jsp 파일 내의 소스를 삽입하기 -->
<!-- 1개 이상 여러개 쓸 수 있음 -->
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<%@include file="/WEB-INF/views/loginHelper.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>작전 로그인 화면</title>




<script>
	//body태그 안의 모든 내용을 읽어들인 이후 init 함수 호출하기
	$(function(){ init(); })
	//body태그 안의 모든 내용을 읽어들인 이후 호출할 자스 코딩 설정하기
	function init(){
			//class=loginBtn 가진 태그에 클릭 이벤트가
			//발생하면 checkLoginForm() 함수 호출하기
		$(".loginBtn").bind("click",function(){
			checkLoginForm();
		});

		//--------------------------------------------------------------------------
		//접속한 클라이언트가 가져온 쿠키중에 쿠키명 "mid"에 대응하는 쿠키값을 
		//			EL문법으로 꺼내서
		//			아이디 입력란에 삽입하기
		//접속한 클라이언트가 가져온 쿠키중에 쿠키명 "pwd"에 대응하는 쿠키값을 
		////		EL문법으로 꺼내서
		//			암호 입력란에 삽입하기
		//--------------------------------------------------------------------------
			$("[name='mem_id']").val("${cookie.mem_id.value}");
			$("[name='mem_pwd']").val("${cookie.mem_pwd.value}");
		
			
			//접속한 클라이언트가 가져온 쿠키중에 쿠키명 "mid"에 대응하는
			//		쿠키값이 있으면
			//			name='autoLogin' 가진 checkbox 체크하기
			//		쿠키값이 없으면
			//			name='autoLogin' 가진 checkbox 체크풀기
			$("[name='autoLogin']").prop("checked",${empty cookie.mem_id.value?false:true} );
			
	}
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// 입력한 아이디와 암호의 유효성 체크하는 함수 선언하기
	// 로그인 버튼을 클릭하면 호출되는 함수이다.
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	function checkLoginForm(){	
		//-----------------------------------------------------
		// 입력한 아이디 읽어와서 변수 mid 에 저장하기
		// 만약에 변수 mid 에 문자가 아닌 데이터가 있다면 "" 로 갱신하기
		// 변수 mid 안의 앞뒤 공백제거 하기
		//-----------------------------------------------------
		var mem_id = $("[name='mem_id']").val();
		if( typeof(mem_id)!="string" ) { mem_id=""; }
		mem_id = $.trim(mem_id);				// mid = mid.trim(); 은 String 객체 메소드라 여기선 제이쿼리 메소드 사용하는게나음.
		//-----------------------------------------------------
		// 입력한 암호 읽어와서 변수 pwd 에 저장하기
		// 만약에 변수 pwd 에 문자가 아닌 데이터가 있다면 "" 로 갱신하기
		// 변수 pwd 안의 앞뒤 공백제거 하기
		//-----------------------------------------------------
		var mem_pwd = $("[name='mem_pwd']").val();
		if( typeof(mem_pwd)!="string" ) { mem_pwd=""; }
		mem_pwd = $.trim(mem_pwd);
		//-----------------------------------------------------
		// 만약에 아이디가 비어 있으면 경고하고 함수 중단하기
		//-----------------------------------------------------
		if( mem_id=="" ){
			alert("아이디가 비어 있음! 입력 바람"); // 회원가입이 아니고 로그인할때 아이디의 유효성은 불친절해야 한다.
			return;
		}
		//-----------------------------------------------------
		// 만약에 암호가 비어 있으면 경고하고 함수 중단하기
		//-----------------------------------------------------
		if( mem_pwd=="" ){
			alert("암호가 비어 있음! 입력 바람");	// 회원가입이 아니고 로그인할때 암호의 유효성은 불친절해야 한다.
			return;
		}
	
		//*******************************************************
		// 개발자 정의 함수인 ajax 함수 호출하여 
		// 			WAS 에   /loginProc.do  로 접속하여
		// 			아이디, 암호의 존재 개수를 얻는다.
		// 			존재 개수가 1이면 
		// 				WAS 에   /boardList.do  로 접속하여 게시판 검색 화면 HTML 을 연다.
		// 			존재 개수가 0이면 
		// 				경고 창이 뜬다.
		//*******************************************************
		ajax(
				//------------------------------------------
				// WAS 에 접속할 떄 사용할 URL 주소 지정
				//------------------------------------------
				"/loginProc.do"
				//------------------------------------------
				// WAS 에 전송할 파라미터값 을 보내는 방법 지정
				//------------------------------------------
				,"post"
				//------------------------------------------
				// form 태그 관리하는  JQuery 객체 메위주 넘겨주는 이유는
				// 아래 form 태그 안에 모든 입력양식 name 값과 value값 이 들어있기 때문
				//------------------------------------------
				,$("[name='loginForm']")
				//----------------------------------------------------------
				// WAS 와 통신한 후 WAS의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
				// 익명함수의 매개변수에는 WAS 가 보내온 [아이디 암호의 존재 개수]가 들어온다
				// 아래 매개변수 idCnt 는 LoginController 에서 들어옴
				//----------------------------------------------------------
				,function(idCnt){
					//----------------------------------------------------------
					// 만약에 매개변수 idCnt 에 1이 있으면
					// 즉 아이디와 암호가 DB 에 존재하면
					// 로그인 성공했으면
					//----------------------------------------------------------
					if( idCnt==1 ){
						//-----------------------------------------------------
						// WAS 에  "/boardList.do" URL 주소로 접속 시도하기
						// <참고> 또 다른 WAS 접속 방법은 document.form태그name값.submit(); 이방법은 (접속방식 설정가능 method= get,post 디폴트값 get), 입력양식 데이터 전부 갖고감.
						//-----------------------------------------------------
						location.replace("/mainWeb.do");
								// ---------------------------------------------------------------------
								// location.replace("/boardList.do"); 명령어로 WAS 로 접속할 때 특징
								// ---------------------------------------------------------------------
									//  무조건 get 방식으로 접속함.
									//  파라미터값은 전혀 없음	/ form태그의 데이터를 갖고 갈수없음 / 파라미터값이 필요없을때
									//  만약 보안성이 필요없는 파라미터값을 보내고 싶다면
										//  location.replace("/boardList.do?xxx=yyy"); 꼐 해야함
										//<참고> 보안성이 필요없어도 양이 너무 많을시 form 태그를 쓸 수 밖에없다.
					}
					//----------------------------------------------------------
					// 만약에 매개변수 idCnt 에 1이 아니면
					// 즉 아이디와 암호가 DB 에 존재하지 않으면
					// 즉 로그인이 실패 했으면
					// 즉 입력한 아이디와 암호가 DB 에 없으면
					//----------------------------------------------------------
					else{
						alert("로그인 실패! 아이디 또는 암호가 틀립니다. 재입력해 주십시요!");
					}
				}
		);
	}			
		
		
		
		
</script>


</head>
<body>
	    <div class="wrapper">
        <form action="" name="loginForm">
            <h1>Login</h1>
            <div class="input-box">
                <input type="text" name="mem_id" placeholder="ID" required>
                <i class='bx bxs-user'></i>
            </div> 

            <div class="input-box">
                <input type="password" name="mem_pwd" placeholder="Password" required>
                <i class='bx bxs-lock-alt' ></i>
            </div>
            <div class="remember-forgot">
                <label><input type="checkbox" name="autoLogin" value="yes" class="autoLogin"> Remember me</label></label>
               <!--  <a href="#">Forgot password?</a> -->
            </div>
            <button type="button" class="loginBtn">Login</button>
            <div class="register-link">
                <p>Don't have an account? <a href="#" style="cursor:pointer" onclick="location.replace('/JoinForm.do');">Register</a></p>
            </div>
        </form>
    </div>
</body>
</html>



