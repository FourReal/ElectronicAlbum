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
		<link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
		<script type="text/javascript" src="js/zooming.js"></script>
		<script type="text/javascript" src="js/jquery-1.3.2.js"></script>
		<script type="text/javascript" src="js/jquery.galleriffic.js"></script>
		<script type="text/javascript" src="js/jquery.opacityrollover.js"></script>
		<link rel="stylesheet" type="text/css" href="css/pageNav.css" />
		<link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
        <script type="text/javascript" src="js/pageNav.js"></script>
		<!-- We only want the thunbnails to display when javascript is disabled -->
		<script type="text/javascript">
			document.write('<style>.noscript { display: none; }</style>');
		</script>
	<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
</head>
<body>
	
<div class="main">

		<div class="main-inner body-width">
		
			<!--照片展示-->
		  	<div class="main-cont main-album">
			  	<h3 style="font-size:30px;"><span class="fa fa-photo"></span> 我的照片</h3>
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
					  			
					  			<!--<p>68张图片 · 2255人收藏</p>-->
					  			<s:a action="photo_delete?id=%{id}&pageNow=%{pageNow}" onclick="return confirm('确定要删除吗?')" class="fa fa-trash-o" style="font-size:14px;color:#6c6c6c;padding:5px;margin-top:6px;float:right;border:1px solid"> 刪除</s:a>
							</div>
				  		</li>
			  		</s:iterator>
				</ul>
		  	</div><!--.main-cont/.main-album-->
		</div><!--.main-inner/.body-width-->
		
        <nav aria-label="Page navigation" class="page-nav-outer" id="PageNavId"></nav>

        <script type="text/javascript">
        	var curpage= ${PageNow};
            var pageNavObj = null;//用于储存分页对象
            pageNavObj = new PageNavCreate("PageNavId",{
                 pageCount:'${pagePhoto.getTotalPage()}', 
                 currentPage:'${PageNow}', 
                 perPageNum:14, 
            });
            pageNavObj.afterClick(pageNavCallBack);

            function pageNavCallBack(clickPage){
            	console.log("clickPage:"+clickPage)
            	window.location="photo_getnPhotos.action?pageNow="+clickPage;
            }
        </script>
        
</div>
		
</div><!--.main-->
		
<script src="js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js"></script>

		
	
</body>
</html>		
		
		
		
		
		
		
	
	
	
 


	
