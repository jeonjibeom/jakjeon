package com.naver.erp;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

//LoginController 클래스 선언하기
/*
 * 스프링에서 관용적으로 Controller 라는 단어가 들어간 클래스는
 * URL주소 접속 시 대응해서 호출되는 메소드를 소유하고있다.
 * 클래스 이름 앞에는 @Controller 라는 어노테이션이 붙는다.
 * 클래스 내부의 URL주소 접속 시 호출되는 메소드명 앞에는
 * @RequestMapping이라는 어노테이션이 붙는다.
 * 
 *       ==========================================
 *       @Controller 어노테이션이 붙은 클래스 특징
 *       ==========================================
 *       (1) 스프링프레임워크가 알아서 객체를 생성하고 관리한다.
 *       (2) URL주소 접속 시 대응해서 호출되는 메소드를 소유하고 있다.
 */
@Controller
public class LoginController {
   

   //@Autowired
   //접근 지정자 인터페이스명 멤버변수명;
   
   //위와 같은 멤버변수가 선언되면 아래와 같은 과정을 거친다.
      //LoginDAO 인터페이스 구현한 클래스를 찾아 객체화 해서
      //멤버변수 loginDAO 에 객체의 메위주를 저장
      //즉, 현재 loginDAOImp 객체의 메위주가 저장되었음
   @Autowired
   private LoginDAO loginDAO;

   //======================================================================
   //웹브라우저가 /loginProc.do라는 URL주소로 접근하면 호출되는 메소드 선언
   //======================================================================
      //URL주소에 대응하여 호출되려면 메소드앞에
      //@RequestMapping( value="포트번호이후주소")라는 
      //어노테이션이 붙어야한다.
   
    /*<주의>
    * @RequestMapping이 붙은 메소드의 이름은 개발자 마음대로다.
    * 될 수 있는대로 URL주소의 의도를 살리는 메소드 이름을 주는것이 좋다.
    */
   @RequestMapping( value="/loginForm.do")  //value 값이 1개라면 value=은 생략이 가능함.
   public ModelAndView loginForm(
		   HttpSession session
		
		   ) {
	   
	   
	   
	  
		session.setAttribute("selectPageNo", 1);
	   
	   
	   
      //ModelAndView객체 생성하기
      ModelAndView mav = new ModelAndView();
      ///ModelAndView객체의 setViewName 메소드 호출하여
      //호출할 JSP페이지명을 문자로 저장하기
      
         /*
          * 호출할 JSP페이지명 앞에 붙는 위치 경로는
          * application.properties에서
          * spring.mvc.view.prefix=/WEB-INF/views/에 설정한다.
          * 호출할 JSP 페이지명 뒤에 붙는 확장자는
          * application.properties에서
          * spring.mvc.view.suffix=jsp에 설정한다. 다만 생략함
          * <참고> 기본적으로 저장 경로에서 webapp폴더까지는 자동으로 찾아간다.
          */
      mav.setViewName("loginForm.jsp");  //->application.properties에 저장안하면 /WEB-INF/views/~ 해야댐.
      //ModelAndView객체 리턴하기
      //ModelAndView 객체를 리턴한 후 스프링은 ModelAndView 객체 저장된 JSP 페이지를 찾아 호출한다.
      
      
      return mav;
   }
   
   //웹브라우저가 /loginProc.do라는 URL주소로 접근하면 호출되는 메소드
   
