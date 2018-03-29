<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
<!--CSS-->
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <link type="text/css" href="css/my_album.css" rel="stylesheet">
    <!--bootstrap-->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/buttons.css">
    <style type="text/css">
    .container{
    	max-width: 1350px;
    }
    </style>
    <script type="text/javascript">
	    function order(id){
			 $.ajax({
	             type : "post",
	             url : 'order_add.action?albumBookid='+id,
	             dataType : "json",//设置需要返回的数据类型
	             success : function(d) {
	             	alert("加入购物车成功！！！")					
	                 
	             },
	             error : function(d) {
	             	alert("error");
	                 alert(d.responseText);
	             }
	         	});
	    }
    </script>

</head>
<body>

<!-- 修改的样式 -->

   
 <div class="content1">
            <div class="content-photo">
                <h3 style="text-align: center">我的相册<p style="font-size: 10px">（鼠标悬浮可预览相册描述）</p></h3>
                
                <a href="user_makeAlbum.action" class="add-photo">
                <button class="addbtn" style="width:90px; background:#FFF0F5;text-align:center;line-height:center;height:30px;border:1px solid #ccc;border-radius:3px;color:#cd9b9b;cursor:pointer;">制作 >></button></a>
                <div class="zzsc-container">
                    <div class="container mt50">
                        <div class="row">
                            <s:iterator value="#albumBookList">
	                            <div class="col-md-3" style="margin-top:40px;">
	                            	<h5 class="title"><s:a action="albumbook_output.action?albumId=%{id}" target="_parent">${name}</s:a></h5>
	                                
	                                <div class="box">
	                                    <img src="${album.coverAddr}" alt="">
	                                    <div class="over-layer">
	                                       
	                                        <p class="description">
	                                            ${description}
	                                        </p>
	                                        <p class="description">
	                                        	<span><s:a action="albumbook_reedit?id=%{id}">再编辑</s:a></span>
	                                        	<span><s:a action="albumbook_editUI?id=%{id}" class="edit">修改相册信息</s:a></span>
	                                            <span><s:a action="albumbook_delete?id=%{id}" onclick="return confirm('您确定要删除该相册书吗？')" class="delete">删除</s:a></span>
												
												
	                                        </p>
											<p class="description">
											<span><a id="addorder" href="#" onclick="order(${id})">加入购物车</a></span>
	                                        </p>
	                                        
	                                        
	                                    </div>
	                                </div>
	                            </div>
                            </s:iterator>

                            <!--//.add-->
                        </div><!--//row-->

                    </div>
                </div>
            </div>
        </div>
	
</body>
</html>