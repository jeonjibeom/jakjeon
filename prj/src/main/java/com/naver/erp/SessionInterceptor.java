package com.naver.erp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	/*URL접속시 [@Controller 가 붙은 클래스]의 
	@RequestMapping 가 붙은 메소드 호출 전 또는 후에
	실행될 메소드를 소유한 [SessionInterceptor 클래스 ] 선언.*/
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

//--------------------------------------------------
/**URL접속시 [@Controller 가 붙은 클래스]의 
@RequestMapping 가 붙은 메소드 호출 전 또는 후에
실행될 메소드를 클래스가 될 자격 조건. */
//--------------------------------------------------
		//<1> 스프링이 제공하는 HandlerInterceptor 인터페이스를 구현
		//<2> @RequestMapping이 붙은 메소드 호출 전에 실행할 코딩은
					//HandlerInterceptor 인터페이스의 
					//[preHandle 메소드]를 재정의(오버라이딩) 하면서 삽입한다.
		//<3> @RequestMapping이 붙은 메소드 호출 후에 실행할 코딩은
					//HandlerInterceptor 인터페이스의 
					//[postHandle 메소드]를 재정의(오버라이딩) 하면서 삽입한다.

public class SessionInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(
			HttpServletRequest request
			,HttpServletResponse response
			,Object handler
			
	) throws Exception{
		//-------------------------------------------------------
		//HttpSession 객체 메위주 얻기 .  이 객체가 로그인 정보를 가지고 있다.
		// HttpServletRequest객체의 getSession()메소드를 호출하면
		// HttpSession객체의 메위주를 얻을 수 있다.
		//-------------------------------------------------------
		HttpSession session = request.getSession();
		
		//-------------------------------------------------------
		//HttpSession객체에서 "mid" 라는 키값으로 저장된 데이터 꺼내기.
		// 즉 로그인 정보 꺼내기
		//-------------------------------------------------------
		String mem_id = (String)session.getAttribute("mem_id");
		//System.out.println(mem_id);
		//-------------------------------------------------------
		//만약 mid변수 안에 null이 저장되어 있으면
		//즉 만약 로그인에 성공한 적이 없으면
		//-------------------------------------------------------
		if(mem_id==null) {
			//-------------------------------------------------------
			//웹 브라우저가 /loginForm.do로 재 접속하라고 설정하기
			// 응답 메세지를 받은 웹브라우저는 이 URL주소로 강제 재접속을 한다.
			//-------------------------------------------------------
			response.sendRedirect("/loginForm.do");
			
			
			//-------------------------------------------------------
			//false값 리턴하기
			//false값을 리턴하면 @ReqeustMapping이 붙은 메소드가 호출 될 수 없다.
			//-------------------------------------------------------
			return false;
		}
		//-------------------------------------------------------
		//만약 mid변수 안에 null이 저장되어 있으면
		//즉 만약 로그인에 성공한 적이 없으면
		//-------------------------------------------------------
		else {
			//-------------------------------------------------------
			//true값 리턴하기
			//true값을 리턴하면 @ReqeustMapping이 붙은 메소드가 호출된다.
			//-------------------------------------------------------
			return true;
		}
		
		
		
	}
	
}
