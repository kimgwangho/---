<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<!-- 반응형 웹 설정 -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum=1.0, minimum-scale=1.0, user-scalable=no"/>
		<!-- css 정의 -->
		<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" />		
		<link href="${pageContext.request.contextPath}/resources/css/main.style.css" rel="stylesheet" />		
		<script defer src="${pageContext.request.contextPath}/resources/js/fontawesome-all.js"></script>
		<!-- jquery 설정 -->
		<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		
		<title>Mangofone</title>
		
		<script type="text/javascript">	
			$(document).ready(function(){
				$('#login_btn').on('click', function() {					
					document.loginfrm.action="loginform.do"
					document.loginfrm.submit();
				});
				
				/* 브라우저의 화면의 크기를 확인한다.*/
				$(".right_col").css("min-height", window.innerHeight);
			});
		</script>	
	</head>
	
	<body>
		<div id="container" style="width:100%">
			<div id="header" class="top_nav_menu">
				<%@ include file="menu/nav_top_menu.jsp" %>
			</div>
			
			<div id="menu" class="left_nav_menu">
				<%@ include file="menu/nav_left_menu.jsp" %>
			</div>
			
			<div id="content" class="right_col" role="main"> 
				<div class="login_wrapper" style="">
					<section class="login_content">
						<form id="loginfrm" name="loginfrm" role="form" method="post">
							<h1 style="text-align:center;">Login</h1>
							<div>
								<input name="user_id" class="form-control" id="user_id" autofocus="" required="" type="text" placeholder="아이디" value="" />
							</div>
							<div>
								<input name="pwd" class="form-control" id="pwd" required="" type="password" placeholder="비밀번호" value="" />
							</div>
							<div style="text-align:right">
								<input class="btn btn-default submit" type="submit" id="login_btn" value="로그인" />
							</div>
						</form>
					</section>
				</div>
			</div>
			
			<div id="footer" style="background-color:#FFA500;clear:both;">
			@ Mango
			</div>
		</div>
	</body>
	
</html>