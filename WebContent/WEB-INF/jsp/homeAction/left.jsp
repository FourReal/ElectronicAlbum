<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@	taglib prefix="s" uri="/struts-tags" %>
		<title>首页左侧导航</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<script type="text/javascript" src="js/jquery.minleft.js"></script>
<script type="text/javascript" src="js/public.js"></script>

	<%-- 
	<script type="text/javascript">
	
		function menuClick(menu){
			//$("#atext").hide();
			//$("#atext").show();
			$(menu).next().toggle();
		}
	</script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
	<link rel="stylesheet" href="css/sidebar-menu.css">

	<style type="text/css">
	.main-sidebar{
		position: absolute;
		top: 0;
		left: 0;
		height: 100%;
		min-height: 100%;
		width: 180px;
		z-index: 810;
		background-color: #fff;
	 }
	</style>	 --%>
	<script type="text/javascript">
	
		function menuClick(menu){
			//$("#atext").hide();
			//$("#atext").show();
			$(menu).next().toggle();
		}
	</script>
</head>


<%-- <div id="Menu">
	<ul id="MenuUl">
		<s:a target="right" href="user_editUI.action"><li>个人信息管理</li></s:a>
		<s:a target="right" href="photo_findPhotos.action"><input type="button"  value="照片管理"/></s:a>
		<s:a target="right" href="http://www.baidu.com"><li>相册制作</li></s:a>
	</ul>
