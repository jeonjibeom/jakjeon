<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
pre{
  white-space: pre-wrap;
  word-break: break-all;
  overflow: auto
}  
</style>

<div class="list-group">

	<c:forEach var="reply" items="${requestScope.replyList}">
		<!-- 댓글 반복문 -->
		<div class="list-group-item list-group-item-action">
			<div class="d-flex w-100 justify-content-between">
				<h5 class="mb-1">${reply.u_name}</h5>
				<small class="text-muted">${reply.reg_date}</small>
			</div>
			<pre class="mb-1">${reply.content}</pre>
			<!-- 댓글 작성자인 경우. -->
			<c:if test="${reply.u_id == sessionScope.mem_id}"> 
				<div class="d-flex justify-content-end">
					<a class="badge rounded-pill bg-primary"
						href="javascript:showReplyUpdate(${reply.r_no})">수정</a> &nbsp; <a
						class="badge rounded-pill  bg-danger" 
						href="javascript:replyDelete(${reply.r_no});">삭제</a>
				</div>
			</c:if>
			<br />
			<div class="w-100" id="replyUpDelArea_${reply.r_no}"
				style="display: none;">
				<form name="replyUpDelForm_${reply.r_no}">
					<input type="hidden" name="r_no" value="${reply.r_no}"> <input
						type="hidden" name="b_no" value="${reply.b_no}"> <input
						type="hidden" name="u_id" value="${reply.u_id} }">
					<!-- 세션에서 사용자 아이디 -->
					<input type="hidden" name="u_name" value="${reply.u_name }">
					<div class="input-group mb-3">
						<textarea class="form-control" name="content"
							placeholder="댓글을 입력하세요.">${reply.content}</textarea>
						<button class="btn btn-outline-primary" type="button"
							onclick="replyUpdate(${reply.r_no});">수정</button>

						<button class="btn btn-outline-danger" type="button"
							onclick="hideReplyUpdate(${reply.r_no});">취소</button>
					</div>
				</form>
			</div>

		</div>

	</c:forEach>


</div>
