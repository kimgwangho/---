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
		
		<title>사용자</title>
		
		<script type="text/javascript">	
			$(document).ready(function(){				
				ShowAccountList(1);
				ShowPageList();

				function ShowAccountList(page) {
					var param;
					var start;
					var view_count;
					var search_user_id;
					var search_auth;
					var search_name;
					var search_hp_num;
					
					search_user_id = $("#user_id").val();
					search_auth = $("#auth").val();
					search_name = $("#name").val();
					search_hp_num = $("#hp_num").val();
					
					view_count = $("#view_count").val();
					start = page == 1? 1: ((page - 1) * view_count) + 1;
					param = {"start":(start - 1), "end":(view_count), "user_id":search_user_id
							,"auth":search_auth, "name":search_name
							,  "hp_num":search_hp_num};
															
					$.ajax({
				        url : "<c:url value='/select_account_info_list.json'/>",
				        type: 'get',
				        dataType: 'json',
				        data: param,
				        error : function() {
				        	alert("json-error");
				        },
				        success : function(response) {
				        	var add_line;
				
				        	$('#list_table > tbody').empty();
				        	
				        	for(var i =0; i < response.length; i++){
											
				        		add_line = '<tr>' +
									'<td></td>' +
									'<td>' + (response[i].user_id == null?"":response[i].user_id) + '</td>' +
									'<td>' + (response[i].pwd == null?"":response[i].pwd) + '</td>' +
									'<td>' + (response[i].auth == null?"":response[i].auth) + '</td>' +
									'<td>' + (response[i].name == null?"":response[i].name) + '</td>' +
									'<td>' + (response[i].hp_num == null?"":response[i].hp_num) + '</td>' +
									'<td>' +
										'<button class="btn btn-primary btn-error btn-xs" name="btn_del_item" onclick="">삭제</button>' +
									'</td>'
								'</tr>';
								
				        		$('#list_table > tbody:last').append(add_line);
							}
				        	add_table_td_count();
						} 
					});
				}
				
				function ShowPageList() {
					var param;
					var search_user_id;
					var search_auth;
					var search_name;
					var search_hp_num;
					
					search_user_id = $("#user_id").val();
					search_auth = $("#auth").val();
					search_name = $("#name").val();
					search_hp_num = $("#hp_num").val();
					
					param = {"user_id":search_user_id, "auth":search_auth, "name":search_name
							, "hp_num":search_hp_num};
					$.ajax({
				        url : "<c:url value='/select_account_info_list_count.json'/>",
				        type: 'get',
				        dataType: 'json',
				        data: param,
				        error : function() {
				        	alert("json-error");
				        },
				        success : function(count) {
				        	ShowPageCount(count);
						} 
					});
				}
				
				$(document).on('click', 'a[name*=page_]', function() {
					var name_by_id = $(this).attr('name');
					var show_page_index;
					
					show_page_index = name_by_id.replace("page_", "");

					// list를 호출한다.
					ShowAccountList(show_page_index);
				});
				
				$(document).on('click', '#search_btn', function() {
					var user_id;
					var auth;
					var name;
					var hp_num;
					
					// 검색 데이터를 가져온다.
					user_id = $("#user_id").val();
					auth = $("#auth").val();
					name = $("#name").val();
					hp_num = $("#hp_num").val();
					
					// 검색 데이터를 입력한다.
					$("#search_user_id").val(user_id);
					$("#search_auth").val(auth);
					$("#search_name").val(name);
					$("#search_hp_num").val(hp_num);
					
					ShowAccountList(1);
					ShowPageList();
				});
				
				$(document).on('click', '#apply_btn', function() {
					var answer = confirm("사용자를 등록 하시겠습니까?")
					if(!answer) {
						return;
					}
					
					var param;
					var input_user_id;
					var input_pwd;
					var input_auth;
					var input_name;
					var input_hp_num;
					
					input_user_id = $("#input_user_id").val();
					input_pwd = $("#input_pwd").val();
					input_auth = $(":input:radio[name=input_auth]:checked").val();
					input_name = $("#input_name").val();
					input_hp_num = $("#input_hp_num").val();
					
					param = {"user_id":input_user_id, "pwd": input_pwd, "auth":input_auth, "name":input_name
							, "hp_num":input_hp_num};
					$.ajax({
				        url : "<c:url value='/insert_account_info.json'/>",
				        type: 'get',
				        dataType: 'json',
				        data: param,
				        error : function() {
				        	alert("json-error");
				        },
				        success : function(response) {
				        	if( response["result"] == -1) {
				        		alert("데이터를 확인할 수 없습니다. id를 확인해 주세요.");
				        		return;
				        	}
							ShowAccountList(1);
							ShowPageList();
						} 
					});
				});
				
				// 삭제 버튼 클릭
				$(document).on('click', 'button[name=btn_del_item]', function() {
					var answer = confirm("데이터를 삭제 하시겠습니까?")
					if(!answer) {
						return;
					}
					
					var check_btn = $(this);
					
					var tr = check_btn.parent().parent();
					var td = tr.children();
					var user_id = td.eq(1).text();
							
					var param = {"user_id":user_id};

					// 입력된 데이터를 DB에 저장한다.
					$.ajax({
				        url : "<c:url value='/delete_account_info.json'/>",
				        type: 'get',
				        dataType: 'json',
				        data: param,
				        error : function() {
				        	alert("데이터를 삭제할 수 없습니다.");
				        },
				        success : function(response) {							
				        	if( response["result"] == -1) {
				        		alert("데이터를 삭제할수 없습니다.");
				        		return;
				        	}
							ShowAccountList(1);
							ShowPageList();
						}
					});
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
					<table>
						<tr>
							<td style="width:100px;">사용자 아이디</td>
							<td><input name="input_user_id" class="form-control" id="input_user_id" autofocus="" required="" type="text" placeholder="사용자 아이디" value="" style="width:200px; display:inline;"/></td>

							<td style="width:100px;">비밀번호</td>
							<td><input name="input_pwd" class="form-control" id="input_pwd" autofocus="" required="" type="text" placeholder="비밀번호" value="" style="width:200px; display:inline;"/></td>
							
							<td style="width:100px;">권한</td>
							<td>
								<input type="radio" id="" name="input_auth" value="0" checked>
    								<label for="contactChoice1">사용자</label>
								<input type="radio" id="" name="input_auth" value="1">
    								<label for="contactChoice2">관리자</label>  
							</td>
						</tr>					
						<tr>
							<td style="width:100px;">이름</td>
							<td><input name="input_name" class="form-control" id="input_name" autofocus="" required="" type="text" placeholder="이름" value="" style="width:200px; display:inline;"/></td>

							<td style="width:100px;">휴대전화</td>
							<td><input name="input_hp_num" class="form-control" id="input_hp_num" autofocus="" required="" type="text" placeholder="휴대전화" value="" style="width:200px; display:inline;"/></td>
						</tr>
					</table>
					<button class="" onclick="" id="apply_btn">등록</button>
					
					<div style="margin-top:20px;"></div>

					사용자 아이디 <input type="text" id="user_id" style="width:100px;"/>
					이름<input type="text" id="name" style="width:100px;"/>
					전화번호<input type="text" id="hp_num" style="width:100px;"/>
					권한 
					<select id = "auth" name = "">
						<option value = "">---</option>
						<option value = "0">사용자</option>
						<option value = "1">관리자</option>
					</select>  
					
					<button class="" id="search_btn" onclick="">검색</button>
					
					<div style="margin-top:20px;"></div>
					
					<section class="content">
						<table class="table table-striped table-bordered table-hover no-footer dtr-inline collapsed" style="width:99%;" id="list_table">
							<thead>
								<tr role="row">
									<th>번호</th>
									<th>사용자 아이디</th>
									<th>비번</th>
									<th>권한</th>
									<th>이름</th>
									<th>휴대전화번호</th>
									<th>관리</th>
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
						<input type="hidden" id="search_user_id" value="">
						<input type="hidden" id="search_name" value="">
						<input type="hidden" id="search_hp_num" value="">		
						<input type="hidden" id="search_auth" value="">
					</section>
					
				</div>
			</div>
			
			<div id="footer" style="background-color:#FFA500;clear:both;">
			@ Mango
			</div>
		</div>
	</body>
	
</html>