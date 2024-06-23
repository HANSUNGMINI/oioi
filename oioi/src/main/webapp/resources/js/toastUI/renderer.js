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
			let idx = e.closest('tr').find('td:first').text();
			location.href="productDetail?PD_IDX=" + idx;
	    });
		
			
	    this.el = el;
	  }

	  getElement() {return this.el;}
	  render(props) {}
}



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
			let id = e.closest('tr').find('td:first').text();
	    });
		
			
	    this.el = el;
	  }

	  getElement() {return this.el;}
	  render(props) {}
}	

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
			let id = e.closest('tr').find('td:first').text();
	    });
		
			
	    this.el = el;
	  }

	  getElement() {return this.el;}
	  render(props) {}
}	

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
			let id = e.closest('tr').find('td:first').text();
	    });
		
			
	    this.el = el;
	  }

	  getElement() {return this.el;}
	  render(props) {}
}	