<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>serviceCenterQboardList</title>
<style type="text/css">
   .sideMenu{
      display: inline-block;
      width: 150px;
      float:left;
   }
   
   .serviceCenter-board{
      width: 780px;
      margin-left: 90px;
      text-align: left;
   }
   
   .board-title{
      width: 550px;
   }
   
   .txt_center{
      text-align: center;
   }
   
   .boardSearch{
      margin-top:10px;
   }
   
   
   .panel {
     
     background-color: white;
     overflow: hidden;
     text-align: left;
     margin : 0px ; 
   
   }
   
   .panel-none{
      display: none;
   }
   
   .faq_content{
      min-height: 300px;
   }
   
   .userBtn > span{
      display: inline-block;
      text-align: center;
      padding : 10 0px;
      margin-right:5px;
      width:60px;
      border: solid 1px purple;
      background-color: #f1f1f1;
      color: purple;
      font-size: 12pt;
      cursor: pointer;
      
   }
   
   .writeBtn{
      display: inline-block;
      border:solid 1px #ddd;
      padding: 5px 30px;
      background-color: purple;
      color:white;
      float: right;
      cursor:pointer;
   }
   
   .writeBtn:hover{
      cursor: pointer;
      background-color: white;
      color:purple;
   }
   
   input[name='searchWord']:focus{
		outline: none;
	}

</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
   $(document).ready(function(){
      console.log("${categoryList}");
      var acc = document.getElementsByClassName("accordion");

      for (i = 0; i < acc.length; i++) {
           acc[i].addEventListener("click", function(event) {
            var $target = $(this).next();
            console.log($target);
            var $other = $target.siblings();
            $other.each(function(index, item){
               if($(item).hasClass("panel")){
                  $(item).addClass("panel-none");   
               }
            });
            $target.toggleClass("panel-none");
           });
         }
      
      
      $("select[name='favoriteQ_Category']").bind("change",function(){
         goInquiry();
      });
   });
   
   function goInquiry(){
      var frm = document.faqFrm;
      frm.action="<%=ctxPath%>/service/FAQ.do";
      frm.method="get";
      frm.submit();
   }
   
   function goUpdate(num){
      location.href="<%=ctxPath%>/service/FAQupdate.do?faq_num="+num;
   }
   
   function goDelete(num){
      location.href="<%=ctxPath%>/service/FAQdelete.do?faq_num="+num;
   }
   
</script>
</head>
<body>
   
   <div class="Mycontainer">
      <jsp:include page="../include/header.jsp"></jsp:include>
      <div class="section" align="center">
         <div class="contents">
            <div class="sideMenu">
               <jsp:include page="../include/serviceCenterSide.jsp"></jsp:include>
            </div>
            <form name="faqFrm">
            <div class="serviceCenter-board">
               <div class="boardInfo" style="margin-bottom: 20px;">
                  <h3 style="display:inline-block" style="margin-bottom: 20px;">자주하는 질문</h3>
                  <span style="margin-left:10px; font-size:8pt; font-weight: bold;">고객님들께서 가장 많이하는 질문들은 모두 모았습니다.</span>
                  <br/>
                  <select name="favoriteQ_Category">
                     <option value="0">전체보기</option>
                     <c:forEach var="item" items="${categoryList}">
                        <c:if test="${category == item.num }">
                           <option value="${item.num }" selected>${item.category}</option>
                        </c:if>
                        <c:if test="${category != item.num }">
                           <option value="${item.num }" >${item.category}</option>
                        </c:if>
                     </c:forEach>
                  </select>
               </div>
               <table style="border-top:solid 2px purple;" class="boardTable table">
                  <tr style="border-bottom:solid 1px #ddd;">
                     <th class="txt_center">번호</th>
                     <th class="txt_center">카테고리</th>
                     <th class="txt_center board-title">제목</th>
                  </tr>
                  <c:if test="${empty FAQList}">   
                     <tr>
                        <td colspan="5"> 검색한 내용에 해당하는 글이 없습니다. </td>
                     </tr>   
                  </c:if>
                  <c:if test="${not empty FAQList}">      
                     <c:forEach var="faq" items="${FAQList}">
                           <tr class='accordion'>
                              <td class="txt_center">${faq.count}</td>
                              <td class="txt_center">${faq.category_content}</td>
                              <td style="cursor: pointer">${faq.subject}</td>
                           </tr>
                           <tr class='panel panel-none'>
                              <td colspan="3" >
                                 <div class="faq_content">${faq.content}</div>
                                 <c:if test="${sessionScope.loginuser.status=='2'}">
                                 <div class="userBtn" align="right">
                                    <span onclick = "goUpdate('${faq.faq_num}')">수정</span><span onclick = "goDelete('${faq.faq_num}')">삭제</span>
                                 </div>
                                 </c:if>
                              </td>
                           </tr>
                        </c:forEach>   
                     </c:if>
               </table>
               
               <div style="border-bottom:solid 1px #ddd; text-align:center; margin-bottom:20px; padding-bottom: 20px;">${pageBar}</div>
               <span style="float:right; border:solid 1px black;">
                     <input type="text" style="float:left; border:none;" name="searchWord"  id="searchWord" value="${searchWord}" /><span style="cursor: pointer;" onclick = "goInquiry()"><img src="<%=ctxPath%>/images/search.png" style="display:inline-block; width:25px; height: 25px; "/></span>
               </span>
               <div style="clear:both; margin-top: 20px;">
               <c:if test="${sessionScope.loginuser.status=='2'}">
                  <span class="writeBtn" onclick="javascript:location.href='<%= request.getContextPath()%>/manager/mangerBoardWrite.do'">게시글 작성</span>
               </c:if>
               </div>
            </div>
            </form>
            
         </div>
      </div>
      <div style="clear:both;">
         <jsp:include page="../include/footer.jsp"></jsp:include>
      </div>
   </div>
</body>
</html>