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
	
	$(document.body).on('keypress', '.titleCase' ,function(){
		var string = $(this).val();
		if(string.length <= 1){
			string = string.charAt(0).toUpperCase() + string.slice(1);
			$(this).val(string);
		}
	});
	
	$(document.body).on('keyup', '.upperCase' ,function(){
		var string = $(this).val();
		string = string.toUpperCase()
		$(this).val(string);
	});
	
//	$(".character_only").keydown(function (e) {
//        // Allow: backspace, delete, tab, escape, enter and .
//        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190, 32]) !== -1 ||
//             // Allow: Ctrl+A, Command+A
//            (e.keyCode == 65 && ( e.ctrlKey === true || e.metaKey === true ) ) || 
//             // Allow: home, end, left, right, down, up
//            (e.keyCode >= 35 && e.keyCode <= 40)) {
//                 // let it happen, don't do anything
//                 return;
//        }
//       
//        // Ensure that it is a number and stop the keypress
//        if ((e.shiftKey || (e.keyCode < 64 || e.keyCode > 97)) && (e.keyCode < 96 || e.keyCode > 123)) {
//            e.preventDefault();
//        }
//    });
});


function checkComplexity(password)
{
	var strongRegex = new RegExp("^(?=.{4,20})(((?=.*[a-z])(?=.*[0-9]))).*$", "g");
	return strongRegex.test(password)
}

function isEmail(email) {
  var regex = /^([a-zA-Z0-9_.+-])+$/;
  return regex.test(email);
}
//    var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
function ContactNo(number) {
  var regex = new RegExp("^((\\+|00)(\\d{1,3})[\\s-]?)?(\\d{10})$");
  return regex.test(number);
}
