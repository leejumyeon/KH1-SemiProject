<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<% Object obj = request.getAttribute("searchType"); 
   String[] searchType = (String[])obj;
   String searchType1 = "";
   String searchType2 = "";
   int typeCnt = 0;
   if(searchType!=null){
	   typeCnt = searchType.length;
	   for(int i=0; i<searchType.length; i++){
		   if(i==0) searchType1 = searchType[i];
		   else searchType2 = searchType[i];
	   }
   }
   
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>serviceCenterBoardList.jsp</title>
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
		width: 400px;
	}
	
	.txt_center{
		text-align: center;
	}
	
	.boardSearch{
		margin-top:10px;
	}
	
	.writeBtn{
		display: inline-block;
		border:solid 1px black;
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
	$("#search-<%=searchType1%>").prop("checked",true);
	$("#search-<%=searchType2%>").prop("checked",true);
	
	if("<%=searchType1%>"=="content"){
		$("#search-subject").prop("checked",false);
	}
	
	$("#searchWord").bind("keydown", function(event){
		  if(event.keyCode == 13) { //엔터
			  goSearch();
		  }
	});
	
	
});


// 검색
function goSearch() {
	  if($("input[name='searchType']:checked").length==0){
		  alert("검색할 타입을 선택해야 합니다.");
		  return false;
	  }
	  
	  var frm = document.noticeFrm;
	  frm.method = "GET";
	  frm.action = "<%=ctxPath%>/service/board.do";
	  frm.submit(); 
 }
 
 function goDetail(num){
	 console.log(num); 
	 var searchWord = $("#searchWord").val();
	 var url = "<%=ctxPath%>/service/boardDetail.do?notice_num="+num;
	location.href=url;
	 
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
				<div class="serviceCenter-board">
					<div class="boardInfo" style=" margin-bottom: 20px;">
						<h3 style="display:inline-block;">공지사항</h3>
						<span style="margin-left:10px; font-size:8pt; font-weight: bold;">새로운 소식들과 유용한 정보들을 한곳에 확인하세요.</span>
					</div>
					<form name="noticeFrm">
						<table style="border-top:solid 2px purple; " class="boardTable table">
							<tr style="border-bottom:solid 1px black;">
								<th class="txt_center">번호</th>
								<th class="txt_center board-title">제목</th>
								<th class="txt_center">작성자</th>
								<th class="txt_center">작성날짜</th>
								<th class="txt_center">조회수</th>
							</tr>
							<tbody>
								<c:if test="${empty noticeList}">	
									<tr>
										<td colspan="5"> 공지사항 게시판 준비중 입니다. </td>
									</tr>	
								</c:if>
								<c:if test="${not empty noticeList}">		
									<c:forEach var="nvo" items="${noticeList}">
										<tr onclick = "goDetail('${nvo.notice_num}')">
											<td class="txt_center">공지<input type="hidden" value="${nvo.notice_num}" name="notice_num" /></td>
											<td class="board-title">${nvo.subject}</td>
											<td class="txt_center">MarketKurly</td>
											<td class="txt_center">${nvo.write_date}</td>
											<td class="txt_center">${nvo.hit}</td>
										</tr>
									</c:forEach>	
								</c:if>
							</tbody>
						</table>
						
						<div style="border-bottom:solid 1px black; text-align:center;">${pageBar}</div>
						<div class="boardSearch">
							<span style="float:left">
							검색어 : <label for="search-subject">제목</label> <input type="checkbox" checked id="search-subject" value="subject" name="searchType" style="margin-right:15px;"/>
								   <label for="search-content">내용</label> <input type="checkbox" id="search-content" value="content" name="searchType" style="margin-right:15px;"/>
							</span>
							<span style="float:right; border:solid 1px black;">
							<input type="text" style="float:left; border:none;" name="searchWord"  id="searchWord" value="${searchWord}" /><span style="cursor: pointer;" onclick = "goSearch()"><img src="<%=ctxPath%>/images/search.png" style="display:inline-block; width:25px; height: 25px; "/></span>
							</span>
						</div>
					</form>
					<div style="clear:both; margin-top: 20px;">
				<c:if test="${sessionScope.loginuser.status=='2'}">
					<span class="writeBtn" onclick="javascript:location.href='<%= request.getContextPath()%>/manager/mangerBoardWrite.do'">게시글 작성</span>
				</c:if>
				</div>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
		<div>
			<jsp:include page="../include/footer.jsp"></jsp:include>
		</div>
	</div>
</body>
</html>