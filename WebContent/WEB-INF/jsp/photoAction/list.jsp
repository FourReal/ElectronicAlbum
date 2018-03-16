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
		<script type="text/javascript">
			jQuery(document).ready(function($) {
				// We only want these styles applied when javascript is enabled
				$('div.navigation').css({'width' : '450px', 'float' : 'left'});
				$('div.content').css('display', 'block');

				// Initially set opacity on thumbs and add
				// additional styling for hover effect on thumbs
				var onMouseOutOpacity = 0.67;
				$('#thumbs ul.thumbs li').opacityrollover({
					mouseOutOpacity:   onMouseOutOpacity,
					mouseOverOpacity:  1.0,
					fadeSpeed:         'fast',
					exemptionSelector: '.selected'
				});
				var page = ${pageNum};
				console.log(page)
				// Initialize Advanced Galleriffic Gallery
				var gallery = $('#thumbs').galleriffic({
					pagenumber:				   page,
					delay:                     2500,
					numThumbs:                 20,
					preloadAhead:              10,
					enableTopPager:            true,
					enableBottomPager:         true,
					maxPagesToShow:            7,
					imageContainerSel:         '#slideshow',
					controlsContainerSel:      '#controls',
					captionContainerSel:       '#caption',
					loadingContainerSel:       '#loading',
					renderSSControls:          false,
					renderNavControls:         true,
					playLinkText:              '播放幻灯片',
					pauseLinkText:             '暂停幻灯片',
					prevLinkText:              '&lsaquo; 上一张图',
					nextLinkText:              '下一张图 &rsaquo;',
					nextPageLinkText:          'Next &rsaquo;',
					prevPageLinkText:          '&lsaquo; Prev',
					enableHistory:             false,
					autoStart:                 false,
					syncTransitions:           true,
					defaultTransitionDuration: 900,
					onSlideChange:             function(prevIndex, nextIndex) {
						// 'this' refers to the gallery, which is an extension of $('#thumbs')
						this.find('ul.thumbs').children()
							.eq(prevIndex).fadeTo('fast', onMouseOutOpacity).end()
							.eq(nextIndex).fadeTo('fast', 1.0);
					},
					onPageTransitionOut:       function(callback) {
						this.fadeTo('fast', 0.0, callback);
					},
					onPageTransitionIn:        function() {
						this.fadeTo('fast', 1.0);
					}
				});
			});
		</script>
	<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
</head>
<body>
	<div id="page">
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
	</div><!-- #page -->
	
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
		
		
		
	<!-- 分页 -->	
		<div class="zzsc-container">
	<div class="container" style="text-align: center">
		<section id="ampager">
			<div id="ampagination"></div>
		</section>
	</div>
</div>
		
</div><!--.main-->
		
<script src="js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/am-pagination.js"></script>
<script type="text/javascript">
	var pager = jQuery('#ampagination').pagination({
		page:1,
		totals:100,
		pageSize:5,
	});
	pager.onChangePage(function(e){
		jQuery('.showlabel').text('The selected page no: '+e.page);
	});
</script>
<script type="text/javascript">
	var pager = window.amPagination('#ampagination-bootstrap',{
		page:1,
		totals:100,
		pageSize:5,
		theme:'bootstrap'
	 });
	pager.onChangePage(function(e){
		jQuery('.showlabel').text('The selected page no: '+e.page);			
	});

</script>
<script type="text/javascript">
	var pager = window.amPagination('#ampagination-amazeui',{
			 page:5,
			 totals:100,
			 pageSize:5,
			 theme:'amazeui'
		 });
		pager.onChangePage(function(e){
			jQuery('.showlabel').text('The selected page no: '+e.page);			
		});

</script>		
		
	
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
		
		


<%-- 	这是照片展示模块！共有${pageNum}页
	<br>
	<div class="content">
		<div class="row">
			
		
		</div>
		<s:a action="photo_add"><button class="upload-your-photo">上传照片</button></s:a>
		<br>
		<s:iterator value="#photoList">
			 
		<s:a action="role_delete?id=%{id}" onclick="return confirm('确定要删除吗?')">删除</s:a>
		<s:a action="role_editUI?id=%{id}" >修改</s:a>
			<div class="col-md-3 col-sm-3 ">
				<img src="/ElectronicAlbum/imgs/${PName}" name="mvUrl"  />
				<br>
				<s:property value="PName"/>
				<br>
				<s:a action="photo_delete?id=%{Id}" onclick="return confirm('确定要删除吗?')">删除</s:a>
				<br>
			</div>
					
		</s:iterator> --%>	
	
			<%-- <tr>
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
    		</s:iterator> --%>
 



	
	
 


	
