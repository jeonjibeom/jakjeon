
<!-- ============================================================================== -->
<!-- JSP기술의 한 종류인 Page Directive를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- ============================================================================== -->
<!-- 현재 이 JSP페이지 실행 후 생성되는 문서는 HTML이고 이 문서 안의 데이터는 UTF-8방식으로 인코딩한다 라고 설정함. -->
<!-- 현재 이 JSP페이지를 저장할때는 UTF-8방식으로 인코딩한다 -->
<!-- 모든 JSP 페이지 상단에 무조건 아래 설정이 들어간다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<!-- ============================================================================== -->
<!-- 아래 코딩 이후에 나오는 
	 c코어 태그는 수입된 라이브러리 JSTL 에서 정한 규칙에 의해 해석하라
	 이게 없으면 c코어 태그는 분석이 안됨										    -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<link href="/css/search.css?<%=Math.random()%>" rel="stylesheet">
<link href="/css/graph.css?<%=Math.random()%>" rel="stylesheet">
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">

<!-- ====================================== -->
<!-- style.css 파일 내용 수입하기 -->
<!-- JQuery 라이브러리 수입하기 -->
<!-- common.js 파일안의 자스 코딩 수입하기 -->
<!-- ====================================== -->
<script src="/js/jquery-1.11.0.min.js"></script>
<script src="/js/common.js?<%=Math.random()%>"></script>
   
<!-- 아이콘을 가져오기 위한 js 수입  사이트 -> ionicons -->
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>




 
