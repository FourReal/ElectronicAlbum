<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>  
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>支付</title>  
    <%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
    <style type="text/css">  
        /* CSS Document */  
        body,ul,ol,li,p,h1,h2,h3,h4,h5,h6,form,table,td,img,div,dl,dt,dd,input{margin:0;padding:0; box-sizing: border-box}  
         
        img{border:none;}  
        li{list-style:none;}  
        input,select,textarea{outline:none;}  
        textarea{resize:none;}  
        a{text-decoration:none;}  
        /*清浮动*/  
        .clearfix:after{content:"";display:block;clear:both;}  
        .clearfix{zoom:1;}  
  
        /* 取消a标签点击后的虚线框 */  
        a {outline: none;}  
        a:active {star:expression(this.onFocus=this.blur());}  
        input[type="text"]{  
            outline: none;  
        }  
        /*付款方式*/  
        .header{
        	width:950px;  
           height:50px; 
            background: #eee;  
            margin:10px auto;  
            border:1px solid #eee;
            border-radius:3px;
            
        }
        .header ul{
        text-align:center;
        
        }
        .header ul li{
        float:left;
        margin-right:20px;
        line-height:50px;
        }
        
        .payWrap{  
            width:950px;  
            min-height: 560px;  
            background: #FFFFFF;  
            margin: 0 auto;  
        }  
        .payHeader{  
          	margin-top:20px;
          	margin-bottom:20px;
         
           }
           .line{
          border: 1px solid #CCCCCC;
          
           margin: 0 auto;  
            width:950px;  
           }
 
        .payWrap .fontsize{  
            color:#d81e06 ;  
            font-size: 18px;  
            margin:0 5px;  
        }  
        .payContent{  
            padding:10px 20px;  
            height:300px;
        }  
         .payContent ul li{
         text-align:center;
         margin-bottom:10px;
         
         }
        .unionpayList{  
            width: 100%;  
            height: 40px;  
            line-height: 40px;  
            margin: 5px 0;  
            position: relative;  
            border: 2px solid #FFFFFF;  
        }  
       
      /*   .unionPrice{  
            position: absolute;  
            top: 0;  
            right: 20px;  
        }   */
       
       
        .payBorder{  
            width: 100%;  
            border-top: 1px solid #f2f2f2;  
            margin-top: 30px;  
        }  
        .payBut{  
            display: block;  
            width: 150px;  
            height: 32px;  
            line-height: 32px;  
            text-align: center;  
            background: red;  
            color: #fff;  
            float: right;  
            margin: 20px 0;  
        }  
       
    </style>  
</head>  
<body>  
 <div class="header">
 	<ul>
		 <li style="margin-left:30px;margin-top:10px;"><img src="images/duihao.jpg" /></li>
 		<li style="font-size:16px;">您的订单已经提交成功</li>
 	</ul>  
 </div>
<div class="payWrap">  
    <div class="payHeader">  
    	<s:iterator value="#session.payorders" status="st" >
    		<ul>
	       	<strong>订单编号：${ id }</strong>  
	        <strong class="fontsize">价格：￥${ totalprice }</strong>
	        </ul>
	    </s:iterator>
    </div>  
     
    <div class="line"></div>
    <section class="payContent">  
        <div class="unionpayList ">
        	<ul>  
        	<li><img src="images/zhifu.png" /></li>
           <li>共支付<strong class="fontsize">${ totalprice }</strong>元  </li>
           </ul>
        </div>  
   
    </section> 
     <div class="payBorder">  
            <s:a action="trolley_pay" class="payBut">确认支付</s:a>  
           
        </div>   
</div>  

</body>  
</html>  