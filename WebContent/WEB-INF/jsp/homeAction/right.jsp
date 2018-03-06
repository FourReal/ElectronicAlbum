<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="keywords" content="Majestic Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />

<link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
<link href="css/style.css" rel='stylesheet' type='text/css' />
<link href='http://fonts.useso.com/css?family=Titillium+Web:400,200,200italic,300,300italic,400italic,600,600italic,700,700italic,900' rel='stylesheet' type='text/css'>

<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
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
</head>
<body>

	<!--您好，<b>${user.name}</b>
	
	这是平台首页！！！！  -->
	
	<body>

<!--banner-starts-->
<div class="banner" id="home">
	<div class="container">
		<section class="slider">
        	<div class="flexslider">
            	<ul class="slides">
						<li>
							<div class="banner-top">
							<div class="col-md-6 banner-left">
							<div class="bnr-one">
								<img src="myimg/b-01.jpg" alt="" />
								<h3>家庭时光</h3>
								<a href="#">More</a>
							</div>
						</div>
						<div class="col-md-6 banner-left">
							<div class="bnr-one">
								<img src="myimg/b-02.jpg" alt="" />
								<h3>旅行日记</h3>
								<a href="#">More</a>
							</div>
						</div>
						
						<div class="clearfix"></div>
					</div>
				</li>
				<li>
					<div class="banner-top">
						<div class="col-md-6 banner-left">
							<div class="bnr-one">
								<img src="myimg/b-03.jpg" alt="" />
								<h3>我毕业啦</h3>
								<a href="#">More</a>
							</div>
						</div>
						<div class="col-md-6 banner-left">
							<div class="bnr-one">
								<img src="myimg/b-04.jpg" alt="" />
								<h3>爱情纪念</h3>
								<a href="#">More</a>
							</div>
						</div>
						
						<div class="clearfix"></div>
					</div>
				</li>
				<li>
					<div class="banner-top">
						<div class="col-md-6 banner-left">
							<div class="bnr-one">
								<img src="myimg/b-05.jpg" alt="" />
								<h3>宝贝写真</h3>
								<a href="#">More</a>
							</div>
						</div>
						<div class="col-md-6 banner-left">
							<div class="bnr-one">
								<img src="myimg/b-06.jpg" alt="" />
								<h3>个人写真</h3>
								<a href="#">More</a>
							</div>
						</div>
						
						<div class="clearfix"></div>
					</div>
				</li>
          </ul>
        </div>
      </section>
		</div>
	</div>
	<!--banner-ends轮播图--> 
	
	<!--FlexSlider-->
	<link rel="stylesheet" href="css/flexslider.css" type="text/css" media="screen" />
	<script defer src="js/jquery.flexslider.js"></script>
	<script type="text/javascript">
    $(function(){
      SyntaxHighlighter.all();
    });
    $(window).load(function(){
      $('.flexslider').flexslider({
        animation: "slide",
        start: function(slider){
          $('body').removeClass('loading');
        }
      });
    });
  </script>
