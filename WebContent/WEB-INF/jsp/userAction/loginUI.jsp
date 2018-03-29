<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
<%@	taglib prefix="s" uri="/struts-tags"%>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>登陆注册界面</title>
<link rel="stylesheet" type="text/css" href="css/normalize.css" />
<link rel="stylesheet" type="text/css" href="css/htmleaf-demo.css">
<style type="text/css">
.login-page {
	width: 360px;
	padding: 8% 0 0;
	margin: auto;
}

.form {
	position: relative;
	z-index: 1;
	background: rgba(255, 255, 255, 0.7);
	max-width: 360px;
	margin: 0 auto 100px;
	padding: 45px;
	text-align: center;
	box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0
		rgba(0, 0, 0, 0.24);
}

.form input {
	font-family: "Roboto", sans-serif;
	outline: 0;
	background: #DCDCDC;
	width: 100%;
	border: 0;
	margin: 0 0 15px;
	padding: 15px;
	box-sizing: border-box;
	font-size: 14px;
}

.form .button {
	font-family: "Microsoft YaHei", "Roboto", sans-serif;
	text-transform: uppercase;
	outline: 0;
	background: #cd9b9b;
	width: 100%;
	border: 0;
	padding: 15px;
	color: #FFFFFF;
	font-size: 14px;
	-webkit-transition: all 0.3 ease;
	transition: all 0.3 ease;
	cursor: pointer;
}

.form button:hover, .form button:active, .form button:focus {
	background: #cd9b9b;
}

.form .message {
	float: left;
	margin-left: 70px;
	color: #b3b3b3;
	font-size: 12px;
}

.form .message a {
	color: #bb0000;
	text-decoration: none;
}

.form .forget {
	float: left;
	color: #b3b3b3;
	font-size: 12px;
}

.form .forget a {
	color: #bb0000;
	text-decoration: none;
}

.login-form span {
	float: left;
	margin: 8px 8px 8px;
}

.register-form span {
	font-size: 14px;
	float: left;
	margin-bottom: 12px;
	margin-left: 5px;
}

.form .register-form {
	display: none;
}

.container {
	position: relative;
	z-index: 1;
	max-width: 300px;
	margin: 0 auto;
}

.container:before, .container:after {
	content: "";
	display: block;
	clear: both;
}

.container .info {
	margin: 50px auto;
	text-align: center;
}

.container .info h1 {
	margin: 0 0 15px;
	padding: 0;
	font-size: 36px;
	font-weight: 300;
	color: #1a1a1a;
}

.container .info span {
	color: #4d4d4d;
	font-size: 12px;
}

.container .info span a {
	color: #000000;
	text-decoration: none;
}

.container .info span .fa {
	color: #EF3B3A;
}

body {
	background: linear-gradient(rgba(255, 228, 225, 0.9),
		rgba(255, 228, 225, 0.9)), url("myimg/tour03.jpg") no-repeat center
		center/cover;
	font-family: "Roboto", sans-serif;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
}

.shake_effect {
	-webkit-animation-name: shake;
	animation-name: shake;
	-webkit-animation-duration: 1s;
	animation-duration: 1s;
}

@
-webkit-keyframes shake {from , to { -webkit-transform:translate3d(0, 0,
	0);
	transform: translate3d(0, 0, 0);
}

10%,
30%,
50%,
70%,
90%
{
-webkit-transform
:
 
translate3d
(-10px
,
0,
0);
transform
:
 
translate3d
(-10px
,
0,
0);
}
20%,
40%,
60%,
80%
{
-webkit-transform
:
 
translate3d
(10px
,
0,
0);
transform
:
 
translate3d
(10px
,
0,
0);
}
}
@
keyframes shake {from , to { -webkit-transform:translate3d(0, 0, 0);
	transform: translate3d(0, 0, 0);
}

10%,
30%,
50%,
70%,
90%
{
-webkit-transform
:
 
translate3d
(-10px
,
0,
0);
transform
:
 
translate3d
(-10px
,
0,
0);
}
20%,
40%,
60%,
80%
{
-webkit-transform
:
 
translate3d
(10px
,
0,
0);
transform
:
 
translate3d
(10px
,
0,
0);
}
}
p.center {
	color: #fff;
	font-family: "Microsoft YaHei";
}
</style>
</head>
<body>

	<div id="wrapper" class="login-page">
		<header class="htmleaf-header">

			<div class="htmleaf-links">
				<a class="htmleaf-icon icon-htmleaf-home-outline"
					href="home_index.action" title="返回首页" target="_parent"><span>返回首页</span></a>
				<a class="htmleaf-icon icon-htmleaf-arrow-forward-outline" href="#"
					onclick="history.go(-1)" title="返回上一页" target="_parent"><span>
						返回上一页</span></a>
			</div>
		</header>
		<div id="login_form" class="form">

			<s:form action="user_login" class="login-form">
				<div>
					<font color="red"> <s:fielderror />
					</font>
				</div>
				<s:textfield name="loginName" size="20" tabindex="1"
					id="loginNameInput" placeholder="请输入用户名"></s:textfield>
				<input name="password" type="password" placeholder="请输入密码">
				<br>


				<s:submit value="登录" class="button" id="login"></s:submit>
				<!-- <p class="message"><a href="#">免费注册</a></p> -->
				<p class="message">
					还没有账户? <a href="#">免费注册</a>
				</p>

			</s:form>

			<s:form action="user_add" class="register-form">
				<input type="text" name="loginName" value=""
					placeholder="4-8位数字或字母组成的用户名" class="reg_user">
				<span class="tip user_hint" style="display: none;"></span>
				<input type="password" name="password" value=""
					placeholder="6-16位数字或字母组成的密码" class="reg_password">
				<span class="tip password_hint" style="display: none;"></span>
				<input type="password" name="" value="" placeholder="确认密码"
					class="reg_confirm">
				<span class="tip confirm_hint" style="display: none;"></span>

				<input name="name" class="InputStyle" placeholder="请输入姓名" />
				<span class="tip" style="display: none;"></span>
				<input type="text" name="phoneNumber" value="" placeholder="手机号"
					class="reg_mobile">
				<span class="tip mobile_hint" style="display: none;"></span>

				<input type="text" name="email" value="" placeholder="邮箱"
					class="reg_email">
				<span class="tip email_hint" style="display: none;"></span>
				<s:submit value="立即注册" class="button"></s:submit>
				<p class="message">
					已经有了一个账户? <a href="#">立刻登录</a>
				</p>
			</s:form>



		</div>
	</div>

	<script type="text/javascript" src="js/jquery.minzhuce.js"></script>
	<!------------------ 注册验证scriptzhuce.js -------------------->
	<script type="text/javascript" src="js/scriptzhuce.js"></script>
	<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
	<script>
		window.jQuery
				|| document
						.write('<script src="js/jquery-2.1.1.min.js"><\/script>')
	</script>
	<script type="text/javascript">
		$(function() {
			$('.message a').click(function() {
				$('form').animate({
					height : 'toggle',
					opacity : 'toggle'
				}, 'slow');
			});
		})
	</script>
</body>
</html>

