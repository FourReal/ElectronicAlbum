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
    /* $(function(){
		   $("#addorder${id}").click(function(){
			   console.log("11111")
				 $.ajax({
              type : "post",
              url : 'order_add.action?albumBookid=${id}',
              dataType : "json",//设置需要返回的数据类型
              success : function(d) {
              	alert("加入购物车成功！！！")					
                  
              },
              error : function(d) {
              	alert("error");
                  alert(d.responseText);
              }
          	});
		   });
		   
	}); */
    </script>
<!-- 之前的代码
<style type="text/css">
	#table table {
		width: 100%;
		font-size: 14px;
		border: 1px solid #ccc;
		border-radius:5px;
	}
	
	#table {
		padding: 0 10px;
		border-radius:5px;
	}
	table thead{
	border-radius:5px;
	}
	
	table thead th {
		background: #ccc;
		padding: 10px;
		text-align: left;
	
	}
	
	
	table tbody td {
		padding: 10px;
		text-align: left;
		border-bottom: 1px solid #ccc;
		border-right: 1px solid #ccc;
	}
	
	table tbody td span {
		margin: 0 10px;
		cursor: pointer;
	}
	
	.delete {
		color: red;
	}
	
	.edit {
		color: #008cd5;
	}
	
	.add {
		border: 1px solid #eee;
		margin: 10px 0;
		padding: 15px;
	}
	
	input {
		border: 1px solid #ccc;
		padding: 5px;
		border-radius: 3px;
		margin-right: 15px;
	}
	
	button {
		background: #008cd5;
		border: 0;
		padding: 4px 15px;
		border-radius: 3px;
		color: #fff;
	}
	
	a{
	text-decoration:none;
	}
	
	
</style> -->

</head>
<body>

<!-- 修改的样式 -->

   
 <div class="content1">
            <div class="content-photo">
                <h4 style="text-align: center">我的相册</h4>
                <p style="font-size: 14px;text-align: right">（鼠标悬浮可预览相册描述）</p>
                <a href="user_makeAlbum.action" class="add-photo">
                    <button>制作相册</button>
                </a>
                <div class="zzsc-container">
                    <div class="container mt50">
                        <div class="row">
                            <s:iterator value="#albumBookList">
                            <div class="col-md-4">
                            	<h5 class="title"><s:a action="albumbook_output.action?albumId=%{id}" target="_parent">${name}</s:a></h5>
                                
                                <div class="box">
                                    <img src="${album.coverAddr}" alt="">
                                    <div class="over-layer">
                                       
                                        <p class="description">
                                            ${description}
                                        </p>
                                        <p class="description" >
                                        	<span><s:a action="albumbook_reedit?id=%{id}">再编辑</s:a></span>
                                        	<span><s:a action="albumbook_editUI?id=%{id}" class="edit">修改相册信息</s:a></span>
                                            <span><s:a action="albumbook_delete?id=%{id}" onclick="return confirm('您确定要删除该相册书吗？')" class="delete">删除</s:a></span>
											<span><a id="addorder" href="#" onclick="order(${id})">加入购物车</a></span>
                                        </p>
                                        
                                    </div>
                                </div>
                            </div>
                            
<%-- 								<tr>
									<td width="10%"><s:a action="albumbook_show?id=%{id}">${id}</s:a>&nbsp;</td>
									<td><s:a action="albumbook_output.action?albumId=%{id}" target="_parent">${name}&nbsp</s:a></td>
									<td>${description}&nbsp;</td>
									<td width="30%"><span><s:a action="albumbook_delete?id=%{id}" onclick="return confirm('您确定要删除该相册书吗？')" class="delete">删除</s:a></span>
									<span><s:a action="albumbook_editUI?id=%{id}" class="edit">修改相册信息</s:a></span>
									<span><s:a action="albumbook_reedit?id=%{id}">再编辑</s:a></span>
									</td>
								</tr> --%>
							</s:iterator>
							
<%--                             <div class="col-md-4">
                                <div class="box">
                                    <img src="img/tour03.jpg" alt="">
                                    <div class="over-layer">
                                        <h3 class="title">我的相册</h3>
                                        <p class="description">
                                            相册描述balabala
                                        </p>
                                        <p class="description">
                                            <span><s:a action="albumbook_delete?id=%{id}" onclick="return confirm('您确定要删除该相册书吗？')" class="delete">删除</s:a></span>
				<span><s:a action="albumbook_editUI?id=%{id}" class="edit">修改相册信息</s:a></span>
				<span><s:a action="albumbook_reedit?id=%{id}">再编辑</s:a></span>
                                        </p>
                                        
                                    </div>
                                </div>
                            </div> --%>

                            
                            <!--添加框-->


                            <!--//.add-->
                        </div><!--//row-->

                    </div>
                </div>
            </div>
        </div>
     




<!-- 	添加样式的版本 -->
	<%-- <div id="table">
	<table cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<th>相册id</th>
				<th>相册书名</th>
				<th>描述</th>
				<th>操作</th>
				
			</tr>
		</thead>
		<tbody>
		<s:iterator value="#albumBookList">
			<tr>
				<td width="10%"><s:a action="albumbook_show?id=%{id}">${id}</s:a>&nbsp;</td>
				<td width="10%">${name}&nbsp;</td>
				<td>${description}&nbsp;</td>
				<td width="30%"><span><s:a action="albumbook_delete?id=%{id}" onclick="return confirm('您确定要删除该相册书吗？')" class="delete">删除</s:a></span>
				<span><s:a action="albumbook_editUI?id=%{id}" class="edit">修改相册信息</s:a></span>
				<span><s:a action="albumbook_reedit?id=%{id}">再编辑</s:a></span>
				</td>
			</tr>
		</s:iterator>
		</tbody>
	</table>
	</div>
 --%>
	
	
</body>
</html>