<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%


int no=Integer.parseInt(request.getParameter("no"));


String col=request.getParameter("col");
String word=request.getParameter("word");
String nowPage=request.getParameter("nowPage");


 	String passwd = request.getParameter("passwd");
 	boolean flag = idao.checkRefno(no);
%>

<!DOCTYPE html> 
<html> 
<head> 

<meta charset="UTF-8"> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
function incheck(f){
if(f.passwd.value==""){
alert("패스워드를 입력하세요");
f.passwd.focus();
return false;
}

}
</script>

</head> 
<body> 
<jsp:include page="/templet/top.jsp" flush="false" />
<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-picture"></span>_썸네일</h2>
<hr class="w3-round border-position">
</div> 
<div>삭제확인</div>
<div class="content">
<%if(flag){ 
out.print("답변있는 글이므로 삭제 할 수 없습니다.<br>");
out.print("<input type='button' value='다시시도' onclick='history.go(-2)'>");

}else{%>
<form method="post" action="deleteProc.jsp" onsubmit="return incheck(this)">

<input type="hidden" name="no" value="<%=no%>"> 
<input type="hidden" name="col" value="<%=col %>">
<input type="hidden" name="word" value="<%=word %>">
<input type="hidden" name="nowPage" value="<%=nowPage %>">
<input type="hidden" name="oldfile"value="<%=request.getParameter("oldfile")%>">


삭제를 하면 복구 될 수 없습니다.<br><br>
삭제하시려면 비밀번호를 입력하시고 확인을 눌러주세요<br><br>
취소는 '목록'버튼을 누르세요.<br><br>
<table class="table-pw">
<tr>
<th>비밀번호</th>
<td><input type="password" name="passwd"></td>
</tr>
</table>

<DIV class='bottom'>
<input type="submit" value="삭제처리">
<input type="button" value="목록" onclick="location.href='./list.jsp'">
</DIV>


</form>
<%} %>
</div>
<jsp:include page="/templet/bottom.jsp" flush="false" />
</body> 
</html> 
