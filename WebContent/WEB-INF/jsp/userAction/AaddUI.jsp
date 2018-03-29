<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@	include file="/WEB-INF/jsp/public/commons.jspf" %>
	<style type="text/css">
	.ItemBlockBoder {
		margin-left:auto;
		margin-right:auto;
		max-width: 450px;
		background: #F7F7F7;
		padding: 20px 10px 20px 5px;
		font: 12px Georgia, "Times New Roman";
		color: #888;
		border:1px solid #ccc;
}
	.h2{
		font-size: 25px;
		padding: 0px 0px 10px 40px;
		display: block;
		border-bottom:1px solid #ccc;
		/* margin: -10px -15px 30px -10px;; */
		color: #000;
}
	.ItemBlockBoder label {
		display: block;
		margin: 0px;
}
	.ItemBlockBoder label>span {
		float: left;
		width: 15%;
		text-align: right;
		padding-right: 6px;
		margin-top: 10px;
		color: #000;
}


 
	.ItemBlockBoder input, .ItemBlockBoder textarea {
		border: 1px solid #DADADA;
		color: #888;
		height: 30px;
		margin-bottom: 16px;
		margin-right: 6px;
		margin-top: 2px;
		outline: 0 none;
		padding: 3px 3px 3px 5px;
		width: 60%;
		font-size: 12px;
		line-height:15px;
		
		
}
	</style>
</head>
<body>
	<s:form action="user_Aadd">
		<s:hidden name="id"></s:hidden>
	
		<!-- 表单内容显示 -->
		<div class="ItemBlockBoder">
		<h2 style="text-align:center;color: #000000;">用户信息</h2>
			<!-- <table cellspacing="0" cellpadding="0" class="mainForm"> -->
				<label><span>登录名:</span>
					<s:textfield name="loginName" cssClass="InputStyle" />*(登录名唯一)
				</label>
				<label><span>姓名:</span>
					<s:textfield name="name" cssClass="InputStyle" /> 
				</label>
				
				<label><span>联系电话:</span>
					<s:textfield name="phoneNumber" cssClass="InputStyle" />
				</label>
				<label><span>E-mail:</span>
					<s:textfield name="email" cssClass="InputStyle" />
				</label>
				<label><span>备注:</span>
					<s:textarea name="description" cssClass="TextareaStyle" ></s:textarea>
				</label>
				
			<label><span>&nbsp;</span>
			<s:submit value="提交" style="color:#fff;width:62%;background: #E27575;border: none;border-radius: 3px;padding: 8px 22px 8px 22px;margin-top:10px;"></s:submit>
		</label>
		</div>
	</s:form>
</body>
</html>