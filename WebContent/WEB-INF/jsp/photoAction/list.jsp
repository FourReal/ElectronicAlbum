<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
</head>
<body>
	
	这是照片展示模块！！！！！！！！！！！！！！！
	<br>
	<s:a action="photo_add">上传照片</s:a>
	<br>
	<s:iterator value="#photoList">
		<s:property value="PName"/>
		<%-- <s:a action="role_delete?id=%{id}" onclick="return confirm('确定要删除吗?')">删除</s:a>
		<s:a action="role_editUI?id=%{id}" >修改</s:a> --%>
		<img src="/ElectronicAlbum/imgs/${PName}" name="mvUrl" width="100px" height="80px" class="myimg"/>
		<br/>
		<s:a action="photo_delete?id=%{Id}" onclick="return confirm('确定要删除吗?')">删除</s:a>
		<br>
		
	</s:iterator>
	
	
	<table>
		<tr>
			<td>photoid</td>
			<td>photoPName</td>
			<td>photoupdatetime</td>
		</tr>
    	<s:iterator value="#photoList" id="p">  
	    	<tr>  
	        <td><s:property value="#p.Id"></s:property></td>  
	        <td><s:property value="#p.PName"></s:property></td>
	        <td><s:property value="#p.updatetime"></s:property></td>  
	        </tr>  
    	</s:iterator>
		
		<span style="color:#FF0000;"><s:set name="page" value="#session.pagePhoto"></s:set>  
        <tr>  
        <td colspan="9">  
        当前是第<s:property value="#session.pagePhoto.pageNow"/>页，共<s:property value="#session.pagePhoto.totalPage"/>页  
        <s:if test="#session.pagePhoto.hasFirst">  
            <s:a action="photo_getAllPhotos?pageNow=1" >首页</s:a>  
        </s:if>  
        <s:if test="#session.pagePhoto.hasPre">  
            <s:a action="photo_getAllPhotos?pageNow=1" >上一页</s:a>  
        </s:if>  
        <s:if test="#session.pagePhoto.hasNext">  
            <s:a action="photo_getAllPhotos?pageNow=2" >下一页</s:a>  
        </s:if>  
         <s:if test="#session.pagePhoto.hasLast">  
            <s:a action="photo_getAllPhotos?pageNow=2" >尾页</s:a>  
        </s:if>  
     	</td>  
  		</tr>
  		</span>	
	
	
	</table>
	
	
	
</body>
</html>