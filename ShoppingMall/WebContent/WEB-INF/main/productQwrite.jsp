<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<% String product_num = request.getParameter("product_num"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>productQwrite.jsp</title>
<style type="text/css">
	.writeTable{
		width:1080px;
		border-top: solid 2px purple;
	}
	
	.writeTable td{
		border-bottom: solid 1px #e0e0eb;
	}
	
	.writeTable, td{
		border-collapse: collapse;
	}
	
	.frmTitle{
		background-color: #ffe6ff;
		padding: 10px 0 10px 10px;
		font-size: 10pt;
		font-weight: bold;
		width: 200px;
	}
	
	.frmTitle ~ td{
		padding-left:10px;
	}
	
	input[name='title']{
		width: 90%;
		height: 30px;
	}
	
	.userBtn{
		width:1080px;
	}
	
	.userBtn > span{
		display: inline-block;
		text-align: center;
		padding : 10px 0;
		margin-top:20px;
		width:80px;
		border: solid 1px purple;
		font-size: 14pt;
		cursor: pointer;
		margin-right:10px;
	}

	.imgInput{
		width: 80%;
		
	}
	
	#txt_area{
		overflow-y: scroll;
		border:solid 1px black; 
		margin-top:10px; 
		height: 600px;
		width: 100%;
		resize: none;
		
	}
	
	
	#imgAdd{
		display: inline-block;
		width: 80px;
		background-color: purple;
		font-weight: bold;
		margin-right: 10px;
		cursor: pointer;
		color:white;
	}
	
	.imgInput, .closeInput{
		display: inline-block;
	}
	
	.closeInput{
		cursor: pointer;
		background-color: red;
		font-size: 12pt;
		font-weight: bold;
		padding : 0  5px;
	}
	

</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript" src="/ShoppingMall/smartEdit/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var cnt=0;
$(document).ready(function(){
	$(document).on('change','.imgFile',function(){
			console.log("이미지 로딩");
			var idx = $(this).prop("id").substring(7)
			func_imgCheck(idx, this);
	});
	
});

function divCheck(){
	
	if($("input[name='title']").val().trim()==""){
		alert("제목을 입력해주세요");
		return;
	}
	
	if($("#txt_area").val().trim() == ""){
		alert("내용을 입력해주세요");
		return;
	}
	
	var imgFlag = true;
	$("input:file[name='imgFile']").each(function(index, item){
		if(item.value == null){
			imgFlag = false;
			return;
		}
	})
	
	if(!imgFlag){
		alert("첨부되지 않은 파일이 있습니다.");
		return;
	}
	
	var content = $("#txt_area").val();
	console.log(content);
	$("#txt_content").val(content);
	console.log($("#txt_content").val());
	var Frm = document.questionWriteFrm;
	Frm.action = "<%=ctxPath%>/productQwrite.do"
	Frm.submit(); 
	
}

function func_addArea(){
	var html="<div class='imgInput' id='imgInput"+cnt+"'>"
	        +"<input type='file' name='imgFile"+cnt+"' class='imgFile' id='imgFile"+cnt+"'  accept='.gif, .jpg, .png' style='margin-bottom:10px;'/>"
		    +"<input id='fileName"+cnt+"' type='hidden' name='fileName'/>"
	        +"</div>"
		    +"<div class='closeInput' id='close"+cnt+"' onclick='func_deleteImg(this)' align='right'>X"
		    +"</div>";
	if($(".imgInput").length>7){
		alert("이미지는 최대 8장 만 입력할 수 있습니다.");
		return;
	}
	$(".productQ-imgTable").prepend(html);
	cnt++;
}

function func_imgCheck(idx, item){
	console.log(item);
	if(item.files && item.files[0]) {
		var fileName = item.files[0].name;
		var index = fileName.indexOf(".");
		var fileType = fileName.substr(index);
		if(fileType==".png"||fileType==".jpg"||fileType==".png"){
			 fileView(item);
		}
		else{
			alert("이미지만 올릴 수 있습니다.");
			item.value=null;
		}
	}
}

function fileView(elem){
	console.log(elem);
	console.log(elem.value);
	var idx = $(elem).prop("id").substring(7);
	console.log(idx);
	var fullPath = elem.value;
	fileName = fullPath.substring(12);
	console.log(fullPath);
	console.log(fileName);
	$("#fileName"+idx).val(fileName);
}


function func_deleteImg(item){
	console.log(item);
	var idx = $(item).prop("id").substring(5); 
	console.log(idx);
	$("#imgInput"+idx).remove();
	$("#close"+idx).remove();
	$("#fileName"+idx).remove();
}


function goBack(){
	alert("작성된 내용은 저장되지 않습니다.");
	history.back();
	
}

</script>
</head>
<body>
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<div class="boardInfo">
					<h3 style="display:inline-block">상품문의 작성</h3>
					<span style="margin-left:10px; font-size:8pt; font-weight: bold;"></span>
				</div>
				<form name="questionWriteFrm" enctype="multipart/form-data" method="post">
					<input type="hidden" name="product_num" value="<%=product_num %>" />
					<table class="writeTable">
						<tr>
							<td class="frmTitle">작성자</td>
							<td><input type="text" value="${sessionScope.loginuser.name}" disabled name="userName"/>
								
							</td>
						</tr>
						<tr>
							<td class="frmTitle">이메일</td>
							<td>
								<input type="email" value="${sessionScope.loginuser.email}" disabled name="userEmail"/>
								<input type="checkbox" value="1" id="emailComment" name="emailComment"/><label for="emailComment">이메일로 답변을 받겠습니다.</label>
							</td>
						</tr>
						<tr>
							<td class="frmTitle">핸드폰</td>
							<td>
								<input type="text" value="${sessionScope.loginuser.mobile}" disabled name="userMobile"/>
								<input type="checkbox" value="1" id="mobileComment" name="mobileComment"/><label for="mobileComment">문자로 답변을 받겠습니다.</label>
							</td>
						</tr>
						<tr>
							<td class="frmTitle">비밀글</td>
							<td>
								<input type="checkbox" value="1" id="secretCheck" name="secretFlag" /><label for="secretCheck">비밀글</label>
							</td>
						</tr>
						<tr>
							<td class="frmTitle">제목</td>
							<td><input type="text" value=""  name="title"/></td>
						</tr>
						<tr>
							<td class="txt_field" colspan="2">
								<textarea rows="30" cols="30" name="weditor" id="txt_area"></textarea>
								<input type="hidden" name="contents" id="txt_content"/>
							</td>

						</tr>
						<tr>
							<td style="vertical-align: top;" >
								<span id="imgAdd" onclick="func_addArea()">추가 업로드</span>
								<label for="imgFile0">이미지 파일</label>
							</td>
							<td class='productQ-imgTable'>
								<!-- <div class="imgInput" id='imgInput0'>
									<input type='file' name="imgFile" class="imgFile" id='imgFile0' accept='.gif, .jpg, .png' style="margin-bottom:10px;"/>
								</div>
								<div class="closeInput" id="close0" align="right" onclick="func_deleteImg(this)">X</div>
								 -->
							</td>
						</tr>
					</table>
					<div class="userBtn" align="center">
						<span onclick="goBack()">취소</span> <span style="background-color:purple; color:white;" onclick="divCheck()">등록</span>
					</div>
				</form>
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>