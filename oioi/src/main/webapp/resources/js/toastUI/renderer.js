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