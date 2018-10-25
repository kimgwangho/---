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
		
			
		<title>외부주문입력</title>
		
		<script type="text/javascript">	
			$(document).ready(function(){				
				ShowProductList(1);
				ShowPageList();
				
				$(document).on('click', '#btn_apply', function() {
					var order_type;	// 주문종류(1:외부,2:앱)
					var open_ready;	// 개통대기 (y,n)
					var prdct_code;	// 상품코드
					var name;
					var hp_num;
					var user_id;	// 사용자 아이디
					var date;
					
					order_type = $(":input:radio[name=order_type]:checked").val();
					open_ready = "n";
					prdct_code = $("#prdct_code").val();
					name = $("#name").val();
					hp_num = $("#hp_num").val();
					user_id = $("#user_id").val();
					
					date = {"order_type":order_type, "open_ready":open_ready, "prdct_code":prdct_code
							, "name":name, "hp_num":hp_num, "user_id":user_id};
					
					var answer = confirm("등록을 하시겠습니까?")
					if(!answer) {
						return;
					}

					$.ajax({
				        url : "<c:url value='/insert_order_info.json'/>",
				        type: 'get',
				        dataType: 'json',
				        data: date,
				        error : function() {
				        	alert("json-error");
				        },
				        success : function(response) {
							alert("등록이 완료 되었습니다.");
						} 
					});
				});
				
				function ShowProductList(page) {
					var start;
					var list_count;
					var view_count;

					view_count = $("#view_count").val();
					start = page == 1? 1: ((page - 1) * view_count) + 1;
					list_count = {"start":(start - 1), "end":(view_count)};

					$.ajax({
				        url : "<c:url value='/select_product_list.json'/>",
				        type: 'post',
				        dataType: 'json',
				        data: list_count,
				        error : function() {
				        	alert("json-error");
				        },
				        success : function(response) {
							var add_line;
							$('#list_table > tbody').empty();
							
				        	for(var i =0; i < response.length; i++){
				        		add_line = '<tr>' +
									'<td></td>' +
									'<td>' + response[i].prdct_code + '</td>' +
									'<td>' + response[i].data + '</td>' +
									'<td>' + response[i].sms + '</td>' +
									'<td>' + response[i].tel + '</td>' +
									'<td>' + response[i].price + '</td>' +
									'<td>' + response[i].remain_sch_cd + '</td>' +
									'<td>' + response[i].desc + '</td>' +
									'<td> <button class="" name="btn_select" onclick="">선택</button> </td>' +								
								'</tr>';
				        		$('#list_table > tbody:last').append(add_line);
				        	}
				        	add_table_td_count();
						} 
					});
				}
				
				$(document).on('click', 'button[name=btn_select]', function() {
					var param;
					var check_btn = $(this);
					var tr = check_btn.parent().parent();
					var td = tr.children();
					var prdct_code = td.eq(1).text();

					$("#prdct_code").val(prdct_code);
				});
				
				function add_table_td_count()
				{
					var lengh = $('#list_table > tbody tr').length;
					for(index=0; index<lengh; index++)
					{
						$('#list_table > tbody tr:eq('+index+') td:eq(0)').html(index + 1);
					}
				}
				
				$(document).on('click', 'a[name*=page_]', function() {
					var name_by_id = $(this).attr('name');
					var show_page_index;
					
					show_page_index = name_by_id.replace("page_", "");

					// list를 호출한다.
					ShowProductList(show_page_index);
				});
				
				function ShowPageList() {
					$.ajax({
				        url : "<c:url value='/select_product_list_count.json'/>",
				        type: 'post',
				        dataType: 'json',
				        error : function() {
				        	alert("json-error");
				        },
				        success : function(count) {
				        	ShowPageCount(count)
						} 
					});
				}
				
				
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
					<table>
						<tr>
							<td style="width:100px;">사용자 아이디</td>
							<td><input name="user_id" class="form-control" id="user_id" autofocus="" required="" type="text" placeholder="사용자 아이디" value="" style="width:200px; display:inline;"/></td>
						</tr>					
						<tr>
							<td style="width:100px;">이름</td>
							<td><input name="name" class="form-control" id="name" autofocus="" required="" type="text" placeholder="이름" value="" style="width:200px; display:inline;"/></td>
						</tr>					
						<tr>
							<td style="width:100px;">휴대전화</td>
							<td><input name="hp_num" class="form-control" id="hp_num" autofocus="" required="" type="text" placeholder="휴대전화" value="" style="width:200px; display:inline;"/></td>
						</tr>
						<tr>
							<td style="width:100px;">주문종류</td>
							<td>
								<input type="radio" id="" name="order_type" value="1" checked>
    								<label for="contactChoice1">외부</label>
								<input type="radio" id="" name="order_type" value="2">
    								<label for="contactChoice2">앱</label>
							</td>
						</tr>		
						<tr>
							<td style="width:100px;">상품코드</td>
							<td><input name="prdct_code" class="form-control" id="prdct_code" autofocus="" required="" type="text" placeholder="상품코드" value="" style="width:200px; display:inline;"/></td>
						</tr>					
					</table>
					<button class="" onclick="" id="btn_apply">등록</button>
					
					<div style="margin-top:20px;"></div>
					
					<section class="content">
						<table class="table table-striped table-bordered table-hover no-footer dtr-inline collapsed" style="width:99%;" id="list_table">
							<thead>
								<tr role="row">
									<th>번호</th>
									<th>상품코드</th>
									<th>데이터</th>
									<th>문자</th>
									<th>전화</th>
									<th>가격</th>
									<th>잔액조회코드</th>
									<th>설명</th>
									<th>선택</th>
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
					</section>
					
				</div>
			</div>
			
			<div id="footer" style="background-color:#FFA500;clear:both;">
			@ Mango
			</div>
		</div>
	</body>
	
</html>