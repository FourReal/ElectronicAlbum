<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8">
		<title>list</title>
		<link rel="stylesheet" href="css/basic.css" type="text/css" />
		<link rel="stylesheet" href="css/galleriffic-2.css" type="text/css" />
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
				</div>
				<div style="clear: both;"></div>
			</div>
		</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	这是照片展示模块！共有${pageNum}页
	<br>
	<s:a action="photo_add">上传照片</s:a>
	<br>
	<s:iterator value="#photoList">
		<s:property value="PName"/>
		<%-- <s:a action="role_delete?id=%{id}" onclick="return confirm('确定要删除吗?')">删除</s:a>
		<s:a action="role_editUI?id=%{id}" >修改</s:a> --%>
		<img src="/ElectronicAlbum/imgs/${PName}" name="mvUrl" width="100px" height="80px" class="myimg"/>
		<br/>
		<s:a action="photo_delete?id=%{Id}" onclick="return confirm('确定要删除吗?')">删除</s:a>
		<br>
		
	</s:iterator>
	
	
	<table>
		<tr>
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
    	</s:iterator>
		
		<span style="color:#FF0000;"><s:set name="page" value="#session.pagePhoto"></s:set>  
        <tr>  
        <td colspan="9">  
        当前是第<s:property value="#session.pagePhoto.pageNow"/>页，共<s:property value="#session.pagePhoto.totalPage"/>页  
        <s:if test="#session.pagePhoto.hasFirst">  
            <s:a action="photo_getAllPhotos?pageNow=1" >首页</s:a>  
        </s:if>  
        <s:if test="#session.pagePhoto.hasPre">  
            <s:a action="photo_getAllPhotos?pageNow=1" >上一页</s:a>  
        </s:if>  
        <s:if test="#session.pagePhoto.hasNext">  
            <s:a action="photo_getAllPhotos?pageNow=2" >下一页</s:a>  
        </s:if>  
         <s:if test="#session.pagePhoto.hasLast">  
            <s:a action="photo_getAllPhotos?pageNow=2" >尾页</s:a>  
        </s:if>  
     	</td>  
  		</tr>
  		</span>	
	
	
	</table>
	
	
	
</body>
</html>