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
</head>
<body>
	<%-- <div id="page">
		<div id="container">
			<!-- Start Advanced Gallery Html Containers -->
			<div id="gallery" class="content">
				<div id="controls" class="controls"></div>
				<div class="slideshow-container">
					<div id="loading" class="loader"></div>
					<div id="slideshow" class="slideshow"></div>
				</div>
				<div id="caption" class="caption-container"></div>
			</div>

			<div id="thumbs" class="navigation">
				<ul class="thumbs noscript">
					<s:iterator value="#photoList">
						<li><!-- 每一张照片-->
							<a class="thumb" name="leaf" href="/ElectronicAlbum/imgs/${PName}" title="标题 #0">
								<img src="/ElectronicAlbum/imgs/${PName}" height="75px" width="75px" alt="标题 #0" />
							</a>
							<div class="caption">					
								<div class="download">
									<div class="image-desc">描述</div>
									<a href="/ElectronicAlbum/imgs/${PName}">下载原图</a>
								</div>	
							</div>
						</li>
					</s:iterator>
				</ul>
			</div><!-- #thumbs -->
			<div style="clear: both;"></div>
		</div><!-- #container -->
	</div><!-- #page --> --%>
	
<div class="main">

		<div class="main-inner body-width">
		
			<!--照片展示-->
		  	<div class="main-cont main-album">
			  	<h3 style="font-size:30px;">我的照片</h3>
				<div class="main-cont__title">
			  		
			  		<s:a action="photo_add" class="more">添加照片 ></s:a>
				</div>
				
				<ul class="main-cont__list clearfix ">
				<s:iterator value="#photoList">
			  		<li class="item content-photo">
						<a href="#" class="pic">
							<img src="/ElectronicAlbum/imgs/${PName}" name="mvUrl" data-action="zoom"/>
							<%-- <img src="/ElectronicAlbum/imgs/${PName}" class="preview"> --%>   
						</a>
						<div class="info">
				  			<p class="title">照片描述</p>
				  			<!--<p>68张图片 · 2255人收藏</p>-->
				  			<s:a action="photo_delete?id=%{id}" onclick="return confirm('确定要删除吗?')" >刪除</s:a>
						</div>
			  		</li>
			  		</s:iterator>
				</ul>
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
		
	<!-- 	
		<div class="zzsc-container">
	<div class="container" style="text-align: center">
		<section id="ampager">
			<div id="ampagination"></div>
		</section>
	</div> -->
</div>
		
</div><!--.main-->
		
<script src="js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js"></script>

		
	
</body>
</html>		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		   		<%-- <div class="container" >
    			<table >
		
			<span style="color:#FF0000; ">
				<s:set name="page" value="#session.pagePhoto"></s:set>  
        		<tr style="padding:10px;">  
        			<td style="float:right;">  
        				当前是第<span style="font-weight:bold;"><s:property value="#session.pagePhoto.pageNow" /></span>页，
        				共<span  style="font-weight:bold;"><s:property value="#session.pagePhoto.totalPage"/></span>页  
        				<s:if test="#session.pagePhoto.hasFirst">  
            				<s:a action="photo_getAllPhotos?pageNow=1" class="page-info">首页</s:a>  
        				</s:if>  
        				<s:if test="#session.pagePhoto.hasPre">  
            				<s:a action="photo_getAllPhotos?pageNow=1" class="page-info">上一页</s:a>  
        				</s:if>  
        				<s:if test="#session.pagePhoto.hasNext">  
            				<s:a action="photo_getAllPhotos?pageNow=2" class="page-info">下一页</s:a>  
        				</s:if>  
         				<s:if test="#session.pagePhoto.hasLast">  
            				<s:a action="photo_getAllPhotos?pageNow=2" class="page-info">尾页</s:a>  
        				</s:if>  
     				</td>  
  				</tr>
  			</span>	
		</table>
		</div><!-- 页码 --> --%>
		
		





	
	
 


	
