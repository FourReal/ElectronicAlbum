/**
 * 获取样式
 * @param {Object} obj
 * @param {Object} attr
 */
function getStyle(obj,attr){
	if(obj.currentStyle){
		return obj.currentStyle[attr];
	}else{
		return getComputedStyle(obj,false)[attr];
	}
}
/**
 * 缓冲运动动画
 * @param {Object} obj		对象
 * @param {Object} json		运动目标值
 * @param {Object} speed	速度
 * @param {Object} fn		运动完成回调函数
 */
function buffer(obj,json,speed,fn){
	 var speed = speed || 5;
     clearInterval(obj.t)		//开始前关闭原有的定时器
     obj.t=setInterval(function(){
		  var endMove=true;	   //设置运动停止初始值
		  for(var attr in json){
		  		// iCur 更新运动元素当前的属性值
         		if(attr=='opacity'){	//对透明度单独处理
              		var iCur = parseInt(parseFloat(getStyle(obj, attr))*100);
			 	}else{					//普通样式
              		var iCur = parseInt(getStyle(obj, attr));
			 	}
			 	// 速度取整
		  	 	var iSpeed=(json[attr]-iCur)/speed>0?Math.ceil((json[attr]-iCur)/speed):Math.floor((json[attr]-iCur)/speed);
		  		//检测是否到目标点
		  		if(iCur!=json[attr]){
              		endMove=false;		
		  		}
		  		//设置样式，对透明度单独处理
             	if(attr=='opacity'){
                   obj.style.filter='alpha(opacity='+(iCur+iSpeed)+')';
				   obj.style.opacity=(iCur+iSpeed)/100;
			 	}else{
                   obj.style[attr]=iCur+iSpeed+'px';
			 	}
		  }
		  //运动完成，关闭定时器
		  if(endMove){
             	clearInterval(obj.t)
				obj.t = null;
			 	if(fn){	//回调函数存在，调用回调函数，并把当前对象做为this
                	fn.call(obj);
				}
		  }
	 },30);
}
/**
 * 弹性运动动画 
 * @param {Object} obj		对象
 * @param {Object} json		运动目标值
 * @param {Object} way		是否从中点开始运动
 * @param {Object} fn		运动完成回调函数
 */
function fiexible(obj,json,way,fn){
	/*** 按坐标运动  ***/
	if(way === true){
		//检测left 与 top 是否都有值
		if(typeof json.left !='undefined' && typeof json.top !='undefined'){
			var x = Math.floor(json.left + json.width/2);	//计算X轴中心点
			var y = Math.floor(json.top + json.height/2);	//计算Y轴中心点
			//设置初始的left 和 top 值 并让元素显示
			obj.style.display = 'block';
			obj.style.left = x-(parseInt(getStyle(obj,'width'))/2) + 'px';  
			obj.style.top = y-(parseInt(getStyle(obj,'height'))/2) + 'px';
			//清除margin
			obj.style.margin = 0 + 'px';
		}
	}
	var newJson = {}
	/*** 往参数中添加位置属性 用于设置元素的运动初始点 ***/
	for(var arg in json){
		newJson[arg] = [json[arg], parseInt(getStyle(obj,arg))]
		//newJson[arg] = [运动目标点,运动初始点];
	}
	var oSite = {};
	/** 添加单独的属性值  **/
	for(var attr in newJson){
		oSite[attr] ={iSpeed:0,curSite:newJson[attr][1],bStop:false};
		//oSite[attr] = {运动初始速度,运动当前值,判断是否完成运动依据};
	}
	/** 运动开始前关闭本身的定时器 **/
	clearInterval(obj.t);
	obj.t = setInterval(function(){
		/*** 循环运动属性  ***/
		for (var attr in newJson) {
			/** 运动状态  **/
			oSite[attr].bStop = false;
			// iCur 更新运动元素当前的属性值
     		if(attr=='opacity'){	//对透明度单独处理
          		var iCur = parseInt(parseFloat(getStyle(obj, attr))*100);
		 	}else{					//普通样式
          		var iCur = parseInt(getStyle(obj, attr));
		 	}
			oSite[attr].iSpeed += (newJson[attr][0] - iCur) /5;		//加速	
			oSite[attr].iSpeed *= 0.75;								//磨擦
			oSite[attr].curSite += oSite[attr].iSpeed;				//更新运动的当前位置
			//运动停止条件 速度绝对值小于1 并且 当前值与目标值的差值的绝对值小于一
			if (Math.abs(oSite[attr].iSpeed) < 1 && Math.abs(iCur - newJson[attr][0]) < 1) {
				
				//设置样式，对透明度单独处理
             	if(attr=='opacity'){
                   obj.style.filter='alpha(opacity='+newJson[attr][0]+')';
				   obj.style.opacity=newJson[attr][0]/100;
				}else{
				   obj.style[attr] = newJson[attr][0] + 'px';	//设置到目标点
				}
				
				oSite[attr].bStop = true;					//设置当前属性运动是否完成
			}
			else {
				//更新运动对象的属性值
				if(attr=='opacity'){
                   obj.style.filter='alpha(opacity='+oSite[attr].curSite+')';
				   obj.style.opacity=oSite[attr].curSite/100;
				}else{
				   obj.style[attr] = oSite[attr].curSite + 'px';	
				}
			}
		}
		// 校验定时器停止
		if(checkStop(oSite)){
			clearInterval(obj.t);
			if(fn){
				fn.call(obj)
			}
		}
	}, 30);
	/** 校验运动是否完成 **/
	function checkStop(oSite){
		for(var i in oSite){
			if(oSite[i].bStop === false){
				return oSite[i].bStop;
			}
		}
		return true;
	}
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    