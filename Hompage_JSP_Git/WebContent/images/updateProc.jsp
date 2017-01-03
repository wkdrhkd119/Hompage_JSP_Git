<%@page import="java.awt.print.Printable"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dto" class="images.ImagesDTO" />
<%
String upDir = "/images/storage";
String tempDir = "/images/temp";

upDir = application.getRealPath(upDir);
tempDir = application.getRealPath(tempDir);

UploadSave upload = new UploadSave(request, -1, -1, tempDir);

String col = upload.getParameter("col");
String word = UploadSave.encode(upload.getParameter("word"));
int nowPage = Integer.parseInt(upload.getParameter("nowPage"));
String oldfile = UploadSave.encode(upload.getParameter("oldfile"));

dto.setNo(Integer.parseInt(upload.getParameter("no")));
dto.setWname(UploadSave.encode(upload.getParameter("wname")));
dto.setTitle(UploadSave.encode(upload.getParameter("title")));
dto.setContent(UploadSave.encode(upload.getParameter("content")));
dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));

FileItem fileItem = upload.getFileItem("fname");

int filesize = (int) fileItem.getSize();
String fname = null;

if (filesize > 0) { //새 파일을 업로드했다.
UploadSave.deleteFile(upDir, oldfile); //기존파일을 삭제
fname = UploadSave.saveFile(fileItem, upDir);
}

dto.setFname(fname);

Map map = new HashMap();
map.put("no", dto.getNo());
map.put("passwd", dto.getPasswd());
boolean pflag = idao.passCheck(map);

boolean flag = false;
if (pflag) {
flag = idao.update(dto);
}
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
function ilist() {
var url = "./list.jsp";
url +="?col=<%=col%>";
url +="&word=<%=word%>";
url +="&nowPage=<%=nowPage%>";
location.href = url;
}
</script>

</head>
<!-- *********************************************** -->
<body leftmargin="0" topmargin="0">
<jsp:include page="/templet/top.jsp" flush="false" />
<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-picture"></span>_썸네일</h2>
<hr class="w3-round border-position">
</div> 

<DIV class="title">Images - updateProc</DIV>

<div class="content">
<%
if (pflag == false) {
out.print("패스워드 틀리셨습니다.");
} else if (flag) {
out.print("수정에 성공하셨습니다.");
} else {
out.print("수정 실패 하셨습니다.");
}
%>
</div>

<%
if (pflag == false) {
%>

<DIV class='bottom'>
<input type='submit' value='재 시도' onclick="history.back()">
<input type='button' value='목록' onclick="location.href='./list.jsp'">
</DIV>

<%
} else {
%>
<DIV class='bottom'>
<input type='submit' value='새글 작성' onclick="location.href='createForm.jsp'">
<input type='button' value='목록' onclick="ilist()">
</DIV>
<%
}
%>


<!-- *********************************************** -->
<jsp:include page="/templet/bottom.jsp" flush="false" />
</body>
<!-- *********************************************** -->
</html>