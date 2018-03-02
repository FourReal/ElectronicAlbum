<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@	taglib prefix="s" uri="/struts-tags" %>
	<script src="jquery-3.2.1.min.js" type="text/javascript"></script>
	
	<script type="text/javascript">
	
		function menuClick(menu){
			//$("#atext").hide();
			//$("#atext").show();
			$(menu).next().toggle();
		}
	</script>
	
	
</head>
<body style="margin:0">

<div id="Menu">
	<ul id="MenuUl">
		<s:a target="right" href="user_editUI.action"><li>个人信息管理</li></s:a>
		
		<s:a target="right" href="photo_findPhotos.action"><input type="button"  value="照片管理"/></s:a>
		<s:a target="right" href="http://www.baidu.com"><li>相册制作</li></s:a>
	</ul>
</div>



</body>
</html>