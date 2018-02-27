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
		<%--显示一级菜单 --%>
		<s:iterator value="#application.topPrivilegeList">
		<s:if test="#session.user.hasPrivilegeByName(name)">
		<li class="level1">
			<div onClick="menuClick(this);" class="level1Style">
				${name}
			</div>
			<ul style="" class="MenuLevel2" id="atext">
				<%--显示二级菜单 --%>
				<s:iterator value="children">
				<s:if test="#session.user.hasPrivilegeByName(name)">
				<li class="level2">
					<div class="level2Style">
						<a target="right" href="${pageContext.request.contextPath}${url}.action"> ${name} </a>
					</div>
				</li>
				</s:if>
				</s:iterator>
			</ul>
		</li>
		</s:if>
		</s:iterator>
	</ul>
</div>



</body>
</html>