<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@	taglib prefix="s" uri="/struts-tags"%>
<title>首页左侧导航</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<script type="text/javascript" src="js/jquery.minleft.js"></script>
<script type="text/javascript" src="js/public.js"></script>
<script type="text/javascript">
	function menuClick(menu) {
		//$("#atext").hide();
		//$("#atext").show();
		$(menu).next().toggle();
	}
</script>
</head>


<body id="bg">
	<div class="container">

		<div class="leftsidebar_box">
			<dl class="system_log">
				<%--显示一级菜单 --%>
				<s:iterator value="#application.topPrivilegeList">
					<s:if test="#session.user.hasPrivilegeByName(name)">
						<dt class="level1">
							<img class="icon1" src="img/coin03.png" /> <img class="icon2"
								src="img/coin04.png" /> <a href="#"> ${name}</a> <img
								class="icon3" src="img/coin19.png" /> <img class="icon4"
								src="img/coin20.png" />
						</dt>

						<dd>
							<%--显示二级菜单 --%>
							<s:iterator value="children">
								<s:if test="#session.user.hasPrivilegeByName(name)">
									<li class="level2">
										<div class="level2Style">
											<img class="coin11" src="img/coin111.png" /><img
												class="coin22" src="img/coin222.png" /> <a target="right"
												href="${pageContext.request.contextPath}${url}.action">${name}
											</a> <img class="icon5" src="img/coin21.png" />
										</div>
									</li>
								</s:if>
							</s:iterator>
						</dd>

					</s:if>
				</s:iterator>
			</dl>
		</div>
	</div>


</body>
</html>
