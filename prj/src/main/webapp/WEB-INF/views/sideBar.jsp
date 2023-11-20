<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작전</title>
</head>
<body>
<div class="sidebar">
      <div class="logo-details">
         <i class='bx bx-home-alt-2' style="cursor: pointer;" onclick="location.replace('/mainWeb.do');"></i> <span class="logo_name"
            style="cursor: pointer;" onclick="location.replace('/mainWeb.do');"> 작전</span>
      </div>
      <ul class="nav-links">
         
         <li>
            <div class="iocn-link">
               <a href="#"> <i class='bx bx-news'></i> <span class="link_name">투자정보</span>
               </a> <i class='bx bxs-chevron-down arrow'></i>
            </div>
            <ul class="sub-menu">
               <li><a class="link_name" href="#">투자정보</a></li>
               <li><a href="#" onclick="location.replace('/graph.do');"> 종목</a></li>
               <li><a href="#" onclick="location.replace('/newsListBoard.do');"> 뉴스</a></li>
               <li><a href="#" onclick="location.replace('/stockDictionary.do');"> 용어/추천영상</a></li>
            </ul>
         </li>
         <li><a href="/boardList.do"> <i class='bx bx-comment-dots'></i> <span
               class="link_name"> 전체게시판 </span>
         </a>
            <ul class="sub-menu blank">
               <li><a href="#" onclick="location.replace('/boardList.do');">전체게시판</a></li>
            </ul>
         </li>
         
         
         <li><a href="/JoinUpdelForm.do"> <i class='bx bx-cog'></i> <span
               class="link_name">마이 페이지</span>
         </a>
            <ul class="sub-menu blank">
               <li><a class="link_name" href="#">마이 페이지</a></li>
            </ul></li>
         <li><a href="#"> <i class='bx bx-log-out'></i> <span
               class="link_name" onclick="location.replace('/loginForm.do');">로그아웃</span>
         </a>
            <ul class="sub-menu blank">
               <li><a class="link_name" href="#" >로그아웃</a></li>
            </ul></li>
         <li>
            <div class="profile-details">
               <div class="profile-content">
                  <img src="img/profile.jpg" style="cursor:pointer;" onclick="location.replace('/JoinUpdelForm.do');"  alt="profile">
               </div>

               <div class="name-job">
                  <div class="profile_name">${mem_nick}님</div>
                  <div class="job">환영합니다.</div>
               </div>
               <i class='bx bx-log-out' onclick="location.replace('/loginForm.do');"></i>
            </div>
         </li>
      </ul>
   </div>

</body>
</html>