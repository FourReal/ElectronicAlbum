<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<head>
	<%@	include file="/WEB-INF/jsp/public/commons.jspf" %>
	<style type="text/css">
	ul, li {
	margin:0; 
	padding:0; 
	list-style-type:none;
}

#infor{
	width:350px; 
	padding:0px; 
	background:#fefefe; 
	margin:0 auto;
	border:1px solid #c4cddb;
	border-top-color:#d3dbde;
	border-bottom-color:#bfc9dc;
	box-shadow:0 1px 1px #ccc;
	border-radius:5px;
	position:relative;
	margin-top:200px;
  
}

h2 {
	margin:0;
	padding:10px 0;
	font-size:20px; 
	text-align:center;
	background:#eff4f7;
	border-bottom:1px solid #dde0e7;
	box-shadow:0 -1px 0 #fff inset;
	border-radius:5px 5px 0 0; /* otherwise we get some uncut corners with container div */
	text-shadow:1px 1px 0 #fff;
}

form ul li {
	margin:10px 20px;
	
}
form ul li:last-child {
	text-align:center;
	margin:20px 0 25px 0;
}
input {
	padding:10px 10px;
	border:1px solid #d5d9da;
	border-radius:5px;
	box-shadow: 0 0 5px #e8e9eb inset;
	width:300px; /* 400 (parent) - 40 (li margins) -  10 (span paddings) - 20 (input paddings) - 2 (input borders) */
	font-size:1em;
	outline:0; /* remove webkit focus styles */
}</style>
</head>
<body>
<div id="infor">
	<s:form action="album_edit" enctype="multipart/form-data" method="post">
		<s:hidden name="id"></s:hidden>
		<h2>相册信息</h2>
		<div>
		</div>
		<!-- 表单内容显示 -->
	<ul>
			<!-- <table cellspacing="0" cellpadding="0" class="mainForm"> -->
				<li>相册名
					<span><s:textfield name="albumName" cssClass="InputStyle" /> </span>
				</li>
				<li>描述
					<span><s:textfield name="description" cssClass="InputStyle" /></span>
					<input type="file" name="image" value="点击选择图片" />
				</li>
				<s:textfield name="description_1" cssClass="InputStyle" />
				
				<!-- <input type="submit" value="上传" /> -->
				<s:submit value="提交" style="margin-left:20px;"></s:submit>
				
	</ul>
	</s:form>
	</div>
</body>
</html>