<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="manager.Manager" %>
<%@ page import="manager.ManagerDAO" %>
<%@ page import="managebbs.ManageBbs" %>
<%@ page import="managebbs.ManageBbsDAO" %>
<%@ page import="bluetooth.Bluetooth" %>
<%@ page import="bluetooth.BluetoothDAO" %>
<%@ page import="carriers.Carriers" %>
<%@ page import="carriers.CarriersDAO" %>
<%@ page import="locate.Locate" %>
<%@ page import="locate.LocateDAO" %>
<%@ page import="temper.Temper" %>
<%@ page import="temper.TemperDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import ="java.net.URLEncoder" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.DriverManager,
                   java.sql.Connection,
                   java.sql.Statement,
                   java.sql.ResultSet,
                   java.sql.SQLException" %>


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
		int b_num = 0;
		if(request.getParameter("b_num") != null){
			b_num = Integer.parseInt(request.getParameter("b_num"));
		}
		Bluetooth bluetooth = new BluetoothDAO().getBluetooth(b_num);
		int c_id = 0;
		if(request.getParameter("c_id") != null){
			c_id = Integer.parseInt(request.getParameter("c_id"));
		}
		Carriers carriers = new CarriersDAO().getCarriers(c_id);		
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		String m_ID = null;
		if (session.getAttribute("m_ID") != null) {
			m_ID = (String) session.getAttribute("m_ID");
		}
		Manager manager = new ManagerDAO().getmanager(m_ID);
		
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
	 	<li><a href="main.jsp">??????</a></li>
	 	<li class="active"><a href="manage_bluetooth.jsp">????????????</a></li>
	 	<li><a href="manage_Accept.jsp">????????????</a></li>
	 	<li><a href="manage_bbs.jsp">????????????</a></li>
	 	<li><a href="manage_manager.jsp">???????????????</a></li>
	 	<li><a href="manage_carrier.jsp">???????????????</a></li>
	 	</ul>
	 		<%
	 		if(m_ID == null){
	 	%>
	 	<ul class="nav navbar-nav navbar-right">
	 		<li class="dropdown">
	 			<a href="#" class="dropdown-toggle"
	 				data-toggle="dropdown" role="button" aria-haspopup="true"
	 				aria-expanded="false">????????? ????????????<span class="caret"></span></a>
	 			<ul class="dropdown-menu">
	 				<li><a href="login.jsp">?????????</a></li>
	 				<li><a href="join.jsp">???????????????</a></li>
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
	 				aria-expanded="false">"<%=manager.getM_ID() %>" ??? ??? ??? ???<span class="caret"></span></a>
	 			<ul class="dropdown-menu">
	 				<li><a href="logoutAction.jsp">????????????</a></li>
	 			</ul>
	 		</li>
	 	</ul>
		<%
	 		}
		%>
	 </div>
	</nav>
	
	
		<div class = "container">
		<div class="row">
		<form method="post" action="Bt_UpdateAction.jsp?b_num=<%=b_num%>">
			<table class="table table-striped" style ="text-align: center; border: 1px solid #dddddd">
					<tr>
						<th colspan="2" style="background-color: #eeeee; text-align: center;">' <%=b_num%>??? '  ????????????  ?????? -> ????????? ??????</th>
					</tr>
					<tr>
						<td><th style="background-color: #eeeee; text-align: center;">
						<input type="number" class="form-control" placeholder="?????????  ???????????? ????????? ??????????????????." name="b_carrier" maxlength="50" "style ="text-align: center;"  ></th>
						</td>
					</tr>
				<th colspan="3" style="background-color: #eeeee; text-align: center;"><input type="submit" class="btn btn-primary pull-center" style="text-align: center" value="????????????"></th>
			</table>		
		</form>
		</div>
		</div>
		
		<div class = "container">
		<div class="row">
			<table class="table table-striped" style ="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr style="background-color: #eeeee; text-align: center;">
						?????? ????????? ????????? ?????????
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="background-color: #eeeee; text-align: center;">??????</th>
						<td style="background-color: #eeeee; text-align: center;">??????</th>
						<td style="background-color: #eeeee; text-align: center;">????????????</th>
						<td style="background-color: #eeeee; text-align: center;">????????????</th>
					</tr>


			<%
			Class.forName("com.mysql.cj.jdbc.Driver");
			String dbUrl="jdbc:mysql://logismart.cafe24.com/logismart?characterEncoding=UTF-8&serverTimezone=UTC";
			String dbUser="logismart";
			String dbpass="Logi2017253012";
			Connection con=DriverManager.getConnection(dbUrl, dbUser, dbpass);
			String sql="select * from carriers LEFT OUTER JOIN managebbs ON c_id = bbs_carrierID where bbs_carrierID is null";
			PreparedStatement pstmt=con.prepareStatement(sql);
			ResultSet rs=pstmt.executeQuery();
			
			%>	
			
			<%
			while(rs.next()){
			%>	
			<tr>
			<td><%=rs.getInt("c_id")%> </td>
			<td><%=rs.getString("c_name")%> </td>
			<td><%=rs.getString("c_birth")%> </td>
			<td><%=rs.getString("c_phone")%> </td>
			</tr>
			<%
			
			}
			%>
			</tbody>
			</table>
			</div>
			</div>
</tbody>
</body>
</html>