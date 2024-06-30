// 관리자 권한 변경 토글
class AD_toggle {
	constructor(props) {
	    const el = document.createElement('label');
	    el.className = 'toggle';
	    
	    var checked = '';
		
		if(props.value == 'Y'){
			checked = 'checked';
		}
	    
	    $(el).append(
	    		'<input role="switch" type="checkbox" class="toggle_check" ' + checked + '/>'
		);
				
	    $(el).on("change", 'input[type="checkbox"]', function() {
	    	let elm = $(this);
	    	let isChecked = elm.prop('checked');
            let id = elm.closest('tr').find('td:first').text();
	    	let type = 'AD_ACTIVE';
            change(elm, isChecked, id, type);
	    });
		
	    this.el = el;
	  }

	  getElement() {return this.el;}
	  render(props) {}
}	

// 공통코드 사용여부 변경 토글
class common_toggle {
	constructor(props) {
	    const el = document.createElement('label');
	    el.className = 'toggle';
	    
	    var checked = '';
		
		if(props.value == 'N'){
			checked = 'checked';
		}
	    
	    $(el).append(
	    		'<input role="switch" type="checkbox" class="toggle_check" ' + checked + '/>'
		);
				
	    $(el).on("change", 'input[type="checkbox"]', function() {
	    	let elm = $(this);
	    	let isChecked = elm.prop('checked');
            let id = elm.closest('tr').find('td:first').text();
	    	let type = 'hide';
            change(elm, isChecked, id, type);
	    });
		
	    this.el = el;
	  }

	  getElement() {return this.el;}
	  render(props) {}
}	

// 카테고리 코드 사용여부 변경 토글
class category_toggle {
	constructor(props) {
	    const el = document.createElement('label');
	    el.className = 'toggle';
	    
	    var checked = '';
		
		if(props.value == 'N'){
			checked = 'checked';
		}
	    
	    $(el).append(
	    		'<input role="switch" type="checkbox" class="toggle_check" ' + checked + '/>'
		);
				
	    $(el).on("change", 'input[type="checkbox"]', function() {
	    	let elm = $(this);
	    	let isChecked = elm.prop('checked');
            let id = elm.closest('tr').find('td:first').text();
	    	let type = 'CTG_HIDE';
            change(elm, isChecked, id, type);
	    });
		
	    this.el = el;
	  }

	  getElement() {return this.el;}
	  render(props) {}
}	

// 게시글 바로가기 버튼
class community_detail_btn {
	constructor(props) {
	    const el = document.createElement('div');
	    el.className = 'buttons nowrap';
	    
	    $(el).append(
	    		'<button class="button small blue" id="detail_btn" type="button">'
			+		'<span class="icon"><i class="mdi mdi-link"></i></span>'
			+	'</button>'
		);
		
		$(el).on("click", function() {
			let e = $(this);
			let idx = e.closest('tr').find('td:first').text();
			location.href="boardDetail?CM_IDX=" + idx;
	    });
		
			
	    this.el = el;
	  }

	  getElement() {return this.el;}
	  render(props) {}
}


// 등록 상품 바로가기
class product_detail_btn {
	constructor(props) {
	    const el = document.createElement('div');
	    el.className = 'buttons nowrap';
	    
	    $(el).append(
	    		'<button class="button small blue" id="detail_btn" type="button">'
			+		'<span class="icon"><i class="mdi mdi-link"></i></span>'
			+	'</button>'
		);
		
		$(el).on("click", function() {
			let e = $(this);
			let target = e.closest('tr').find('td:first').text();
			window.open("admin_detail?table=auctionProduct&target=" + target ,"옥션상품","width=1200, height=800, top=150, left=500");
	    });
		
			
	    this.el = el;
	  }

	  getElement() {return this.el;}
	  render(props) {}
}


// 유저 상세보기 버튼
class user_detail_btn {
	constructor(props) {
	    const el = document.createElement('div');
	    el.className = 'buttons nowrap';
	    
	    $(el).append(
	    		'<button class="button small blue" id="detail_btn" type="button">'
			+		'<span class="icon"><i class="mdi mdi-account-search-outline"></i></span>'
			+	'</button>'
		);
		
		$(el).on("click", function() {
			let e = $(this);
			let target = e.closest('tr').find('td:eq(1)').text();
			window.open("admin_detail?table=user&target=" + target ,"유저 상세","width=600, height=300, top=150, left=650");
	    });
		
			
	    this.el = el;
	  }

	  getElement() {return this.el;}
	  render(props) {}
}	


// 유저 상점 바로가기 버튼
class user_shop_btn {
	constructor(props) {
	    const el = document.createElement('div');
	    el.className = 'buttons nowrap';
	    
	    $(el).append(
	    		'<button class="button small blue" id="detail_btn" type="button">'
			+		'<span class="icon"><i class="mdi mdi-shopping-search"></i></span>'
			+	'</button>'
		);
		
		$(el).on("click", function() {
			let e = $(this);
			let id = e.closest('tr').find('td:eq(1)').text();
			location.href="myStore?userId=" + id;
	    });
		
			
	    this.el = el;
	  }

	  getElement() {return this.el;}
	  render(props) {}
}	



// 신고 상세보기 버튼
class report_detail_btn {
	constructor(props) {
	    const el = document.createElement('div');
	    el.className = 'buttons nowrap';
	    
	    $(el).append(
	    		'<button class="button small blue" id="detail_btn" type="button">'
			+		'<span class="icon"><i class="mdi mdi-account-search-outline"></i></span>'
			+	'</button>'
		);
		
		$(el).on("click", function() {
			let e = $(this);
			let target = e.closest('tr').find('td:first').text();
			window.open("admin_detail?table=report&target=" + target ,"신고 상세","width=1200, height=700, top=150, left=500");
	    });
		
			
	    this.el = el;
	  }

	  getElement() {return this.el;}
	  render(props) {}
}	

