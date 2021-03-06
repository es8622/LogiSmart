<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="managebbs.ManageBbs" %>
<%@ page import="managebbs.ManageBbsDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import ="java.net.URLEncoder" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.DriverManager,
                   java.sql.Connection,
                   java.sql.Statement,
                   java.sql.ResultSet,
                   java.sql.SQLException" %>
<%@ page import="manager.Manager" %>
<%@ page import="manager.ManagerDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<title>Logi Mananger Web</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<!-- <link rel="stylesheet" href="css/btn-deco.css"> -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 0;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		String searchType="전체";
		if(request.getParameter("searchType") != null){
			searchType = request.getParameter("searchType");
		}
		String search="";
		if(request.getParameter("search") != null){
			search = request.getParameter("search");
		}
		
	%>
	<nav class="navbar navbar-default">
	 <div class="navbar-header">
	 	<button type="button" class="navbar-toggle collapsed"
	 		data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" 
	 		aria-expanded="false">
	 		<span class="icon-bar"></span>
	 		<span class="icon-bar"></span>
	 		<span class="icon-bar"></span>
	 		</button>
	 		<a class="navbar-brand" href="main.jsp">LogiSmart Manage Page</a>
	 </div>
	 <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	 	<ul class="nav navbar-nav">
	 	<li><a href="main.jsp">메인</a></li>
	 	<li><a href="manage_Accept.jsp">운반수락</a></li>
	 	<li class="active"><a href="manage_bbs.jsp">운반현황</a></li>
	 	<li><a href="manage_manager.jsp">관리자현황</a></li>
	 	<li><a href="manage_carrier.jsp">운반자현황</a></li>
	 	</ul>
	 	<%
	 		if(userID == null){
	 	%>
	 	<ul class="nav navbar-nav navbar-right">
	 		<li class="dropdown">
	 			<a href="#" class="dropdown-toggle"
	 				data-toggle="dropdown" role="button" aria-haspopup="true"
	 				aria-expanded="false">관리자 접속하기<span class="caret"></span></a>
	 			<ul class="dropdown-menu">
	 				<li><a href="login.jsp">로그인</a></li>
	 				<li><a href="join.jsp">관리자가입</a></li>
	 			</ul>
	 		</li>
	 	</ul>
	 	<%
	 		}else {
	 	%>
	 	<ul class="nav navbar-nav navbar-right">
	 		<li class="dropdown">
	 			<a href="#" class="dropdown-toggle"
	 				data-toggle="dropdown" role="button" aria-haspopup="true"
	 				aria-expanded="false">회원관리<span class="caret"></span></a>
	 			<ul class="dropdown-menu">
	 				<li><a href="logoutAction.jsp">로그아웃</a></li>
	 			</ul>
	 		</li>
	 	</ul>
		<%
	 		}
		%>
	 </div>
	</nav>
	
	<div class = "container">
		
		<form method="get" action="manage_bbs.jsp" class="form-inline" style="margin-bottom: 10px">
				<select name="searchType" class="form-control">
					<option value="전체">전체</option>
					<option value="이름" <%if(searchType.equals("이름")) out.println("selected");%>>이름</option>
					<option value="상태" <%if(searchType.equals("상태")) out.println("selected");%>>상태</option>
					<option value="정보" <%if(searchType.equals("정보")) out.println("selected");%>>정보</option>
				</select>
				<input type="text" name="search" class="form-control" <% if(!search.equals("")) out.println("value="+ search); else out.println("placeholder=\"내용을 입력하세요\""); %>>
				<button type="submit" class="form-control btn btn-primary">검색</button>
			
		</form>
	
	
		<div class="row">
			<table class="table table-striped" style ="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeee; text-align: center;">물품 이름</th>
						<th style="background-color: #eeeee; text-align: center;">담당관리자</th>
						<th style="background-color: #eeeee; text-align: center;">담당운반자</th>
						<th style="background-color: #eeeee; text-align: center;">출발지</th>
						<th style="background-color: #eeeee; text-align: center;">도착지</th>
						<th style="background-color: #eeeee; text-align: center;">실시간온도</th>
						<th style="background-color: #eeeee; text-align: center;">실시간위치</th>
						<th style="background-color: #eeeee; text-align: center;">상세정보</th>
					</tr>
				</thead>
				

			<%
			Class.forName("com.mysql.cj.jdbc.Driver");
			String dbUrl="jdbc:mysql://logismart.cafe24.com/logismart?characterEncoding=UTF-8&serverTimezone=UTC";
			String dbUser="logismart";
			String dbpass="Logi2017253012";
			Connection con=DriverManager.getConnection(dbUrl, dbUser, dbpass);
			String sql="select * from managebbs LEFT OUTER JOIN temper ON bbs_num = t_id JOIN locate ON bbs_num = l_id ";
			PreparedStatement pstmt=con.prepareStatement(sql);
			ResultSet rs=pstmt.executeQuery();
			%>
			<%
				
			%>	
			
			
			<%
			while(rs.next()){
			%>
			<tr>
			<td><%=rs.getInt("bbs_num")%> </td>
			<td><%=rs.getString("bbs_name")%></td>
			<td><%=rs.getString("bbs_manager")%> </td>
			<td><%=rs.getString("bbs_start")%> </td>
			<td><%=rs.getString("bbs_arrival")%> </td>
			<td><%=rs.getInt("t_data")%> </td>
			<td><a href="LocateView.jsp?bbs_num=<%=rs.getInt("bbs_num")%>" class="btn btn-primary pull-center" style="text-align: center">위치</a></td>
			<td><a href="DetailView.jsp?bbs_num=<%=rs.getInt("bbs_num")%>" class="btn btn-primary pull-center" style="text-align: center">상세보기</a></td>
			<%
			}
			%>
					

</body>
</html>