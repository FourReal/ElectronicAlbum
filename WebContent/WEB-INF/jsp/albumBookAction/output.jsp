<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html lang="zh">
	<head>
		<%@	taglib prefix="s" uri="/struts-tags" %>
		<%pageContext.setAttribute("baseURL", request.getContextPath()); %>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
		<link rel="stylesheet" type="text/css" href="${baseURL }/css/jquery.jscrollpane.custom.css" />
		<link rel="stylesheet" type="text/css" href="${baseURL }/css/bookblock.css" />
		<link rel="stylesheet" type="text/css" href="${baseURL }/css/custom.css" />
		<link rel="stylesheet" type="text/css" href="${baseURL }/css/buttons.css" />
		<script src="${baseURL }/js/modernizr.custom.79639.js"></script>
		<link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
		<style type="text/css">
			.draggable {    
			position: absolute;
			width: 200px;
			height: 200px;
			}
			.bgps{
			    position: relative;	
			}
			.bshare-custom{
				display: flex;
				justify-content:center;
			}
			.container{
				height: 90%;
			}
			.button0 {
				display: inline-block;
				position: relative;
				color: #888;
				text-shadow: 0 1px 0 rgba(255,255,255, 0.8);
				text-decoration: none;
				text-align: center;
				padding:8px 8px;
				font-size: 12px;
				font-weight: 700;
				font-family: helvetica, arial, sans-serif;
				border-radius: 4px;
				border: 1px solid #bcbcbc;
				cursor:pointer;
				margin-left:10px;
				-webkit-box-shadow: 0 1px 3px rgba(0,0,0,0.12);
				box-shadow: 0 1px 3px rgba(0,0,0,0.12);
			
				background-image: -webkit-linear-gradient(top, rgba(255,255,255,1) 0%,rgba(239,239,239,1) 60%,rgba(225,223,226,1) 100%);
				background-image: -moz-linear-gradient(top, rgba(255,255,255,1) 0%,rgba(239,239,239,1) 60%,rgba(225,223,226,1) 100%);
				background-image: -o-linear-gradient(top, rgba(255,255,255,1) 0%,rgba(239,239,239,1) 60%,rgba(225,223,226,1) 100%);
				background-image: -ms-linear-gradient(top, rgba(255,255,255,1) 0%,rgba(239,239,239,1) 60%,rgba(225,223,226,1) 100%);
				background-image: linear-gradient(top, rgba(255,255,255,1) 0%,rgba(239,239,239,1) 60%,rgba(225,223,226,1) 100%);
			}

			.button0:hover {
				color: #555;
			}
			
			.button0:active,.button:active:after,.button:active:before {
				-webkit-box-shadow: none;
				box-shadow: none;
			}
			
			/* Back Button */
			.button.back {
				border-left: none;
			}


			
		</style>
	</head>
	<body>
	<a href="#" onclick="history.go(-1)"><i class="fa fa-hand-o-left fa-2x" style="padding:10px;margin-left:10px" title="返回上一页"></i></a>
	<a href="home_index.action"><i class="fa fa-home fa-2x" style="padding:10px" title="返回首页"></i></a>
	
		<div id="container" class="container">	
			
			
			<div class="bb-custom-wrapper">
			
				<div id="bb-bookblock" class="bb-bookblock">
				
					<s:iterator value="#modelBgps" status="st" var="bgpalb">
						<div class="bb-item">
							<div class="content">
								<div class="scroller">
									<div id="bgp${st.count}" class="bgps" style="width:1228px;height:675px;background-size: 100% 100%;background-image: url('${addr}');">
										
									</div>
									
								</div>
							</div>
						</div>
				    </s:iterator>

				<nav>
				
					<span id="bb-nav-prev">&larr;</span>
					<span id="bb-nav-next">&rarr;</span>
					
				</nav>
				
				</div>
				
			</div>
		
		</div><!-- /container -->
		<script src="${baseURL }/js/jquery.min.js"></script>
		<script src="${baseURL }/js/jquery.jscrollpane.min.js"></script>
		<script src="${baseURL }/js/jquerypp.custom.js"></script>
		<script src="${baseURL }/js/jquery.bookblock.js"></script>
		<script src="${baseURL }/js/page.js"></script>
		<script>
			$(function() {

				Page.init();

			});
		</script>
		<s:iterator value="#photo_proList">
						<script type="text/javascript">
							console.log("${id}")
 							$("#bgp${page+1}").prepend('<div class="draggable" id="dg" style="top:${ordinate}px;left:${horizon}px;width:${size_x}px;height:${size_y}px" >\n' +
									
									'			 <img src="/ElectronicAlbum/imgs/${photo.getPName()}" name="opphoto" width="100%" height="100%" class="opphotoc">\n'+
									'        </div>');
						</script>
		</s:iterator>
		<div class="bshare-custom"><h4 style="width:130px">与朋友分享你的相册</h4><div class="bsPromo bsPromo2"></div><a title="分享到新浪微博" class="bshare-sinaminiblog"></a><a title="分享到微信" class="bshare-weixin" href="javascript:void(0);"></a><a title="分享到QQ空间" class="bshare-qzone" href="javascript:void(0);"></a><a title="分享到腾讯微博" class="bshare-qqmb"></a><a title="分享到网易微博" class="bshare-neteasemb"></a><a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a></div><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
		<script type="text/javascript" charset="utf-8">
			bShare.addEntry({
			    title: "我刚刚制作的电子相册，快来围观！《印书，在线定制你的个人电子相册》",
			    summary: "",
			});
		</script>
	</body>
</html>
