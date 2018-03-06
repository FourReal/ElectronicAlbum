<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
<link href="css/style.css" rel='stylesheet' type='text/css' />
<link rel="stylesheet" href="css/aboutsmoth.css"/>
<link href='http://fonts.useso.com/css?family=Titillium+Web:400,200,200italic,300,300italic,400italic,600,600italic,700,700italic,900' rel='stylesheet' type='text/css'>
<script src="js/jquery-1.11.0.min.js"></script>


	<!---- start-smoth-scrolling---->
	<script type="text/javascript" src="js/move-top.js"></script>
	<script type="text/javascript" src="js/easing.js"></script>
	<script type="text/javascript">
        jQuery(document).ready(function($) {
            $(".scroll").click(function(event){
                event.preventDefault();
                $('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
            });
        });
	</script>
	<!---- start-smoth-scrolling---->
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/style4.css" />
<script type="text/javascript" src="js/modernizr.custom.79639.js"></script>
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/jquery.indexSlidePattern.js"></script>
	<!--轮播-->
	<script language="javascript">
        $(document).ready(function(e){
            var opt	=	{
                "speed"	:	"fast"		,	//变换速度,三速度可选 slow,normal,fast;
                "by"	:	"mouseover"		,	//触发事件,click或者mouseover;
                "auto"	:	true		,	//是否自动播放;
                "sec"	:	3000	 		//自动播放间隔;
            };
            $("#demo").IMGDEMO(opt);
        });
	</script>
	<!--轮播-->


<title>Insert title here</title>
</head>
<body>
<!--轮播-->
<ul id="demo">
	<li class="active">
		<a href="http://sc.chinaz.com/jiaoben/"><img src="myimg/tourbanner01.jpg"  /></a>
		<div><a href="http://sc.chinaz.com/jiaoben/">1</a></div>
	</li>
	<li>
		<a href="http://sc.chinaz.com/jiaoben/"><img src="myimg/tourbanner02.jpg"  /></a>
		<div><a href="http://sc.chinaz.com/jiaoben/">2</a></div>
	</li>
	<li>
		<a href="http://sc.chinaz.com/jiaoben/"><img src="myimg/tourbanner03.jpg"  /></a>
		<div><a href="http://sc.chinaz.com/jiaoben/">3</a></div>
	</li>
	<li>
		<a href="http://sc.chinaz.com/jiaoben/"><img src="myimg/tourbanner04.jpg"  /></a>
		<div><a href="http://sc.chinaz.com/jiaoben/">4</a></div>
	</li>
	<li>
		<a href="http://sc.chinaz.com/jiaoben/"><img src="myimg/tourbanner05.jpg"  /></a>
		<div><a href="http://sc.chinaz.com/jiaoben/">5</a></div>
	</li>
</ul>

<!--轮播-->
	<!--about-starts--> 
	<div class="about">
		<div class="container">
			<div class="about-top heading">
				<h1>旅游照片书</h1>
				<h4>旅途中的风景和心情，都要记录！</h4>


				<div class="about-bottom">
					<div class="col-md-12 about-left">
						<br/><br/>
				
						<a href="single.html"><img src="myimg/tour01.jpg" alt="" /></a>

						<p style="font-family: Helvetica Neue, Helvetica, Arial, sans-serif;color: #000;text-align:center ">
							<em>旅途中的风景与故事<br/>收录进来，才不辜负。<br/><br/></em>
						</p>
					</div>
					<div class="col-md-6 about-left">
						<a href="single.html"><img src="myimg/tour02.jpg" alt="" /></a>
						<h5 style="font-size: 28px"><a href="single.html">书籍质感，爱不释手</a></h5>
						<p>源于书本，高于书本，厚薄有度。完整收录你的旅行回忆。</p>
					</div>
					<div class="col-md-6 about-left">
						<a href="single.html"><img src="#" alt="" /></a>
						<h5 style="font-size: 28px"><a href="single.html">排版多样，选择多元</a></h5>
						<p>手动排版，自动排版，多种模板，任意选择。</p>
					</div>

					<div class="col-md-6 about-left">
						<a href="single.html"><img src="myimg/tour03.jpg" alt="" /></a>

					<div class="col-md-6 about-left">
						<a href="single.html"><img src="#" alt="" /></a>

					</div>
					<div class="clearfix"></div>
				</div>
			</div>
		</div>
	</div>
	<!----about-end---->
		<br/><br/><br/>
		<!--advantages-starts-->

	<div class="advantages" >
		<div class="container">
			<div class="col-md-6 advantages-left heading">
				<h2>10分钟，简单轻松制作一本相册</h2>
				
			<div class="clearfix"></div>
		</div>
	</div>
	<!--advantages-end--> 
	<!--team-starts-->
		<div class="offer">
			<div class="container">
				<div class="offer-bottom">
					<div class="o-btn">
						<a href="single.html" style="font-size: 30px">去制作！</a>
					</div>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
	
	</div>
	</div>
</body>
</html>