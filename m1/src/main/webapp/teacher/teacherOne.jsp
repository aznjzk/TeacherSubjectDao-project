<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	/* 요청값 유효성 검사 */
	if(request.getParameter("teacherNo") == null  
		|| request.getParameter("teacherNo").equals("")) {
		// teacherList.jsp으로 리다이렉트
		response.sendRedirect(request.getContextPath() + "/teacher/selectTeacherListByPage.jsp");
		return;
	}
	// 유효성 검사를 통과하면 변수에 저장
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));

	TeacherDao tDao = new TeacherDao(); // TeacherDao 객체 생성
	Teacher tOne = tDao.selectTeacherOne(teacherNo); // teacherNo를 매개변수로 selectTeacherOne 메서드 호출하여, 상세보기에 표시할 Teacher 객체 가져오기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>teacherOne</title>
<!-- 부트스트랩 5 사용 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container text-center">
	<h1>강사 정보 상세</h1>
	<form action="<%=request.getContextPath()%>/teacher/modifyTeacher.jsp" method="get">
		<table class="table table-bordered">
			<tr>
				<th class="table-primary">teacherName</th>
				<td>
					<input type="hidden" name="teacherNo" value="<%=tOne.getTeacherNo()%>">
					<%=tOne.getTeacherName()%>
				</td>
			</tr>
			<tr>
				<th class="table-primary">teacherId</th>
				<td>
					<input type="hidden" name="teacherNo" value="<%=tOne.getTeacherNo()%>">
					<%=tOne.getTeacherId()%>
				</td>
			</tr>
			<tr>
				<th class="table-primary">teacherHistory</th>
				<td><%=tOne.getTeacherHistory()%></td>
			</tr>
			<tr>
				<th class="table-primary">createdate</th>
				<td><%=tOne.getCreatedate()%></td>
			</tr>
			<tr>
				<th class="table-primary">updatedate</th>
				<td><%=tOne.getUpdatedate()%></td>
			</tr>
		</table>
		
		<div style="float:left;">
			<button type="submit" class="btn btn-outline-primary">수정</button>
		</div>
	</form>
		
	<div style="float:right;">
		<form action="<%=request.getContextPath()%>/teacher/removeTeacher.jsp" method="get">
			<input type="hidden" name="teacherNo" value="<%=tOne.getTeacherNo()%>">
			<button type="submit" class="btn btn-outline-primary">삭제</button>
		</form>
	</div>
	
		<a href="<%=request.getContextPath()%>/teacher/selectTeacherListByPage.jsp">
			<button type="button" class="btn btn-primary">목록으로</button>
		</a>
	</div>
</body>
</html>