   //메소드 앞에
   //@RequestMapping(~,~,produces="application/json:charset=UTF-8"하고
   //@ResponseBody 가 붙으면 리턴하는 데이터가 웹브라우저에게 전송된다.
            //html이 가는게 아님 ~!
   @RequestMapping(
         value="/loginProc.do"
         ,method=RequestMethod.POST
         ,produces="application/json;charset=UTF-8"
   )
   @ResponseBody
   public int loginProc(
         //-------------------------------------------------------------------------------------
         //"mid"라는 파라미터명에 해당하는 파라미터값을 꺼내서 매개변수 mid에 저장하고 들어온다.
         //즉, 웹브라우저에 유저가 입력한 id가 아래 매개변수로 저장되어 들어옴
         //즉, <input type="text" name="mid"> 태그 입력된 값이 들어온다.
         //두 name값이 일치해야함.
         //-------------------------------------------------------------------------------------
         @RequestParam(value="mem_id") String mem_id
         
         //-------------------------------------------------------------------------------------
         //"pwd"라는 파라미터명에 해당하는 파라미터값을 꺼내서 매개변수 pwd에 저장하고 들어온다.
         //즉, 웹브라우저에 유저가 입력한 pwd가 아래 매개변수로 저장되어 들어옴
         //즉, <input type="password" name="pwd"> 태그 입력된 값이 들어온다.
         //두 name값이 일치해야함.
         //-------------------------------------------------------------------------------------
         ,@RequestParam(value="mem_pwd") String mem_pwd
         //-------------------------------------------------------------------------------------
         //"autoLogin" 라는 파라미터명에 해당하는 파라미터값을
         //꺼내서 매개변수 autoLogin에 저장하고 들어온다
         //required는 필수요구는 아니다 라는 뜻
         //즉, 웹브라우저의 유저가 체크한 데이터가 아래 매개변수로 저장되어 들어온다.
         //즉, <input type="checkbox" name="autoLogin" value="yes"> 태그가 체크 될 때 "yes"값이 들어옴
         //-------------------------------------------------------------------------------------
         ,@RequestParam(value="autoLogin" , required=false) String autoLogin
         
         
         
            //=========================================================
            // 매개변수 왼쪽에 붙는 @RequestParam 어노테이션 형식
            //=========================================================
               //@RequestParam( value="xxx1", required=false 또는 true ) String xxx2
                  //"xxx"이라는 파라미터명에 대응하는 파라미터값을 매개변수 xxx2에 저장하고 들어와
            //=========================================================
            //required=false ?
            //=========================================================
               //=> 파라미터값이 없더라도 괜찮아 없으면 티폴트 값을 매개변수에 넣어줄게
            //=========================================================
            //required=true ?
            //=========================================================
               //=> 파라미터값이 없으면 안돼 없으면 에러발생
               
         
            // ***둘다없으면 required=true가 있다고 봐야함****
         
         
         //HttpSession 객체의 메위주를 저장하는 매개면수 session 선언하기
         //웹브라우저에 처음 접속했을 때 생성됨. -> 무언갈 맡기려고(사라지지않고 기다리니까 )
         ,HttpSession session
         
         //HttpServletResponse 객체가 들어올 매개변수 선언
         //URL 접속시 항상 새롭게 생성되고 응답메시지 전송 후에 제거된다.
         ,HttpServletResponse response
         ) {   
      
      
      
      
      
      
      //HashMap 객체 생성하고 객체의 메위주를 map에 저장하기
      //이 HashMap 객체에는 매개변수로 들어온 아이디와 암호를 저장할 예정이다.
      //HashMap 객체에 매개변수로 들어온 로그인 아이디 저장하기
      //HashMap 객체에 매개변수로 들어온 암호 저장하기
      
      Map<String,String> map = new HashMap<String,String>();
      //로그인 아이디와 암호의 DB존재 개수를 저장할 변수 loginIdCnt 선언하고
            //LoginDAOImp 객체의 getLoginIdCnt 메소드를 호출하여 얻은 데이터 저장하기
            //즉 로그인 아이디와 암호의 DB 존재개수를 구해서 변수 loginIdCnt에 저장한다.
      map.put("mem_id",mem_id);
      map.put("mem_pwd",mem_pwd);
      //로그인 아이디와 암호의 DB존재 개수를 저장할 변수 loginIdCnt 선언하고
      //LoginDAOImp 객체의 getLoginIdCnt 메소드를 호출하여 얻은 데이터 저장하기
      //즉 로그인 아이디와 암호의 DB 존재개수를 구해서 변수 loginIdCnt에 저장한다.
      
      
      int loginIdCnt = this.loginDAO.getLoginIdCnt(map);
      
      //만약 loginIdCnt 변수안의 데이터가 1이면, 즉 아이디와 암호가 DB에 있으면
      if(loginIdCnt==1) {
         //HttpSession 객체에 로그인 아이디 저장하기
         //HttpSession 객체에 로그인 아이디를 저장하면 재 접속했을 때 다시 꺼낼 수 있다.
         
         //<참고>HttpSession객체는 접속 한 이후에는 제거되지 않고 지정된 기간동안 살아있는 객체이다.
         //<참고>HttpServletRequest,HttpServletResponse 객체는 접속때 생성되고 응답이후 삭제되는 객체이다.
         
         //HttpSession 객체에 키값 mid 에 붙어 저장된 데이터 지우기
         //즉, 예전에 로그인 성공했을 때 HttpSession 객체에 저장한 로그인 아이디를 삭제한다.
         //즉, 로그 아웃을 시킨것이다.

         
         session.setAttribute("mem_id",mem_id);
         
         session.setAttribute("mem_nick",this.loginDAO.getNick(map));
         

         session.setAttribute("mem_name",this.loginDAO.getName(map));
         session.setAttribute("mem_gender",this.loginDAO.getGender(map));
         session.setAttribute("mem_birth",this.loginDAO.getBirth(map));
         session.setAttribute("mem_email",this.loginDAO.getEmail(map));
         

         
               //=============================
               //sqlSession 객체에 아이디를 저장하는 이유
               //=============================
               //나중에 재접할때 꺼내서 id가 있으면 예전에 로그인 성공했다는걸 입증하려고 ㄱ-
               //이 객체는 항상 살아있는건 아니고 일정 기간만 살아있음 (=쿠키값삭제되면 없어짐)
         
         //매개변수 autoLogin에 null이 저장되어있으면(=아이디,암호 작동 입력의사 없을 경우)
         if(autoLogin==null ||  autoLogin == "") {
            //********************************************************
            /*
            웹브라우저로 보낼 쿠키명-쿠키값을 만든다.
            웹브라우저에 저장할 쿠키명-쿠키값은
            "mid"-null   "pwd"-null 이다.
            즉 웹브라우저 쪽에 이미 있는
            쿠키명 "mid"에 대응하는 데이터를  null로 바꾸어 무력화할 목적이다.
            쿠키명 "pwd"에 대응하는 데이터를  null로 바꾸어 무력화할 목적이다.
            이것들이 무력화 됨으로서 다음에 WAS에 접속할 때는 아이디와 암호가 저장된
            쿠키는 들어올 수 없다.
            */
            //*********************************************************
            
            //Cookie 객체를 생성하고 쿠키명-쿠키값을 "mid"-null로 하기
            //was는 웹브라우저의 쿠키를 삭제할 수 없어서 같은 쿠키명,의미없는 데이터로 덮어씌우는것임
            //쿠키객체에 저장된 쿠키의 수명은 0으로 하기
            Cookie cookie1 = new Cookie("mem_id",null);
            cookie1.setMaxAge(0);
            
            //Cookie 객체를 생성하고 쿠키명-쿠키값을 "pwd"-null로 하기
            //쿠키객체에 저장된 쿠키의 수명은 0으로 하기
            Cookie cookie2 = new Cookie("mem_pwd",null);
            cookie2.setMaxAge(0);
            
            Cookie cookie3 = new Cookie("mem_nick",null);
            cookie3.setMaxAge(0);
            
            //쿠키 객체가 소유한 쿠키를 응답메시지에 저장하기
            response.addCookie(cookie1);
            response.addCookie(cookie2);
            response.addCookie(cookie3);
            
            
         }
         //매개변수 autoLogin에 "yes"이 저장되어있으면(=아이디,암호 자동 입력의사 있을 경우)
         else {
            //********************************************************
            /*
            웹브라우저가 파라미터값으로 보낸 아이디,암호를 
            다시 응답메시지에 쿠키명-쿠키값으로 저장하여
            웹브라우저쪽으로 다시 보내 저장하게 하기
            */
            //*********************************************************
            
            //클라이언트가 보낸 아이디,암호를 응답메시지에 쿠키명-쿠키값으로 저장하기
            //Cookie 객체를 생성하고 쿠키명-쿠키값을 "mid"-"입력아이디"로 하기
            //Cookie 객체에 저장된 쿠키의 수명은 60*60*24으로 하기
            Cookie cookie1 = new Cookie("mem_id",mem_id);
            cookie1.setMaxAge(60*60*24);
            
            //Cookie 객체를 생성하고 쿠키명-쿠키값을 "pwd"-"입력암호"로 하기
            //Cookie 객체에 저장된 쿠키의 수명은 60*60*24로 하기
            Cookie cookie2 = new Cookie("mem_pwd",mem_pwd);
            cookie2.setMaxAge(60*60*24);
            
            
            //Cookie 객체가 소유한 쿠키를 응답메시지에 저장하기
            //응답메시지에 저장되는 쿠키는 결국 웹브라우저 즉 클라이언트쪽에 저장된다.
            response.addCookie(cookie1);
            response.addCookie(cookie2);
         }
         
      }
      //로그인 아이디와 암호의 DB존재 개수를 리턴하기.
      return loginIdCnt;
   }
   
   
   
}



// http://localhost:8081/loginForm.do