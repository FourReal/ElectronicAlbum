<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@	taglib prefix="s" uri="/struts-tags" %>
<%pageContext.setAttribute("baseURL", request.getContextPath()); %>
<meta charset="utf-8">
<title>jQuery创建DIV块拖动布局代码 - 站长素材</title>
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="${baseURL }/css/Huploadify.css"/>
<script type="text/javascript" src="${baseURL }/js/jquery.Huploadify.js"></script>


<script src="${baseURL }/js/interact.js"></script>
<link href="http://how2j.cn/study/css/bootstrap/3.3.5/bootstrap.min.css" rel="stylesheet">
<script src="http://how2j.cn/study/js/bootstrap/3.3.5/bootstrap.min.js"></script>
<script type="text/javascript">  
$(function(){
	$('#upload').Huploadify({
		auto:true,
		fileTypeExts:'*.jpg;*.jpeg;*.gif;*.png;*.bmp',  
		multi:true,
		formData:{key:123456,key2:'vvvv'},
		fileSizeLimit:9999,
		showUploadedPercent:false,//是否实时显示上传的百分比，如20%
		showUploadedSize:true,
		removeTimeout:0,
		fileObjName:'uploadify',  
		buttonText:'从本地上传',
		itemTemplate:'photo',
		uploader:'${baseURL}/upload.action?savePath=imgs',
		onUploadStart:function(){
			//alert('开始上传');
			},
		onInit:function(){
			//alert('初始化');
			},
		onUploadComplete:function(){
			//alert('上传完成');
			},
		onDelete:function(file){
			console.log('删除的文件：'+file);
			console.log(file);
		},
			onUploadSuccess : function(file, data, response) { 
                //$.parseJSON(json)  
                // alert('The file ' + file.name + ' was successfully uploaded with a response of ' + response + ':' + data);  
				$('.addedph').append('<img src="${baseURL}/'+data+'" name="photosled" width="100px" height="100px" class="drag_l" onclick="photointo(src)"/>');
               },  
		});
	});

