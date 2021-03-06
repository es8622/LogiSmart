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
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int bbs_num = 0;
		if(request.getParameter("bbs_num") != null){
			bbs_num = Integer.parseInt(request.getParameter("bbs_num"));
		}
		ManageBbs managebbs = new ManageBbsDAO().getmanageBbs(bbs_num);
		
		int l_id = 0;
		if(request.getParameter("l_id") != null){
			l_id = Integer.parseInt(request.getParameter("l_id"));
		}
		Locate locate = new LocateDAO().getLocate(managebbs.getBbs_carrierID());
		
		int t_id = 0;
		if(request.getParameter("t_id") != null){
			t_id = Integer.parseInt(request.getParameter("t_id"));
		}
		Temper temper = new TemperDAO().getTemper(managebbs.getBbs_carrierID());
	
		int b_carrier = 0;
		if(request.getParameter("b_carrier") != null){
			b_carrier = Integer.parseInt(request.getParameter("b_carrier"));
		}
	
		Bluetooth bluetooth = new BluetoothDAO().getBluetooth(managebbs.getBbs_carrierID());
		
		int c_id = 0;
		if(request.getParameter("c_id") != null){
			c_id = Integer.parseInt(request.getParameter("c_id"));
		}
		Carriers carriers = new CarriersDAO().getCarriers(managebbs.getBbs_carrierID());	

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
	 	<li><a href="manage_Accept.jsp">????????????</a></li>
	 	<li><a href="manage_bbs.jsp">????????????</a></li>
	 	<li><a href="manage_manager.jsp">???????????????</a></li>
	 	<li><a href="manage_carrier.jsp">???????????????</a></li>
	 	</ul>
	 	<%
	 		if(userID == null){
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
	 				aria-expanded="false">???????????????<span class="caret"></span></a>
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
		<form method="post" action="writeAction.jsp">
			<table class="table table-striped" style ="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
					<th colspan="3" style="background-color: #eeeee; text-align: center;"><a href="LocateView.jsp?bbs_num=<%=managebbs.getBbs_num()%>" class="btn btn-primary pull-center" style="text-align: center">????????????</a></th>
					</tr>
					<tr>
						<th colspan="3" style="background-color: #eeeee; text-align: center;">????????? ?????? ?????? ??????</th>
					</tr>
				</thead>
				<tbody>
	      			<tr>
						<td style="width: 20%;">??????</td>
						<td colspan="2"><%= managebbs.getBbs_num() %></td>
					</tr>
					<tr>
						<td style="width: 20%;">?????? ??????</td>
						<td colspan="2"><%= managebbs.getBbs_name() %></td>
					</tr>
					<tr>
						<td style="width: 20%;">?????? ?????????</td>
						<td colspan="2"><%= carriers.getC_name() %></td>
					</tr>
				   	<tr>
						<td style="width: 20%;">????????? ??????</td>
						<td colspan="2"><%=temper.getT_data() %></td>
					</tr>
					<tr>
						<td style="width: 20%;">?????? ???????????? ??????</td>
						<td colspan="2"><%=temper.getT_time() %></td>
					</tr>
					<td>????????? ??????</td>
					<td colspan="10">
					<div id="map" style="width:100%;height:300px;"></div>
				    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3e715328006c2c7c0960654959d990d9"></script>
				    <script>
				        var mapContainer = document.getElementById('map'), // ????????? ????????? div  
				            mapOption = {
				                center: new kakao.maps.LatLng(<%=locate.getL_wido() %>,<%=  locate.getL_gyeongdo()%>), // ????????? ????????????
				                level: 6 // ????????? ?????? ??????
				            };
				        var map = new kakao.maps.Map(mapContainer, mapOption); // ????????? ???????????????
				        // ????????? ????????? ????????? ????????? ?????? ???????????????
				        const locations = [
				            { place:"????????????", lat:<%=locate.getL_wido() %>, lng: <%=  locate.getL_gyeongdo()%>}	      
				        ];
				
				        for (var i = 0; i < locations.length; i++) {
				            var marker = new kakao.maps.Marker({
				                map: map,
				                position: new kakao.maps.LatLng(locations[i].lat, locations[i].lng)
				            });
				        }
				    </script>	
				    <tr>
						<td style="width: 20%;">?????? ???????????? ??????</td>
						<td colspan="2"><%= locate.getL_time() %></td>
					</tr>
				</tbody>
			</table>
			<a href="manage_bbs.jsp" class="btn btn-primary">??????</a>
				<input type="submit" class="btn btn-primary pull-right" value="????????????">
		</form>
		</div>
	</div>
</body>
</html>