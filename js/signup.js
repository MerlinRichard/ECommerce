$(document).ready(function(){
  function validateFirstname(){
    var firstname = $('#firstnameid').val();
    var firstnameReg = /^[A-Z a-z]+$/;
    if (firstname == "") {
      $("#firsterror").html("First Name is Missing!");
      return false;
    } else if (firstname.length < 3) {
      $("#firsterror").html("First Name must contain atleast 3 characters!");
      return false;
    } else if(!firstnameReg.test(firstname)){
      $('#firsterror').html("Please enter alphabets only!");
      return false;
    } else{
      $('#firsterror').html("");
      return true;
    }
  }
  function validateLastname(){
    var lastname = $("#lastnameid").val();
    var lastnameReg = /^[A-Z a-z]+$/;
    if (lastname == "") {
      $("#lasterror").html("Last Name is Missing!");
      return false;
    } else if(!lastnameReg.test(lastname)){
      $('#lasterror').html("Please enter alphabets only!");
      return false;
    } else{
      $('#lasterror').html("");
      return true;
    }
  }
  function validateEmail(){
		var email=$('#emailid').val();
		var emailReg =/^([_\-\.!0-9a-zA-Z]+)@([_\-\.0-9a-zA-Z]+)\.([a-zA-Z]){2,7}$/;
		if (email == '') {
      $('#emailerror').html("Email Id is Missing!");
      return false;
    } else if(!emailReg.test(email)){
			$('#emailerror').html("Please enter a valid email id!");
      return false;
		} else {
      $('#emailerror').html("");
			return true;
    }
	}
  function validatePassword(){
    var password = $('#passwordid').val();
    var passwordReg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    if (password == "") {
      $('#pswderror').html("**Password is missing!");
      return false;
    }
    else if (password.length < 8) {
      $('#pswderror').html("**Password must contain minimum 8 characters!");
      return false;
    }
    else if(!passwordReg.test(password)){
      $("#pswderror").html("**Password must contain at least one uppercase letter, one lowercase letter, one number and one special character!");
      return false;
    }
    else{
      $("#pswderror").html("");
      return true;
    }
  }
  $("#signUpFormId").submit(function(e){
    e.preventDefault();
    var validFirstName = validateFirstname();
    var validLastName = validateLastname();
    var validEmail = validateEmail();
    var validPswd = validatePassword();
    if(validFirstName == true && validLastName == true && validEmail == true && validPswd == true) {
      var formData = {
        firstName : $('#firstnameid').val(),
        lastName : $('#lastnameid').val(),
        email : $('#emailid').val(),
        password : $('#passwordid').val()
      }
      formData = JSON.stringify(formData);
      $('#signupBtn').prop("disabled", true);
      $.ajax({
        type: "post",
        dataType:'json',
        url: "../components/user.cfc?method=createUser",
        data: {
          userDetails: formData
        },
        success: function(response){
          if(response.ERROR == false){
            window.location.href = "../views/productList.cfm";
          } else {
            $("#signuperror").html(response.MESSAGE);
          }
          $('#signupBtn').prop("disabled", false);
        }
      });
    }
  });

  $("#loginFormId").submit(function(e){
    e.preventDefault();
    var validEmail = validateEmail();
    var validPswd = validatePassword();
    if(validEmail == true && validPswd == true) {
      var formData = {
        email : $('#emailid').val(),
        password : $('#passwordid').val()
      }
      formData = JSON.stringify(formData);
      $('#loginBtn').prop("disabled", true);
      $.ajax({
        type: "post",
        dataType:'json',
        url: "../components/user.cfc?method=validateUser",
        data: {
          userDetails: formData
        },
        success: function(response){
          if(response.ERROR == false){
            window.location.href = "../views/productList.cfm";
          } else {
            $("#loginerror").html(response.MESSAGE);
          }
          $('#loginBtn').prop("disabled", false);
        }
      });
    }
  });
});