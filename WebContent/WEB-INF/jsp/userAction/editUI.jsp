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
			<s:form action="user_edit">
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
						邮箱：<s:textfield name="email" class="input3" />
					</div>
					<!-- <div class="bbD">
						<p class="bbDP">
							<button class="btn_ok btn_yes" href="#">提交</button>
							<a class="btn_ok btn_no" href="#">取消</a>
						</p>
					</div> -->
				</div>
				<s:submit value="提交" class="tijiao"></s:submit>
			</s:form>
	</div>
	</div>

			
		</div>
	
	
	<div>相册展示：----------
	<br>
		<tbody id="TableData" class="dataContainer">
		<s:iterator value="#userAlbums">
			<tr class="TableDatail template">
				<td>id=======${id }</td>
				<td><s:a action="album_getAllBgps">${albumName}</s:a>&nbsp;</td>
				<td>${description}&nbsp;</td>
				<td>
					<s:a action="user_delAlbum?id=%{id}" onclick="return confirm('您确定要删除该相册吗？')">删除</s:a>
					<s:a action="" >修改</s:a>
				</td>
			</tr>
			<br>
		</s:iterator>
		</tbody>
	</div>
	
</body>
</html>
<%-- <s:form action="user_edit">
		<s:hidden name="id"></s:hidden>
		
		<div class="ItemBlock_Title1"><!-- 信息说明 --><div class="ItemBlock_Title">用户信息:</div>
		</div>
		
		<!-- 表单内容显示 -->
		<div class="ItemBlockBoder">
			<table cellspacing="0" cellpadding="0" class="mainForm">

				<tr><td>登录名</td>
					<td><s:textfield name="loginName" cssClass="InputStyle" /></td>
				</tr>
				<tr><td>姓名</td>
					<td><s:textfield name="name" cssClass="InputStyle" /> *</td>
				</tr>
					
			</table>
		</div>
			
			
		<s:submit value="提交"></s:submit>
	</s:form> --%>