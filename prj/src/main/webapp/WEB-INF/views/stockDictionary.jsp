<!-- mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm  -->
<!-- JSP기술의 한 종류인 [Page Directive]를 이용하여 현 JSP페이지 처리 방식 선언 -->
<!-- mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm  -->
   <!-- 현재 JSP페이지 실행 후 실행되는 문서는 HTML이고 이 문서안의 데이터는 UTF-8방식으로 인코딩한다 라고 설정함 -->
   <!-- 현재 이 JSP페이지를 저장할때는 UTF-8 방식으로 인코딩한다. -->
   <!-- 모든 JSP페이지 상단에 무조건 아래 설정이 들어간다.  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주식용어</title>
<script src="/js/jquery-1.11.0.min.js"></script>
<script src="/js/common.js"></script>
<%@include file="/WEB-INF/views/stockDictionaryHelper.jsp" %>
<%@include file="/WEB-INF/views/sideBar.jsp" %>
 <!-- 상단 메뉴바 -->
<style>
   .a:link{
      font-weight: bold;
      color: black;
      text-decoration: none;
   }
   .a:visited{
      color: gray;
      text-decoration: none;
   }
   .a:hover{
      text-decoration: underline;
   }
   .a:active{
      color: blue;
   }
</style>

<script>

$(function(){
   
})
   
function pageNoClick(
      clickPageNo
){
   var formObj = $("[name='Dictionary']");
   formObj.find("[name='selectPageNo']").val(clickPageNo);
   search();
}


function search(){
      ajax(
            "/stockDictionary.do"
            ,"post"
            , $("[name='Dictionary']")
            , function(responseHtml){
               var obj = $(responseHtml);
               var searchResultCnt = obj.find(".searchResultCnt").html();
               var searchResult = obj.find(".searchResult").html();
               var pageNos = obj.find(".pageNos").html();
               $(".searchResultCnt").html(searchResultCnt);
               $(".searchResult").html(searchResult);
               $(".pageNos").html(pageNos);
               
            }
      );
   }

function detail(sss){
   

   var formObj = $("[name='Dictionary']");
   var search = formObj.find("#pp").html("<span style='color:red;''><br><br><b>"+sss+"</b></span>")   
   
   search();
   
}
function init(){
      $(".init").bind("click",function xxx(){
         
          $("[name='keyword_dic']").val("");
          pageNoClick(1);
            search();
            
      });
   }

function goGraphBtn(){
   document.goGraph.submit();
}

