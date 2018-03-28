<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8">
		<title>list</title>
	<!-- 	<link rel="stylesheet" href="css/basic.css" type="text/css" />
		<link rel="stylesheet" href="css/galleriffic-2.css" type="text/css" /> -->
		<link rel="stylesheet" href="css/bootstrap.css" type="text/css">
		<link rel="stylesheet" href="css/manage_photo.css" type="text/css">
		<!-- 分页部分 -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" href="css/am-pagination.css">
		
		<script type="text/javascript" src="js/zooming.js"></script>
		<script type="text/javascript" src="js/jquery-1.3.2.js"></script>
		<script type="text/javascript" src="js/jquery.galleriffic.js"></script>
		<script type="text/javascript" src="js/jquery.opacityrollover.js"></script>
		
		<!-- We only want the thunbnails to display when javascript is disabled -->
		<script type="text/javascript">
			document.write('<style>.noscript { display: none; }</style>');
		</script>
	<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
	<style type="text/css">
		form {
		  position: relative;
		  width: 300px;
		}
		.d1 input {
		  width: 95%;
		  height: 42px;
		  padding-left: 10px;
		  border: 2px solid #cd9b9b;
		  border-radius: 3px;
		  outline: none;
		  background: #FFFFFF;
		  color: #9E9C9C;
		}
		.d1 button {
		  position: absolute; 
		  top: 0;
		  right: 0px;
		  width: 50px;
		  height: 42px;
		  border: none;
		  background: #cd9b9b;
		  border-radius: 0 3px 3px 0;
		  cursor: pointer;
		
		  margin-right:1px;
		  color:#FFFFFF;
		  font-size:16px;
		  
		}
	</style>
</head>
<body>
	
<div class="main">
	<div class="main-inner body-width">
		<div class="search d1">
			<s:form action="photo_adminfindByUserid">
				<s:hidden name="id"></s:hidden>
				<font color="red">
					<s:fielderror/>
				</font>
				<s:textfield name="searchId" cssClass="InputStyle" placeholder="用户id" />
				<button type="submit">查找</button>
			</s:form>
		</div>
		
		<!--照片展示-->
	  	<div class="main-cont main-album">
	  		<table cellpadding="0" cellspacing="0">
				<thead>
					<tr>
						<th>用户id</th>
						<th>照片</th>
						<th>照片名</th>
						<th>操作</th>
						
					</tr>
				</thead>
				<tbody>
				<s:iterator value="#adminphotos">
					<tr>
						<td>${ OwnerId }</td>
						<td width="10%">
							<a href="#" class="pic">
							<img src="/ElectronicAlbum/imgs/${PName}" name="mvUrl" data-action="zoom"/></a> 
						</td>
						<td>${PName}&nbsp;</td>
						<td width="10%"><span><s:a action="photo_admindelete?id=%{id}" onclick="return confirm('您确定要删除该用户的这张照片吗？')" class="delete">删除</s:a></span>
						</td>
					</tr>
				</s:iterator>
				</tbody>
			</table>
	  	
	  	
	  	
	  	
			<%-- <ul>
			<s:iterator value="#adminphotos">
		  		<li class="item content-photo">
					<a href="#" class="pic">
						<img src="/ElectronicAlbum/imgs/${PName}" name="mvUrl" data-action="zoom"/> 
					</a>
					<div class="info">
			  			<p class="title">照片描述</p>
			  			<s:a action="photo_delete?id=%{id}" onclick="return confirm('确定要删除吗?')" >刪除</s:a>
					</div>
		  		</li>
		  		</s:iterator>
			</ul> --%>
	  	</div><!--.main-cont/.main-album-->
	</div><!--.main-inner/.body-width-->
	
	<div class="container" >
		<s:set name="page" value="#session.pagePhoto"></s:set>  
		当前是第<span style="font-weight:bold;"><s:property value="#session.pagePhoto.pageNow" /></span>页，
		共<span  style="font-weight:bold;"><s:property value="#session.pagePhoto.totalPage"/></span>页  
		<s:if test="#session.pagePhoto.hasFirst">  
  				<s:a action="photo_getPhotos?dosign=1" class="page-info">首页</s:a>  
		</s:if>  
		<s:if test="#session.pagePhoto.hasPre">  
  				<s:a action="photo_getPhotos?dosign=2" class="page-info">上一页</s:a>  
		</s:if>  
		<s:if test="#session.pagePhoto.hasNext">  
  				<s:a action="photo_getPhotos?dosign=3" class="page-info">下一页</s:a>  
		</s:if>  
			<s:if test="#session.pagePhoto.hasLast">  
  				<s:a action="photo_getPhotos?dosign=4" class="page-info">尾页</s:a>  
		</s:if>  
	</div><!-- 页码 -->

</div>
		
</div>
		
<script src="js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js"></script>

		
	
</body>
</html>		
		
		





	
	
 


	
