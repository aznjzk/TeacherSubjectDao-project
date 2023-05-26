<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "util.DBUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>subjectOne</title>
</head>
<body>
	<h1>과목 상세보기</h1>
	<table>
		<tr>
			<th>subjectNo</th>
			<th>subjectName</th>
			<th>subjectTime</th>
			<th>createdate</th>
			<th>updatedate</th>
		</tr>
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
			<td><%=subject.getCreatedate()%></td>
			<td><%=subject.getUpdatedate()%></td>
		</tr>
	<% 
		}
	%>
	
	</table>
</body>
</html>