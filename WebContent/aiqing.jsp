<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>details</title>

<link rel="stylesheet" href="css/shouye.css">

<script   src="js/modernizr-custom-v2.7.1.min.js"></script>
<link href="css/reset.css" rel="stylesheet" type="text/css">
<script src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<link href="css/topstyle.css" rel="stylesheet" type="text/css" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Home</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/main.css">
<script>
	$(document).ready(function(){
var $miaobian=$('.Xcontent08>div');
var $huantu=$('.Xcontent06>img');
var $miaobian1=$('.Xcontent26>div');
$miaobian.mousemove(function(){miaobian(this);});
$miaobian1.click(function(){miaobian1(this);});
function miaobian(thisMb){
	for(var i=0; i<$miaobian.length; i++){
		$miaobian[i].style.borderColor = '#dedede';
	}
	thisMb.style.borderColor = '#cd2426';

	$huantu[0].src = thisMb.children[0].src;
}
function miaobian1(thisMb1){
	for(var i=0; i<$miaobian1.length; i++){
		$miaobian1[i].style.borderColor = '#dedede';
	}
//		thisMb.style.borderColor = '#cd2426';
	$miaobian.css('border-color','#dedede');
	thisMb1.style.borderColor = '#cd2426';
	$huantu[0].src = thisMb1.children[0].src;
}
		$(".Xcontent33").click(function(){
		var value=parseInt($('.input').val())+1;
		$('.input').val(value);
	})

	$(".Xcontent32").click(function(){	
		var num = $(".input").val()
		if(num>0){
			$(".input").val(num-1);
		}			
		
	})

	})
</script>
</head>
<body>
	<a name="top" id="header"></a>


<div class="Xcontent" >
	<ul class="Xcontent01">
		<div class="Xcontent06">  <img src="images/191.jpg"></div>
		<ol class="Xcontent08">
			<div class="Xcontent07"><img src="images/191.jpg"></div>
			<div class="Xcontent09"><img src="images/194.jpg"></div>
			<div class="Xcontent10"><img src="images/195.jpg"></div>
			<div class="Xcontent11"><img src="images/215.jpg"></div>
		</ol>
		<ol class="Xcontent13">
			<div class="Xcontent14"><a href="#"><p>爱情纪念册</p></a></div>
			<!-- <div class="Xcontent15"><img src="images/shangpinxiangqing/X11.png"></div> -->
			<div class="Xcontent17">
				<p class="Xcontent18">售价</p>
				<p class="Xcontent19">￥<span>999.00</span></p> 
				<!-- <div class="Xcontent20">
					<p class="Xcontent21">促销</p>
					<img src="images/shangpinxiangqing/X12.png">
					<p class="Xcontent22">领610元新年礼券，满再赠好礼</p>
				</div> -->
				<div class="Xcontent23">
					<p class="Xcontent24">服务</p>
					<p class="Xcontent25">7天无忧退货&nbsp;&nbsp;&nbsp;&nbsp;</p>
				</div>
			</div>
			<div class="Xcontent30">
				<p class="Xcontent31">数量</p>
				<div class="Xcontent32"><img src="images/X15.png"></div>
				<form><input class="input" value="1"></form>
				<div class="Xcontent33"><img src="images/16.png"></div>
			</div>
			<a href="JavaScript:;" onclick="panduan()" class="Xcontent34" style="display:inline-block;height:38px;
	line-height:38px;text-decoration:none;background:#cd9b9b;font-size:20px;color:#fff;">开始制作</a>
		</ol>
	</ul>
</div>
<script language="JavaScript" type="text/javascript">
 function panduan(){
	   /*alert("onclick attribute in html");  */
	
	 if ("${user}" == ""){
			//console.log("user:"+${user})
		 	alert("您还没有登陆，请先登陆！");
			parent.location.href="${pageContext.request.contextPath}/user_loginUI.action";

		
	}else{
		
		location.href="${pageContext.request.contextPath}/user_makeAlbum.action";
		
		
	} 
	
} 
</script> 
<div class="product">
</div> 
<div id="services" class="services service-section">
  <div class="container">
  <div class="section-header">
                <h2 class="wow fadeInDown animated">商品展示</h2>
                <p class="wow fadeInDown animated">富有温暖感觉的色彩和简洁明确的设计，正如爱情一样，温暖美丽简单.</p>
            </div>
    <div class="section-display">
	  <span class="service-img"><img src="images/新191.jpg" alt="service"/> </span>
        <div class="services-content">
          <h4>Love</h4>
          <!-- <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu libero scelerisque ligula sagittis faucibus eget quis lacus.</p> -->
        </div>
        </div>
      </div>
    <div class="section-display">
	  <span class="service-img"><img src="images/新194.jpg" alt="service"/> </span>
        <div class="services-content">
          <h4>微笑</h4>
         <!--  <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu libero scelerisque ligula sagittis faucibus eget quis lacus.</p> -->
        </div>
	   </div>
    <div class="section-display">
	  <span class="service-img"><img src="images/新195.jpg" alt="service"/> </span>
        <div class="services-content">
          <h4>梦想</h4>
          <!-- <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu libero scelerisque ligula sagittis faucibus eget quis lacus.</p> -->
        </div>
      </div>
  
</div>
<div id="footerimg">
<a href="#header" id="top-arrow" title="Go to Top"><img src="images/top1.png" height="50px" width="50px"alt=""></a>
</div>
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