NumericBox_Item.prototype.AddNumericItem = function(e, box) {  
	var keyCode = e.which;
	var value = box.value;
	
	// if ctrl-c, ctrl-v, or ctrl-x, allow
	if (e.ctrlKey && (keyCode == 67 || keyCode == 99 || keyCode == 86 || keyCode == 118 || keyCode == 88 || keyCode == 120)) {
	   return true;
	}
	
	var ok = this.OkToAddItem(value, keyCode);
	
	if (ok) {
	   return true;
	} else {
	   e.preventDefault();
	}
}