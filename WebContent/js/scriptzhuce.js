// user
var user_Boolean = false;
var password_Boolean = false;
var varconfirm_Boolean = false;
var emaile_Boolean = false;
var Mobile_Boolean = false;


$('.reg_user').blur(function(){
  if ((/^[a-z0-9_-]{4,8}$/).test($(".reg_user").val())){
   /* $('.user_hint').html("×").css("color","green");*/
	  $('.user_hint').hide();
    user_Boolean = true;
  }else {
    $('.user_hint').html("请输入有效的用户名格式").css("color","red");
    $('.user_hint').css("display","");
    user_Boolean = false;
  }
});
// password
$('.reg_password').blur(function(){
  if ((/^[a-z0-9_-]{6,16}$/).test($(".reg_password").val())){
    /*$('.password_hint').html("✔").css("color","green");*/
	  $('.password_hint').hide();
    password_Boolean = true;
  }else {
    $('.password_hint').html("请输入有效的密码格式").css("color","red");
    $('.password_hint').css("display","");
    password_Boolean = false;
  }
});


// password_confirm
$('.reg_confirm').blur(function(){
  if (($(".reg_password").val())==($(".reg_confirm").val())){
    /*$('.confirm_hint').html("✔").css("color","green");*/
	  $('.confirm_hint').hide();
    varconfirm_Boolean = true;
  }else {
    $('.confirm_hint').html("密码不一致").css("color","red");
    $('.confirm_hint').css("display","");
    varconfirm_Boolean = false;
  }
});


// Email
$('.reg_email').blur(function(){
  if ((/^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/).test($(".reg_email").val())){
   /* $('.email_hint').html("✔").css("color","green");*/
	  $('.email_hint').hide();
    emaile_Boolean = true;
  }else {
    $('.email_hint').html("请输入正确的邮箱格式").css("color","red");
    $('.email_hint').css("display","");
    emaile_Boolean = false;
  }
});


// Mobile
$('.reg_mobile').blur(function(){
  if ((/^1[34578]\d{9}$/).test($(".reg_mobile").val())){
    /*$('.mobile_hint').html("✔").css("color","green");*/
	  $('.mobile_hint').hide();
    Mobile_Boolean = true;
  }else {
    $('.mobile_hint').html("请输入正确的手机号格式").css("color","red");
    $('.mobile_hint').css("display","inline");
    Mobile_Boolean = false;
  }
});


// click
$('.button').click(function(){
  if(user_Boolean && password_Boolea && varconfirm_Boolean && emaile_Boolean && Mobile_Boolean == true){
    alert("注册成功");
  }
});
