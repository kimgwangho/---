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
		
			
		<title>결제완료</title>
		
		<script type="text/javascript">	
			$(document).ready(function(){				
				ShowOrderList(1);
				ShowPageList();
				
				function ShowPageList() {
					var search_start_time;
					var search_end_time;
					var search_name;
					var search_pay_yn;
					var search_finish_yn;
					var search_order_type;
					
					search_start_time = $("#start_datepicker").val();
					search_end_time = $("#end_datepicker").val();
					search_name = $("#search_name").val();
					search_pay_yn = $("#search_pay_yn").val();
					search_finish_yn = $("#search_finish_yn").val();
					search_order_type = $("#search_order_type").val();
					
					list_count = {"name":search_name, "pay_yn":search_pay_yn, "finish_yn":search_finish_yn
							, "order_start_time":search_start_time, "order_end_time":search_end_time, "order_type":search_order_type};
					
					$.ajax({
				        url : "<c:url value='/select_order_list_count.json'/>",
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
				
				function ShowOrderList(page) {
					var list_count;
					var start;
					var view_count;
					var search_start_time;
					var search_end_time;
					var search_name;
					var search_pay_yn;
					var search_finish_yn;
					var search_order_type;
					
					search_start_time = $("#start_datepicker").val();
					search_end_time = $("#end_datepicker").val();
					search_name = $("#search_name").val();
					search_pay_yn = $("#search_pay_yn").val();
					search_finish_yn = $("#search_finish_yn").val();
					search_order_type = $("#search_order_type").val();
					
					view_count = $("#view_count").val();
					start = page == 1? 1: ((page - 1) * view_count) + 1;
					list_count = {"start":(start - 1), "end":(view_count), "name":search_name
							, "pay_yn":search_pay_yn, "finish_yn":search_finish_yn
							, "order_start_time":search_start_time, "order_end_time":search_end_time,"order_type":search_order_type};
															
					$.ajax({
				        url : "<c:url value='/select_order_list.json'/>",
				        type: 'post',
				        dataType: 'json',
				        data: list_count,
				        error : function() {
				        	alert("json-error");
				        },
				        success : function(response) {
				        	var add_line;
				        	var pay_yn;
				        	var finish_yn;
				        				    
				        	$('table > tbody').empty();
				        	
				        	for(var i =0; i < response.length; i++){
								if(response[i].pay_yn == 'y') {
									pay_yn = '<td style="color:blue">완료</td>'
								} else if(response[i].pay_yn == 'n') {
									pay_yn = '<td style="color:red">대기</td>'
								} else {
									pay_yn = '<td style="color:red">' + response[i].pay_yn + '</td>'
								}
								
				        		add_line = '<tr>' +
									'<td></td>' +
									'<td>' + response[i].order_no + '</td>' +
									'<td>' + (response[i].prdct_code == null?"":response[i].prdct_code) + '</td>' +
									'<td>' + (response[i].name == null?"":response[i].name) + '</td>' +
									'<td>' + (response[i].order_time == null?"":response[i].order_time) + '</td>' +
									'<td>' + (response[i].order_type == '1'?'외부':'앱') + '</td>' +
									'<td>' + (response[i].open_ready == null?"":response[i].open_ready) + '</td>' +
									pay_yn +
								'</tr>';
								
								//$('table > tbody:last').append(add_line);
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
					ShowOrderList(show_page_index);
				});
				
				
				$(document).on('click', '#search_btn', function() {
					var name;
					var pay_yn;
					var finish_yn;
					var order_type;
					
					// 검색 데이터를 가져온다.
					name = $("#name").val();
					pay_yn = $("#pay_yn").val();
					finish_yn = $("#finish_yn").val();
					order_type = $("#order_type").val();
					
					// 검색 데이터를 입력한다.
					$("#search_name").val(name);
					$("#search_pay_yn").val(pay_yn);
					$("#search_finish_yn").val(finish_yn);
					$("#search_order_type").val(order_type);
					
					ShowOrderList(1);
					ShowPageList();
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
					<!-- 결제여부 검색 -->
					결제여부 
					<select id = "pay_yn" name = "">
						<option value = "">---</option>
						<option value = "Y">완료</option>
						<option value = "N">대기</option>
					</select>  
					<button class="" id="search_btn" onclick="">검색</button>
				</div>	
				
				<div style="margin-top:20px;"></div>
				
				<section class="content">
					<table class="table table-striped table-bordered table-hover no-footer dtr-inline collapsed" style="width:99%;" id="list_table">
						<thead>
							<tr role="row">
								<th>번호</th>
								<th>주문번호</th>
								<th>상품코드</th>
								<th>신청인</th>
								<th>주문일</th>
								<th>주문분류</th>
								<th>개통대기</th>
								<th>결제여부</th>
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
					<input type="hidden" id="search_pay_yn" value="">
					<input type="hidden" id="search_finish_yn" value="">
					<input type="hidden" id="search_order_type" value="">						
				</section>					
			</div>
			
			<div id="footer" style="background-color:#FFA500;clear:both;">
			@ Mango
			</div>
		</div>
	</body>
	
</html>