function NumericBox_Item(id, isReal, isPositive, validationExpression, decimalPlaces, dollarSign, decimalSign, groupingSeparator, placesBeforeDecimal, currentValue, autoFormatCurrency) {
   this.Id = id;
   this.IsReal = isReal;
   this.IsPositive = isPositive;
   this.ValidationExpression = validationExpression;
   this.DecimalPlaces = decimalPlaces;
   this.DollarSign = dollarSign;
   this.DecimalSign = decimalSign;
   this.GroupingSeparator = groupingSeparator;
   this.PlacesBeforeDecimal = placesBeforeDecimal;
   this.CurrentValue = currentValue;
   this.AutoFormatCurrency = autoFormatCurrency;
   
   this.ParseAdd = function(box) {
	   var currentValue = box.value;
   	
	   var newValue = this.ParseRemoveFromValue(currentValue);
	   newValue = this.ParseAddFromValue(newValue);
   	
	   box.value = newValue;
   }
   
   this.ParseAddFromValue = function(value) {
      var currentValue = value;
      
      if (!this.AutoFormatCurrency) {
         return value;
      } else {
	      var parseValue = '';
	      var newValue = '';
	      var getDecimal = false;
	      var addNegative = false;
      	
	      if(currentValue.indexOf('-') >= 0) {
		      addNegative = true;
		      currentValue = currentValue.replace('-', '');
	      }
	      if(currentValue != '' && currentValue.indexOf(this.DecimalSign) >= 0) {
		      parseValue = currentValue.substr(0, currentValue.indexOf(this.DecimalSign));
		      getDecimal = true;
	      } else {
		      parseValue = currentValue;
		      getDecimal = false;
	      }
	      var rotations = parseInt(parseValue.length / 3);
	      if(parseValue.length % 3 == 0)
		      rotations--;
	      for(var i=0; i<rotations; i++)
		      newValue = this.GroupingSeparator + parseValue.substr(parseValue.length - ((i + 1) * 3), 3) + newValue;
	      newValue = parseValue.substr(0, parseValue.length - ((rotations) * 3)) + newValue;		
	      if(getDecimal)
		      newValue = newValue + currentValue.substr(currentValue.indexOf(this.DecimalSign));
	      if(newValue.length > 0) {
		      if(addNegative)
			      newValue = this.DollarSign + '-' + newValue;
		      else
			      newValue = this.DollarSign + newValue;
	      }
      	
	      return newValue;
	   }
   }
   
   this.ParseRemove = function(box) {
	   var currentValue = box.value;
   	
	   box.value = this.ParseRemoveFromValue(currentValue);
	   box.select();
   }
   
   this.ParseRemoveFromValue = function(value) {
      var newValue = value;
      
      while(newValue.indexOf(this.DollarSign) > -1)
		   newValue = newValue.replace(this.DollarSign, '');
	   while(newValue.indexOf(this.GroupingSeparator) > -1)
		   newValue = newValue.replace(this.GroupingSeparator, '');
   		
	   return newValue;
   }
   
   this.OkToAddItem = function(value, keyCode) {
      
      if (keyCode == 8 || keyCode == 0 || keyCode == 13) {
         if (value.length == 0)
         {
            this.CurrentValue = '';
         }
         return true;
      }
   	
	   if((keyCode >= 48 && keyCode <= 57)) {
		   if(this.DecimalPlaces == -1 || this.IsReal == false) {
			   var tempVal = value;
			   if(tempVal.indexOf('-', 0) == 0)
				   tempVal = tempVal.replace('-', '');
			   if(tempVal.indexOf(this.DecimalSign, 0) == -1) {
				   if(tempVal.length < this.PlacesBeforeDecimal || this.PlacesBeforeDecimal == -1)
					   return true;
				   else
					   return false;
			   } else {
				   return true;
			   }
		   } else {
			   var tempVal = value;
			   if(tempVal.indexOf('-', 0) == 0)
				   tempVal = tempVal.replace('-', '');
			   if(tempVal.indexOf(this.DecimalSign, 0) == -1) {
				   if(tempVal.length < this.PlacesBeforeDecimal || this.PlacesBeforeDecimal == -1)
					   return true;
				   else
					   return false;
			   } else {
				   if(tempVal.indexOf(this.DecimalSign, 0) == -1)
					   return true;
				   else {
					   if((tempVal.length - tempVal.indexOf(this.DecimalSign, 0)) <= this.DecimalPlaces)
						   return true;
					   else
						   return false;
				   }
			   }
		   }
	   } else if(keyCode == 45 || keyCode == 46 || keyCode == 44) {
		   if(keyCode == 45) {
			   var tempVal = value + "-";
			   if(tempVal.indexOf("-") == 0 && tempVal.indexOf("-", 1) == -1) {
				   if(this.IsPositive)
					   return false;
				   else
					   return true;
			   } else
				   return false;
		   } else if(keyCode == 46 && this.DecimalSign == "."){
			   var tempVal = value;
			   if(tempVal.indexOf(".", 0) == -1) {
				   if(this.IsReal)
					   return true;
				   else
					   return false;
			   } else
				   return false;
		   } else if(keyCode == 44 && this.DecimalSign == ",") {
			   var tempVal = value;
			   if(tempVal.indexOf(",", 0) == -1) {
				   if(this.IsReal)
					   return true;
				   else
					   return false;
			   } else
				   return false;
		   } else
			   return false;
	   } else
		   return false;
   }
   
   this.OnTextChange = function(box) {
      var currentValue = this.ParseRemoveFromValue(box.value);
      
      if (currentValue.length > 0 && currentValue.indexOf(this.DecimalSign) == (currentValue.length - 1)) {
         currentValue = currentValue.substring(0, currentValue.length - 1);
      }
   	
	   eval("var re = /" + this.ValidationExpression + "/;");
   	
	   if(currentValue.length == 0 || re.test(currentValue)) {
		   this.CurrentValue = currentValue;
		   box.value = this.ParseAddFromValue(currentValue);
	   } else {
	      box.value = this.CurrentValue;
	   }
   }
}

function NumericBox_FindItem(id) {
   return eWorld_FindItem(eWorld_NumericBox_Items, id);
}