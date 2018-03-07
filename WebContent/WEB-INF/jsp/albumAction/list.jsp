<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
</head>
<body>
	<table cellspacing="0" cellpadding="0" class="TableStyle">
		
		<thead>
			<tr align="center" valign="middle" id=TableTitle>
				<td width="100px">相册名</td>
				<td>描述</td>
				<td>相关操作</td>
			</tr>
		</thead>
		
		<tbody id="TableData" class="dataContainer">
		<s:iterator value="#albumList">
			<tr class="TableDatail template">
				<td><s:a action="album_show?id=%{id}">${albumName}</s:a>&nbsp;</td>
				<td>${description}&nbsp;</td>
				<td>
					<s:a action="album_delete?id=%{id}" onclick="return confirm('您确定要删除该用户吗？')">删除</s:a>
					<s:a action="album_editUI?id=%{id}" >修改</s:a>
				</td>
			</tr>
		</s:iterator>
		</tbody>
	</table>
	<s:a action="album_addUI">添加</s:a>
</body>
</html>