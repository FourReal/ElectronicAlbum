<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<%@ include file="/WEB-INF/jsp/public/commons.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@	taglib prefix="s" uri="/struts-tags"%>
<%
	pageContext.setAttribute("baseURL", request.getContextPath());
%>
<meta charset="utf-8">

<title>相册制作</title>
<link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="${baseURL }/css/Huploadify.css" />
<link rel="stylesheet" type="text/css" href="css/default.css" />
<link rel="stylesheet" type="text/css" href="css/bookblock.css" />
<link rel="stylesheet" type="text/css" href="css/demo5.css" />
<link href="http://how2j.cn/study/css/bootstrap/3.3.5/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script type="text/javascript" src="${baseURL }/js/jquery.Huploadify.js"></script>
<script src="${baseURL }/js/jquery-ui.min.js"></script>
<script src="${baseURL }/js/modernizr.custom.js"></script>
<script src="${baseURL }/js/interact.js"></script>
<script src="http://how2j.cn/study/js/bootstrap/3.3.5/bootstrap.min.js"></script>
<script type="text/javascript" src="js/drag.js"></script>



<script type="text/javascript">
	//点击从本地上传，弹出照片选择，同时将选中的相片放进用户的照片库，并在左侧显示
	$(function() {
		$('#upload')
				.Huploadify(
						{
							auto : true,
							fileTypeExts : '*.jpg;*.jpeg;*.gif;*.png;*.bmp',
							multi : true,
							formData : {},
							fileSizeLimit : 9999,
							showUploadedPercent : false,//是否实时显示上传的百分比，如20%
							showUploadedSize : true,
							removeTimeout : 0,
							fileObjName : 'uploadify',
							buttonText : '<span class="fa fa-upload"></span>从本地上传',

							uploader : 'user_upload.action',
							onUploadStart : function() {
								//alert('开始上传');
							},
							onInit : function() {
								//alert('初始化');
							},
							onUploadComplete : function() {
								//alert('上传完成');
							},
							onDelete : function(file) {
								console.log('删除的文件：' + file);
								console.log(file);
							},
							onUploadSuccess : function(file, data, response) {
								$('.addedph')
										.append(
												'<img src="${baseURL}/'
														+ data
														+ '" name="photosled" width="100px" height="100px" class="drag_l" onclick="photointo(src)"/>');
							},
						});
	});

	//在用户相册照片选择模块点击图片触发事件；
	//输入：图片的id；点击的check（input）id；
	function checkclick(imgid, ckid) {
		console.log(imgid, ckid);
		if (document.getElementById(ckid).checked == true) {
			document.getElementById(ckid).checked = false;
			document.getElementById(imgid).style = "border:none";
		} else {
			document.getElementById(ckid).checked = true;
			document.getElementById(imgid).style = "border: 5px solid #ccc";
		}

		console.log(ckid)
		console.log(document.getElementById(ckid).checked)
	}
