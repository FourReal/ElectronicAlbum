<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@	taglib prefix="s" uri="/struts-tags" %>
	<script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>
	
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
	</style>	
	
</head>


<%-- <div id="Menu">
	<ul id="MenuUl">
		<s:a target="right" href="user_editUI.action"><li>个人信息管理</li></s:a>
		<s:a target="right" href="photo_findPhotos.action"><input type="button"  value="照片管理"/></s:a>
		<s:a target="right" href="http://www.baidu.com"><li>相册制作</li></s:a>
	</ul>
</div> --%>
<body style="margin:0">
	<aside class="main-sidebar">
	<section  class="sidebar">
		<ul class="sidebar-menu">
		  <li class="header" style="color:#fff;background-color:#cd2626;font-family:yahei;font-size:20px;text-align:center;">你的导航</li>
		  <li class="treeview">
			<a href="#">
			  <i class="fa fa-dashboard"></i> <span>你的一切</span> <i class="fa fa-angle-left pull-right"></i>
			</a>
			<ul class="treeview-menu">
			  <li><a href="${pageContext.request.contextPath}/user_editUI.action" target="right"><i class="fa fa-circle-o"></i> 个人信息</a></li>
			  <li><a href="${pageContext.request.contextPath}/photo_findPhotos.action" target="right"><i class="fa fa-circle-o"></i> 照片管理</a></li>
			  <!-- <li><a href="#"><i class="fa fa-circle-o"></i> 相册制作</a></li> -->
			</ul>
		  </li>
		  <li class="treeview">
			<a target="right" href="album_list.action">
			  <i class="fa fa-files-o"></i>
			  <span>相册制作</span>
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
		  
		</ul>
	  </section>
	 </aside>
	
	<script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>
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
	</script>






</body>
</html>
