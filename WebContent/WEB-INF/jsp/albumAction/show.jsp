<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<head>
	<%@	include file="/WEB-INF/jsp/public/commons.jspf" %>
</head>
<body>
	这是相册展示页面！！！！
	album====${id }<br/>
	<a href="javascript:history.go(-1);">返回</a>
	<!--<s:hidden name="id" value="%{id}"></s:hidden>  -->
	<s:a action="album_make?id=%{id}">添加相册背景图</s:a>
	<br/>
	<s:a action="user_addalbum?id=%{id}">收藏该相册</s:a>
	<br/>
	<table cellspacing="0" cellpadding="0" class="TableStyle">	
		<tbody id="TableData" class="dataContainer">
		<s:iterator value="#bgpList">
			<tr class="TableDatail template">
				<img src="${addr}" name="mvUrl" width="100px" height="80px" class="myimg"/>
				<td>bgpid=====${ id }</td>
				<td>remark=====${remark}&nbsp;</td>
				
				<td>albumId====${album.id}</td>
				<%-- <s:hidden name="id" value=${album.id}></s:hidden> --%>
				<s:a action="album_deleteBgp?id=%{id}"  onclick="return confirm('您确定要删除该背景图片吗？')">删除</s:a>
			</tr>
		</s:iterator>
		</tbody>
	</table>
	
</body>
</html>