</script>
<script>
	(function() {

		var every_x = [ null, null, null, null, null, null, null, null, null,
				null, null, null, null, null, null, null, null, null, null,
				null, null, null, null, null, null, null, null, null, null ];
		var every_y = [ null, null, null, null, null, null, null, null, null,
				null, null, null, null, null, null, null, null, null, null,
				null, null, null, null, null, null, null, null, null, null ];

		function removeByValue(arr, val) {
			for (var i = 0; i < arr.length; i++) {
				if (arr[i] == val) {
					arr.splice(i, 1);
					break;
				}
			}
		}

		Array.prototype.insert = function(index, item) {
			this.splice(index, 1, item);
		};

	})()

	function closep(ele) {
		ele.parentElement.remove();

	}

	//在用户相册界面选择照片后点击“导入”按钮触发的函数	
	$(function() {
		$("#ipfalbbtn")
				.click(
						function() {

							var groupCheckbox = $("input[name='photoselect']");
							for (i = 0; i < groupCheckbox.length; i++) {
								if (groupCheckbox[i].checked) {
									$('.addedph')
											.append(
													'<img src="/ElectronicAlbum/imgs/'
															+ groupCheckbox[i].value
															+ '" name="photosled" width="100px" height="100px" class="drag_l" onclick="photointo(src)"/>')
									console.log(groupCheckbox[i].value);
								}

							}
							$("#ipfalbdia").modal('hide');
							$("input[name='photoselect']").prop("checked",
									false);
						});
	});

	//选择从相册导入按钮，准备弹出的照片选择界面的数据
	$(function() {
		$("#fralb")
				.click(
						function() {
							console.log("从相册导入！")
							$
									.ajax({
										type : "post",
										url : 'photo_scanPhotos.action',
										dataType : "json",//设置需要返回的数据类型
										success : function(d) {
											console.log(d);
											for ( var i in d) {
												$('.selectphoto')
														.append(
																'<span><img src="/ElectronicAlbum/imgs/'
																		+ d[i]
																		+ '" class="photols" name="allphoto" id="'
																		+ i
																		+ '"  width="100px" height="100px" onclick="checkclick(id,\'ck\'+id)"/><input type="checkbox" name="photoselect"   style="display:none"   id=ck'+i+' value="'+d[i]+'"></span>');
												console.log(d[i]);
											}

										},
										error : function(d) {
											alert("error");
											alert(d.responseText);
										}
									});
							console.log(htmlobj)
						});

	});

	//在左侧点击导入后的照片触发；

	function photointo(src) {

		$("#bgp" + $curr_page)
				.prepend(
						'<div class="draggable" id="dg">\n'
								+
								'            <p class="lt"></p>\n'
								+ '			 <img src="'
								+ src
								+ '" name="opphoto" width="100%" height="100%" class="opphotoc">'
								+ '            <p class="wh" id="dgc"></p>\n'
								+ '            <p class="close" style="display: block;font-size:30px;" onclick="closep(this)">x</p>\n'
								+

								'        </div>')
		mydrag("#bgp" + $curr_page, $curr_page + src);
	}

	function mydrag(a, b) {
		console.log(a, b);
		$(a + ' .draggable').each(function(index) {
			$(this).myDrag({
				randomPosition : false,
				direction : 'all',
				handler : false,
				coor : '.wh'
			});
		});

	}
	$(function() {
		$("#ipfalbdia").on("hidden.bs.modal", function() {
			$(".selectphoto").empty();
			console.log(this);
		});
	});
	$(function() {
		$(".tempimg").click(function() {
			$(".middle").css("background", "url(" + this.src + ") no-repeat");
			$(".middle").css("background-size", "cover");
		})
	});
	$(document).ready(function() {
		$("#lastpage").click(function() {
			$(".middle").css("background", "");
			$(".middle").empty();
		});
		$("#nextpage").click(function() {
			$(".middle").css("background", "");
			$(".middle").empty();
		});
	});

	//相册完成制作；
	$(function() {
		$("#submitbtn").click(
				function() {
					console.log("完成制作！");
					var data = [];
					var objDom0 = document.getElementById("itemContainer"); //展示照片编辑区域的ul区域
					var bgps = objDom0.getElementsByClassName("bgps"); //获取objDom0中的li标签
					var obj = $(bgps[0]);

					obj.removeClass("jp-disabled");//显示后取信息

					console.log("bgps.length:" + bgps.length)
					for (var i = 0; i < bgps.length; i++) {//遍历所有模板页
						var draggable = bgps[i]
								.getElementsByClassName("draggable"); //获取每个li中的div标签：（存放照片的元素）
						console.log("div:" + i + draggable.length);
						console.log("当前模板页数：" + $curr_page);
						/**
						 *修正取draggable对象位置大小信息的方式
						 */
						var photos = [];
						for (var j = 0; j < draggable.length; j++) {//遍历照片
							var photo = {};
							photo.src = draggable[j]
									.getElementsByClassName("opphotoc")[0].src;
							photo.x = parseInt($(draggable[j]).css('left'));//draggable[j].offsetLeft;
							photo.y = parseInt($(draggable[j]).css('top'));//
							photo.w = $(draggable[j]).width(); //
							photo.h = $(draggable[j]).height(); //
							photo.page = i;
							console.log("photo:" + photo)
							photos.push(photo);

						}
						data.push(photos);
					}
					console.log("data：" + data);
					var jsonString = JSON.stringify(data);
					console.log(jsonString);
					$.ajax({
						type : "post",
						url : 'user_beAlbum.action',//触发的action
						async : false,//非异步传输
						data : jsonString,//设置要传输的数据
						contentType : "application/json; charset=utf-8",
						success : function(d) {
							alert("相册制作完成！");
						},
						error : function(d) {
							alert("error");
							alert(d.responseText);
						}
					});
				});
	});
