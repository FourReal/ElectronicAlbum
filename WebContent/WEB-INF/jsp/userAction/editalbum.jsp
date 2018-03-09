<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%  
	String path = request.getContextPath();  
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
</head>
<body>
	<%-- <span>id=${ id }</span>
	<s:form action="album_addBgp?id=%{id}" enctype="multipart/form-data" method="post">
    	<span style="white-space:pre">  </span>上传文件：<input type="file" name="image"><br/>    
             <span style="white-space:pre"> </span><input type="submit" value="提交"/> 
	</s:form> --%>
	
	<%-- <div id="albumbgp_show">
		<input type="text" id="search" name="search" class="textbox" size="20">
		<s:a action=""><input type="button" value="查找" ></s:a>
		<br> 
		<s:iterator value="#bgpsList" >		
			<tr class="TableDatail template">
			     
			      
				<td>bgpid=====${ id }</td>
				<td>remark=====${remark}&nbsp;</td>
				
				<td>albumId====${album.id}</td>  
			</tr>
			<br>
		</s:iterator>
	</div> --%>
	
	
	<table>
		<tr>
			<td>bgpId</td>
			<td>bgpaddr</td>
			<td>bgpremark</td>
		</tr>
		
		<s:iterator value="#bgpsList" id="bgp">  
	    	<tr>  
	        <td><s:property value="#bgp.id"></s:property></td>  
	        <td><s:property value="#bgp.addr"></s:property></td>
	        <td><s:property value="#bgp.remark"></s:property></td>  
	        </tr>  
    	</s:iterator> 
    	
    <span style="color:#FF0000;"><s:set name="page" value="#session.page"></s:set>  
        <tr>  
        <td colspan="9">  
        当前是第<s:property value="#session.page.pageNow"/>页，共<s:property value="#session.page.totalPage"/>页  
        <s:if test="#page.hasFirst">  
            <s:a action="album_getAllBgps?pageNow=1" >首页</s:a>  
        </s:if>  
        <s:if test="#page.hasPre">  
            <s:a action="album_getAllBgps?pageNow=3" >上一页</s:a>  
        </s:if>  
        <s:if test="#page.hasNext">  
            <s:a action="album_getAllBgps?pageNow=4" >下一页</s:a>  
        </s:if>  
         <s:if test="#page.hasLast">  
            <s:a action="album_getAllBgps?pageNow=6" >尾页</s:a>  
        </s:if>  
     </td>  
  </tr></span> 
		
	</table>
</body>
</html>