function checkclick(imgid,ckid){
	if(document.getElementById(ckid).checked ==true){
		document.getElementById(ckid).checked = false;
		document.getElementById(imgid).style="border:none";
	}else{
		document.getElementById(ckid).checked = true;
		document.getElementById(imgid).style="border: 5px solid #ccc";
	}

	console.log(ckid)
	console.log(document.getElementById(ckid).checked)
}
</script> 
<script>
	(function () {

		$(function () {
			$('.addedph').click(function (event) {

			});

			mydrag();

		});
		var every_x = [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null];
		var every_y = [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null];


		function removeByValue(arr, val) {
			for (var i = 0; i < arr.length; i++) {
				if (arr[i] == val) {
					arr.splice(i, 1);
					break;
				}
			}
		}

		Array.prototype.insert = function (index, item) {
			this.splice(index, 1, item);
		};

		var mydrag = function () {
			// target elements with the "draggable" class
			interact('.draggable')

				.draggable({

					// enable inertial throwing
					inertia: false,

					// keep the element within the area of it's parent
					restrict: {
						restriction: "parent",
						endOnly: true,
						elementRect: {top: 0, left: 0, bottom: 1, right: 1}
					},


					maxPerElement: 100,
					onmove: dragMoveListener,


					onend: function (event) {
						console.log('onend');
						var textEl = event.target.querySelector('p.lt');

						textEl && (textEl.textContent =
							position(event));

						var closeEl = event.target.querySelector('p.close');
						closeEl.style.display = 'block';

						drag_s(event);

						//myclose(event);

					}


				})

				.resizable({
					// resize from all edges and corners
					edges: {left: true, right: true, bottom: true, top: true},

					// keep the edges inside the parent
					restrictEdges: {
						outer: 'parent',
						endOnly: true
					},

					// minimum size
					restrictSize: {
						min: {width: 50, height: 50}
					},


					inertia: false
				})
				.on('resizemove', function (event) {
					var s = $(event.target);
					var target = event.target,
						x = (parseFloat(target.getAttribute('data-x')) || 0),
						y = (parseFloat(target.getAttribute('data-y')) || 0),
						xr=(parseFloat(target.getAttribute('data-x')) || 0)+s.width(),
						yb=(parseFloat(target.getAttribute('data-y')) || 0)+s.height();

					 // update the element's style



					// translate when resizing from top or left edges
					x += event.deltaRect.left;
					y += event.deltaRect.top;
					xr += event.deltaRect.right;
					yb += event.deltaRect.bottom;




					var s = $(event.target);
					var sid = s.attr('id');
					var ns = parseInt(sid);

					var i = ns * 2
					every_y[i] = null;
					every_x[i] = null;
					every_y[i + 1] = null;
					every_x[i + 1] = null;



					 for (ax in every_x) {
						if ((parseInt(every_x[ax]) - 3) <= x && x <= (parseInt(every_x[ax]) + 3)) {

							x = parseInt(every_x[ax]);
						}else {
						}

					}
					for (ay in every_y) {
						if ((parseInt(every_y[ay]) - 3) <= y && y <= (parseInt(every_y[ay]) + 3)) {
							  y = parseInt(every_y[ay]);

						}else {


						}
					}

					for (a_x in every_x) {

						if ((parseInt(every_x[a_x]) - 3) <= xr && xr <= (parseInt(every_x[a_x]) + 3)) {
							   xr = parseInt(every_x[a_x]);

						}else {

						}
					}
					for (a_y in every_y) {
						if ((parseInt(every_y[a_y]) - 3) <= yb&& yb <= (parseInt(every_y[a_y]) + 3)) {
							 yb = parseInt(every_y[a_y]);
						 }else {

						}
					}



					target.style.width = (xr-x) + 'px';
					target.style.height =(yb-y) + 'px';

					target.style.webkitTransform = target.style.transform =
						'translate(' + x + 'px,' + y + 'px)';

					target.setAttribute('data-x', x);
					target.setAttribute('data-y', y);
					target.querySelector('p.wh').textContent =(xr-x) + '\u00D7' +(yb-y) + 'px';
					var textEl = event.target.querySelector('p.lt');

					textEl && (textEl.textContent =
						position(event));



				})
				.on('resizeend', function (event) {

					drag_s(event)

				});



			function dragMoveListener(event) {
				console.log("dragMoveListener")
				var target = event.target,
					// keep the dragged position in the data-x/data-y attributes
					x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx,
					y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy;


				var s = $(event.target)
				var sid = s.attr('id');
				var ns = parseInt(sid);

				var i = ns * 2
				every_y[i] = null;
				every_x[i] = null;
				every_y[i + 1] = null;
				every_x[i + 1] = null;


				for (ax in every_x) {

					if ((parseInt(every_x[ax]) - 3) <= x && x <= (parseInt(every_x[ax]) + 3)) {

						x = parseInt(every_x[ax]);

					}
				}
				for (ay in every_y) {
					if ((parseInt(every_y[ay]) - 3) <= y && y <= (parseInt(every_y[ay]) + 3)) {
						y = parseInt(every_y[ay]);


					}
				}

				for (a_x in every_x) {

					if ((parseInt(every_x[a_x]) - 3) <= (x+s.width()) && (x+s.width()) <= (parseInt(every_x[a_x]) + 3)) {

						x = parseInt(every_x[a_x])-s.width();

					}
				}
				for (a_y in every_y) {
					if ((parseInt(every_y[a_y]) - 3) <= (y+s.height()) && (y+s.height()) <= (parseInt(every_y[a_y]) + 3)) {
						y = parseInt(every_y[a_y])-s.height();


					}
				}


				// translate the element
				target.style.webkitTransform =
					target.style.transform =
						'translate(' + x + 'px, ' + y + 'px)';

				// update the posiion attributes
				target.setAttribute('data-x', x);
				target.setAttribute('data-y', y);


			}


			function position(e) {
				return '左' + e.target.getAttribute('data-x') + "上" + e.target.getAttribute('data-y') + 'px'
			}



			function drag_s(event) {
				var s = $(event.target)
				var sid = s.attr('id');
				var ns = parseInt(sid);
				 var i = ns * 2
				// top  right  bottom left   //data-y  data-x+width  data-y+height  data-x

				every_y.insert(i, parseFloat(s.attr('data-y')));
				every_x.insert(i, parseFloat(s.attr('data-x')) + parseFloat(s.width()));
				every_y.insert(i + 1, parseFloat(s.attr('data-y')) + parseFloat(s.height()));
				every_x.insert(i + 1, parseFloat(s.attr('data-x')));

				console.log("drag s")
			}

			function drag_c(event) {
				var s = $(event.target)
				var sid = s.attr('id');
				var ns = parseInt(sid);


				var i = ns * 2

				every_y.insert(i, 0);
				every_x.insert(i, 0);
				every_y.insert(i + 1, 0);
				every_x.insert(i + 1, 0);
				console.log("drag c")
			 };



			window.dragMoveListener = dragMoveListener;

		};
		


	})()

	function closep(ele){
		ele.parentElement.remove();

	}

		
	$(function(){
	   $("#ipfalbbtn").click(function(){
		  var groupCheckbox=$("input[name='photoselect']");
		  for(i=0;i<groupCheckbox.length;i++){
			if(groupCheckbox[i].checked){
					$('.addedph').append('<img src="/ElectronicAlbum/imgs/'+groupCheckbox[i].value+'" name="photosled" width="100px" height="100px" class="drag_l" onclick="photointo(src)"/> ')
					console.log(i);
			}
					
		  }
		  $("#ipfalbdia").modal('hide');
		  $("input[name='photoselect']").prop("checked",false);
	   });
	});

	function photointo(src){
		console.log(src)
		$('.middle').append('<div class="draggable" id="">\n' +
					//'            <h4>' + $(this).text() + '</h4>\n' +
					'            <p class="lt"></p>\n' +
					'			 <img src="'+src+'" name="opphoto" width="100%" height="100%" class="opphotoc">'+
					'            <p class="wh"></p>\n' +
					'            <p class="close" style="display: block;" onclick="closep(this)">x</p>\n' +

					'        </div>')
	}
	
	$(function(){
	    $("#ipfalbdia").on("hidden.bs.modal",function(){
	    	console.log(this)
	    	for(var i=1;i<50;i++){
	    		document.getElementById(i).style="border:none";
	    		//document.getElementById('ck'+i).checked="false";
	    	}
	      //alert("隐藏模态窗口完毕");
	    });
	});
	$(function(){
		$("#tp1").click(function(){
			console.log(document.getElementById('tp1').src);
			console.log(this)
			$(".middle").css("background","url("+this.src+")");
		})
	});
