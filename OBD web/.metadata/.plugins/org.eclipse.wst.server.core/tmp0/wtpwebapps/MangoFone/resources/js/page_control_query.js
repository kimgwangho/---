$(function() {

	$(document).on('click', '#previous_page', function() {
		var sel_page;
		var add_line ="";
		
		sel_page = $("#sel_page").val();
		if(sel_page < 10) {
			return;
		}
		
		sel_page = Number(sel_page) - 10;
		$("#sel_page").val(sel_page);
		$("#page_count").empty();
		
		var start_num = (sel_page * 10) - 10;	// 10page 씩 보여주기 때문에..
		
		for(index = 0; index < 10; index++) {
			add_line += '<a href="#" name="page_' + (index + start_num + 1) + '"> [' + (index + start_num + 1) + '] </a>';
    	}
    	
    	$('#page_count').append(add_line);
	});
	
	$(document).on('click', '#next_page', function() {
		var sel_page;
		var add_line = "";
		var for_count;
		var tot_page_count;
		
		tot_page_count = $("#tot_page_count").val();
		sel_page = $("#sel_page").val();
		sel_page = Number(sel_page) + 10;
		
		if(sel_page > tot_page_count) {
			return;
		} else {
			$("#sel_page").val(sel_page);						
		}
		
		// 페이지의 내용을 삭제한다.
		$("#page_count").empty();
		
		if( tot_page_count < sel_page ) {
			for_count = 10;
		} else {
			for_count = tot_page_count - (sel_page - 1);
		}
		
		for(index = 0; index < for_count; index++) {
			add_line += '<a href="#" name="page_' + (index + sel_page) + '"> [' + (index + sel_page) + '] </a>';
    	}
    	
    	$('#page_count').append(add_line);
	});
	
});

function add_table_td_count()
{
	var lengh = $('#list_table > tbody tr').length;
	for(index=0; index<lengh; index++)
	{
		$('#list_table > tbody tr:eq('+index+') td:eq(0)').html(index + 1);
	}
}

function ShowPageCount(count){
	var show_page_count;
	var tot_page_count;
	var view_count;
	var add_line = "";
	
	view_count = $("#view_count").val();
	// 전체 페이지를 가져온다.
	tot_page_count = Math.ceil(count / view_count);
	// 전체 페이지를 입력한다.
	$("#tot_page_count").val(tot_page_count);
	
	// 화면에 보여지는 페이지 count를 가져온다.
	if(tot_page_count > 10) {
		show_page_count = 10;
	} else {
		show_page_count = tot_page_count; 
	}
	
	// 라인을 추가한다.
	for(index = 0; index < show_page_count; index++) {
		add_line += '<a href="#" name="page_' + (index + 1) + '"> [' + (index + 1) + '] </a>';
	}
	
	$("#page_count").empty();
	$('#page_count').append(add_line);
}