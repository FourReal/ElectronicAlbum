<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="refresh" content="5;URL=${pageContext.request.contextPath}/home_index.action">
<link rel="stylesheet" href="css/logout.css">
<title>Insert title here</title>
</head>
<body>
	<div id="js-alert-box" class="alert-box"> <svg class="alert-circle" width="234" height="234">
	  <circle cx="117" cy="117" r="108" fill="#FFF" stroke="#43AEFA" stroke-width="17"></circle>
	  <circle id="js-sec-circle" class="alert-sec-circle" cx="117" cy="117" r="108" fill="transparent" stroke="#F4F1F1" stroke-width="18" transform="rotate(-90 117 117)"></circle>
	  <text class="alert-sec-unit" x="82" y="172" fill="#BDBDBD">secs</text>
	  </svg>
	  <div id="js-sec-text" class="alert-sec-text"></div>
	  <div class="alert-body">
	    <div id="js-alert-head" class="alert-head"></div>
		<div style="height:70px"></div>
	    <a id="js-alert-btn" class="alert-btn"  href="${pageContext.request.contextPath}/home_index.action">立即前往首页</a> 
	    
	    </div>

	</div>
	<script>
	function alertSet(e) {
	    document.getElementById("js-alert-box").style.display = "block",
	    document.getElementById("js-alert-head").innerHTML = e;
	    var t = 5,
	    n = document.getElementById("js-sec-circle");
	    document.getElementById("js-sec-text").innerHTML = t,
	    setInterval(function() {
	        if (0 == t){
				location.href="#";//#时间到后跳转地址
			}else {
	            t -= 1,
	            document.getElementById("js-sec-text").innerHTML = t;
	            var e = Math.round(t / 5 * 735);
	            n.style.strokeDashoffset = e - 735
	        }
	    },
	    970);
	}
	alertSet('注销成功');
	</script>
</body>
</html>