<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "util.DBUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>subjectList</title>
<!-- 부트스트랩 5 사용 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<br>
<div class="container text-center">
	<h1>과목 목록</h1>
	<!--------------- 강사목록 버튼 --------------->
	<div style="float:left;">
		<a href="<%=request.getContextPath()%>/teacher/selectTeacherListByPage.jsp" class="btn btn-outline-primary">
			강사 목록
		</a>
	</div>
	
	<!--------------- 과목 추가 버튼 --------------->
	<div style="float:right;">
		<a href="<%=request.getContextPath()%>/subject/addSubject.jsp" class="btn btn-outline-primary">
			과목 추가
		</a>
	</div>
	<br>
	
	<!------------ subjectList 출력 ------------>
	<br>
	<table class="table table-bordered table-hover">
		<thead class="table-primary">
			<tr>
				<th>subjectNo</th>
				<th>subjectName</th>
				<th>subjectTime</th>
			</tr>
			</thead>
			<tbody>
		<% 
			SubjectDao subjectDao = new SubjectDao();
			ArrayList<Subject> subjectList = subjectDao.selectSubjectListByPage(0, 10);
			for(Subject subject : subjectList) {
		%>
			<tr>
				<td>
					<a href="./subjectOne.jsp?subjectNo=<%=subject.getSubjectNo()%>">
					<%=subject.getSubjectNo()%>
					</a>
				</td>
				<td><%=subject.getSubjectName()%></td>
				<td><%=subject.getSubjectTime()%></td>
			</tr>
		<% 
			}
		%>
		</tbody>
	</table>
</div>
</body>
</html>