</script>

<style>
	* {
		padding: 0px;
		margin: 0px;
	}
	
	.draggable {

		width: 200px;
		height: 200px;
		line-height: 50px;
		min-height: 10px;
		min-width: 10px;
		margin: 0px;
		position: absolute;
		padding: 1px;
		left: 0px;
		right: 0px;
		background-color: #fff;

		color: white;

		border-radius: 0px;
		padding: 0px;
		float: left;
		margin: 0px;

		overflow: hidden;
		

	}

	h4 {
		text-align: center;
		vertical-align: middle;
	}

	p.wh {
		font-size: 8px;
		position: absolute;
		bottom: 0px;
		right: 0px;
		line-height: 8px;
		padding: 2px;
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
		background: #ffffcc;
		width: 1000px;
		height: 100%;
		float: left;
		position: relative;
		left: 2.5%;
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
		margin-bottom: 10px;
		margin-left: 5%;
		padding: 5px;
		width: 100px;
		height:100px;

	}

	.drag_l:hover {
		background-color: #577a8b;
	}
    .photols{
    	background-color: #234b5e;
		border-radius: 3px;
		color: #f7ebca;
		cursor: pointer;
		margin-bottom: 10px;
		margin-left: 5%;
		padding: 2px;
		width: 100px;
		height:100px;
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
</style>

<style type="text/css">
body {  
    font-size: 12px;  
}  
  
.wraps {  
    clear: both;   
}  
  
.wraps input {  
    width: 300px  
}  
  
.preview,.del {  
    cursor: pointer;  
    text-indent: -99999px;  
    float: left;  
    margin-left: 20px  
}  
.del{position: absolute;top: 0;right: 0;background-color: white;}  
ul li{list-style: none}  
#pics{padding: 10px;border: 1px solid #ccc;height: 200px}  
#pics li{float: left;display: block;width: 100px;height: 80px;padding: 2px;border: 1px solid #ccc; margin: 10px;}  
</style>  
</head>
<body>
<h4>相册编辑</h4>
<div id="content" class="content">
<div class="left">
	<div>选择图片</div>
	<div class="impphoto">
		<button type="button" action="photo_findPhotos.action" class="btn btn-primary" data-toggle="modal" data-target="#ipfalbdia">
		从相册导入</button>
		<div id="upload"></div> 
	</div>
	<div style="padding-top: 8px;"></div>
	<div id="photo" class="addedph">
		
	</div>
	
</div>

<div class="middle">

</div>

<div class="right">
	<h4>模板</h4>
	<div align="center">
	<table  border="1"   cellpadding="10" class="TableStyle" >
		<thead>
			<tr align="center" valign="middle" id=TableTitle>
				<td><h5>模板名</h5></td>
				<td><h5>描述</h5></td>
				
			</tr>
		</thead>
		<tbody id="TableData" class="dataContainer">
		<s:iterator value="#albumList" status="st">
			<tr class="TableDatail template">
				<td><s:a >${albumName}</s:a>
				<s:a accesskey="user_makeAlbum"><img src="${bgps.iterator().next().addr}" id="tp${st.count}" height="80px" width="80px"></s:a>
				&nbsp;</td>
				<td>${description}&nbsp;</td>
				<td>			
				</td>
			</tr>
		</s:iterator>
		</tbody>
	</table>
	</div>
</div>
</div>
<div class="modal fade" id="ipfalbdia" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog">
        <div class="modal-content">
			<div id="" class="">
					<div>
					<h4>选择要导入的照片</h4>
					</div>
					<br>
					<s:iterator value="#photoList" status="status">
						<span>
						<img src="/ElectronicAlbum/imgs/${PName}" class="photols" name="allphoto" id=${status.count}  width="100px" height="100px" onclick="checkclick(id,'ck'+id)"/>
						<input type="checkbox" name="photoselect"   style="display:none"   id=ck${status.count} value="${PName}">
						</span>									
						<!--<s:property value="PName"/>-->		
					</s:iterator>
			</div>
          <div class="modal-footer">
            <button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
            <button class="btn btn-primary" id="ipfalbbtn" type="button" >导入</button>
          </div>
        </div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div>



</body>
</html>