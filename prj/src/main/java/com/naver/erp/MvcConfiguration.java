package com.naver.erp;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
//개발자가 만든 SessionInterceptor 클래스를
//인터셉터로 등록하기 위한 MvcConfiguration 클래스 선언하기
//즉, 설정을 위한 클래스이다.
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM

@Configuration
	//-------------------------------------
	//@Configuration ???
	//-------------------------------------
		//클래스 앞에 붙는다.
		//@Configuration이 붙은 클래스는 자동 객체화 되어 스프링이 관리한다.  
		//@Configuration이 붙은 클래스는 설정 관련 메소드를 소유하고있다.
		//@Configuration이 붙은 클래스는 WebMvcConfigurer 인터페이스를 구현한다.
public class MvcConfiguration implements WebMvcConfigurer {
	//===========================================================
	//SessionInterceptor 객체를 인터셉터로 등록하는 코딩이 내포된
	//addInterceptors 메소드를 오버라이딩 한다.
	//===========================================================
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		registry.addInterceptor(new SessionInterceptor()).excludePathPatterns(
				"/loginForm.do"
				,"/loginProc.do"
				,"/js/**" //로그인 화면에서도 쓸 수 잇어서 막지 않는다.
				
				,"/JoinForm.do"
				,"/joinProc.do"
				
				,"/css/**"
				//,"/img/**" //파일업 로드하고 쓸거면(보여지게 할거면) 지워도 된다.
		);
		//----------------------------------------------
		//InterceptorRegistry 객체의
		//addInterceptor 메소드를 호출하여 SessioonInterceptor 객체를 인터셉터로 등록하고
		//excludePathPatterns 메소드를 호출하여 예외되는 URL 주소 패턴을 등록한다.
		//----------------------------------------------
		
	}
}