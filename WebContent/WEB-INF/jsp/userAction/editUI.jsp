<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<head>
	<%@	include file="/WEB-INF/jsp/public/commons.jspf" %>
	<link rel="stylesheet" type="text/css" href="css/cssInformation.css" />
	<script type="text/javascript" src="js/jquery.min.js"></script>
</head>
<body>
	<div id="pageAll">
		<div class="page ">
			<!-- 会员注册页面样式 -->
			<div class="banneradd bor">
			<s:form action="user_edit" enctype="multipart/form-data" method="post">
				<s:hidden name="id"></s:hidden>
				<div class="baTopNo">
					<span>用户信息</span>
				</div>
				<div>
					<font color="red">
						<s:fielderror/>
					</font>
				</div>
				<div class="baBody">
				<div class="bbD">账号：<s:textfield name="loginName" class="input3"/>	
					</div>
					<div class="bbD">
					姓名：<s:textfield name="name" class="input3" />
					</div>
					<div class="bbD">
					电话：<s:textfield name="phoneNumber" class="input3" />
					</div>
					<div class="bbD">
					头像：
						<input type="file" name="image" value="点击选择图片" />
					</div>
					<div class="bbD">
						邮箱：<s:textfield name="email" class="input3" />
					</div>
				</div>
				<s:submit value="提交" class="tijiao"></s:submit>
			</s:form>
	</div>
	</div>	
		</div>
</body>
</html>