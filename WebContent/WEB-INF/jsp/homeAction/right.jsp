<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>FReal照片书展示页</title>
<!--顶端CSS-->
<link rel="stylesheet" href="css/main_banner.css">
<!--展示部分CSS-->
<link rel="stylesheet" href="css/main_show.css">
<!--展示部分轮播图CSS-->
<link rel="stylesheet" href="css/main_show_banner.css" />
<link rel="stylesheet" href="css/foot.css" />
</head>
<body>
	<!--顶端-->
	<ul class="fold_wrap" id="sm" style="margin-top: 0px">
		<li><a href="#">
				<div class="mask_b">
					<h4 class="i_how_n1"></h4>
				</div>
				<div class="pic_auto"
					style="background: url(images/ly1.jpg) no-repeat center 0;"></div>
		</a></li>
		<li><a href="#">
				<div class="mask_b">
					<h4></h4>
				</div>
				<div class="pic_auto"
					style="background: url(images/ly2.jpg) no-repeat center 0;"></div>
		</a></li>
		<li><a href="#">
				<div class="mask_b">
					<h4 class="i_how_n1"></h4>
				</div>
				<div class="pic_auto"
					style="background: url(images/gr1.jpg) no-repeat center 0;"></div>
		</a></li>
		<li><a href="#">
				<div class="mask_b">
					<h4></h4>
				</div>
				<div class="pic_auto"
					style="background: url(images/gr3.jpg) no-repeat center 0;"></div>
		</a></li>
	</ul>
	<!--//顶端-->
	<!--展示部分-->
	<div class="container-master">
		<div class="container-tile">
			<!--介绍-->
			<h1>
				精选照片书

			</h1>
			<!--//介绍-->

			<div class="content">
				<div class="floaty tile">
					<h3 class="title"
						style="color: rgb(255, 228, 225); background-color: #555555">旅行的意义</h3>
					<div class="lines"></div>
					<ul class="first">
						<li class="first"></li>
					</ul>
				</div>
				<div class="floaty tile">
					<h3 class="title"
						style="color: rgb(255, 228, 225); background-color: #555555">爱情纪念册</h3>
					<div class="lines"></div>
					<ul class="second">
						<li class="second"></li>
					</ul>
				</div>
				<div class="floaty tile">
					<h3 class="title"
						style="color: rgb(255, 228, 225); background-color: #555555">成长的宝宝</h3>
					<div class="lines"></div>
					<ul class="third">
						<li class="third"></li>
					</ul>
				</div>
				<div class="floaty tile">
					<h3 class="title" style="background-color: #fff">我们毕业啦</h3>
					<div class="lines"></div>
					<ul class="forth">
						<li class="forth"></li>
					</ul>
				</div>
				<div class="floaty tile">
					<h3 class="title" style="background-color: #fff">关于我自己</h3>
					<div class="lines"></div>
					<ul class="fifth">
						<li class="fifth"></li>
					</ul>
				</div>
				<div class="floaty tile">
					<h3 class="title" style="background-color: #fff">团聚在一起</h3>
					<div class="lines"></div>
					<ul class="sixth">
						<li class="sixth"></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="container-lyrics">
			<div class="content">
				<div class="header">
					<a class="back"></a> <br />
					<h4 class="lyrics-title"></h4>
				</div>
				<div class="lyrics-wrapper"></div>
			</div>
		</div>
	</div>

	<!--//展示部分-->
	<!--顶端特效-->
	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
		(function() {
			var slideMenu = function() {
				var sp, st, t, m, sa, l, w, gw, ot;
				return {
					destruct : function() {
						if (m) {
							clearInterval(m.htimer);
							clearInterval(m.timer);
						}
					},
					build : function(sm, sw, mt, s, sl, h) {
						sp = s;
						st = sw;
						t = mt;
						m = document.getElementById(sm);
						sa = m.getElementsByTagName('li');
						l = sa.length;
						w = m.offsetWidth;
						gw = w / l;
						ot = Math.floor((w - st) / (l - 1));
						var i = 0;
						for (i; i < l; i++) {
							s = sa[i];
							s.style.width = gw + 'px';
							this.timer(s)
						}
						if (sl != null) {
							m.timer = setInterval(function() {
								slideMenu.slide(sa[sl - 1])
							}, t)
						}
					},
					timer : function(s) {
						s.onmouseover = function() {
							clearInterval(m.htimer);
							clearInterval(m.timer);
							m.timer = setInterval(function() {
								slideMenu.slide(s)
							}, t);
							//console.log($(this).find('.mask_b').html());
							$(this).find('.mask_b').hide();
							//console.log($(this).find('.mask_b').attr("style"));
						}
						s.onmouseout = function() {
							clearInterval(m.timer);
							clearInterval(m.htimer);
							m.htimer = setInterval(function() {
								slideMenu.slide(s, true)
							}, t);
							//console.log($(this).find('.mask_b').html());
							$(this).find('.mask_b').show();
							//console.log($(this).find('.mask_b').attr("style"));
						}
					},
					slide : function(s, c) {
						var cw = parseInt(s.style.width);
						if ((cw < st && !c) || (cw > gw && c)) {
							var owt = 0;
							var i = 0;
							for (i; i < l; i++) {
								if (sa[i] != s) {
									var o, ow;
									var oi = 0;
									o = sa[i];
									ow = parseInt(o.style.width);
									if (ow < gw && c) {
										oi = Math.floor((gw - ow) / sp);
										oi = (oi > 0) ? oi : 1;
										o.style.width = (ow + oi) + 'px';
										//console.log(o);
										//console.log(o.style.width);
									} else if (ow > ot && !c) {
										oi = Math.floor((ow - ot) / sp);
										oi = (oi > 0) ? oi : 1;
										o.style.width = (ow - oi) + 'px';
										//console.log(o);
										//console.log(o.style.width);
									}
									if (c) {
										owt = owt + (ow + oi)
									} else {
										owt = owt + (ow - oi)
									}
								}
							}
							s.style.width = (w - owt) + 'px';
						} else {
							if (m.htimer)
								clearInterval(m.htimer)
							if (m.timer)
								clearInterval(m.timer);
						}
					}
				};
			}();
			slideMenu.build('sm', 875, 10, 10, 1);
		})();
	</script>
	
	<!--展示部分特效-->
	<script type="text/javascript" src='js/jquery.min.js'></script>
	<script type="text/javascript" src="js/index.js"></script>


<div id="footer">
    	<div id="footer-wrap">
    	<div style="height:20px;"></div>
	        <h3>服务指南</h3>
	       <!--  <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.</p> -->
	         <ul id="sponsors">
	            <li><a href="#"><p>定制指南</p></a></li>
	            <li><a href="#"><p>关于我们</p></a></li>
	            <li><a href="#"><p>信誉保证</p></a></li>
	            <li><a href="#"><p>联系我们</p></a></li>
	        </ul>
	        <div id="copyright">
	        	<p>Copyright &copy; 2018.FourReal All rights reserved.<a href="#"><img src="images/logo6.png"></a></p>
	        </div><!-- END copyright--> 
	        <div class="end"></div>
        </div><!-- END footer-wrap -->
	</div><!-- END footer-->


</body>
</html>