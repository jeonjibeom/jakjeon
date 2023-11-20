package com.naver.erp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ReplyController {

	@Autowired
	private ReplyDAO replyDAO;

	// 댓글 입력
	@RequestMapping(value = "/replyInsert.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> replyInsert(ReplyDTO reply) {

		Map<String, Object> res = new HashMap<String, Object>();

		int cnt = 0;

		try {
			cnt = replyDAO.insertReply(reply);
		} catch (Exception ex) {
			res.put("ErrorMsg", ex.toString());
			cnt = -1;

		}

		res.put("regCnt", cnt);

		return res;
	}

	// 댓글 목록
	@RequestMapping(value = "/replyList.do", method = RequestMethod.POST)
	public ModelAndView replyList(@RequestParam(value = "b_no") int b_no) {

		ModelAndView mav = new ModelAndView();

		List<ReplyDTO> replyList = replyDAO.getReply(b_no);

		mav.setViewName("replyList.jsp");
		mav.addObject("replyList", replyList);
		return mav;
	}

	// 댓글 수정
	@RequestMapping(value = "/replyUpdate.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> replyUpdate(ReplyDTO reply) {

		Map<String, Object> res = new HashMap<String, Object>();

		int cnt = 0;

		try {
			cnt = replyDAO.updateReply(reply);
		} catch (Exception ex) {
			res.put("ErrorMsg", ex.toString());
			cnt = -1;

		}

		res.put("regCnt", cnt);

		return res;
	} 
	
	// 댓글 삭제

	@RequestMapping(value = "/replyDelete.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> replyDelete(ReplyDTO reply) {

		Map<String, Object> res = new HashMap<String, Object>();

		int cnt = 0;

		try {
			cnt = replyDAO.deleteReply(reply);
		} catch (Exception ex) {
			res.put("ErrorMsg", ex.toString());
			cnt = -1;

		}

		res.put("regCnt", cnt);

		return res;
	} 
}