</script>
<script src="js/jPages.js"></script>
<script>
	var $curr_page;
	$(function() {
		$("div.holder").jPages({
			containerID : "itemContainer",
			previous : "上一页",
			next : "下一页",
			perPage : 1,
			scrollBrowse : false,
			callback : function(page, items) {
				$curr_page = page.current;
				console.log("当前模板页数：" + $curr_page)
			}
		});
	});
</script>
<style>
* {
	padding: 0px;
	margin: 0px;
}

.draggable {
	position: relative;
	width: 200px;
	height: 200px;
}

h4 h3 {
	text-align: center;
	vertical-align: middle;
}

p.wh {
	position: absolute;
	bottom: 0px;
	right: 0px;
	padding: 2px;
	width: 10px;
	height: 10px;
	cursor: se-resize;
	background-color: #09C;
	margin: 0;
}

p.lt {
	font-size: 8px;
	position: absolute;
	top: 0px;
	left: 0px;
	line-height: 8px;
	padding: 2px;
}

p.close {
	font-size: 8px;
	position: absolute;
	top: 0px;
	right: 0px;
	line-height: 8px;
	padding: 2px;
	cursor: pointer;
	display: none;
}

.content {
	border: 1px solid #ccc;
	width: 90%;
	height: 700px;
	position: relative;
	margin: 0px auto;
}

h1 {
	text-align: center;
}

.left {
	background: #84acb3;
	float: left;
	width: 15%;
	height: 100%;
}

.middle {
	border: 1px solid #ccc;
	border-radius: 6px;
	background: #ffffff;
	width: 100%;
	height: 100%;
	float: left;
	position: relative;
}

.right {
	background: #ccffff;
	width: 15%;
	height: 100%;
	float: right;
}

.drag_l {
	background-color: #234b5e;
	border-radius: 6px;
	color: #f7ebca;
	cursor: pointer;
	margin: 5px;
	padding: 3px;
	width: 100px;
	height: 100px;
}

.drag_l:hover {
	background-color: #577a8b;
}

.photols {
	background-color: #234b5e;
	border-radius: 3px;
	color: #f7ebca;
	cursor: pointer;
	margin-bottom: 10px;
	margin-left: 5%;
	padding: 2px;
	width: 100px;
	height: 100px;
}

.photols:hover {
	background-color: #577a8b;
}

pre {
	color: green;
	padding: 10px 15px;
	background: #f0f0f0;
	border: 1px dotted #333;
	font: 12px/1.5 Courier New;
	margin: 12px;
}

span {
	
}

div#container {
	width: 730px;
	margin: 100px auto;
}

.holder {
	margin-top: 10px;
	text-align: center;
}

.holder a {
	font-size: 12px;
	cursor: pointer;
	margin: 0 5px;
	color: #000000;
	padding: 2px 5px;
}

.holder a:hover {
	background-color: #eee;
	color: #FF4242;
}

.holder a.jp-previous {
	margin-right: 15px;
}

.holder a.jp-next {
	margin-left: 15px;
}

.holder a.jp-current, a.jp-current:hover {
	color: #FF4242;
	font-weight: bold;
}