</div> --%>
<body id="bg">
<div class="container">
		<%-- <div class="leftsidebar_box">
			<a href="#">
				<div class="line">
					<img src="img/coin01.png" />&nbsp;&nbsp;首页
				</div>
			</a>
			<dl class="system_log">
				<dt>
					<img class="icon1" src="img/coin03.png" /><img class="icon2"
						src="img/coin04.png" /><a href="${pageContext.request.contextPath}/user_personal.action" target="right"> 你的一切</a><img class="icon3"
						src="img/coin19.png" /><img class="icon4"
						src="img/coin20.png" />
				</dt>
				<dd>
					<img class="coin11" src="img/coin111.png" /><img class="coin22"
						src="img/coin222.png" /><a href="${pageContext.request.contextPath}/user_editUI.action" target="right">个人信息</a><img class="icon5" src="img/coin21.png" />
				</dd>
				<dd>
					<img class="coin11" src="img/coin111.png" /><img class="coin22"
						src="img/coin222.png" /><a href="${pageContext.request.contextPath}/photo_getAllPhotos.action" target="right">照片管理</a><img class="icon5" src="img/coin21.png" />
				</dd>
			</dl>
			<dl class="system_log">
				<dt>
					<img class="icon1" src="img/coin01.png" /><img class="icon2"
						src="img/coin02.png" /><a target="right" href="album_list.action" style="color:#333;">相册模板制作</a><img class="icon3"
						src="img/coin19.png" /><img class="icon4"
						src="img/coin20.png" />
				</dt>
				
			</dl>
			<dl class="system_log">
				<dt>
					<img class="icon1" src="img/coin07.png" /><img class="icon2"
						src="img/coin08.png" /> <a target="right" href="user_list.action" style="color:#333;">用户管理</a><img class="icon3"
						src="img/coin19.png" /><img class="icon4"
						src="img/coin20.png" />
				</dt>
			</dl>
			<dl class="system_log">
				<dt>
					<img class="icon1" src="img/coin07.png" /><img class="icon2"
						src="img/coin08.png" /> <a target="right" href="role_list.action" style="color:#333;">用户角色管理</a><img class="icon3"
						src="img/coin19.png" /><img class="icon4"
						src="img/coin20.png" />
				</dt>
			</dl>
			
			<dl class="system_log">
				<dt>
					<img class="icon1" src="img/coin10.png" /><img class="icon2"
						src="img/coin09.png" /> <a target="right" href="user_makeAlbum.action" style="color:#333;">制作相册</a><img class="icon3"
						src="img/coin19.png" /><img class="icon4"
						src="img/coin20.png" />
				</dt>
			</dl>
			 --%>
			<div class="leftsidebar_box">
				<dl class="system_log">
					<%--显示一级菜单 --%>
					<s:iterator value="#application.topPrivilegeList">
					<s:if test="#session.user.hasPrivilegeByName(name)">
					<dt class="level1">
						<img class="icon1" src="img/coin03.png" />
						<img class="icon2" src="img/coin04.png" />
						<a href="${pageContext.request.contextPath}/user_personal.action" target="right"> ${name}</a>
						<img class="icon3" src="img/coin19.png" />
						<img class="icon4"src="img/coin20.png" />
					</dt>	
						
						<dd>
							<%--显示二级菜单 --%>
							<s:iterator value="children">
							<s:if test="#session.user.hasPrivilegeByName(name)">
							<li class="level2">
								<div class="level2Style">
									<img class="coin11" src="img/coin111.png" /><img class="coin22" src="img/coin222.png" />
									<a target="right" href="${pageContext.request.contextPath}${url}.action">${name} </a>
									<img class="icon5" src="img/coin21.png" />
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

		
		
		
	</div>
	<%-- <aside class="main-sidebar">
	<section  class="sidebar">
		<ul class="sidebar-menu">
		  <li class="header" style="color:#000;background-color:#EEE0E5;font-family:yahei;font-size:20px;text-align:center;"><a href="#">首页</a></li>
		  <li class="treeview">
			<a href="#">
			  <i class="fa fa-dashboard"></i> <span>你的一切</span> <i class="fa fa-angle-left pull-right"></i>
			</a>
			<ul class="treeview-menu">
			  <li><a href="${pageContext.request.contextPath}/user_editUI.action" target="right"><i class="fa fa-circle-o"></i> 个人信息</a></li>
			  <li><a href="${pageContext.request.contextPath}/photo_getAllPhotos.action" target="right"><i class="fa fa-circle-o"></i> 照片管理</a></li>
			  <!-- <li><a href="#"><i class="fa fa-circle-o"></i> 相册制作</a></li> -->
			</ul>
		  </li>
		  <li class="treeview">
			<a target="right" href="album_list.action">
			  <i class="fa fa-files-o"></i>
			  <span>相册模板制作</span>
			  <i class="fa fa-angle-left pull-right"></i>
			</a>
		  </li>
		  <li class="treeview">
			<a target="right" href="user_list.action">
			  <i class="fa fa-files-o"></i>
			  <span>用户管理</span>
			  <i class="fa fa-angle-left pull-right"></i>
			</a>
		  </li>
		  <li class="treeview">
			<a target="right" href="user_makeAlbum.action">
			  <i class="fa fa-files-o"></i>
			  <span>制作相册</span>
			  <i class="fa fa-angle-left pull-right"></i>
			</a>
		  </li> --%>
		 <%--  <li>
			<a href="#">
			  <i class="fa fa-th"></i> <span>Widgets</span>
			  <i class="fa fa-angle-left pull-right"></i>
			</a>
		  </li>
		  <li class="treeview">
			<a href="#">
			  <i class="fa fa-pie-chart"></i>
			  <span>Charts</span>
			  <i class="fa fa-angle-left pull-right"></i>
			</a>
			<ul class="treeview-menu">
			  <li><a href="#"><i class="fa fa-circle-o"></i> ChartJS</a></li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> Morris</a></li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> Flot</a></li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> Inline charts</a></li>
			</ul>
		  </li>
		  <li class="treeview">
			<a href="#">
			  <i class="fa fa-laptop"></i>
			  <span>UI Elements</span>
			  <i class="fa fa-angle-left pull-right"></i>
			</a>
			<ul class="treeview-menu">
			  <li><a href="#"><i class="fa fa-circle-o"></i> General</a></li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> Icons</a></li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> Buttons</a></li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> Sliders</a></li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> Timeline</a></li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> Modals</a></li>
			</ul>
		  </li>
		  <li class="treeview">
			<a href="#">
			  <i class="fa fa-edit"></i> <span>Forms</span>
			  <i class="fa fa-angle-left pull-right"></i>
			</a>
			<ul class="treeview-menu">
			  <li><a href="#"><i class="fa fa-circle-o"></i> General Elements</a></li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> Advanced Elements</a></li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> Editors</a></li>
			</ul>
		  </li>
		  <li class="treeview">
			<a href="#">
			  <i class="fa fa-table"></i> <span>Tables</span>
			  <i class="fa fa-angle-left pull-right"></i>
			</a>
			<ul class="treeview-menu">
			  <li><a href="#"><i class="fa fa-circle-o"></i> Simple tables</a></li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> Data tables</a></li>
			</ul>
		  </li>
		  <li>
			<a href="#">
			  <i class="fa fa-calendar"></i> <span>Calendar</span>
			  <i class="fa fa-angle-left pull-right"></i>
			</a>
		  </li>
		  <li>
			<a href="#">
			  <i class="fa fa-envelope"></i> <span>Mailbox</span>
			  <i class="fa fa-angle-left pull-right"></i>
			</a>
		  </li>
		  <li class="treeview">
			<a href="#">
			  <i class="fa fa-folder"></i> <span>Examples</span>
			  <i class="fa fa-angle-left pull-right"></i>
			</a>
			<ul class="treeview-menu">
			  <li><a href="#"><i class="fa fa-circle-o"></i> Invoice</a></li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> Profile</a></li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> Login</a></li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> Register</a></li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> Lockscreen</a></li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> 404 Error</a></li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> 500 Error</a></li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> Blank Page</a></li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> Pace Page</a></li>
			</ul>
		  </li>
		  <li class="treeview">
			<a href="#">
			  <i class="fa fa-share"></i> <span>Multilevel</span>
			  <i class="fa fa-angle-left pull-right"></i>
			</a>
			<ul class="treeview-menu">
			  <li><a href="#"><i class="fa fa-circle-o"></i> Level One</a></li>
			  <li>
				<a href="#"><i class="fa fa-circle-o"></i> Level One <i class="fa fa-angle-left pull-right"></i></a>
				<ul class="treeview-menu">
				  <li><a href="#"><i class="fa fa-circle-o"></i> Level Two</a></li>
				  <li>
					<a href="#"><i class="fa fa-circle-o"></i> Level Two <i class="fa fa-angle-left pull-right"></i></a>
					<ul class="treeview-menu">
					  <li><a href="#"><i class="fa fa-circle-o"></i> Level Three</a></li>
					  <li><a href="#"><i class="fa fa-circle-o"></i> Level Three</a></li>
					</ul>
				  </li>
				</ul>
			  </li>
			  <li><a href="#"><i class="fa fa-circle-o"></i> Level One</a></li>
			</ul>
		  </li>
		  <li><a href="#"><i class="fa fa-book"></i> <span>Documentation</span></a></li> --%>
	<%-- 	  
		</ul>
	  </section>
	 </aside> --%>
	
	<%-- <script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>
	<script src="js/sidebar-menu.js"></script>
	<script>
	$.sidebarMenu($('.sidebar-menu'))
	</script>
	<script type="text/javascript">
		function menuClick(menu){
			//$("#atext").hide();
			//$("#atext").show();
			$(menu).next().toggle();
		}
	</script> --%>






</body>
</html>
