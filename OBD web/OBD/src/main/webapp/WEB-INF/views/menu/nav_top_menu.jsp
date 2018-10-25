<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<div style="float:left;">
	<h1 style="margin-bottom:0; margin-top:0;"> Main Title(log info) </h1>
</div>

<ul class="nav navbar-nav navbar-right">			
	<c:choose>
		<c:when test= "${sessionScope.account.user_id == null }">
			<li><a href="<c:url value='/'/>" > <i class="fas fa-sign-out-alt fa-lg"></i> 로그인 </a></li>	
		</c:when>
		<c:otherwise>
			<li><a href="<c:url value='/log_out.do'/>" > <i class="fas fa-sign-out-alt fa-lg"></i> 로그아웃 </a></li>
		</c:otherwise>
	</c:choose>					
	
</ul>
   