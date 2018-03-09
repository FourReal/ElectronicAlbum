<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<head>
	<%@	include file="/WEB-INF/jsp/public/commons.jspf" %>
</head>
<body>
	<s:form action="user_edit">
		<s:hidden name="id"></s:hidden>
		
		<div class=""><!-- 信息说明 --><div class="">用户信息:</div>
		</div>
		<div>
		<font color="red">
			<s:fielderror/>
		</font>
		</div>
		<!-- 表单内容显示 -->
		<div class="ItemBlockBoder">
			<table cellspacing="0" cellpadding="0" class="mainForm">	
				<s:hidden name="id"></s:hidden>						
				<tr><td>姓名</td>
					<td><s:textfield name="name" cssClass="InputStyle" /></td>
				</tr>
				<tr><td>性别</td>
					<td>
						<s:radio name="gender" list="%{#{'男':'男','女':'女'} }"></s:radio>
					</td>
				</tr>
				<tr><td>联系电话</td>
					<td><s:textfield name="phoneNumber" cssClass="InputStyle" /></td>
				</tr>
				<tr><td>E-mail</td>
					<td><s:textfield name="email" cssClass="InputStyle" /></td>
				</tr>
				<tr><td>备注</td>
					<td><s:textarea name="description" cssClass="TextareaStyle" ></s:textarea></td>
				</tr>
					
			</table>
		</div>
			
		<s:submit value="提交"></s:submit>
	</s:form>
	
	
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