</script>
</head>
<body>
   
   <!------------ 여기서 부터 게시판  ------------------->
   <section class="home-section">
      <div class="home-content">
         <i class="bx bx-menu"></i>
         <div class="wrap1">
            <div class="search1">

               <form name="goGraph" method="post" action="/graph.do">
                  <input type="text" name="keyword" class="searchTerm1"
                     placeholder="Search...">
               </form>

               <button type="submit" class="searchButton1" onClick="goGraphBtn();">
                  <i class="fa fa-search"></i>
               </button>
            </div>
         </div>
      </div>
      <!-- -------- 여기 밑 부터 디자인 하면됨 --------------->
      <div class="cardBox_1">
         <!---------------첫째줄------------------->
         <div class="card_1">
            <div>
               <div class="numbers_1">${requestScope.kospiListDescMap.kospiListDesc[0].previous_close}</div>
               <div class="cardName_1">KOSPI</div>
            </div>
            <div class="iconBx">
               <ion-icon name="analytics-outline"></ion-icon>
            </div>
         </div>
         <!--------------------------------------------->
         <div class="card_1">
            <div>
               <div class="numbers_1">${requestScope.kosdaqListDescMap.kosdaqListDesc[0].previous_close}</div>
               <div class="cardName_1">KOSDAQ</div>
            </div>
            <div class="iconBx">
               <ion-icon name="trending-down-outline"></ion-icon>
            </div>
         </div>
         <!--------------------------------------------->
         <div class="card_1">
            <div>
               <div class="numbers_1">12,789.48</div>
               <div class="cardName_1">NASDAQ</div>
            </div>
            <div class="iconBx">
               <ion-icon name="trending-up-outline"></ion-icon>
            </div>
         </div>
         <!--------------------------------------------->
         <div class="card_1">
            <div>
               <div class="numbers_1">${requestScope.exchangeDescList[0].USD}</div>
               <div class="cardName_1">환율</div>
            </div>
            <div class="iconBx">
               <ion-icon name="cash-outline"></ion-icon>
            </div>
         </div>
      </div>
      <!------KOSPI 부분 끝-------------->
      <!-- 둘째줄 시작 -->
      <form name="Dictionary">
      <div class="cardBox_2">
         <div class="card_2"   >
            <div>
               
                  <br>
                  <center>
                      <div class="wrap">
                              
                             <div style="margin-left:-10%;" class="search">
                             <input type="text" name="keyword" class="searchTerm" placeholder="주식용어검색">
                                <button type="submit" class="searchButton" onClick="search();">
                                  <i class="fa fa-search"></i>
                               </button><input class="init" style="cursor:pointer; margin-left: 5%;" type="button" value="초기화" onClick="init();">
                             </div>
                             
                        </div>

                     <div style="height: 10px"></div>
                     <div class="searchResultCnt">
                        <div class="searchResult">
                           <h4>📖주식용어사전</h4>
                           <div style="height: 30px"></div>
                           <c:if test="${empty requestScope.stockMap.searchStockList}">
                                 <br><br>검색결과가 없습니다.
                           </c:if>
                           <c:forEach var="stock"
                              items="${requestScope.stockMap.searchStockList}"
                              varStatus="vs">
                              <a style="cursor: pointer"
                                 onClick="detail('${stock.STOCK_DIC}')"><b>
                                    ${stock.STOCK_DIC_NAME} <c:if test="${vs.count%5==0}">
                                       <br>
                                       <br>
                                    </c:if>
                              </b></a>&nbsp;&nbsp;&nbsp;
                           </c:forEach>
                           <br> <br>
                           <div class="pageNos">
                              <c:forEach var="pageNo"
                                 begin="${requestScope.stockMap.begin_pageNo}"
                                 end="${requestScope.stockMap.end_pageNo}">
                                 <c:if test="${requestScope.stockMap.selectPageNo==pageNo}">
                                    <span style="color: blue; text-decoration: underline;"><b>${pageNo}</b></span>
                                 </c:if>
                                 <c:if test="${requestScope.stockMap.selectPageNo!=pageNo}">
                                    <span style="cursor: pointer; color: navy;"
                                       onClick="pageNoClick(${pageNo})"><b>${pageNo}</b></span>
                                 </c:if>
                              </c:forEach>
                              &nbsp;&nbsp;
                           </div>
                           
                     <div id="pp"
                        style="width: 600px; height: 200px; border: 0px solid orange;">
                        <c:if test="${!empty requestScope.stockMap.searchStockList}">
                                 <br><br> 궁금한 용어를 클릭해보세요!
                           </c:if>
                        
                     </div>
                        </div>
                     </div>
               </div>
         </div>
      </div>
      </center>
      <!-- 둘째줄 끝 -->
      <!-- 셋째줄 시작 -->
      <div class="cardBox_3">
         <div class="card_3">
            <div>

                  <div
                     style="width: 1200px; height: 550px; background-color: white; border: 0px solid blue;">
                     <br> <b><center>💡 여기서 알아두셔야 할 우리나라 주식 시장의 특징이 있습니다 💡</center></b><br>
                     <br> <br>
                     우리나라 주식은 주식을 매수하거나 매도할 때 실제로 돈이 출금되거나, 매수한 주식의 실물을 소유하게 도는 것은 D+2 거래일 때입니다.
                     <hr style="width: 1150px;">
                     예수금 100만원을 가지고 삼성전자 주식 100만원어치를 사면 나의 보유주식 수는 바로 100만원어치가 되나,
                     <hr style="width: 1150px;">
                      실제 돈이 빠져 나가는 것은 D+2거래일 뒤입니다. 
                     <hr style="width: 1150px;">
                     그러나 증권사 어플등에서 보면 거래가 체결됐다는 알람과 함께 내 주식계좌에 주식이 추가된 것을 볼 수 있습니다.
                     <hr style="width: 1150px;">
                      하지만 이는 전산상으로 선반영한 것이지 실제로 주식을 손에 쥐는 것은 D+2 거래일 뒤입니다. 
                     <hr style="width: 1150px;">
                     즉 주식거래의 전산반영 시점과 실제로 거래가 모두 완료되는 시점은 D+2거래일의 차이가 있습니다.
                     <hr style="width: 1150px;">
                      삼성전주 주식 100주를 사고, 증권사 어플에서 체결됐다고 하면 보유주식은 삼성전자 주식 100개가 보일 것입니다.
                     <hr style="width: 1150px;">
                      하지만 예수금은 아직 빠져나가지 않은 상태입니다. D+2 거래일에 실제로 돈이 인출됩니다.
                     <hr style="width: 1150px;">
                      또한 주식의 소유주로서 실제로 인증받는 것도 이 시점입니다.
                     <hr style="width: 1150px;">
                      이 때문에 배당을 받으려 하시는 분이 배당락일에 주식을 매수한다면 이미 늦게 되는 것입니다.
                     <hr style="width: 1150px;">
                      주식의 소유주이름이 D+2일에 비로소 새로 반영되기 때문입니다.
                     <hr style="width: 1150px;">

                     100만원어치 주식을 보유하고 있다가 매도했다면 그 돈을 당일에는 인출할 수 없고 D+2거래일 뒤에 출금할 수 있습니다.
                     <hr style="width: 1150px;">
                      하지만 해당 금액을 주식의 매수에 쓰는 것은 매도하자마자 바로 가능합니다.
                     <hr style="width: 1150px;">
                     결국 우리가 실제로 돈을 뽑을 수 있는 보유현금은 모든 것이 반영되는 D+2거래일의 예수금입니다.
                     <hr style="width: 1150px;">
                      이 금액은 각 증권사 어플에서 확인할 수 있습니다. 현재 예수금이 100만원이어도 D+2거래일 예수금이 120만원, 80만원 일수도 있습니다.
                     <hr style="width: 1150px;">
                      이 D+2거래일의 예수금이 현재 전산으로 왔다갔다하고 있는 모든 거래를 반영한 최종 금액입니다.
                     <hr style="width: 1150px;">
                  </div>

                  <div style="height: 20px"></div>
                  <!-- mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm -->

                  <br> <input type="hidden" name="selectPageNo" value="1">

               </div>
         </div>
      </div>
      </form>
      <!-- 셋째줄 끝 -->
      
      
      
         <!-- 넷째줄 시작 -->
         <form name="youtube">
      <div class="cardBox_4">
         <div class="card_4">
            
               <iframe style="width:100%; height:300px;" src="https://www.youtube.com/embed/bE1iSUYA0KI?si=zY9OKZgxLDRo3C7p" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
            
            
         </div>         
         <div class="card_4">
            
               <iframe style="width:100%; height:300px;" src="https://www.youtube.com/embed/LzXzHoXO5ZE?si=wCV45gsd9KgjLgD5" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
   
            
            
         </div>
         <div class="card_4">
            
               <iframe style="width:100%; height:300px;" src="https://www.youtube.com/embed/lDWGPapR-_U?si=Ksk0Qw4E08yJCr_e" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
   
            
            
         </div>         
         <div class="card_4">
            
               <iframe style="width:100%; height:300px;" src="https://www.youtube.com/embed/4L06QIeLntI?si=oNSNAvsGZKesAYbS" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
   
            
            
         </div>
         <div class="card_4">
            
               <iframe style="width:100%; height:300px;" src="https://www.youtube.com/embed/-7PNSj9m1XA?si=MNvNjslQpZSx2bjC" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
   
            
            
         </div>         
         <div class="card_4">
            
               <iframe style="width:100%; height:300px;" src="https://www.youtube.com/embed/edN-kyKFPkI?si=1YG17VXvXyvFm5G6" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
   
            
            
         </div>
      </div>
      <!-- 넷째줄 끝 -->
      <!-- 다섯째줄 시작 -->
         <div class="cardBox_5">
         <div class="card_5">
               <div>
                  <div align="center">
                     <img alt="${youtubeMap.img}" src="${youtubeMap.img}"><br>
                     <br> <a href="https://www.youtube.com/${youtubeMap.link}"><b>${youtubeMap.title}</b></a><br>
                     <br> ${youtubeMap.description}<br> <br> 구독자수
                     :${youtubeMap.subscriberCount}명
                  </div>
               </div>
            </div>
         <!--------------------------------------------->
         <div class="card_5">
               <div>
                  <div align="center">
                     <img alt="${youtubeMap.img1}" src="${youtubeMap.img1}"><br>
                     <br> <a href="https://www.youtube.com/${youtubeMap.link1}"><b>${youtubeMap.title1}</b></a><br>
                     <br> ${youtubeMap.description1}<br> <br> 구독자수
                     :${youtubeMap.subscriberCount1}명
                  </div>
               </div>

         </div>
            <!--------------------------------------------->
         <div class="card_5">
            <div>
                  <div align="center">
                     <img alt="${youtubeMap.img2}" src="${youtubeMap.img2}"><br>
                     <br> <a href="https://www.youtube.com/${youtubeMap.link2}"><b>${youtubeMap.title2}</b></a><br>
                     <br> ${youtubeMap.description2}<br> <br> 구독자수
                     :${youtubeMap.subscriberCount2}명
                  </div>
               </div>

         </div>
         <!--------------------------------------------->
         <div class="card_5">
               <div>
                  <div align="center">
                     <img alt="${youtubeMap.img3}" src="${youtubeMap.img3}"><br>
                     <br> <a href="https://www.youtube.com/${youtubeMap.link3}"><b>${youtubeMap.title3}</b></a><br>
                     <br> ${youtubeMap.description3}<br> <br> 구독자수
                     :${youtubeMap.subscriberCount3}명
                  </div>
               </div>

            </div>
      </div>
      </form>
      <!-- 다섯째줄 끝 -->
      
   </section>
   
      <script>
        let arrow = document.querySelectorAll(".arrow");
        for (var i = 0; i < arrow.length; i++) {
            arrow[i].addEventListener("click", (e)=>{
                let arrowParent = e.target.parentElement.parentElement;
                console.log(arrowParent);
                arrowParent.classList.toggle("showMenu");
            });
        }

        let sidebar = document.querySelector(".sidebar");
        let sidebarBtn = document.querySelector(".bx-menu");
        sidebarBtn.addEventListener("click",()=>{
            sidebar.classList.toggle("close");
        });
    </script>
   <!-- 삭제하면 화면 움직이는거 안됨 -->
   


   
</body>
</html>