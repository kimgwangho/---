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
		<script src="${pageContext.request.contextPath}/resources/js/fontawesome-all.js"></script>
		<!-- jquery 설정 -->
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/calendar_control_query.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/page_control_query.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/order_control_query.js" charset="utf-8"></script>

		<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		<script src="//code.jquery.com/jquery.min.js"></script>
		<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

			
		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		
			
		<title>메시지 발송</title>
		
		<script type="text/javascript">	
			$(document).ready(function(){				
				ShowSendMessageList(1);
				ShowPageList();
			
				function ShowPageList() {
					var search_start_time;
					var search_end_time;
					var search_name;
					var search_order_type;
					var search_prdct_code;
					var search_open_ready;
					
					search_start_time = $("#start_datepicker").val();
					search_end_time = $("#end_datepicker").val();
					search_name = $("#search_name").val();
					search_order_type = $("#search_order_type").val();
					search_prdct_code = $("#search_prdct_code").val();
					search_open_ready = $("#search_open_ready").val();
					
					list_count = {"name":search_name, "start_datepicker":search_start_time, "end_datepicker":search_end_time
							, "order_type":search_order_type, "prdct_code":search_prdct_code, "open_ready":search_open_ready};
					$.ajax({
				        url : "<c:url value='/select_send_message_list_count.json'/>",
				        type: 'post',
				        dataType: 'json',
				        data: list_count,
				        error : function() {
				        	alert("json-error");
				        },
				        success : function(count) {
				        	ShowPageCount(count);
						} 
					});
					
				}
				
				function ShowSendMessageList(page) {
					var list_count;
					var start;
					var view_count;
					var search_start_time;
					var search_end_time;
					var search_name;
					var search_order_type;
					var search_prdct_code;
					var search_open_ready;
					
					search_start_time = $("#start_datepicker").val();
					search_end_time = $("#end_datepicker").val();
					search_name = $("#search_name").val();
					search_order_type = $("#search_order_type").val();
					search_prdct_code = $("#search_prdct_code").val();
					search_open_ready = $("#search_open_ready").val();
					
					view_count = $("#view_count").val();
					start = page == 1? 1: ((page - 1) * view_count) + 1;
					list_count = {"start":(start - 1), "end":(view_count), "name":search_name
							,"start_datepicker":search_start_time, "end_datepicker":search_end_time
							,  "order_type":search_order_type, "prdct_code":search_prdct_code
							, "open_ready":search_open_ready};
															
					$.ajax({
				        url : "<c:url value='/select_send_message_list.json'/>",
				        type: 'post',
				        dataType: 'json',
				        data: list_count,
				        error : function() {
				        	alert("json-error");
				        },
				        success : function(response) {
				        	var add_line;
				
				        	$('table > tbody').empty();
				        	
				        	for(var i =0; i < response.length; i++){
											
				        		add_line = '<tr>' +
									'<td></td>' +
									'<td>' + (response[i].name == null?"":response[i].name) + '</td>' +
									'<td>' + (response[i].user_id == null?"":response[i].user_id) + '</td>' +
									'<td>' + (response[i].hp_num == null?"":response[i].hp_num) + '</td>' +
									'<td>' + (response[i].order_time == null?"":response[i].order_time) + '</td>' +
									'<td>' + (response[i].order_type == '1'?"외부":"앱") + '</td>' +
									'<td>' + (response[i].prdct_code == null?"":response[i].prdct_code) + '</td>' +
									'<td>' + (response[i].data == null?"":response[i].data) + '</td>' +
									'<td>' + (response[i].sms == null?"":response[i].sms) + '</td>' +
									'<td>' + (response[i].tel == null?"":response[i].tel) + '</td>' +
									'<td>' + (response[i].price == null?"":response[i].price) + '</td>' +
									'<td>' + (response[i].desc == null?"":response[i].desc) + '</td>' +
									'<td>' + (response[i].open_ready == null?"":response[i].open_ready) + '</td>' +
									'<td> <button class="" name="btn_send" onclick="">전송</button> </td>' +									
								'</tr>';
								
				        		$('#list_table > tbody:last').append(add_line);
							}
				        	add_table_td_count();
						} 
					});
				}
				
				$(document).on('click', 'a[name*=page_]', function() {
					var name_by_id = $(this).attr('name');
					var show_page_index;
					
					show_page_index = name_by_id.replace("page_", "");

					// list를 호출한다.
					ShowSendMessageList(show_page_index);
				});
				
				
				$(document).on('click', '#search_btn', function() {
					var name;
					var pay_yn;
					var finish_yn;
					var order_type;
					var open_ready;
					
					// 검색 데이터를 가져온다.
					name = $("#name").val();
					pay_yn = $("#pay_yn").val();
					finish_yn = $("#finish_yn").val();
					order_type = $("#order_type").val();
					open_ready = $("#open_ready").val();
					
					// 검색 데이터를 입력한다.
					$("#search_name").val(name);
					$("#search_pay_yn").val(pay_yn);
					$("#search_finish_yn").val(finish_yn);
					$("#search_order_type").val(order_type);
					$("#search_open_ready").val(open_ready);
					
					ShowSendMessageList(1);
					ShowPageList();
				});
				
				$(document).on('click', 'button[name=btn_send]', function() {
					var param;
					var check_btn = $(this);
					var tr = check_btn.parent().parent();
					var td = tr.children();
					var name = td.eq(1).text();
					var user_id = td.eq(2).text();
					var ph_num = td.eq(3).text();
					var send_phone_num = $("#send_phone_num").val();
					var push_message = $("#push_message").val();

					param = {"user_id":user_id, "ph_num":ph_num, "name":name, "send_phone_num":send_phone_num, "push_message":push_message};
													
					var answer = confirm(name + "님에게 메시지를 보내겠습니까?")
					if(!answer) {
						return;
					}
					
					$.ajax({
				        url : "<c:url value='/push_send_message.json'/>",
				        type: 'post',
				        dataType: 'json',
				        data: param,
				        error : function() {
				        	alert("json-error");
				        },
				        success : function(response) {
				        	if(response["result"] == 0) {
				        		alert("문자를 발송하였습니다.");
				        	} else {
				        		alert("문자 발송에 실패했습니다.")
				        	} // if
						} // success : function
					}); // $.ajax
					
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
			
			<div id="content" class="right_col"> 
				<div style="margin-bottom:1%">
					<!-- 신청인 검색 -->
					신청인 <input type="text" id="name" style="width:100px;"/>
					
					<!-- 주문날짜 검색 -->
					주문 날짜 <input type="text" id="start_datepicker"  style="width:100px;"> ~ <input type="text" id="end_datepicker"  style="width:100px;">
					
					<!-- 주문 검색 -->
					주문 
					<select id = "order_type" name = "">
						<option value = "">---</option>
						<option value = "1">외부</option>
						<option value = "2">앱</option>
					</select>  
					<!-- 주문 검색 -->
					개통 
					<select id = "open_ready" name = "">
						<option value = "">---</option>
						<option value = "Y">개통</option>
						<option value = "N">대기</option>
					</select>
					<button class="" id="search_btn" onclick="">검색</button>
				</div>	
				
				<div style="margin-top:20px;"></div>
				
				Push Message
				<br/>
				<input type = "text" id="send_phone_num" placeholder="수신번호" value="">
				<br/>
				<textarea rows="5" cols="50" id="push_message" placeholder="메시지"></textarea>
				<br/>

				<div style="margin-top:20px;"></div>
				
				<section class="content">
					<table class="table table-striped table-bordered table-hover no-footer dtr-inline collapsed" style="width:99%;" id="list_table">
						<thead>
							<tr role="row">
								<th>번호</th>
								<th>신청인</th>
								<th>사용자 아이디</th>
								<th>전화번호</th>
								<th>주문시간</th>
								<th>주문</th>
								<th>상품코드</th>
								<th>데이터</th>
								<th>문자</th>
								<th>전화</th>
								<th>가격</th>
								<th>설명</th>
								<th>계통</th>
								<th>발송</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div style="display:inline;"><a href="#" id="previous_page"><i class="fas fa-caret-left fa-lg"></i></a></div>
					&nbsp; <div id="page_count" style="display:inline;"></div> &nbsp;
					<div style="display:inline;"><a href="#" id="next_page"><i class="fas fa-caret-right fa-lg"></i></a></div>
					<!-- paging 정보 -->
					<input type="hidden" id="view_count" value="10">
					<input type="hidden" id="sel_page" value="1">
					<input type="hidden" id="tot_page_count" value="">	
					<!-- 검색 조건 정보 -->
					<input type="hidden" id="search_name" value="">
					<input type="hidden" id="search_order_type" value="">
					<input type="hidden" id="search_prdct_code" value="">		
					<input type="hidden" id="search_open_ready" value="">				
				</section>					
			</div>
			
			<div id="footer" style="background-color:#FFA500;clear:both;">
			@ Mango
			</div>
		</div>
	</body>
	
</html>