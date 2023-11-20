package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReplyDAO {

	// 댓글 목록
	List<ReplyDTO> getReply(int b_no);

	// 댓글 입력
	int	insertReply(ReplyDTO reply);
	
	// 댓글 수정
	int	updateReply(ReplyDTO reply);

	// 댓글 삭제
	int	deleteReply(ReplyDTO reply);
	
	// 게시판 아이디에 종속된 모든 댓글을 삭제
	int deleteReplyAllByBno(int b_no);
}
