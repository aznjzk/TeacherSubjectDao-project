<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	// 현재페이지
	int currentPage = 1;
	
	/* 유효성 검사 통과하면 변수에 저장 */
	if (request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}	
	/*  
	rowPerPage = 5 일때
		 
		 currentPage	  beginRow
			 1				 0
			 2				 5
		 	10				 45									
	*/  
	
	// 페이지에 보여줄 글의 개수
	int rowPerPage = 5;
	// 시작 글의 번호
	int beginRow = (currentPage-1) * rowPerPage;
	
	
	// 페이지에 해당하는 데이터 조회
	TeacherDao teaDao = new TeacherDao();
	ArrayList<HashMap<String, Object>> teacherList = teaDao.selectTeacherListByPage(beginRow, rowPerPage);

	// 전체 글의 수 구하기
	int totalRow = teaDao.selectTeacherCnt();
	
	// 마지막 페이지
	int lastPage = totalRow / rowPerPage;
		// 딱 나누어 떨어지지 않으면 마지막 페이지 하나 추가
		if(totalRow % rowPerPage != 0) {
			lastPage = lastPage + 1;
		}
	
	/*
	pagePerPage = 10 일때
		
		currentPage	  minPage		  maxPage
			 1			 1				10
			15			11				20
			27			21				30	
	*/
		
	// 하단 페이지목록 : 한 번에 보여줄 페이지의 개수
	int pagePerPage = 10;
	// 페이지 목록 중 가장 작은 숫자의 페이지
	int minPage = ((currentPage - 1) / pagePerPage ) * pagePerPage + 1;
	// 페이지 목록 중 가장 큰 숫자의 페이지
	int maxPage = minPage + (pagePerPage - 1);
	// maxPage 가 last Page보다 커버리면 안되니까 lastPage를 넣어준다
	if (maxPage > lastPage){
		maxPage = lastPage;
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>teacherList</title>
<!-- 부트스트랩 5 사용 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<br>
<!-- teacherList -->
<div class="container text-center">
	<h1>강사 목록</h1>
	
	<!--------------- 과목목록 버튼 --------------->
	<div style="float:left;">
		<a href="<%=request.getContextPath()%>/subject/subjectList.jsp" class="btn btn-outline-primary">
			과목 목록
		</a>
	</div>
	
	<!--------------- 강사 추가 버튼 --------------->
	<div style="float:right;">
		<a href="<%=request.getContextPath()%>/teacher/addTeacher.jsp" class="btn btn-outline-primary">
			강사 추가
		</a>
	</div>
	<br>
	
	<!------------ teacherList 출력 ------------>
	<br>
	<table class="table table-bordered table-hover">
		<thead class="table-primary">
			<tr>
				<th>teacherNo</th>
				<th>teacherId</th>
				<th>teacherName</th>
				<th>subjectName</th>
			</tr>
		</thead>
		<tbody>
	<% 
		for(HashMap<String, Object> teacher : teacherList) {
	%>
		<tr>
			<td><a href="<%=request.getContextPath()%>/teacher/teacherOne.jsp?teacherNo=<%=teacher.get("teacherNo")%>">
				<%=teacher.get("teacherNo")%></a></td>
			<td><%=teacher.get("teacherId")%></td>
			<td><%=teacher.get("teacherName")%></td>
			<td><%=teacher.get("subjectName")%></td>
		</tr>
	<% 
		}
	%>
		</tbody>
	</table>
	
	<!------------ 페이지네이션 ------------>
	<nav>
		<ul class="pagination justify-content-center">
			<%
				if(minPage != 1) {
			%>
					<li class="page-item">
						<a href="<%=request.getContextPath()%>/teacher/selectTeacherListByPage.jsp?currentPage=<%=minPage - 1%>&rowPerPage=<%=rowPerPage%>" class="page-link">
							&laquo; 이전
						</a>
					</li>
			<%
				} else { // 1페이지에서는 버튼 비활성화
			%>
					<li class="page-item disabled">
				      <span class="page-link">&laquo; 이전</span>
				    </li>
			<%
				}
				for(int i = minPage; i <= maxPage; i++) {
					if(i != currentPage) {
			%>
						<li class="page-item">
							<a href="<%=request.getContextPath()%>/teacher/selectTeacherListByPage.jsp?currentPage=<%=i%>&rowPerPage=<%=rowPerPage%>" class="page-link">
								<%=i%>
							</a>
						</li>
			<%
					} else { // 현재페이지에서는 버튼 비활성화
			%>
						<li class="page-item disabled">
							<span class="page-link"><%=i%></span>
						</li>
			<%
					}
				}
				if(maxPage != lastPage) {
			%>
					<li class="page-item">
						<a href="<%=request.getContextPath()%>/teacher/selectTeacherListByPage.jsp?currentPage=<%=maxPage + 1%>&rowPerPage=<%=rowPerPage%>" class="page-link">
							다음 &raquo;
						</a>
					</li>
			<%
				} else { // 마지막 페이지에서는 버튼 비활성화
			%>
					<li class="page-item disabled">
				      <span class="page-link">다음 &raquo;</span>
				    </li>
			<%
				}
			%>
		</ul>
	</nav>
</div>
</body>
</html>