.holder a.jp-disabled, a.jp-disabled:hover {
	color: #a1a1a1;
}

.holder a.jp-current, a.jp-current:hover, .holder a.jp-disabled, a.jp-disabled:hover
	{
	cursor: default;
	background: none;
}

.holder span {
	margin: 0 5px;
}

div#content {
	width: 700px;
}

.bgps {
	height: 675px;
}
</style>

<style type="text/css">
body {
	font-size: 12px;
	background-color: #eee;
}

div.container div.row div {
	
}

div.container div.row div {
	text-align: center;
}

.wraps {
	clear: both;
}

.wraps input {
	width: 300px
}

.preview, .del {
	cursor: pointer;
	text-indent: -99999px;
	float: left;
	margin-left: 20px
}

.panel-body {
	height: 800px;
}

.panel-heading {
	padding: 5px;
	height: 45px;
}

.thumbnail {
	height: 80px;
	margin-bottom: 10px;
}

.del {
	position: absolute;
	top: 0;
	right: 0;
	background-color: white;
}

ul li {
	list-style: none
}

#pics {
	padding: 10px;
	border: 1px solid #ccc;
	height: 200px
}

#pics li {
	float: left;
	display: block;
	width: 100px;
	height: 80px;
	padding: 2px;
	border: 1px solid #ccc;
	margin: 10px;
}
</style>


</head>
<body>
	<div class="panel panel-default">
		<div class="panel-heading">
			<div class="finishbtn" style="float: right; margin-right: 10px">
				<span id="submitbtn" class="btn btn-default">
				<span class="glyphicon glyphicon-floppy-save"></span> 保存</span>
			</div>
		</div>
		<div class="panel-body">

			<div class="row">
				<nobr>
				<!-- 左侧照片操作区域 -->
				<div class="col-xs-2 " style="">
					<div class="panel panel-danger">
						<div class="panel-heading">
							<div class="impbtngroup" align="center">
								<button type="button" id="fralb" class="btn btn-primary"
									data-toggle="modal" data-target="#ipfalbdia">
									<span class="fa fa-folder-o"> 从相册导入</span>
								</button>
								<span id="upload"></span>
							</div>
						</div>
						<div class="panel-body" style="height: 700px">
							<div id="photo" class="addedph"></div>
						</div>
					</div>
				</div>

				<!-- 中间相册编辑区域 -->
				<div class="col-xs-9 " style="width:1260px">
					<div class="panel panel-danger">
						<div class="panel-heading">
							<div class="holder"></div>

						</div>

						<!-- 相册背景图片展示界面 -->
						<div class="panel-body" style="height: 700px">
							<ul id="itemContainer">
								<s:iterator value="#modelBgps" status="st" var="bgpalb">
									<li id="bgp${st.count}" class="bgps"
										style="background-size:100% 100%;background-image: url('${addr}')"></li>
								</s:iterator>
							</ul>
						</div>

					</div>
				</div>

				<!-- 右侧模板选择区域 -->
				<div class="col-xs-1 ">
					<div class="panel panel-danger">
						<div class="panel-heading">
							<h5 align="center">选择模板</h5>
						</div>
						<div class="panel-body" style="height: 700px">
							<s:iterator value="#albumList">
			  		${description}
			        <a href="user_makeAlbum.action?albumId=${id}"
									class="thumbnail"> <img src="${coverAddr}">
								</a>
							</s:iterator>
						</div>
					</div>
				</div>

				</nobr>

			</div>

		</div>
	</div>


	<!-- 照片选择模块弹出区域 -->
	<div class="modal fade" id="ipfalbdia" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog">
			<div class="modal-content">


				<div class="modal-header">
					<button data-dismiss="modal" class="close" type="button">
						<span aria-hidden="true">×</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title">选择要导入的照片</h4>
				</div>
				<div class="selectphoto" style="margin-top: 10px"></div>

				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default" type="button">取消</button>
					<button class="btn btn-primary" id="ipfalbbtn" type="button">导入</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

</body>
</html>