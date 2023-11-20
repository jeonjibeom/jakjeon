package com.naver.erp;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class JoinController {

   @Autowired
   private JoinDAO joinDAO;

   /*
    * @RequestMapping(value="/JoinForm.do", method=RequestMethod.GET) public void
    * signupGET() { }
    */

   // SignUp POST
//      @RequestMapping(value="/JoinForm.do", method=RequestMethod.POST)
//      public String signupPOST(JoinDTO joinDTO)
//      {
//         joinService.insertJoin(joinDTO);
//      
//         return "inserJoin";
//      }

   @RequestMapping(value = "/JoinForm.do")
   public ModelAndView JoinForm(JoinDTO joinDTO

   ) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("JoinForm.jsp");

      return mav;
   }

   // joinProc.do
   @RequestMapping(value = "/joinProc.do")
   public ModelAndView aaa(JoinDTO joinDTO) {

      System.out.println(joinDTO.getMem_nick());

      joinDAO.insertJoin(joinDTO);

      ModelAndView mav = new ModelAndView();
      mav.setViewName("loginForm.jsp");
      return mav;

   }
   
   
   
   //회원 개인정보 수정
   @RequestMapping(value = "/JoinUpdelForm.do")
   public ModelAndView JoinUpdelForm(JoinDTO joinDTO
		   ,HttpSession session
		

   ) {
	   
	 
		session.setAttribute("selectPageNo", 1);
	   
      ModelAndView mav = new ModelAndView();
      mav.setViewName("JoinUpdelForm.jsp");

      return mav;
   }

   // joinProc.do
   @RequestMapping(value = "/JoinUpdelProc.do")
   public ModelAndView bbb(JoinDTO joinDTO) {

      joinDAO.updateJoin(joinDTO);

      ModelAndView mav = new ModelAndView();
      mav.setViewName("loginForm.jsp");
      return mav;

   }
      
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   //닉넴 체크
   @RequestMapping(value = "/checkNickDuplication.do", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
   @ResponseBody
   public Map<String, Object> checkNickDuplication(@RequestParam(value = "mem_nick") String mem_nick) {
      Map<String, Object> responseMap = new HashMap<String, Object>();
      
      
      int cnt = joinDAO.checkNickDuplication(mem_nick);
      responseMap.put("isDuplication", cnt > 0);
      

      return responseMap;
   }
   //아이디 체크
   @RequestMapping(value = "/checkIdDuplication.do", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
   @ResponseBody
   public Map<String, Object> checkIdDuplication(@RequestParam(value = "mem_id") String mem_id) {
      Map<String, Object> responseMap = new HashMap<String, Object>();
      
      
      int cnt = joinDAO.checkIdDuplication(mem_id);
      responseMap.put("isDuplication", cnt > 0);
      

      return responseMap;
   }
}