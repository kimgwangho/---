<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<li>
	<a href="#">주문</a>
	<ul>
		<li><a href="<c:url value='/outside_order_page.do'/>">외부주문 입력</a></li>
		<li><a href="<c:url value='/order_list_page.do'/>">주문리스트</a></li>
		<li><a href="<c:url value='/pay_complete_page.do'/>">결제 완료</a></li>
		<li><a href="<c:url value='/finish_complete_page.do'/>">처리 완료</a></li>
	</ul>
<li>

<li>
	<a href="#">회원관리</a>
	<ul>
		<li><a href="<c:url value='/send_message_page.do'/>">메시지 발송</a></li>
		<li><a href="<c:url value='/account_n_order_manager_page.do'/>">회원 및 주문관리</a></li>
	</ul>
<li>

<li>
	<a href="#">게시판</a>
	<ul>
		<li><a href="#">공지사항</a></li>
		<li><a href="#">사용설명서</a></li>
		<li><a href="#">FAQ</a></li>
		<li><a href="#">QNA</a></li>
	</ul>
<li>

<li>
	<a href="#">설정</a>
	<ul>
		<li><a href="#">잔액조회코드</a></li>
		<li><a href="#">상품코드</a></li>
		<li><a href="<c:url value='/user_page.do'/>">사용자</a></li>
	</ul>
<li>