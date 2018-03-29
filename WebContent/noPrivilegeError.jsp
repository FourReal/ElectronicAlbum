<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<title>Insert title here</title>
<style type="text/css">
.error{
margin:0 auto;
text-align:center;
width:400px;
height:300px;
margin-top:200px;
}
.fa-exclamation-triangle{
font-size:20px;
}
.fa-reply{
font-size:18px;
}
a{
 text-decoration:none;
}
</style>
</head>
<body>
<div class="error">
	<font color="red" class="fa fa-exclamation-triangle">
	出错了，您没有权限访问该功能！！</font>
	<br/>
	<div style="margin-top:20px;">
		<a href="javascript:history.go(-1);" class="fa fa-reply" title="返回"></a>
		
	</div>
	</div>
</body>
</html>