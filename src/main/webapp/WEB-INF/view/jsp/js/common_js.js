jQuery(document).ready(function() {
	
	setTimeout(function() {
	      $(".alert-dismissible").css("display","none");
	}, 5000);

			
	$(".number_only").keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
             // Allow: Ctrl+A, Command+A
            (e.keyCode == 65 && ( e.ctrlKey === true || e.metaKey === true ) ) || 
             // Allow: home, end, left, right, down, up
            (e.keyCode >= 35 && e.keyCode <= 40)) {
                 // let it happen, don't do anything
                 return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });
	
	$(document.body).on('change', '.number_pasitive' ,function(){
		
		if($(this).val() < 0)
		{
			$(this).val('0'); 
		}
//		alert("hello" );
	});
	
});


function checkComplexity(password)
{
	var strongRegex = new RegExp("^(?=.{4,20})(((?=.*[a-z])(?=.*[0-9]))).*$", "g");
	return strongRegex.test(password)
}

function isEmail(email) {
  var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  return regex.test(email);
}

function ContactNo(number) {
	  var regex = new RegExp("^((\\+|00)(\\d{1,3})[\\s-]?)?(\\d{10})$");
	  return regex.test(number);
	}

