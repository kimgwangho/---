<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<title>Home</title>
	<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		
	<script type="text/javascript">	
		$(document).ready(function(){
			
			$.ajax({
		        url : "<c:url value='/select_account.json'/>",
		        //url : "<c:url value='/insert_account_info.json'/>",
		        type: 'post',
		        dataType: 'json',
		        contentType: "application/json; charset=UTF-8",
		        //data: JSON.stringify(insert_jquery),
		        error : function() {
		        	alert("json-error");
		        },
		        success : function(response) {
		        	var add_line;
		        	
		        	for(var i =0; i < response.length; i++){
        		
		        		add_line = '<tr>' +
							'<td>' + response[i].user_id + '</td>' +
							'<td>' + response[i].pwd + '</td>' +
							'<td>' + response[i].name + '</td>' +
							'<td>' + response[i].hp_num + '</td>' +
						'</tr>';
						
						$('table > tbody:last').append(add_line);
					}
		        	
				}
			});
			
			$('#push').on('click', function() {
				var message;
				var text_area;
				var text_title;
				
				text_title = $("#push_title").val();
				text_area = $("#push_message").val();
				message = {"title":text_title, "msg":text_area};
				
				
				$.ajax({
			        url : "<c:url value='/push_test.json'/>",
			        type: 'post',
			        dataType: 'json',
			        contentType: "application/json; charset=UTF-8",
			        data: JSON.stringify(message),
			        error : function() {
			        	alert("json-error");
			        },
			        success : function(response) {
			        	alert("전송성공");			        	
					}
				});
				
			});
		});
	</script>	
		
</head>
<body>
	<table border=1px;>
		<thead>
			<tr role="row">
				<th>사용자 아이디</th>
				<th>비번</th>
				<th>권한</th>
				<th>이름</th>
				<th>휴대전화번호</th>
				<th>push_id</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	
	Push Message
	<br/>
	<input type = "text" id="push_title" value = "title">
	<br/>	
	<textarea rows="10" cols="50" id="push_message"></textarea>
	<button class="" onclick="" id="push">push</button>

</body>
</html>
