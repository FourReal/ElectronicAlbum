<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@	taglib prefix="s" uri="/struts-tags" %>
<%pageContext.setAttribute("baseURL", request.getContextPath()); %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>struts2 +jquey uploadify3.2 实现多文件上传，可预览、删除、排序</title>
<script src="${baseURL }/js/jquery-1.9.1.js" type="text/javascript"></script>
<script src="${baseURL }/js/jquery.uploadify.min.js" type="text/javascript"></script>
<script src="${baseURL }/js/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="${baseURL }/js/ajaxsubmit.js" type="text/javascript" ></script>
<link rel="stylesheet" type="text/css" href="${baseURL }/css/uploadify.css">
<link rel="stylesheet" href="${baseURL }/themes/base/jquery.ui.all.css">
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
<script type="text/javascript">  
  
      $(function() {  
           // $( "#pics" ).sortable();  
          //$( ".wraps" ).disableSelection();  
            $("#uploadFile").uploadify({  
                height        : 30,  
                swf           : '${baseURL}/themes/uploadify.swf',  
                uploader      : '${baseURL}/upload.action?savePath=imgs',  //保存到imgs路径下
                width         : 100,  
                fileObjName:'uploadify',  
                auto : false,  
                buttonText : '<div>选择图片</div>' ,  
                multi : true,  
                 'queueID'  : 'some_file_queue',  
                	//允许上传的文件后缀  
                    'fileTypeExts':'*.jpg;*.jpeg;*.gif;*.png;*.bmp',  
                    //上传文件的大小限制  
                    'fileSizeLimit':'3MB',  
                    //上传数量  
                    'queueSizeLimit' : 15,  
                    //上传成功在pics展示框中显示
                 'onUploadSuccess' : function(file, data, response) { 
                     //$.parseJSON(json)  
                     // alert('The file ' + file.name + ' was successfully uploaded with a response of ' + response + ':' + data);  
                     var html = "<li><div style='position: relative;' id='dfs'> <img src=${baseURL}/"+data+" name='mvUrl' width='100px' height='80px' class='myimg'/><div class='del ui-icon-closethick ui-icon' >删除</div></div></li>";  
                     $("#pics").append(html);  
                    },  
                    'onFallback':function(){  
                        alert("您未安装FLASH控件，无法上传图片！请安装FLASH控件后再试。");  
                    },  
                    onSelectError:function(file, errorCode, errorMsg){  
  
                        switch(errorCode) {  
  
                            case -100:  
  
                                alert("上传的文件数量已经超出系统限制的"+$('#uploadFile').uploadify('settings','queueSizeLimit')+"个文件！");  
  
                                break;  
  
                            case -110:  
  
                                alert("文件 ["+file.name+"] 大小超出系统限制的"+$('#uploadFile').uploadify('settings','fileSizeLimit')+"大小！");  
  
                                break;  
  
                            case -120:  
  
                                alert("文件 ["+file.name+"] 大小异常！");  
  
                                break;  
  
                            case -130:  
  
                                alert("文件 ["+file.name+"] 类型不正确！");  
  
                                break;  
  
                        }  
  
                    }  
            });  
              
          	//删除
          	//jQuery 1.9 已经将 live 和 die 移除，取而代之的是 on 和 off
           $(".del").die().live('click',function(){  
                $(this).parent().parent().remove();  
            });   
           
            $(".preview").on({ mouseenter: function () {  
                var src = $(this).parent().find("input").val();  
                src = "${baseURL}/"+src;  
                $("#testimg").attr("src",src);  
                var left = $(this).position().left;  
                var top = $(this).position().top;  
                $("#imgf").css({left:left,top:top});  
                $("#imgf").show();            
            }, mouseleave: function () {  
                $("#imgf").hide();       
            }  
       	   });  
        });  
        
    function dosubmint(){  
         $(".mvurl").remove();  
         $(".myimg").each(function(){  
            var     d=$(this).attr("src");  
            d = d.replace('${baseURL}/',"");  
            d = "<input type='hidden' name='mvUrl' class='mvurl' value="+d+">";  
            $("#form1").append(d);  
        });  
         $("#form1").ajaxSubmit({    
             type: 'post',    
             //dataType: 'json',   
             success: function(data){    
                 alert(data);    
             },    
             error: function(XmlHttpRequest, textStatus, errorThrown){    
                 alert( "error");    
             }    
         });     
    }  
</script>  
</head>
<body>
    <div id="some_file_queue"></div>  

    <p>按钮</p>
    <input type="file" name="uploadifys" id="uploadFile" />  
    <br /> 
    <p>${baseURL}</p> 
    <form action="${baseURL}upload.action?savePath=imgs" id="form1"  >  
      
    <ul id="pics" >  
    <!--   
        <li class='wraps' name="list"><input type='text' name='mvUrl'  style='float: left;' /><span class='preview ui-icon ui-icon-newwin' >预览</span><span class='del ui-icon-closethick ui-icon'>删除</span></li> 
      
    <!--
    <li name="list">  
        <div style="position: relative;">  
            <img src="${baseURL }/" name="mvUrl" width="100px" height="80px" class="myimg"/>  
            <div class='del ui-icon-closethick ui-icon' style="position: absolute;top: 0;right: 0;background-color: white;">删除</div>  
        </div>  
    </li>  
      -->
    </ul>  
    </form>  
    <div style="clear: both;margin-top: 20px">  
  
        <button class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" onclick="javascript:$('#uploadFile').uploadify('upload','*')">  
            <span class="ui-button-icon-primary ui-icon ui-icon-play"></span> <span class="ui-button-text">开始上传</span>  
        </button>  
  
        <button class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" onclick="javascript:$('#uploadFile').uploadify('cancel','*')">  
            <span class="ui-button-icon-primary ui-icon ui-icon-cancel"></span> <span class="ui-button-text">取消上传</span>  
        </button>  
  
        <button class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" onclick="dosubmint()">  
            <span class="ui-button-icon-primary ui-icon ui-icon-locked"></span> <span class="ui-button-text">完成</span>  
        </button>  
    </div> 
    <s:a action="photo_findPhotos?userid=1"><input type="button"  value="查找"/></s:a>
</body>
</html>