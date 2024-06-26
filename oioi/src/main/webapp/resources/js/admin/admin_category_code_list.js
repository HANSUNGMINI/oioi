// 컬럼 헤더 
const columns = [
    {header: '코드', name: 'CTG_CODE', editor : 'text'},
    {header: '내용', name: 'CTG_NAME', editor : 'text'},
    {header: '사용여부', name: 'CTG_HIDE'
    		, renderer: {
			  	type: category_toggle
    		  },
    },
]

// 조회할 테이블
const table = "category";


function search(type = 'T', disabled = true) {
	if(type ===''){
		alert("대분류를 선택하라고");
		return;
	}

	$.ajax({
		type : "GET",
		url : "List",
		data : {
			"table" : table,
			"type" : type,
		},
		dataType : "JSON",
		success : function (response) {
			$("#grid").empty();
			
			const gridData = []
			
				
			for (let item of response){
				gridData.push(item);
			}
			
		    const grid = new tui.Grid({
			    el: document.getElementById('grid'),
			    data: gridData,
			    scrollX: false,
			    scrollY: false,
			    columns: columns,
			    rowHeaders: ['rowNum'],
			    pageOptions: {
		           useClient: true,
		           perPage: itemsPerPage
		        },
		        minBodyHeight : '0',
		        bodyHeight : 'auto'
		    });
		    
		    // 수정버튼
			$('#btn-apply').on('click', function () {
				const target = table
				const modifiedRows = grid.getModifiedRows();
				const dataToSend = {target: target,modifiedRows: modifiedRows};
			    const jsonData = JSON.stringify(dataToSend);
			    
				putCode(jsonData)
			});
			
			// 추가버튼(row만 추가 DB작업 X)
			$('#btn-add').on('click', function () {
			   // const newRow = {}
				// grid.appendRow(newRow);
				alert("예정");
			});
		    
		    $("#type2").empty();
		    $("#type2").append('<option value=""> 중분류를 선택하시오 </option>');
		    for(let list of response){
			    $("#type2").append('<option value="'+ list.CTG_CODE + '">'+ list.CTG_NAME +'</option>');
		    };
		    
		    if (disabled != true) { $("#type2").prop("disabled", disabled); }
		    
		    
		} // success 끝
	});
}

function search2(type) {

	if(type ===''){
		alert("중분류를 선택하라고");
		return;
	}
	
	$.ajax({
		type : "GET",
		url : "List",
		data : {
			"table" : table,
			"type" : type,
		},
		dataType : "JSON",
		success : function (response) {
			$("#grid").empty();
			
			const gridData = []
			
				
			for (let item of response){
				gridData.push(item);
			}
			
		    const grid = new tui.Grid({
			    el: document.getElementById('grid'),
			    data: gridData,
			    scrollX: false,
			    scrollY: false,
			    columns: columns,
			    rowHeaders: ['rowNum'],
			    pageOptions: {
		           useClient: true,
		           perPage: itemsPerPage
		        },
		        minBodyHeight : '0',
		        bodyHeight : 'auto'
		    });
		    
		    // 수정버튼
			$('#btn-apply').on('click', function () {
				const target = table
				const modifiedRows = grid.getModifiedRows();
				const dataToSend = {target: target,modifiedRows: modifiedRows};
			    const jsonData = JSON.stringify(dataToSend);
			    
				putCode(jsonData)
			});
			
			// 추가버튼(row만 추가 DB작업 X)
			$('#btn-add').on('click', function () {
			    //const newRow = {}
				//grid.appendRow(newRow);
				
				alert("예정");
			});
			
		} // success 끝
	});
}






function putCode(jsonData) {
	$.ajax({
		type : "PUT",
		url : "category",
		contentType : 'application/json; charset=utf-8',
		data : jsonData,
		dataType : "JSON",
		success : function (response) {
			
			if(response == 0) {
				alert("변경실패 다시 시도");
			} else {
				alert(response + "개 항목 변경완료!");
			}
			
			location.reload();
		}
	})
}


// 코드 상태 변경 함수
function change(elm, isChecked, code, type) {
	let answer = confirm("코드 상태를 변경하시겠습니까?");
	if(answer) {
		$.ajax({
			type : "PATCH",
			url : "status",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify({
				"code" : code,
				"value" : isChecked,
				"type" : type,
			}),
			dataType : "JSON",
			success : function(response) {
				if(response > 0) {
					alert("변경 완료!");
				} else {
					alert("변경실패 다시 시도");
					elm.prop('checked', !isChecked);
				}
			}
		}) //끝
	} else {
		//취소 선택시 상태 제자리
		elm.prop('checked', !isChecked);
	}
}