</div>
			<!--End-slider-script-->
			
	<!--welcome-starts--> 
	<!-- <div class="welcome">
		<div class="container">
			<div class="welcome-top">
				<h1>制作你的独家记忆</h1>
				<p> Maecenas ornare lobortis mi id dapibus. Sed magna leo, malesuada in luctus ut, convallis nec sapien. Nulla rhoncus, nunc sollicitudin sodales elementum, augue nunc congue tellus, a varius urna odio vitae mauris. Aenean ultricies porttitor dui quis laoreet.</p>
			</div>
			<div class="welcome-bottom">
				<div class="col-md-6 welcome-left">
					<h3>Aenean ultricies porttitor</h3>
					<p>Integer tincidunt ligula id lacinia placerat. Etiam rutrum fermentum tortor. Nunc tempor dui nec tincidunt eleifend. Phasellus lacinia gravida mollis. Curabitur laoreet ligula tempus, elementum dui quis, malesuada velit. Nullam cursus a magna vitae vestibulum.</p>
					<div class="welcome-one">
						<div class="col-md-6 welcome-one-left">
							<a href="WebContent/WEB-INF/jsp/homeAction/zhaopianfenye.jsp"><img src="images/w-6.jpg" alt="" /></a>
						</div>
						<div class="col-md-6 welcome-one-right">
							<a href="single.html"><img src="images/w-4.jpg" alt="" /></a>
							<a href="single.html" class="one-top"><img src="images/w-5.jpg" alt="" /></a>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>
				<div class="col-md-6 welcome-left">
					<h3>Nullam mattis nibh dolor</h3>
					<p>Integer tincidunt ligula id lacinia placerat. Etiam rutrum fermentum tortor. Nunc tempor dui nec tincidunt eleifend. Phasellus lacinia gravida mollis. Curabitur laoreet ligula tempus, elementum dui quis, malesuada velit. Nullam cursus a magna vitae vestibulum.</p>
					<div class="welcome-one">
						<a href="single.html"><img src="images/w-2.jpg" alt="" /></a>
					</div>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	welcome-ends 
	offer-starts
	<div class="offer">
		<div class="container">
			<div class="offer-top heading">
				<h2>OUR BEST OFFERS</h2>
			</div>
			<div class="offer-bottom">
				<div class="col-md-3 offer-left">
					<a href="single.html"><img src="images/o-1.jpg" alt="" />
					<h6>$29</h6></a>
					<h4><a href="single.html">Quisque sed neque</a></h4>
					<p>Maecenas interdum augue eget elit interdum, vitae elementum diam molestie. Nulla facilisi.</p>
					<div class="o-btn">
						<a href="single.html">Read More</a>
					</div>
				</div>
				<div class="col-md-3 offer-left">
					<a href="single.html"><img src="images/o-2.jpg" alt="" />
					<h6>$70</h6></a>
					<h4><a href="single.html">Donec mattis nunc</a></h4>
					<p>Maecenas interdum augue eget elit interdum, vitae elementum diam molestie. Nulla facilisi.</p>
					<div class="o-btn">
						<a href="single.html">Read More</a>
					</div>
				</div>
				<div class="col-md-3 offer-left">
					<a href="single.html"><img src="images/o-3.jpg" alt="" />
					<h6>$46</h6></a>
					<h4><a href="single.html">Maecenas non risus</a></h4>
					<p>Maecenas interdum augue eget elit interdum, vitae elementum diam molestie. Nulla facilisi.</p>
					<div class="o-btn">
						<a href="single.html">Read More</a>
					</div>
				</div>
				<div class="col-md-3 offer-left">
					<a href="single.html"><img src="images/o-5.jpg" alt="" />
					<h6>$80</h6></a>
					<h4><a href="single.html">Nullam vitae nisl</a></h4>
					<p>Maecenas interdum augue eget elit interdum, vitae elementum diam molestie. Nulla facilisi.</p>
					<div class="o-btn">
						<a href="single.html">Read More</a>
					</div>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	offer-ends 
	nature-starts 
	<div class="nature">
		<div class="container">
			<div class="nature-top">
				<h3>Maecenas ornare lobortis</h3>
				<p>Phasellus tempor erat id erat gravida pulvinar. Aenean est felis, ullamcorper et volutpat sed, cursus at enim. Vestibulum vel finibus neque. In sed magna tellus.</p>
			</div>
		</div>
	</div>
	nature-ends 
	field-starts 
	<div class="fields">
		<div class="container">
			<div class="fields-top">
				<div class="col-md-4 fields-left">
					<span class="home"></span>
					<h4>Vestibulum vel finibus</h4>
					<p>Pellentesque sed sem bibendum, rutrum ipsum vitae, facilisis turpis. Mauris vitae metus gravida, hendrerit erat ac, facilisis ligula.</p>
				</div>
				<div class="col-md-4 fields-left">
					<span class="men"></span>
					<h4>Quisque non ligula</h4>
					<p>Pellentesque sed sem bibendum, rutrum ipsum vitae, facilisis turpis. Mauris vitae metus gravida, hendrerit erat ac, facilisis ligula.</p>
				</div>
				<div class="col-md-4 fields-left">
					<span class="pen"></span>
					<h4>Lorem ipsum dolor</h4>
					<p>Pellentesque sed sem bibendum, rutrum ipsum vitae, facilisis turpis. Mauris vitae metus gravida, hendrerit erat ac, facilisis ligula.</p>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div> -->
	<!--field-end--> 


</body>
</body>
</html>