/*

oneBook3d
v 2.31;
www.onebook3d.riadesign.ru
swipe up,down,right,left

(13.03.2015)
automatic removal of
old book in the target element;

(29.10.2015)
new options "startWithFullScreen";

*/

window['ONEBOOK3DTHEBEST'] = true;

var ONEBOOK3D_ADDITIONAL_LANGUAGES = [{
		lng:'it',
		save:'Salva',
		light:'Luminoso',
		dark:'Scuro',
		next:'Prossimo',
		prev:'Precedente',
		zoom:'Zoom',
		slope:'Inclina',
		fromfullscreen:'Rimpicciolisci',
		tofullscreen:'Ingrandisci',
		close:'Chiudi',
		left:'Sinistra',
		right:'Destra',
		toStart:'Alla Partenza',
		toEnd:'Alla Fine',
		goToHomelink:'Aprire home page',
		clickToOpen:'Clicca per aprire',
		useMousewheel:'Usa la rotellina del mouse',
		forEasyViewing:'Per visualizzare',
		askSaveImage:'Selezionare la pagina da salvare, per favore',
		or:'o'
	}];

(function($){

$.onebook = function (arrSrc,options,target) {

var 
	G_DATA = 'ONEBOOK3DGLOBALDATASTORAGE',
	target = target&&target!==$&&target.size?target:false;
	
	if(!window[G_DATA]){
		window[G_DATA]={
			FLIPS:{},
			NUMBER:0,
			BOOKS:[],
			CURRENT:false,
			SUPERBOOK:false,
			SKIN:{},
			queueBooksBuilding:[],
			buildNextBook:function(){
				window[G_DATA].buildingNowFlag = true;
				var book = window[G_DATA].queueBooksBuilding.shift();
				if(book){

					if(book.target){
						var oldbookName = $(book.target).attr('onebook3d');
						if(oldbookName && window[G_DATA].BOOKS[oldbookName]){
							var oldbook = window[G_DATA].BOOKS[oldbookName];
							oldbook.exit();
						}
					};

					var BOOK_CONSTRUCTOR = $.extend( true, {}, OneBook3D );
					BOOK_CONSTRUCTOR.init(book.arrSrc,book.options,book.target);
				}else{
					window[G_DATA].buildingNowFlag = false;
				}
			},
			GLOSSY:function(){
				var
				gl, cnv = document.createElement('canvas'),
				names = ["webgl", "experimental-webgl", "webkit-3d", "moz-webgl"];
				
				for (var i=0;i<names.length;++i){
					try{ gl = cnv.getContext(names[i]); }catch(e){};
		          	if(gl){break;} 
		        };

		       if(gl == null){
		       		console.log('NO GL',gl)
		       		return false;
		        }else{
		        	console.log('YES GL',gl)
		        	return true;
		        }
			}()
		};		
	};

var OneBook3D = {

	init:function(images_src,options,target){
		var _this=this;
		this.IMAGES_SRC = images_src
		this.$TARGET = target;
		this.startIndex = 1000+20*window[G_DATA].NUMBER;		
		this.options = this.set_options_default(options);		
		OneBookEditor.init($.extend(this.options,{
			onReady:function(FRDATA){			
				_this.initWithData(FRDATA);
			}
		}));		
	},
	
	set_options_default:function(options){		
		return $.extend({
			language:'en',
			skin:'dark',
			bgDark:'',
			bgLight:'',
			pageColor:'white',
			border:30,
			typeAnimation:'',
			startPage:1,
			slope:0,
			flip:'basic',			
			cesh:true,
			startWithFullScreen:false
		},options||{});
	},	

	initWithData:function(FRDATA){
		
		var
			_this = this,
			z = this.startIndex;

		var fn = {
			defineSkin:function(skin){
				var skinMode = {'dark':'dark','light':'light'};	
				return skinMode[skin&&skin.toLowerCase()]||'dark';
			},
			defineSkinArray:function(skinArr){
				if(typeof(skinArr)==='object'){
					var skin0 =  fn.defineSkin(skinArr[0]);
					var skin1 =  fn.defineSkin(skinArr[1]);
					return [skin0,skin1];	
				}else{
					return [fn.defineSkin(skinArr)];	
				}
			},				 	
			defineLanguage:function(lng){
			var lgs = ONEBOOK3D_ADDITIONAL_LANGUAGES;
			var language = {'en':0,'ru':1};
			if(lgs && lgs.length>0){
				for (var i=0;i<lgs.length;i++){
					language[lgs[i].lng]=i+2;
				}
			}
			return language[lng.toLowerCase()]||0;
			},
			defineBorder:function(number){
			var number = parseInt(number,10);
			return number<101?number:30;
			},
			defineSlope:function(number){
			var number = parseInt(number,10);
			return number<3?number:0;
			}			
		};

		this.CFG = {
			HOME_LINK:'http://www.onebook3d.riadesign.ru',
			DIVIDE_IMAGES:false,
			PAGE_DEFAULT_COLOR:this.options.pageColor,
			BORDER:fn.defineBorder(this.options.border),
			ARR_SLOPE_ANGLES:[0,20,40],			
			START_SLOPE_MODE:fn.defineSlope(this.options.slope), 
			ROTATE_CENTER_OFFSET:1.7,
			ROTATE_CENTER_OFFSET_GL:0.3,
			SHEETS_SENSIVITY:8,
			PASPARTU_BEHAVIORS_PARAM:{width:0,height:80},
			SPACE_AROUND_STAGE:{horizontal:20,vertical:20},
			DRAG_PARAM:{px_per_persent:3},
			NUMBEROF_PRELOAD_SHEETS:3,
			MAX_SCREEN_SIZE:{width:2000,height:1200},

			ICONS_PANEL:{
				tiny:{height:101,width:265,noTitle:20,betweenIcons:2,pageNumbers:{width:83,fontSize:16}},
				small:{height:101,width:410,noTitle:20,betweenIcons:8,pageNumbers:{width:102,fontSize:18}},
				middle:{height:101,width:470,noTitle:20,betweenIcons:6,pageNumbers:{width:92,fontSize:16}},
				large:{height:140,width:700,noTitle:30,betweenIcons:10,pageNumbers:{width:105,fontSize:16}},
				titleSection:65,
				overlay_pr:0.8
			},

			ICONS_SIZE:{big:50,small:36},
			MAX_FRAME_DRAGGABLE:60,
			MAX_MOUSE_SPEED_X:90,
			ZOOM_WAITER_SIZE:60,
			LANGUAGE:fn.defineLanguage(this.options.language),
			ZINDEX:{bookBackground:z,bookStage:z+5,bookIconsPanel:z+10,bookSaveMenu:z+20,zoomLayer:z+2000},
			GL_DEPTH_STEP:3,
			FV:window[this.getString([79,78,69,66,79,79,75,51,68,84,72,69,66,69,83,84])] 		
		};

		this.GIF = "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7";
		this.AJAX_LOADER = "data:image/gif;base64,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";
		this.SRC_ICONS_BIG = "data:image/png;base64,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";
		this.SRC_ICONS_MINI = "data:image/png;base64,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";		
		this.SRC_HOME_LINK = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAeCAYAAABE4bxTAAAACXBIWXMAAA7DAAAOwwHHb6hkAAACG0lEQVR4nO2WTyhlcRTHD1n4lzIlTQ2lsJCReMkMCtGUjYXsZjGbKavJYhaKrGhqLG1kKaVRSqKsZKOIhfHv6SVmUrOippmUxYjv1zkvr+ve7nW9pOae+nTfve/ec77n/O7t9xWJ4nGR9dzyxsEoeJkmITEwDg68bsgMkOQHWAbToDGEiCLQD76DYbACrkPkuY1dO1L4O7AANkCv+DdTJ9oEc3wGxS5570WG43xH7tTniS7VDEiILt86yAeDoB6MgDlHjhLwBZSKLjdzNoAKUA4qwRvLWQh+gxovQVT+OuWca/0RVFuiZhO0Zv81WVLecwK6wZjoJAus8B9rJGEcgyXLea+m39t+ZcXXUq7lWqFW8Er0HdkEP206f63Rb+ATuHTJG/gdcq6t51qnBCf03op0SbAPZdfjd1oEJeMhX46noCDdPGlEgvwiEuQXkSC/iAT5hZ8g7lt9IDtN9egeBkQ36FCC3opumNtgCLwIISLppebBouhmGwv6sNfexY7o+mg5JkGZyz3OvYxT5W6/J2rUGoLUdNqPM1GrmWMFaJ7iJmQfdIpObdYSfQWHjhzM2WdipkCbNVQramHpgzj15LR/pT7sNGjOoLWosiQ80lPzvaKNpe9pB6uiDpLn9EkTYEvUjMWMI2t0xxo5BeduBf0EuQWXgk6xBXSILh+vsWNOmA6RU10xsRTxL0Sd0EGr+gFcgB7RCUbx/8QNBj9rFr9f954AAAAASUVORK5CYII=';
		this.SRC_HELP_ARROW = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADcAAAAaCAYAAAAT6cSuAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAByklEQVR4nO2XOUtDQRSFryKiQUURSVxQERcQ10qwEhEULKwsUoudP8FGLS0tBAs7xUJE0NrCykIRcSmMjVjEfQVRweUc7oQEMQmEN04IOfDx3iTzZs7cmbnznkhWaacC1wZsaQjcgFrXRmyIs3YIdkG+Yy9W1AiewKJrI7Y0DD7BuGsjtjQD3kGPayM2lAs2QRgEHHuxohIQAjuSoQmmGbyABddGbGlE4iQYrt1R0PbfjjzWpPyRYErBJfgG12AVTIj7wTLorSAIZsEWuAXzCeofgDkW8syPj6AKdIB+0AemQRl4BSfmoSPRt4Mz0Qz14cEA6KFS9HWKe4cHdAtoMvc+0w897IM1sBGnrW7TxhILOUk67QKdojPYLjr4ipg6d6KDvBCNKHVlrl/gAZSbMk0Wm3aZtv2GyP8UA8nAhQynEg1qskBycvZM3UH2n2hw8URDdaBaNOKRa0CiK8H/65k30dcliqvkXjQIJBzDeQp+qCKwDQpF99tziu2knbjP1kW/FOrdWvFeTDTMkL2ujXitMdEMH3RtxGsxq3PGplwb8VoNopl6RXTPZYyYGY9Fv8R9jr14rmXRzFjj2ojX4jnKQ3rAtZGsbOoHTqZUb7lFI8sAAAAASUVORK5CYII=';
		
		this.GLOSSY = window[G_DATA].GLOSSY;

		this.options.startWithFullScreen && this.fsapi.goFullScreen();

		this.BOOK_INTERNAL = this.$TARGET?true:false;		
		this.PRE_NAME = 'OneBook3d_'+Math.floor(Math.random()*1000000)+'_';
		window[G_DATA].BOOKS[this.PRE_NAME]=this;
		window[G_DATA].CURRENT = this.PRE_NAME;
		if(!this.BOOK_INTERNAL){ window[G_DATA].SUPERBOOK = this.PRE_NAME;}	
		
		this.SKIN_ARRAY = fn.defineSkinArray(this.options.skin);
		var targetSkin = !this.BOOK_INTERNAL&&this.SKIN_ARRAY.length>1?1:0;
		this.DARK_MODE = this.SKIN_ARRAY[targetSkin]==='light'?false:true;

		this.addStyle();
				
		this.$gStage = this.getStage();		
		this.$gContainter = $('#'+this.divNames.book_container);
		this.$gBookLoader = $('#'+this.divNames.book_loader);
		this.$gGlossyContainter = $('#'+this.divNames.glossy_container);

		this.LNG = {
			save:['Save','Сохранить'],
			light:['Light','Светлый'],
			dark:['Dark','Темный'],
			prev:['Prev','Назад'],
			next:['Next','Далее'],
			zoom:['Zoom','Масштаб'],
			zoomclose:['Zoom','Масштаб'],
			slope:['Slope','Наклон'],
			fromfullscreen:['Smaller','Уменьшить'],
			tofullscreen:['Larger','Увеличить'],			
			close:['Close','Закрыть'],
			left:['Left','Слева'],
			right:['Right','Справа'],
			toStart:['To start','В начало'],
			toEnd:['To end','В конец'],

			hlpGoToHomelink:['Open homepage','Открыть домашнюю страницу'],
			hlpClickToOpen:['Click to open','Открой меня'],
			hlpUseMousewheel:['Use mouse wheel<br>for easy viewing','Используйте колесо мыши<br>для листания'],
			hlpUseMousewheelGL:[['Use mouse wheel','for easy viewing'],['Используйте колесо','мыши для листания']],
			askSaveImage:['Select the page to save, please','Какое изображение сохранить?'],
			askSaveLinks:['<a href="#">Left</a> or <a href="#">Right</a>','<a href="#">Левое</a> или <a href="#">Правое</a>']
		};

		var lngs = ONEBOOK3D_ADDITIONAL_LANGUAGES;
		if(lngs && lngs.length>0){
			for (var i=0;i<lngs.length;i++){
				this.LNG.save.push(lngs[i].save);
				this.LNG.light.push(lngs[i].light);
				this.LNG.dark.push(lngs[i].dark);
				this.LNG.prev.push(lngs[i].prev);
				this.LNG.next.push(lngs[i].next);
				this.LNG.zoom.push(lngs[i].zoom);
				this.LNG.zoomclose.push(lngs[i].zoom);
				this.LNG.slope.push(lngs[i].slope);
				this.LNG.fromfullscreen.push(lngs[i].fromfullscreen);
				this.LNG.tofullscreen.push(lngs[i].tofullscreen);
				this.LNG.close.push(lngs[i].close);
				this.LNG.left.push(lngs[i].left);
				this.LNG.right.push(lngs[i].right);
				this.LNG.toStart.push(lngs[i].toStart);
				this.LNG.toEnd.push(lngs[i].toEnd);
				this.LNG.hlpGoToHomelink.push(lngs[i].goToHomelink);
				this.LNG.hlpClickToOpen.push(lngs[i].clickToOpen);
				this.LNG.hlpUseMousewheel.push(lngs[i].useMousewheel+'<br>'+lngs[i].forEasyViewing);
				this.LNG.hlpUseMousewheelGL.push([lngs[i].useMousewheel,lngs[i].forEasyViewing]);
				this.LNG.askSaveImage.push(lngs[i].askSaveImage);
				this.LNG.askSaveLinks.push('<a href="#">'+lngs[i].left+'</a> '+lngs[i].or+' <a href="#">'+lngs[i].right+'</a>');
			}
		};

		this.BTNS_OFFSET = {
			save:[['-100px']],
			skin:[['-50px','0px'],['dark','light'],'DARK_MODE'],
			prev:[['-150px']],
			zoom:[['-200px']],
			next:[['-250px']],
			slope:[['-300px']],
			togglebook:[['-350px','-400px'],['toStart','toEnd'],'START_FROM_END'],			
			close:[['-450px']],
			zoomclose:[['-450px']]
		};
		this.BTNS_MINI_OFFSET = {
			save:[['-72px']],
			skin:[['-36px','0px'],['dark','light'],'DARK_MODE'],
			prev:[['-108px']],
			zoom:[['-144px']],
			next:[['-180px']],
			slope:[['-216px']],
			tofullscreen:[['-252px']],
			fromfullscreen:[['-288px']],						
			togglebook:[['-324px','-360px'],['toStart','toEnd'],'START_FROM_END'],
			close:[['-396px']],
			zoomclose:[['-396px']]
		};	

		this.PANEL_TYPE = '';
		this.LARGE_ICONS = false;
		this.FRDATA = FRDATA;
		this.FIRST_FRAME = 0;	

		this.ARR_PAGES_SRC  = [];
		this.ARR_PAGES_TITLE = [];				
		this.getSrcAndTitles(this.IMAGES_SRC);		
		if(!this.CFG.DIVIDE_IMAGES && this.ARR_PAGES_SRC.length%2>0){
			this.ARR_PAGES_SRC.push(this.CFG.PAGE_DEFAULT_COLOR);
		};				

		this.START_FROM_END = 0;
		this.START_PAGE = this.options.startPage;
		this.GSCALE = 1;
		this.ALL_PAGES_MAP = [];
		this.ALLSHEETS = [];
		this.$ARR_SHEETS = [];
		this.GL_ARR_SHEETS = [];
		this.FIRST_IMAGE_SIZE = {w:0,h:0};		
		this.SHEETS_WAS_BUILT = [];
		this.SHEET_DISPLAYED = null;
		this.QUEUE_IMAGES_LOADED = [];
		this.IMG_NOW_LOADING = [];
		this.NOW_LOADING_COUNTER = 0;
		this.IMG_NOW_LOADING_FOR_ZOOM=[];
		
		if(!this.options.cesh){
			this.addCeshNames(Math.floor(Math.random()*10000));
		};	
		
		this.ANIMATION_SLOPE = false; 
		this.ZOOM_MODE = 0;
		this.STAGE = {width:0,height:0};
		this.STAGE_CENTER = {top:0,left:0};
		this.STAGE_BOUNDING_BOX = {width:0,height:0,top:0,left:0};
		this.MAX_BOUNDS = {width:0,height:0,top:0,left:0};
		
		this.ENVIRON = this.getEnviron();		

		var fn2 = {
			prepareAndStart:function(){
				!_this.BOOK_INTERNAL && _this.build_background();

				_this.prepareBookSize();
				_this.prepareIconsPanelSize();

				_this.prepareSkinImages(function(){
					_this.findBookSizeByFirstImage(function(){
						_this.fit3dDataToBookSize();
					});
				});				
			}
		};
		
		var pause = this.options.startWithFullScreen ? 1000:100;
		setTimeout(function(){	fn2.prepareAndStart(); },pause);

	},	
	prepareBookSize:function(){
		this.WINSIZE = {width:$(window).width(),height:$(window).height()};	
		this.TARGETSIZE = this.$TARGET?{left:this.$TARGET.offset().left,top:0,width:this.$TARGET.width(),height:100}:false;
		this.ZOOMSIZE = {height:this.WINSIZE.height,width:this.WINSIZE.width,top:0,left:0};
	},
	getString:function(arr){
		var str='';
		for(var i=0;i<arr.length;i++){ str+=arr[i]?String.fromCharCode(arr[i]):' ';};
		return str;
	},
	prepareIconsPanelSize:function(){
		
		var 
			p = this.CFG.ICONS_PANEL,
			spaceSize = this.$TARGET?this.TARGETSIZE:this.WINSIZE;

		if(this.BOOK_INTERNAL){
			if(spaceSize.width < p.tiny.width){
				
				return false;
			}else if(spaceSize.width < p.small.width){
				this.LARGE_ICONS = false;
				this.PANEL_TYPE = 'tiny';
			}else{
				this.LARGE_ICONS = false;
				this.PANEL_TYPE = 'small';
			}			
		}else{
			if(this.fsapi.isFullScreen()){
				if(spaceSize.width < p.large.width){
					
					return false;					
				}else{
					this.LARGE_ICONS = true;
					this.PANEL_TYPE = 'large';
				}					
			}else{
				if(spaceSize.width < p.middle.width){
					
					return false;					
				}else{					
					this.LARGE_ICONS = false;
					this.PANEL_TYPE = 'middle';
				}				
			}
		}
	},
	
	getTotalSheets:function(){
		return this.ALLSHEETS.length;
	},
	
	getEnviron:function(){		
		var x = navigator.userAgent,
			xChrome = x.indexOf('Chrome') != -1,
			xSafari = x.indexOf('Safari') != -1,
			xOpera = x.indexOf('OPR') != -1,
			xWebkit = x.indexOf('WebKit') != -1;		
		var env =  {
			ios: (navigator.userAgent.indexOf('iP') != -1),
			android: (navigator.userAgent.indexOf('Android') != -1),
			firefox: (navigator.userAgent.indexOf('Firefox') != -1),
			windows: (navigator.userAgent.indexOf('Windows') != -1),
			mac: (navigator.userAgent.indexOf('Macintosh') != -1),	
			webkit: xWebkit,			
			safari: xSafari && !xChrome,
			chrome: xSafari && xChrome && !xOpera,
			opera: xOpera,
			ipad:  (navigator.userAgent.indexOf('iPad') != -1),
			iphone:  (navigator.userAgent.indexOf('iPhone') != -1)
		};
		env.touch = (env.ios || env.android);		
		return env;
	},

	getSrcAndTitles:function(arr){
		var arr = arr.slice()||[];
		var counter=0;
		this.NO_ONE_TITLES = true;
		if(!arr.length){return;};
		for(var i=0,length=arr.length;i<length;i++){		
			if(typeof(arr[i])=='string'){
				this.ARR_PAGES_SRC.push(arr[i]);
				this.ARR_PAGES_TITLE.push('');
			}else if(typeof(arr[i])=='object' && arr[i].length == 2){
			counter++;
				this.ARR_PAGES_SRC.push(arr[i][0]);
				this.ARR_PAGES_TITLE.push(arr[i][1]);
			};
		};
		this.NO_ONE_TITLES = counter?false:true;
	},
	
	addStyle:function(){
		
		var 
			_this=this,
			n = this.PRE_NAME;
	
		this.divNames ={			
			background: n + 'background',			
			book_stage: n + 'stage',
			book_help_layer: n + 'help_layer',
			book_container: n + 'stage_container',
			glossy_container: n + 'glossy_container',
			book_loader: n + 'book_loader',			
			book_icons_panel: n + 'icons_panel',
			book_spread_title: n + 'spread_title',
			book_page_numbers: n + 'page_numbers',
			icons_container: n + 'icons_container',			
			zoom_layer: n + 'zoom_layer',
			zoom_content: n + 'zoom_content',
			zoom_title_spread: n + 'zoom_title_spread',
			zoom_behavior_section: n + 'zoom_behavior_section',
			zoom_buttons: n + 'zoom_buttons',
			zoom_waiter: n + 'zoom_waiter_layer',
			save_menu:n + 'save_menu'			
		};		
	
		var appendStyle = function(styles) {
			var css = document.createElement('style');
			css.type = 'text/css';
			if(css.styleSheet){
				css.styleSheet.cssText = styles;
			}else{
				css.appendChild(document.createTextNode(styles));
			};
			_this.CSS = document.getElementsByTagName("head")[0].appendChild(css);
		};
		
		var 
			bookBackground = '#'+this.divNames.background,
			bookStage = '#' + this.divNames.book_stage,
			bookContainerName = '#'+this.divNames.book_container,
			glossyContainer = '#'+this.divNames.glossy_container,
			bookHelpLayer = '#'+this.divNames.book_help_layer,			
			bookLoaderName = '#'+this.divNames.book_loader,
			bookSpreadTitle = '.'+ this.divNames.book_spread_title,
			bookPageNumbers = '#'+ this.divNames.book_page_numbers,
			bookIconsPanel = '#'+this.divNames.book_icons_panel,
			zoomLayer = '#' + this.divNames.zoom_layer,
			zoomContent = '.' + this.divNames.zoom_content,
			zoomTitleSpread = '.' + this.divNames.zoom_title_spread,
			zoomWaiter = '#' + this.divNames.zoom_waiter;
			saveMenu = '.' + this.divNames.save_menu;
			
		var zIndex = this.CFG.ZINDEX;

		var styles = "";

		styles += zoomLayer+'{position:relative;}\n';
		styles += zoomLayer+' .btn_title{font:12px arial;color:black;padding:5px;white-space:nowrap;}\n';		
		styles += zoomContent+'{overflow:hidden;text-align:center;background:#e5e5e5;}\n';
		styles += zoomContent+' .zoom_pages{border-collapse:collapse;border:0px;background:white;}\n';
		styles += zoomContent+' .zoom_pages td{padding:0px;}\n';		
		styles += zoomTitleSpread+'{border-top:1px solid white;}\n';		
		styles += zoomTitleSpread+' p{font:14px arial;color:black;line-height:140%;margin:0px;}\n';
		styles += zoomTitleSpread+' p span{font:bold 14px arial;color:gray;margin-right:8px;}\n';								
		
		styles += saveMenu+' h1{font:16px arial;color:white;}\n';
		styles += saveMenu+' p{font:16px arial;color:white;}\n';
		styles += saveMenu+' a{font:16px arial;color:white;}\n';

		styles += bookPageNumbers+'{color:#b2b2b2;}\n';
		styles += bookPageNumbers+'.light{color:#555555;}\n';

		styles += [
			bookStage+'{',			
			'position:absolute;left:0px;top:0px;',
			'overflow:hidden;',
			'-webkit-perspective:1000px;',
			'-moz-perspective:1000px;',
			'-ms-perspective:1000px;',
			'z-index:'+zIndex.bookStage+';}\n'
		].join('');
		
		styles += [
			bookStage+'.pointer:hover{',			
			'cursor:pointer;}\n'
		].join('');
		

		styles += [
			bookBackground+'{',
			'position:fixed;left:0px;top:0px;right:0px;bottom:0px;',
			this.options.bgDark?'background:'+this.options.bgDark+';':'background:#282828;',
			'z-index:'+zIndex.bookBackground+';}\n'
		].join('');
		
		styles += [
			bookBackground+'.light{',
			this.options.bgLight?'background:'+this.options.bgLight+';':'background:#d0d0d0;',
			';}\n'
		].join('');
		
		styles += [
			bookContainerName+'{',
			'width:100%; height:100%;',
			'top:0px;left:0px;position:absolute;',
			'-webkit-transform-style: preserve-3d;',
			'-moz-transform-style: preserve-3d;',
			'-ms-transform-style: preserve-3d;',
			'z-index:20;}\n'
		].join('');
		
		styles += [
			glossyContainer+'{',
			'width:100%; height:100%;',
			'top:0px;left:0px;position:absolute;',
			'z-index:25;}\n'
		].join('');		
		
		styles += [
			bookContainerName+' div{',
			'height:300px;',
			'-webkit-transform-origin:left center;',
			'-moz-transform-origin:left center;',	
			'-ms-transform-origin:left center;',				
			'-webkit-transform-style: preserve-3d;',
			'-ms-transform-style: preserve-3d;',
			'-moz-transform-style: preserve-3d;}\n'
		].join('');	
		
		styles += [
			bookContainerName+' .all_edges{',
			'-moz-perspective:5000px;-moz-transform-origin:left center;-moz-transform-style: preserve-3d;',
			'-ms-perspective:5000px;-ms-transform-origin:left center;-ms-transform-style: preserve-3d;',
			'}\n'
		].join('');

		styles += [
			bookContainerName+' .wholeimage{',
			'-webkit-transform-origin:left center;-moz-transform-origin:left center;-ms-transform-origin:left center;',
			'-webkit-transform-style:preserve-3d;-moz-transform-style: preserve-3d;-ms-transform-style: preserve-3d;',
			'font:bold 20px arial;color:white;}\n'	
		].join('');

		styles += [
			bookContainerName+' .wholeimage,',
			bookContainerName+' .wholeimage span,',
			bookContainerName+' .wholeimage div{',
			'}\n'	
		].join('');


		styles += [
			bookContainerName+' div .back, \n',
			bookContainerName+' div .front, \n',
			bookContainerName+' .front_image, \n',
			bookContainerName+' .front_image>div, \n',
			bookContainerName+' .back_image, \n',
			bookContainerName+' .back_image>div {',
			'-moz-transform-style: preserve-3d;',
			'-ms-transform-style: preserve-3d;',
			'display:block;width:100%;height:100%;',
			'top:0px;left:0px;position:absolute;',
			'-webkit-backface-visibility: hidden;',
			'-ms-backface-visibility: hidden;',
			'-moz-backface-visibility: hidden;}\n'
		].join('');	
		
		styles += [
			bookHelpLayer+'{',
			'position:absolute;',
			'outline: 1px solid transparent;',
			'-webkit-transform:translate3d(0px,0px,-1px);',
			'-moz-transform:translate3d(0px,0px,-1px);',
			'-ms-transform:translate3d(0px,0px,-1px);',
			'z-index:0;}\n'
		].join('');

		styles += bookHelpLayer + ' a {text-decoration:none;}';
		styles += bookHelpLayer + ' a:hover {text-decoration:underline;}';
		styles += bookHelpLayer + ' p {padding:20px 20px 20px 0px;margin:0px;}';
		styles += bookHelpLayer + ' p span{display:block;margin-top:10px;}';
		
		styles += bookHelpLayer + ' .hlpLeftSide {border:1px solid #cccccc;border-right:none;}\n';
		styles += bookHelpLayer + ' .hlpRightSide {border:1px solid #cccccc;border-left:none;}\n'; 
		
		styles += bookHelpLayer + ' .hlpLeftSide p span[name=home_link]{width:36px;height:30px;margin:10px 0px 0px auto;opacity:0.8;}';
		styles += bookHelpLayer + ' .hlpLeftSide p span[name=click_to_open] a{font:21px arial;color:white;}';
		styles += bookHelpLayer + ' .hlpLeftSide p span[name=use_mousewheel]{font:12px arial;color:#d4d4d4;}';
		styles += bookHelpLayer + ' .hlpLeftSide p span[name=help_arrow]{width:55px;height:26px;margin:10px 0px 0px auto;opacity:0.8;}';		
		styles += bookHelpLayer + ' .hlpRightSide p span[name=goto_start] a{font:18px arial;color:white;}';		

		styles += bookHelpLayer + ' p.middleSize {padding:10px 10px 10px 0px;}';
		styles += bookHelpLayer + ' p.middleSize span{margin-top:5px;}';		
		styles += bookHelpLayer + ' .hlpLeftSide p.middleSize span[name=click_to_open] a{font:16px arial;}';
		styles += bookHelpLayer + ' .hlpRightSide p.middleSize span[name=goto_start] a{font:14px arial;}';		

		styles += bookHelpLayer + '.light .hlpLeftSide {border:1px solid #bfbfbf;border-right:none;}\n';
		styles += bookHelpLayer + '.light .hlpRightSide {border:1px solid #bfbfbf;border-left:none;}\n'; 
		
		styles += bookHelpLayer + '.light .hlpLeftSide p span[name=home_link]{opacity:0.4;}';
		styles += bookHelpLayer + '.light .hlpLeftSide p span[name=click_to_open] a{color:#656565;}';
		styles += bookHelpLayer + '.light .hlpLeftSide p span[name=use_mousewheel]{color:#656565;}';
		styles += bookHelpLayer + '.light .hlpLeftSide p span[name=help_arrow]{opacity:0.4;}';	
		styles += bookHelpLayer + '.light .hlpRightSide p span[name=goto_start] a{color:#656565;}';


		styles += [
			bookLoaderName+'{',
			'background:white url("'+this.AJAX_LOADER+'") center no-repeat;',
			'position:absolute;top:0px;left:0px;width:90px;height:90px;',
			'-moz-border-radius:15px;',
			'border-radius:15px;',
			'opacity:0.5;display:none;',
			'z-index:100;}\n'
		].join('');		
		
		styles += [
			zoomWaiter+'{',
			'position:absolute;',
			'width:100px;height:100px;',
			'left:0px;top:0px;',
			'z-index:300;}\n'
		].join('');		
		
		styles += [
			bookIconsPanel+'{',
			'position:absolute;',
			'top:0px;left:0px;text-align:center;',
			'z-index:'+zIndex.bookIconsPanel+';}\n'
		].join('');		
		
		styles += bookIconsPanel+' '+bookSpreadTitle+' p{font:14px arial;color:#aaaaaa;line-height:140%;margin:0px;}\n';
		styles += bookIconsPanel+' '+bookSpreadTitle+' span{font:bold 14px arial;color:#ffffff;margin-right:8px;}\n';
		styles += bookIconsPanel+'.light '+bookSpreadTitle+' p{color:#000000;}\n';
		styles += bookIconsPanel+'.light '+bookSpreadTitle+' span{color:#888888;}\n';
		styles += bookIconsPanel+' .btn_title{font:12px arial;color:#ffffff;padding:5px;white-space:nowrap;}\n';
		styles += bookIconsPanel+'.light .btn_title{color:black;}\n';				
					
		styles += [
			'.unselectable{',
			'-webkit-user-select:none;',
			'-khtml-user-select:none;',
			'-moz-user-select:none;',
			'user-select: none;}\n'
		].join('');

		styles += [
			'.noPointerEvents{',
			'pointer-events:none;}\n'
		].join('');

		appendStyle(styles);
	},

	getStage:function(){

	var 
		bookStageName = this.divNames.book_stage,
		bookContainerName = this.divNames.book_container,
		glossyContainer = this.divNames.glossy_container,
		bookLoaderName = this.divNames.book_loader,	
		zoomWaiterName = this.divNames.zoom_waiter;
		
		var $gStage = $('#'+bookStageName);
		$gStage.size() && $gStage.remove();
		
		var glossy = this.GLOSSY?'<div id="'+glossyContainer+'" style="pointer-events:none;"></div>':'';

		var tmpStage = [
				'<div id="'+bookStageName+'">',
				'<div id="'+bookContainerName+'"></div>', glossy,
				'<div id="'+bookLoaderName+'" style="display:none;"></div>',
				'<div id="'+zoomWaiterName+'" style="display:none;"></div>',
				"</div>"
		].join('');
		$('body').append(tmpStage);
		return $('#'+bookStageName);
	},

	getGlStage:function(){

		var gl = {}, 
			width = this.$gStage.width(), 
			height = this.$gStage.height();
		
		this.$gGlossyContainter.css({width:width,height:height});

		gl.container =document.getElementById(this.divNames.glossy_container);

    	gl.renderer = new THREE.WebGLRenderer({ alpha: true , antialias: true});
    	gl.renderer.setSize(width, height);
    	gl.container.appendChild(gl.renderer.domElement);			
		
		gl.scene = new THREE.Scene();

		var wh_ratio = width / height;

		gl.bookBase =  new THREE.Object3D();
		gl.bookBase.position.y = - (this.CFG.BOOK_GL_SIZE.height*this.CFG.ROTATE_CENTER_OFFSET_GL);
		gl.scene.add(gl.bookBase);

		gl.camera = new THREE.PerspectiveCamera( 33*2.25 / wh_ratio, wh_ratio, 0.1, 3000 );
		gl.camera.position.z = 1200;
		gl.camera.position.y = 0;	
		gl.scene.add(gl.camera);

		return gl;				
		
	},	

	bookHide:function(){
		this.$gStage.hide();
		this.$gIconsPanel && this.$gIconsPanel.hide();
	},
	bookShow:function(){
		this.$gStage.show();
		this.$gIconsPanel && this.$gIconsPanel.show();
	},	
	bgLoaderShow:function(show){
		var $loader = this.$gBookBackground && this.$gBookBackground.find('div');
		if(show){
			if($loader && $loader.is(':hidden')){
				$loader.show();
			}
		}else{
			if($loader && $loader.is(':visible')){
				$loader.hide();
			}						
		}
	},
	bookLoaderShow:function(show){
		if(show){			
			if(this.$gBookLoader.is(':hidden')){				
				this.$gBookLoader.show();
			}
		}else{
			if(this.$gBookLoader.is(':visible')){
				this.$gBookLoader.fadeOut();
			}
		}
	},

	exit:function(){

		if(this.TMR_RESIZE){clearTimeout(this.TMR_RESIZE);this.TMR_RESIZE=null};
		window[G_DATA].NUMBER-=1;
		window[G_DATA].SUPERBOOK=false;
		delete window[G_DATA].BOOKS[this.PRE_NAME];
		this.zoomOut();
		this.$gStage && this.$gStage.remove();
		this.$gSaveMenu && this.$gSaveMenu.remove();
		this.$gIconsPanel && this.$gIconsPanel.remove();		
		this.$gBookBackground && this.$gBookBackground.fadeOut('normal',function(){this.remove();});
		this.CSS.remove();
		$(window).unbind('.'+this.PRE_NAME);
		$(document).unbind('keyup.'+this.PRE_NAME);

		var parentBookName = this.options.parentBook;
		var currentSpread = this.CURRENT.spread;
		var currentSlopeMode = this.CURRENT.slope_mode;

		var updateOtherBooks  = function(){
			var books = window[G_DATA].BOOKS;
			for(var name in books){
				if (books.hasOwnProperty(name)){
					var parent = name === parentBookName;
					var BOOK = books[name];
					var update = BOOK.isNeedResizeReposInternal();					
					if(parentBookName && parent){
						var startPage = currentSpread?currentSpread*2:1;
						BOOK.START_PAGE = startPage;
						BOOK.slopeToggle(currentSlopeMode);
						window[G_DATA].CURRENT = BOOK.PRE_NAME;
						var gotoOtherSpread = BOOK.CURRENT.spread!==currentSpread;
						if(update==='resize'){
							BOOK.restart();
						}else{
							update==='reposition' && BOOK.restart(update);
							gotoOtherSpread && BOOK.gotoSpread(currentSpread);
						}
					}else{
						if(update){
							BOOK.restart(update);
						}
					}
				}
			}
		};

		updateOtherBooks();	
		
	},

	restart:function(mode){
		
		if(mode==='reposition'){
			
			var targetSize  =  this.TARGETSIZE;
			var stageSize = this.STAGE;
			var left = Math.round ((targetSize.width-stageSize.width)/2 + targetSize.left);
			var ipWidth = this.getIconsPanelWidth();
			var ipLeft = Math.round ((targetSize.width-ipWidth)/2 + targetSize.left);
			var menuLeft = Math.round ((targetSize.width-this.$gSaveMenu.width())/2 + targetSize.left);
			this.$gStage.css({left:left});
			this.$gIconsPanel.css({left:ipLeft});
			this.$gSaveMenu.css({left:menuLeft});
			this.prepareBookSize();
			this.calculateBounds();
		}else{
			
			this.zoomOut();
			this.GSCALE = 1;
			this.SHEETS_WAS_BUILT = [];
			this.QUEUE_IMAGES_LOADED = [];
			this.IMG_NOW_LOADING = [];
			this.NOW_LOADING_COUNTER = 0;	
			this.prepareBookSize();			
			this.prepareIconsPanelSize();

			this.deleteAllGLSheets();
			
			this.fit3dDataToBookSize();	
			//xxxx 

			

		}
	},	

	deleteAllGLSheets:function(){
		if(this.GLOSSY){
			var sheetnums = [];
			for(var i in this.GL_ARR_SHEETS){
				sheetnums.push(this.GL_ARR_SHEETS[i].num);
			};
			for(var i=0;i<sheetnums.length;i++){
				var n = sheetnums[i];
				var sheet = this.getSheetByIndex(n);
				if(sheet){ 
					this.gGL.bookBase.remove(sheet.mesh);
					delete this.GL_ARR_SHEETS[n];
				}										
			}				
		}		
	},

	gotoSpread:function(spreadNumber){
		
		var _this=this;
		var totalSheets = this.getTotalSheets();

		if(this.GLOSSY){
			_this.GL_LINK_TO_START = false;
			_this.$gStage.removeClass('pointer');
		};
	
		if(!this.ZOOM_MODE && !this.ANIMATION_FLAG){

			if(spreadNumber===0){
				this.START_FROM_END = true;
				this.toggleBook();
			}else if(spreadNumber===totalSheets){
				this.START_FROM_END = false;
				this.toggleBook();
			}else{
				this.CURRENT.spread	= spreadNumber;
				if(!this.GLOSSY){
					this.$gHelpLayer.find('.hlpLeftSide').css({opacity:0});
					this.$gHelpLayer.find('.hlpRightSide').css({opacity:0});
				};
			};
			 
			var arr = this.SHEETS_WAS_BUILT;
			for(var i in arr){
				if (arr.hasOwnProperty(i)){
					this.deleteSheet(i);
				}
			};
			
			this.buildAndPreloadSheets();
			this.changeSpreadTitle();
			this.pageNumbersChange();
			var btnToggleBook = this.$G_ARR_BUTTONS['togglebook'];
			btnToggleBook && btnToggleBook.update();

		}
	},

	prepareSkinImages:function(nextfn){
	
		var 
			_this=this,
			SKIN = window[G_DATA].SKIN;
		
		var fn = {
			invertCanvas:function(canvas){
				var ctx = canvas.getContext('2d');
				var imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
				var data = imageData.data;
				for(var i = 0; i < data.length; i += 4){
					data[i] = 255 - data[i];
					data[i + 1] = 255 - data[i + 1];
					data[i + 2] = 255 - data[i + 2];
				};
				ctx.putImageData(imageData, 0, 0);
				return canvas;			
			},
			cloneCanvas:function(oldCanvas){
				var newCanvas = document.createElement('canvas');
				var context = newCanvas.getContext('2d');
				newCanvas.width = oldCanvas.width;
				newCanvas.height = oldCanvas.height;
				context.drawImage(oldCanvas, 0, 0);
				return newCanvas;			
			},
			drawHomeLink:function(){
				if(!SKIN.HOME_LINK){
					var img = new Image();				
					img.onload = function(){
						var canvas = document.createElement('canvas');
						canvas.width = this.width; canvas.height = this.height;
						var ctx = canvas.getContext('2d'); ctx.drawImage(this,0,0,this.width,this.height);
						SKIN.HOME_LINK = {light:canvas,dark:fn.invertCanvas(fn.cloneCanvas(canvas))};
						fn.drawHelpArrow();					
					};
					img.src = _this.SRC_HOME_LINK;	
				}else{
					fn.drawHelpArrow();
				}
			},
			drawHelpArrow:function(){
				if(!SKIN.HELP_ARROW){
					var img = new Image();				
					img.onload = function(){
						var canvas = document.createElement('canvas');
						canvas.width = this.width; canvas.height = this.height;
						var ctx = canvas.getContext('2d'); ctx.drawImage(this,0,0,this.width,this.height);
						SKIN.HELP_ARROW = {light:canvas,dark:fn.invertCanvas(fn.cloneCanvas(canvas))};
						fn.drawIconsBig();
					};
					img.src = _this.SRC_HELP_ARROW;	
				}else{
					fn.drawIconsBig();
				}
			},						
			drawIconsBig:function(){
				if(!SKIN.ICONS){
					var img = new Image();				
					img.onload = function(){
						var canvas = document.createElement('canvas');
						canvas.width = this.width; canvas.height = this.height;
						var ctx = canvas.getContext('2d'); ctx.drawImage(this,0,0,this.width,this.height);
						SKIN.ICONS = {light:canvas,dark:fn.invertCanvas(fn.cloneCanvas(canvas))};
						fn.drawIconsMini();
					};
					img.src = _this.SRC_ICONS_BIG;
				}else{
					fn.drawIconsMini();
				}	
			},
			drawIconsMini:function(){
				if(!SKIN.ICONS_MINI){
					var img = new Image();
					img.onload = function(){
						var canvas = document.createElement('canvas');
						canvas.width = this.width;
						canvas.height = this.height;
						var ctx = canvas.getContext('2d');
						ctx.drawImage(this,0,0,this.width,this.height);
						SKIN.ICONS_MINI = {light:canvas,dark:fn.invertCanvas(fn.cloneCanvas(canvas))};
						nextfn&&nextfn();
					};
					img.src = _this.SRC_ICONS_MINI;					
				}else{
					nextfn&&nextfn();
				}
			}
		};

		fn.drawHomeLink();		
		
	},


	getIconsPanelWidth:function(){
		return this.CFG.ICONS_PANEL[this.PANEL_TYPE].width;
	},
	getIconsPanelHeight:function(){			
		var 
			p = this.CFG.ICONS_PANEL,
			height = p[this.PANEL_TYPE].height,
			noTitle = p[this.PANEL_TYPE].noTitle,
			title = p.titleSection;			
		return this.NO_ONE_TITLES?(height-title+noTitle):height;			
	},
	fsapi:{
		goFullScreen:function(id){
			var el = id?document.getElementById(id):document.documentElement,
			 rfs = el.requestFullScreen
				|| el.webkitRequestFullScreen
				|| el.mozRequestFullScreen
				|| el.msRequestFullscreen;
			rfs.call(el);
		},
		exitFullScreen:function(){
			var el = document,
			rfs = el.exitFullscreen
				|| el.webkitCancelFullScreen
				|| el.webkitExitFullScreen
				|| el.webkitExitFullscreen
				|| el.mozCancelFullScreen
				|| el.msExitFullscreen;
			rfs.call(el);
		},	
		isFullScreen:function(){
			return document.fullscreenElement
			|| document.webkitFullscreenElement
			|| document.webkitCurrentFullScreenElement
			|| document.mozFullScreenElement
			|| document.msFullscreenElement;					
		}
	},	

	buildIconsPanel:function(){
		
		var 
			_this=this,
			iconsPanel = this.CFG.ICONS_PANEL,
			stageSize = this.STAGE,
			bookSize = this.CFG.BOOK_SIZE,
			bookIconsPanel = this.divNames.book_icons_panel,
			bookIconsContainer = this.divNames.icons_container,
			bookSpreadTitle = this.divNames.book_spread_title,
			classLight = !this.DARK_MODE?' light':'';

		var container = {
			build:function(){								
				if(_this.NO_ONE_TITLES){
					var noTitle = iconsPanel[sizeMode].noTitle;
					return $container = $([
						'<table cellpadding="0" cellspacing="0" width="100%" align="center" border=0>',
						'<tr><td height="'+noTitle+'px" style="font-size:0;line-height:0;"><img width="1px" height="1px" src="'+_this.GIF+'"></td></tr>',
						'<tr><td><div class="'+bookIconsContainer+'" style="position:relative;"></div></td></tr>',
						'</table>'
					].join(''));							
				}else{
					var heightTitleSection = _this.CFG.ICONS_PANEL.titleSection;
					return $container = $([
						'<table cellpadding="0" cellspacing="0" width="100%" align="center" border=0>',
						'<tr><td height="'+heightTitleSection+'px" class="'+bookSpreadTitle+'">&nbsp;</td></tr>',
						'<tr><td><div class="'+bookIconsContainer+'" style="position:relative;"></div></td></tr>',
						'</table>'
						].join(''));		
				};
			}
		};
			
		var sizeMode = this.PANEL_TYPE;
		var iconsPanelWidth = this.getIconsPanelWidth();
		var iconsPanelHeight = this.getIconsPanelHeight();
		
		if(!sizeMode){
			
			return; 
		};
			
		var $container = container.build();			
		var $panel = $('#'+bookIconsPanel);
		$panel.size() && $panel.remove();
		
		var $panel = $('<div id="'+bookIconsPanel+'" class="unselectable'+classLight+'" style="visibility:hidden;"></div>')
		.append($container).css({width:iconsPanelWidth,height:iconsPanelHeight});
		$('body').append($panel);
		this.$gIconsPanel = $panel;
		
		!this.BOOK_INTERNAL && this.$gIconsPanel.mousewheel && this.$gIconsPanel.mousewheel(function(){return false;});
		
		var $tmpl_br = $('<div style="width:1px;display:table-cell;"><img width="'+iconsPanel[sizeMode].betweenIcons+'px" src="'+this.GIF+'"></div>');
		var $book3d_icons = $panel.find('.'+bookIconsContainer);
		this.$gSpreadTitle = $panel.find('.'+bookSpreadTitle);
	
		var fn = {
			skin:function(btnTitle){
				_this.$gSaveMenu.hide();
				if(!_this.ZOOM_MODE){
					_this.toggleSkin();				
				}
			},
			save:function(btnTitle){
				if(!_this.ZOOM_MODE){
					_this.saveImagesAs();
				}
			},
			next:function(btnTitle){
				_this.gotoNext();
			},
			prev:function(btnTitle){
				_this.gotoPrev();
			},
			zoom:function(btnTitle){
				_this.$gSaveMenu.hide();
				if(!_this.ZOOM_MODE){
					_this.zoomIn();
				}
			},	
					
			close:function(btnTitle){
				_this.$gSaveMenu.hide();
				if(!_this.ZOOM_MODE){					
					if(_this.fsapi.isFullScreen()){
						_this.fsapi.exitFullScreen();
						setTimeout(function(){
							_this.exit();	
						},700);	
					}else{
						_this.exit();
					}
				}	
			},
			fullScreen:function(btnTitle){
				_this.$gSaveMenu.hide();
				if(!_this.ZOOM_MODE){
					if(_this.BOOK_INTERNAL){
						//xxxx
						var options = $.extend(_this.options,{
							startPage:_this.START_PAGE,
							parentBook:_this.PRE_NAME,
							slope:_this.CURRENT.slope_mode
						});	
						$.onebook(_this.IMAGES_SRC,options);

					}else{

						if(_this.fsapi.isFullScreen()){
							_this.fsapi.exitFullScreen();
						}else{
							_this.bookHide();
							_this.bgLoaderShow(true);
							_this.fsapi.goFullScreen();
						};
					}					
				}	
			},
			slope:function(btnTitle){
				_this.$gSaveMenu.hide();
				if(!_this.ZOOM_MODE){			
					_this.slopeAnimate();
				}	
			},
			toggleBook:function(btnTitle){
				_this.$gSaveMenu.hide();
				_this.toggleBook();
			}			
		};

		var fullscreenBtnTitle = _this.fsapi.isFullScreen()?'fromfullScreen':'tofullScreen';
	
		if(sizeMode === 'tiny'){		
			
			var $centerIconSet = this.cloneIconsSet();
			$centerIconSet.find('>div').append(this.buttonCreate('Prev',fn.prev)).append($tmpl_br.clone());
			$centerIconSet.find('>div').append(this.buttonCreate('Save',fn.save)).append($tmpl_br.clone());
			$centerIconSet.find('>div').append(this.pageNumbersCreate(sizeMode)).append($tmpl_br.clone());
			$centerIconSet.find('>div').append(this.buttonCreate('Slope',fn.slope)).append($tmpl_br.clone());		
			$centerIconSet.find('>div').append(this.buttonCreate(fullscreenBtnTitle,fn.fullScreen)).append($tmpl_br.clone());
			$centerIconSet.find('>div').append(this.buttonCreate('Next',fn.next));
			$book3d_icons.append($centerIconSet);
			$container.css({position:'absolute',zIndex:10,top:0,left:iconsPanelWidth/2-$centerIconSet.width()/2});
			this.$gButtonsTitle = $panel.find('.btn_title');

		}else if(sizeMode === 'small'){
		
			var $leftIconSet = this.cloneIconsSet();
			$leftIconSet.find('>div').append(this.buttonCreate('Save',fn.save)).append($tmpl_br.clone());
			$leftIconSet.find('>div').append(this.pageNumbersCreate(sizeMode)).append($tmpl_br.clone());
			$book3d_icons.append($leftIconSet.css({float:'left'}));

			var $centerIconSet = this.cloneIconsSet();
			$centerIconSet.find('>div').append(this.buttonCreate('Prev',fn.prev)).append($tmpl_br.clone());
			$centerIconSet.find('>div').append(this.buttonCreate('Zoom',fn.zoom)).append($tmpl_br.clone());
			$centerIconSet.find('>div').append(this.buttonCreate('Next',fn.next));
			$book3d_icons.append($centerIconSet);
			$centerIconSet.css({position:'absolute',zIndex:10,top:0,left:iconsPanelWidth/2-$centerIconSet.width()/2});

			var $rightIconSet = this.cloneIconsSet();
			$rightIconSet.find('>div').append(this.buttonCreate('togglebook',fn.toggleBook)).append($tmpl_br.clone());
			$rightIconSet.find('>div').append(this.buttonCreate('Slope',fn.slope)).append($tmpl_br.clone());			
			$rightIconSet.find('>div').append(this.buttonCreate(fullscreenBtnTitle,fn.fullScreen));
			$book3d_icons.append($rightIconSet.css({float:'right'}));
			this.$gButtonsTitle = $panel.find('.btn_title');

		}else if(sizeMode === 'middle'){
			
			var $leftIconSet = this.cloneIconsSet();
			$leftIconSet.find('>div').append(this.buttonCreate('Save',fn.save)).append($tmpl_br.clone());
			$leftIconSet.find('>div').append(this.buttonCreate('Skin',fn.skin)).append($tmpl_br.clone());			
			$leftIconSet.find('>div').append(this.pageNumbersCreate(sizeMode)).append($tmpl_br.clone());
			$book3d_icons.append($leftIconSet.css({float:'left'}));

			var $centerIconSet = this.cloneIconsSet();
			$centerIconSet.find('>div').append(this.buttonCreate('Prev',fn.prev)).append($tmpl_br.clone());
			$centerIconSet.find('>div').append(this.buttonCreate('Zoom',fn.zoom)).append($tmpl_br.clone());
			$centerIconSet.find('>div').append(this.buttonCreate('Next',fn.next));
			$book3d_icons.append($centerIconSet);
			$centerIconSet.css({position:'absolute',zIndex:10,top:0,left:iconsPanelWidth/2-$centerIconSet.width()/2});

			var $rightIconSet = this.cloneIconsSet();
			$rightIconSet.find('>div').append(this.buttonCreate('togglebook',fn.toggleBook)).append($tmpl_br.clone());
			$rightIconSet.find('>div').append(this.buttonCreate('Slope',fn.slope)).append($tmpl_br.clone());			
			$rightIconSet.find('>div').append(this.buttonCreate(fullscreenBtnTitle,fn.fullScreen));
			$rightIconSet.find('>div').append($tmpl_br.clone()).append(this.buttonCreate('Close',fn.close));
			$book3d_icons.append($rightIconSet.css({float:'right'}));
			this.$gButtonsTitle = $panel.find('.btn_title');

		}else if(sizeMode === 'large'){

			var $leftIconSet = this.cloneIconsSet();
			$leftIconSet.find('>div').append(this.buttonCreate('Save',fn.save)).append($tmpl_br.clone());
			$leftIconSet.find('>div').append(this.buttonCreate('Skin',fn.skin)).append($tmpl_br.clone());
			$book3d_icons.append($leftIconSet.css({float:'left'}));
			
			var $centerIconSet = this.cloneIconsSet();
			$centerIconSet.find('>div').append(this.buttonCreate('Prev',fn.prev)).append($tmpl_br.clone());
			$centerIconSet.find('>div').append(this.buttonCreate('Zoom',fn.zoom)).append($tmpl_br.clone());
			$centerIconSet.find('>div').append(this.buttonCreate('Next',fn.next));
			$book3d_icons.append($centerIconSet);
			$centerIconSet.css({position:'absolute',zIndex:10,top:0,left:iconsPanelWidth/2-$centerIconSet.width()/2});
			
			var $rightIconSet = this.cloneIconsSet();
			$rightIconSet.find('>div').append(this.buttonCreate('togglebook',fn.toggleBook)).append($tmpl_br.clone());			
			$rightIconSet.find('>div').append(this.buttonCreate('Slope',fn.slope));
			if(!_this.$TARGET){ 
				$rightIconSet.find('>div')
				.append($tmpl_br.clone())
				.append(this.buttonCreate('Close',fn.close));
			};
			$book3d_icons.append($rightIconSet.css({float:'right'}));
			this.$gButtonsTitle = $panel.find('.btn_title');

		};
		this.changeSpreadTitle();
		this.pageNumbersChange();
	},
	getHlpLayerGL:function(){
		var skinMode = this.DARK_MODE?'dark':'light';
		return {
			left:this.gGL&&this.gGL.helpLayers?this.gGL.helpLayers[skinMode].left:'',
			right:this.gGL&&this.gGL.helpLayers?this.gGL.helpLayers[skinMode].right:''
		}
	},
	toggleSkinHlpLayerGLTo:function(skinMode){
		if(this.gGL&&this.gGL.helpLayers){
			if(skinMode==='dark'){
				this.gGL.helpLayers['dark'].left.material.opacity = 0;	
				this.gGL.helpLayers['dark'].right.material.opacity = 0;	
				this.gGL.helpLayers['light'].left.material.opacity = 1;	
				this.gGL.helpLayers['light'].right.material.opacity = 1;					
			}else{
				this.gGL.helpLayers['dark'].left.material.opacity = 1;	
				this.gGL.helpLayers['dark'].right.material.opacity = 1;	
				this.gGL.helpLayers['light'].left.material.opacity = 0;	
				this.gGL.helpLayers['light'].right.material.opacity = 0;	
			}
		};
		this.startRender();
	},
	toggleBook:function(){

		if(!this.ZOOM_MODE && !this.ANIMATION_FLAG){
			
			if(this.GLOSSY){
				var glHlp = this.getHlpLayerGL(); 	
			};
			

			if(this.START_FROM_END){
				this.START_FROM_END = false;
				this.CURRENT.spread = 0;
				if(this.GLOSSY){
					if(glHlp.left&&glHlp.right){
						glHlp.left.material.opacity = 1;
						glHlp.right.material.opacity = 0;
					}
				}else{
					this.$gHelpLayer.find('.hlpLeftSide').css({opacity:1});
					this.$gHelpLayer.find('.hlpRightSide').css({opacity:0});
				}
			}else{
				this.START_FROM_END = true;
				this.CURRENT.spread = this.getTotalSheets();
				if(this.GLOSSY){
					if(glHlp.left&&glHlp.right){
						glHlp.left.material.opacity = 0;
						glHlp.right.material.opacity = 1;
					}
				}else{
					this.$gHelpLayer.find('.hlpLeftSide').css({opacity:0});
					this.$gHelpLayer.find('.hlpRightSide').css({opacity:1});	
				}			
			};
			 
			var arr = this.SHEETS_WAS_BUILT;	
			for(var i in arr){
				if (arr.hasOwnProperty(i)){
					this.deleteSheet(i);
				}
			};

			this.START_PAGE = this.CURRENT.spread*2?this.CURRENT.spread*2:1;
			this.buildAndPreloadSheets();
			this.changeSpreadTitle();
			this.pageNumbersChange();
			this.$G_ARR_BUTTONS['togglebook'] && this.$G_ARR_BUTTONS['togglebook'].update();
		}
	},

	toggleSkin:function(){
		var 
			_this=this,
			$pageNumbers = $('#'+this.divNames.book_page_numbers),
			invertMode = this.DARK_MODE?'light':'dark',
			SKIN = window[G_DATA].SKIN;

		var fn = {
				btn_update:function(){
					for(var i in _this.$G_ARR_BUTTONS){
						_this.$G_ARR_BUTTONS[i].update();
					};
				},
				hlp_update_images:function(){
					if(!_this.GLOSSY){
						_this.$gHelpLayer.find('span[name=home_link]').css({background:'url('+SKIN.HOME_LINK[invertMode].toDataURL()+') no-repeat center'});
						_this.$gHelpLayer.find('span[name=help_arrow]').css({background:'url('+SKIN.HELP_ARROW[invertMode].toDataURL()+') no-repeat center'});
					}
				}
			};

		if(this.GLOSSY){ var glHlp = this.getHlpLayerGL(); };

		if(this.DARK_MODE){

			this.DARK_MODE = false;
			var bgImage  = this.getHlpLayerBgImage();
			this.$gBookBackground.addClass('light');
			$pageNumbers.addClass('light');
			this.$gIconsPanel.addClass('light');

			if(this.GLOSSY){

			this.toggleSkinHlpLayerGLTo('dark');

			}else{
				this.$gHelpLayer.addClass('light');
				this.$gHelpLayer.find('.hlpLeftSide').css({background:'url('+bgImage.toDataURL()+')'});
				this.$gHelpLayer.find('.hlpRightSide').css({background:'url('+bgImagetoDataURL()+')'});
			};

			fn.hlp_update_images();
			fn.btn_update();

		}else{
			this.DARK_MODE = true;
			var bgImage  = this.getHlpLayerBgImage();
			this.$gBookBackground.removeClass('light');
			$pageNumbers.removeClass('light');
			this.$gIconsPanel.removeClass('light');

			if(this.GLOSSY){

			this.toggleSkinHlpLayerGLTo('light');	

			}else{
				this.$gHelpLayer.removeClass('light');
				this.$gHelpLayer.find('.hlpLeftSide').css({background:'url('+bgImage.toDataURL()+')'});
				this.$gHelpLayer.find('.hlpRightSide').css({background:'url('+bgImage.toDataURL()+')'});	
			};

			fn.hlp_update_images();
			fn.btn_update();
		};
	},

	cloneIconsSet:function(){
		var $tmpl_icon_set = $('<div style="display:table;"><div style="display:table-row"></div></div>');		
		return $tmpl_icon_set.clone();
	},
	pageNumbersCreate:function(sizeMode){		
		var 
			id = this.divNames.book_page_numbers,
			p = this.CFG.ICONS_PANEL[sizeMode],
			width = p.pageNumbers.width,
			fontSize = p.pageNumbers.fontSize,
			light = !this.DARK_MODE?'class="light" ':'',
			$pn = $([
				'<div id="' + id + '" ' + light,
				'style="display:table-cell;vertical-align:middle;width:'+width+'px;font:'+fontSize+'px arial;">',
				'<span style=""></span></div>'
				].join(''));
		return $pn;
	},
	pageNumbersChange:function(){	
		var 	
			id = this.divNames.book_page_numbers,
			from = this.CURRENT.spread,
			total_spreads = this.getTotalSheets(),
			currfrom = from+'&nbsp;/&nbsp;'+total_spreads;
		
		$('#'+id).find('span').html(currfrom);

	},	
	buttonCreate:function(title,fn,skinMode){
	
		this.$G_ARR_BUTTONS = this.$G_ARR_BUTTONS?this.$G_ARR_BUTTONS:[];

		var 
			_this=this,
			title = title.toLowerCase(),
			skin = skinMode?skinMode.mode:(this.DARK_MODE?'dark':'light');

		if(this.LARGE_ICONS){
			var
				ICONS = window[G_DATA].SKIN.ICONS,
				B_OFFSET = this.BTNS_OFFSET,
				ic = this.CFG.ICONS_SIZE.big,
				book_btn = [
					'<table width="100%" cellpadding="0" cellspacing="0">',
					'<tr><td height="'+ic+'px" align="center">',
						'<div class="btn_image" style="width:'+ic+'px;height:'+ic+'px;" ><img src="'+this.GIF+'"></div>',
					'</td></tr>',
					'<tr><td align="center" class="btn_title">-</td></tr></table>'
				].join('');		
		}else{
			var 
				ICONS = window[G_DATA].SKIN.ICONS_MINI,
				B_OFFSET = this.BTNS_MINI_OFFSET,
				ic = this.CFG.ICONS_SIZE.small,
				book_btn = [
					'<div class="btn_image" style="width:'+ic+'px;height:'+ic+'px;">',
					'<img src="'+this.GIF+'"></div>',
					'</div>'
				].join('');	
		};

		var getBtnParam = function(){

			var 
				param = B_OFFSET[title][0],
				multiple = param.length>1;

			if(multiple){
				var 
					conditionName = B_OFFSET[title][2],
					mode = _this[conditionName]?0:1,
					offset = B_OFFSET[title][0][mode],
					btnsTitle = B_OFFSET[title][1][mode];
			}else{
				var 
					offset = param,
					btnsTitle = title;
			};
			return {
				offset:offset,
				lngTitle:_this.getLNG(btnsTitle)
			}
		};

		var btnOpacity = function(mode){
		   var opacityMode = _this.DARK_MODE?{start:0.7,end:1}:{start:0.8,end:0.5};
		  return opacityMode[mode];
		};
		
		
		var	
			param = getBtnParam(),
			iconBackground = 'url('+ICONS[skin].toDataURL()+') no-repeat '+param.offset+' 0px',
			$tmpl_btn = $('<div class="book_btn" style="width:'+ic+'px;display:table-cell;cursor:pointer;">'+book_btn+'</div>'),
			$btn = $tmpl_btn.clone(),
			$div = $btn.find('.btn_image').css({background:iconBackground,opacity:btnOpacity('end')}).attr({title:param.lngTitle}),
			$title = $btn.find('.btn_title').html(param.lngTitle);
		

		$btn.hover(function(){$div.css({opacity:btnOpacity('start')})},function(){$div.css({opacity:btnOpacity('end')})})
		.mousedown(function(){$div.css({backgroundPosition:param.offset+' 1px'});})
		.mouseup(function(){
			$div.css({backgroundPosition:param.offset+' 0px'});				
			fn&&fn(title);
		});
		$btn.update = function(){
		    var 
				param = getBtnParam(),
		 		skin = _this.DARK_MODE?'dark':'light',
				iconBackground = 'url('+ICONS[skin].toDataURL()+') no-repeat '+param.offset+' 0px',
				$div = this.find('.btn_image').css({background:iconBackground,opacity:btnOpacity('end')}).attr({title:param.lngTitle});
				$div = this.find('.btn_title').html(param.lngTitle);				
		};
		this.$G_ARR_BUTTONS[title] = $btn;		
		return $btn;	
	},

	gotoNext:function(){
		this.$gSaveMenu.hide();
		if(!this.ZOOM_MODE){				
			if(!this.ANIMATION_FLAG && !this.startDrag){
				if(this.isDirectionCorrect('next')){
					this.animateSheet('next');
				}
			}else{
				this.ORDER_TO_ANIMATE = 'next';
			}
		}
	},	
	gotoPrev:function(){
		this.$gSaveMenu.hide();
		if(!this.ZOOM_MODE){
			if(!this.ANIMATION_FLAG  && !this.startDrag){
				if(this.isDirectionCorrect('prev')){
					this.animateSheet('prev');
				}		
			}else{
				this.ORDER_TO_ANIMATE = 'prev';
			}
		}
	},	

	zoomIn:function(coord){

		var _this=this;		
		if(this.ZOOM_MODE || this.ANIMATE_ZOOM){return false;};		
		this.ANIMATE_ZOOM = true;
		this.ZOOM_MODE = 1;		
		
		var nm = this.divNames.zoom_layer;
		var $zoomLayer = $('#'+nm);
			$zoomLayer.size() && $zoomLayer.remove();
		
		this.ZOOMSIZE = {height:$(window).height(),width:$(window).width(),top:0,left:0};		
		var s = this.ZOOMSIZE;
		s.top = $(document).scrollTop();
		
		var zoomk = 0.8;
		var pre = {width:s.width*zoomk,height:s.height*zoomk};
			pre.top = Math.floor(s.top+((s.height-pre.height)/2));
			pre.left = Math.floor(s.left+((s.width-pre.width)/2));
		
		var fn = {
			buildZoomLayer:function(){
				var $zoomLayer = $('<div id="'+nm+'"></div>')
				.css({
					border:'1px solid white',position:'absolute',
					top:pre.top,left:pre.left,width:pre.width,height:pre.height,
					cursor:'pointer',opacity:0.5,zIndex:_this.CFG.ZINDEX.zoomLayer
				}).click(function(){
					if(!_this.ANIMATE_ZOOM){
						_this.zoomOut();
					}				
				});		
				$('body').append($zoomLayer);
				_this.$gZoomLayer = $('#'+nm);					
				fn.animateZoomLayerAppear();
			},
			animateZoomLayerAppear:function(){
				var w = s.width;
				var h = s.height;
				_this.$gZoomLayer.animate({
						top:s.top,left:s.left,
						width:w,height:h,opacity:1
					},200,function(){
					$(this).css({opacity:0,border:'0px none',background:'#e5e5e5'})
					.animate({opacity:1},300,function(){
						_this.ANIMATE_ZOOM = false;
						_this.showZoomContent(coord);
					});
				});		
			}
		};
		fn.buildZoomLayer();
	},	
	
	showZoomContent:function(firstCoord){
		
		var 
			_this = this,
			firstCoord = firstCoord,
			total_spreads = this.getTotalSheets(),
			cs = this.CURRENT.spread,
			isFirstPage = cs == 0,
			isLastPage = cs == total_spreads,
			zSize = this.ZOOMSIZE,
			borderSpace = 250,
			titleHeight = 85,
			cSize = {width:zSize.width,height:zSize.height-titleHeight,left:zSize.left,top:zSize.top},
			pagesAmount = !isFirstPage && !isLastPage ?2:1;
		
		var bookSize = {
			height:this.CFG.BOOK_UNSCALED.height,
			width:this.CFG.BOOK_UNSCALED.width*pagesAmount
			};	
		
		var bookSmallerThanContent = bookSize.width<cSize.width && bookSize.height<cSize.height;
		
		var percentSize = {
			vertical:(bookSize.height+borderSpace*2-cSize.height)/100,
			horizontal:(bookSize.width+borderSpace*2-cSize.width)/100
			};		
		
		var 
			$zoomPages = '',	
			zoomContentClassName = this.divNames.zoom_content,
			zoomBehaviorSection = this.divNames.zoom_behavior_section,
			zoomTitleSpread = this.divNames.zoom_title_spread,
			zoomButtonsClassName = this.divNames.zoom_buttons;
		
		var style='position:absolute;width:100%;height:'+titleHeight+'px;top:'+cSize.height+'px;left:0px;';
		
		var tplContent = [			
			'<div class="'+zoomContentClassName+'" style="width:100%;height:100%;"></div>',
			'<div style="'+style+'z-index:10;background:white;opacity:0.8">&nbsp;</div>',
			'<div style="'+style+'z-index:30;" class="'+zoomButtonsClassName+'">&nbsp;</div>',
			'<div style="position:absolute;width:100%;height:100%;top:0px;left:0px;z-index:20;">',
				'<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">',
					'<tr><td colspan=3 align="center" class="'+zoomBehaviorSection+'"></td></tr>',
					'<tr><td align="center" class="'+zoomTitleSpread+'">'+this.CURRENT.spreadTitle+'</td></tr>',
				'</table>',
			'</div>'
		].join('');
		
		this.$gZoomLayer.html(tplContent);

		var $zoomContent = this.$gZoomLayer.find('.'+zoomContentClassName);
		var $zoomBehavior = this.$gZoomLayer.find('.'+zoomBehaviorSection).css({height:cSize.height});
		var $zoomTitle = this.$gZoomLayer.find('.'+zoomTitleSpread).css({height:titleHeight});
		var $zoomButtons = this.$gZoomLayer.find('.'+zoomButtonsClassName);
								
		var fn = {
			buttonsInsert:function(){
				var $rightIconSet = _this.cloneIconsSet();
				$rightIconSet.append(_this.buttonCreate('zoomClose',function(){},{mode:'light'}));
				$zoomButtons.append($rightIconSet.css({float:'right',margin:'8px 8px 0px 0px'}));
			},
			calculateCoord:function(mouseCoord){
				var coord = {x:mouseCoord.x-cSize.left,y:mouseCoord.y-cSize.top};	
				var percents = {vertical:100/(cSize.height/coord.y),horizontal:100/(cSize.width/coord.x)};			
				var top = percentSize.vertical*(percents.vertical)*-1+borderSpace;
				var left = percentSize.horizontal*(percents.horizontal)*-1+borderSpace;								
				return {top:top,left:left};
			},
			moveContent:function(targetCoord){									
				$zoomPages.css({marginTop:targetCoord.top+'px',marginLeft:targetCoord.left+'px'});
			},
			contentToCenter:function(){
				var frames = 20;			
				var startX = parseFloat($zoomPages.css('marginLeft'))||0;
				var startY = parseFloat($zoomPages.css('marginTop'))||0;
				if(firstCoord && !bookSmallerThanContent){
					var endCoord = this.calculateCoord(firstCoord);
					var endX = endCoord.left;
					var endY = endCoord.top;
				}else{
					var endX = (bookSize.width-cSize.width)/2*-1;
					var endY = bookSize.height<cSize.height?(bookSize.height-cSize.height)/2*-1:0;
				};
				fn.recurseAnimation(frames,0,[startX,startY],[endX,endY]);
			},
			behaviors:function(){
				var that = this;
				$zoomBehavior.mousemove(function(e){			
					if(!bookSmallerThanContent){						
						fn.moveContent(that.calculateCoord({x:e.pageX,y:e.pageY}));									
					}
				}).hover(function(){
					if(!bookSmallerThanContent){
						if(_this.TMR_ZOOMPAGES_ANI){
							clearTimeout(_this.TMR_ZOOMPAGES_ANI)
							_this.TMR_ZOOMPAGES_ANI = null;
						};
						if(firstCoord){
							firstCoord = false;
						}else{
							$zoomPages.hide().fadeIn('normal');
						}					
					}
				},function(){
					if(firstCoord){
						firstCoord = false;
					};
					fn.contentToCenter();
				});
			},
			recurseAnimation:function(frames,count,startCoord,endCoord){						
				_this.TMR_ZOOMPAGES_ANI = setTimeout(function(){
					count++;
					var n = count/frames;
					var a = 1-(1 - Math.sin(Math.acos(1-n)));
					var persent = a*100;				
					var newY = startCoord[1] - (startCoord[1]-endCoord[1])/100*persent;
					var newX = startCoord[0] - (startCoord[0]-endCoord[0])/100*persent;								
					$zoomPages.css({margin:newY+'px 0px 0px '+newX+'px'});
					if(count<frames){fn.recurseAnimation(frames,count,startCoord,endCoord);}	
				},5);		
			},
			showEmptyPages:function(){
				var h = bookSize.height;
				var w = bookSize.width;
				var pages = '';
				if(!isFirstPage && !isLastPage){					
					pages+='<td class="page_back" width="50%"></td><td class="page_front" width="50%"></td>';
				}else{
					pages+=isFirstPage?'<td class="page_front"></td>':'<td class="page_back"></td>';
				};
				var html = [
					'<table class="zoom_pages" width="'+w+'px" height="'+h+'px" style="display:none;"><tr>',
					pages,
					'</tr></table>'
				].join('');
				$zoomContent.html(html);						
				$zoomPages = $zoomContent.find('.zoom_pages');
				fn.behaviors();
				fn.insertSelfShadow();
				fn.choosePageForLoading();
			},
			insertSelfShadow:function(){
				var shadow = _this.SELFSHADOW_UNSCALED;	
				var height=$zoomPages.height();
				$zoomPages.find('.page_back').html('<div style="width:100%;height:'+height+'px;background:url('+shadow['back'].toDataURL()+') no-repeat;">&nbsp;</div>');
				$zoomPages.find('.page_front').html('<div style="width:100%;height:'+height+'px;background:url('+shadow['front'].toDataURL()+') no-repeat;">&nbsp;</div>');
				$zoomPages.fadeIn('normal');
				fn.contentToCenter();
			},
			insertImageToZoomPage:function(image){
				var page_class = image.side=='left'?'.page_back':'.page_front';
				var sheet = image.side=='left'?cs-1:cs;
				var imgBackground = _this.buildResizedImage(_this.CFG.BOOK_UNSCALED,1,{
					img:image.img,
					page:image.side=='left'?0:1,
					sheet:sheet
				},false);		
				if(_this.CFG.DIVIDE_IMAGES){
					var leftMargin = image.side=='left'?0:_this.CFG.BOOK_UNSCALED.width*-1;
					$zoomPages.find(page_class).css({background:'url("'+imgBackground.toDataURL()+'") '+leftMargin+'px 0px no-repeat'});
				}else{
					$zoomPages.find(page_class).css({background:'url("'+imgBackground.toDataURL()+'") no-repeat'});
				}
			},
			loadImageForZoomPage:function(src,side){

				if(!_this.TMR_ZOOM){_this.TMR_ZOOM={};};								
				if(src.indexOf('.png')>-1 || src.indexOf('.jpg')>-1 || src.indexOf('.gif')>-1){
				var img = new Image();
				img.onload = function(){				
					var image = {img:this,src:src,side:side};
					setTimeout(function(){
						fn.insertImageToZoomPage(image)
					},10);
				};
				_this.IMG_NOW_LOADING_FOR_ZOOM.push(img); 
				img.src = src;
				}			
			},
			choosePageForLoading:function(){
				if(!cs){			
					var pageNumber = 0;
					var src = _this.ARR_PAGES_SRC[pageNumber];			
					fn.loadImageForZoomPage(src,'right');
				}else if(cs == total_spreads){
					var pageNumber = total_spreads*2-1;
					var src = _this.ARR_PAGES_SRC[pageNumber];
					fn.loadImageForZoomPage(src,'left');
				}else{
					var pageNumber = cs*2-1;
					var src = _this.ARR_PAGES_SRC[pageNumber];
					fn.loadImageForZoomPage(src,'left');
					var pageNumber = cs*2;
					var src = _this.ARR_PAGES_SRC[pageNumber];		
					fn.loadImageForZoomPage(src,'right');
				}
			}
		};		
		
		fn.buttonsInsert();
		fn.showEmptyPages();
	},	
	
	zoomOut:function(){
		if(!this.ZOOM_MODE){return false;};
		this.ZOOM_MODE = 0;
		this.$gZoomLayer && this.$gZoomLayer.remove();
	},

	rotate_x_to:function(degree){
		if(this.GLOSSY){
			 if(this.gGL ){
			 	this.gGL.bookBase.rotation.x =  degree*Math.PI/180 * (-1);
			 	this.startRender();
			 }
		};
		var transform = 'translate3d(' + this.OFFSET.left + 'px,' + this.OFFSET.top + 'px,0px) rotateX('+degree+'deg)';
		this.$gContainter.css({'-webkit-transform':transform,'-moz-transform':transform,'-ms-transform':transform});
	},

	slopeAnimate:function(){
		var _this=this;
		if(this.ANIMATION_SLOPE){return false;};
		this.ANIMATION_SLOPE = true;
		var total = this.CFG.ARR_SLOPE_ANGLES.length;
		var curr = _this.CURRENT.slope_mode;
		var from = this.CFG.ARR_SLOPE_ANGLES[curr];
		this.CURRENT.slope_mode = curr+1<total?curr+1:0;
		this.CFG.START_SLOPE_MODE = this.CURRENT.slope_mode;		
		var to = this.CFG.ARR_SLOPE_ANGLES[this.CURRENT.slope_mode];
		var k = to>from?1:-1;
		var rotateRecursive = function(){
			from+=k;
			setTimeout(function(){
			    if(from!=to){
					_this.rotate_x_to(from);
					rotateRecursive();
				}else{
					_this.rotate_x_to(from);
					_this.ANIMATION_SLOPE = false;
				}
			},10);
		};
		rotateRecursive();
	},

	slopeAnimateTo:function(direction){
		var _this=this;
		if(this.ANIMATION_SLOPE){return false;};
		this.ANIMATION_SLOPE = true;
		var total = this.CFG.ARR_SLOPE_ANGLES.length;
		var curr = _this.CURRENT.slope_mode;
		var from = this.CFG.ARR_SLOPE_ANGLES[curr];
		if(direction==='up'){
		    if(curr+1<total){
			    this.CURRENT.slope_mode = curr+1;
			}else{
                _this.ANIMATION_SLOPE = false;			
			    return false;
			};
		}else{
		    if(curr>0){
			   this.CURRENT.slope_mode = curr-1;
			}else{
                _this.ANIMATION_SLOPE = false;			
			    return false;			
			}		    
		};		
		this.CFG.START_SLOPE_MODE = this.CURRENT.slope_mode;		
		var to = this.CFG.ARR_SLOPE_ANGLES[this.CURRENT.slope_mode];
		var k = to>from?1:-1;
		var rotateRecursive = function(){
			from+=k;
			setTimeout(function(){
			    if(from!=to){
					_this.rotate_x_to(from);
					rotateRecursive();
				}else{
					_this.rotate_x_to(from);
					_this.ANIMATION_SLOPE = false;
				}
			},10);
		};
		rotateRecursive();
	},	

	slopeToggle:function(num){
		var 
			_this=this,
			num = parseInt(num,10),
			angles = this.CFG.ARR_SLOPE_ANGLES;
		if(num<angles.length){
			var gr = angles[num]; 
			this.CURRENT.slope_mode = num;
			this.CFG.START_SLOPE_MODE = this.CURRENT.slope_mode;
			this.rotate_x_to(gr);
		}
	},
	
	fit3dDataToBookSize:function(){
		var _this=this;
		
		this.FRAMES = this.getClonedData();
		this.FRAMES_GL_SCALED = this.getClonedData();

		var space = !this.$TARGET?this.CFG.SPACE_AROUND_STAGE:{horizontal:0,vertical:0};
				
		var bookSize = {
			width:(this.FIRST_IMAGE_SIZE.w + 2*_this.CFG.BORDER) || 100,
			height:(this.FIRST_IMAGE_SIZE.h + 2*_this.CFG.BORDER) || 100
		};
				
		if(this.CFG.DIVIDE_IMAGES){
			bookSize.width = bookSize.width%2>0?(bookSize.width-1)/2:bookSize.width/2;
		};

		var spaceSize = !this.$TARGET?this.WINSIZE:this.TARGETSIZE;
		if(this.BOOK_INTERNAL){ spaceSize.height = this.CFG.MAX_SCREEN_SIZE.height;};
		var iconsPanelHeight = this.getIconsPanelHeight();
		var screenSize = {
			w:Math.min(this.CFG.MAX_SCREEN_SIZE.width,spaceSize.width)-space.horizontal,
			h:Math.min(this.CFG.MAX_SCREEN_SIZE.height,spaceSize.height)-iconsPanelHeight - space.vertical
			};

		var boundingBox = {
			w:2*bookSize.width + 2*this.CFG.PASPARTU_BEHAVIORS_PARAM.width,
			h:bookSize.height + 2*this.CFG.PASPARTU_BEHAVIORS_PARAM.height
			};				
			
		if(boundingBox.w>screenSize.w || boundingBox.h > screenSize.h){
			var x_ratio = screenSize.w / boundingBox.w;
			var y_ratio = screenSize.h / boundingBox.h;
			var ratio = Math.min(x_ratio, y_ratio);
		}else{ var ratio = 1; };


		this.GSCALE = ratio;

		bookUnscaled = {width:bookSize.width,height:bookSize.height};
		bookSize.width = Math.round(bookSize.width*this.GSCALE);
		bookSize.height = Math.round(bookSize.height*this.GSCALE);

		var bookGLSize = {width:800,height:Math.round(bookSize.height*800/bookSize.width)};

		var bezieArrayLength = this.FRAMES[0][0].bezie.length;
		var dataWidth = Math.abs(this.FRAMES[0][0].bezie[bezieArrayLength-1].x);
		var kscaled = bookSize.width/dataWidth;
		var kGLscaled = bookGLSize.width/dataWidth;

		var calculate = function(frames,k){
			for(var i=0;i<frames.length;i++){
				var edges3d = frames[i].edges3d;
				for(var n=0;n<edges3d.length;n++){
					edges3d[n].width*=k;
					edges3d[n].x*=k;
					edges3d[n].z*=k;
				}
			}
		};
		
		calculate(this.FRAMES[0],kscaled);
		calculate(this.FRAMES[1],kscaled);
		calculate(this.FRAMES_GL_SCALED[0],kGLscaled);
		calculate(this.FRAMES_GL_SCALED[1],kGLscaled);

		if(bookSize.width && bookSize.height){
		
			this.initWithSize(bookSize,bookUnscaled,bookGLSize);	
		
		}

		
	},

	initWithSize:function(bookSize, bookUnscaled, bookGLSize){			
		
		var _this=this;
		
		this.CFG.BOOK_GL_SIZE = bookGLSize;
		this.CFG.BOOK_SIZE = bookSize;
		this.CFG.BOOK_UNSCALED = bookUnscaled;

		this.MOUSE = {		
			startDragCoord:{x:0,y:0},				
			oldCoord:{x:0,y:0},		
			lastCoord:{x:0,y:0},	
			isOverStage:false 		
		};

		this.ANIMATION = {SPEED:15};
		
		this.STAGE = {
			width:Math.round(this.CFG.BOOK_SIZE.width + this.CFG.PASPARTU_BEHAVIORS_PARAM.width*this.GSCALE)*2,
			height:Math.round(this.CFG.BOOK_SIZE.height + this.CFG.PASPARTU_BEHAVIORS_PARAM.height*2*this.GSCALE)
		};
		
		this.STAGE_HALF = {
			width:this.STAGE.width/2,
			height:Math.round(this.STAGE.height/2)
		};
		this.STAGE_CENTER = {top:0,left:0};
		this.OFFSET = {
			top:Math.round((this.STAGE.height-this.CFG.BOOK_SIZE.height)*0.5),
			left:this.STAGE.width*0.5
		};

		this.CURRENT = {
			frame:0,
			sheet:-1,
			dragged_sheet:-1,
			spread:0,
			hoverframe:0,
			hoverside:'front',
			dir_ani:1,
			slope_mode:this.CFG.START_SLOPE_MODE,
			spreadTitle:''
		};

		this.LAST = {
			mousemoved:false,
			sheet:-1,
			forward:1,
			moved:{sheet:-1,$edges:false,forward:0},
		};

		this.$gStage.css({width:this.STAGE.width,height:this.STAGE.height,border:'0px solid red'});
		
		this.$gContainter.css({
				width:this.CFG.BOOK_SIZE.width,
				height:this.CFG.BOOK_SIZE.height*this.CFG.ROTATE_CENTER_OFFSET,border:'0px solid gold'
				});
		
		this.calculateSheets();
		this.correctStartPage();

		this.SELFSHADOW = {
			front:this.createSelfShadow('front',this.CFG.BOOK_SIZE),
			back:this.createSelfShadow('back',this.CFG.BOOK_SIZE)
		};
		this.SELFSHADOW_UNSCALED = {
			front:this.createSelfShadow('front',this.CFG.BOOK_UNSCALED),
			back:this.createSelfShadow('back',this.CFG.BOOK_UNSCALED)
		};


		this.buildIconsPanel();		
		this.buildSaveMenuLayer();
		!_this.GLOSSY && this.buildHelpLayer();
		this.stageToCenter();
		this.behavior();
		
		if(this.GLOSSY){ 
			if(!this.gGL){
				this.gGL = this.getGlStage();
				this.createGlHlpLayer();
				this.renderGL();
			}else{
				this.updateGlStage();
				this.updateGlHlpLayer();
			};
			this.startRender();
		};			
		
		this.rotate_x_to(this.CFG.ARR_SLOPE_ANGLES[this.CURRENT.slope_mode]);

		this.buildAndPreloadSheets();

		
	},
	updateGlStage:function(){
		var gl = this.gGL, 
			width = this.$gStage.width(), 
			height = this.$gStage.height();
		this.$gGlossyContainter.css({width:width,height:height});
		gl.renderer.setSize(width, height);
	},	
	updateGlHlpLayer:function(){
		var glhlp = this.gGL.helpLayers;
		this.gGL.bookBase.remove(glhlp['dark'].left);
		this.gGL.bookBase.remove(glhlp['dark'].right);
		this.gGL.bookBase.remove(glhlp['light'].left);
		this.gGL.bookBase.remove(glhlp['light'].right);
		this.createGlHlpLayer();
	},
	createGlHlpLayer:function(){
		var 
			_this=this,
			bookSize = this.CFG.BOOK_SIZE,
			size = this.CFG.BOOK_GL_SIZE,
			bgImages  = {dark:this.getHlpLayerBgImage('dark'),light:this.getHlpLayerBgImage('light')},
			hlpImageSize = {width:300,height:200},
			skinMode = this.DARK_MODE?'dark':'light',
			SKIN = window[G_DATA].SKIN;

		var fn = {
			PlainTextured:function(options){
			    var white = "data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==";		    
				var transparent = "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7";
			    var src = options.src || white;
				var side = THREE.FrontSide;
				var skin = options.skin;
		        var plainMesh = new THREE.Mesh(
					   new THREE.PlaneGeometry( size.width, size.height ),
					   new THREE.MeshBasicMaterial({map:THREE.ImageUtils.loadTexture( transparent ), transparent:true, side:side })
					);
			    THREE.ImageUtils.loadTexture(src,undefined,function(texture){
	               plainMesh.material.map = texture;
	               if(skin!==skinMode){plainMesh.material.opacity = 0;};
				    options.onReady && options.onReady(plainMesh);
				});
	            return plainMesh;			
			},
			backgroundImage:function(side, skin){

				var cnv = document.createElement('canvas');
					cnv.width = size.width; cnv.height = size.height;
				var ctx = cnv.getContext("2d");
					ctx.drawImage(bgImages[skin],0,0,cnv.width,cnv.height);		

					ctx.lineWidth = 4;
					ctx.strokeStyle = skin==='dark'?'#888888':'#bcbcbc';	

					var k = 470/bookSize.width;
					k = k>2.2?2.2:k;
					k = k<0.8?0.8:k;

					if(side==='left'){
						
						ctx.beginPath();						
						ctx.moveTo(size.width,0);
						ctx.lineTo(0,0);
						ctx.lineTo(0,size.height);
						ctx.lineTo(size.width,size.height);
						ctx.stroke();

						var hlpLeftImage = fn.hlpLeftImage(skin);
						ctx.drawImage(hlpLeftImage,size.width-hlpImageSize.width*k-20,size.height-hlpImageSize.height*k-20,hlpImageSize.width*k,hlpImageSize.height*k);

					}else{

						ctx.beginPath();
								
						ctx.moveTo(0,0);
						ctx.lineTo(size.width,0);
						ctx.lineTo(size.width,size.height);
						ctx.lineTo(0,size.height);	
						ctx.stroke();

						var hlpRightImage = fn.hlpRightImage(skin);
						ctx.drawImage(hlpRightImage,size.width-hlpImageSize.width*k-20,size.height-hlpImageSize.height*k-20,hlpImageSize.width*k,hlpImageSize.height*k);						

					};
					
				return cnv.toDataURL();
			},
			hlpLeftImage:function(skin){
				var
					lngHlpClickToOpen = _this.getLNG('hlpClickToOpen'),
					lngHlpUseMousewheel = _this.getLNG('hlpUseMousewheelGL');
				var cnv = document.createElement('canvas');
					cnv.width = hlpImageSize.width; cnv.height = hlpImageSize.height;
				var ctx = cnv.getContext("2d");
					ctx.fillStyle = skin==='dark'?'rgba(255,255,255,1)':'rgba(0,0,0,1)';
					ctx.font = "bold 20pt Arial";
					ctx.textAlign = 'right';
					ctx.fillText(lngHlpClickToOpen, hlpImageSize.width-10, hlpImageSize.height-155);
					ctx.fillStyle = skin==='dark'?'rgba(255,255,255,0.5)':'rgba(0,0,0,.5)';
					ctx.font = "18pt Arial";
					ctx.fillText(lngHlpUseMousewheel[0], hlpImageSize.width-10, hlpImageSize.height-110);
					ctx.fillText(lngHlpUseMousewheel[1], hlpImageSize.width-10, hlpImageSize.height-80);
				var arrowImage = SKIN.HELP_ARROW[skin],
					k=1.5;
					ctx.drawImage(arrowImage,cnv.width-arrowImage.width*k-10,cnv.height-arrowImage.height*k-20,arrowImage.width*k,arrowImage.height*k);
					return cnv;						
			},
			hlpRightImage:function(skin){
				var lngHlpToStart = _this.getLNG('toStart');
				var cnv = document.createElement('canvas');
					cnv.width = hlpImageSize.width; cnv.height = hlpImageSize.height;
				var ctx = cnv.getContext("2d");	
					ctx.fillStyle = skin==='dark'?'rgba(255,255,255,1)':'rgba(0,0,0,1)';
					ctx.font = "20pt Arial";
					ctx.textAlign = 'right';
					ctx.fillText(lngHlpToStart, hlpImageSize.width-10, hlpImageSize.height-10);	
					return cnv;											  
			}
		};

		var layerLeftLight = fn.PlainTextured({
			src:fn.backgroundImage('left','light'),
			side:'left', skin:'light',
			onReady:function(plainMesh){
				plainMesh.position.y = size.height*_this.CFG.ROTATE_CENTER_OFFSET_GL;
				plainMesh.position.z = -5;
				plainMesh.position.x = - size.width*0.5;
				_this.gGL.bookBase.add(plainMesh);			
			}
		});

		var layerRightLight = fn.PlainTextured({
			src:fn.backgroundImage('right','light'),
			side:'right', skin:'light',			
			onReady:function(plainMesh){
				plainMesh.position.y = size.height*_this.CFG.ROTATE_CENTER_OFFSET_GL;
				plainMesh.position.z = -5;
				plainMesh.position.x = size.width*0.5;
				_this.gGL.bookBase.add(plainMesh);			
			}
		});		

		var layerLeftDark = fn.PlainTextured({
			src:fn.backgroundImage('left','dark'),
			side:'left', skin:'dark',
			onReady:function(plainMesh){
				plainMesh.position.y = size.height*_this.CFG.ROTATE_CENTER_OFFSET_GL;
				plainMesh.position.z = -5;
				plainMesh.position.x = - size.width*0.5;
				_this.gGL.bookBase.add(plainMesh);			
			}
		});

		var layerRightDark = fn.PlainTextured({
			src:fn.backgroundImage('right','dark'),
			side:'right', skin:'dark',			
			onReady:function(plainMesh){
				plainMesh.position.y = size.height*_this.CFG.ROTATE_CENTER_OFFSET_GL;
				plainMesh.position.z = -5;
				plainMesh.position.x = size.width*0.5;
				_this.gGL.bookBase.add(plainMesh);			
			}
		});	
		this.gGL.helpLayers = {light:{left:layerLeftLight,right:layerRightLight},dark:{left:layerLeftDark,right:layerRightDark}};

	},
	correctStartPage:function(){
		var verify_range = function(num,min,max){
			if(num<min){num=min};
			if(num>max){num=max};
			return num;
		};
		this.START_PAGE = verify_range(this.START_PAGE,1,this.getTotalSheets()*2);
		this.CURRENT.spread = (this.START_PAGE - this.START_PAGE%2)/2;
		this.START_FROM_END = this.CURRENT.spread===this.getTotalSheets();
	},

	calculateSheets:function(){
		if(!this.ALLSHEETS || !this.ALLSHEETS.length){
			this.ALL_PAGES_MAP = [];
			var Sheets = [];
			if(!this.CFG.DIVIDE_IMAGES){
				var totalPages = this.ARR_PAGES_SRC.length;
			}else{
				if(this.ARR_PAGES_SRC.length<2){this.ARR_PAGES_SRC.push(this.CFG.PAGE_DEFAULT_COLOR);};
				var totalPages = this.ARR_PAGES_SRC.length*2;
				var arr = [];
				arr.push(this.ARR_PAGES_SRC[0]); 
				for(var i=1;i<this.ARR_PAGES_SRC.length;i++){
						arr.push(this.ARR_PAGES_SRC[i]);
						arr.push(this.ARR_PAGES_SRC[i]);
					};
				arr.push(this.ARR_PAGES_SRC[0]); 
				this.ARR_PAGES_SRC = arr;			
			};
			for(var i=0;i<totalPages;i++){
				var isImage = this.ARR_PAGES_SRC[i].indexOf('.jpg')>-1||this.ARR_PAGES_SRC[i].indexOf('.png')>-1 ||this.ARR_PAGES_SRC[i].indexOf('.gif')>-1;
				this.ALL_PAGES_MAP[i] = isImage?'image':'color';
			};
			var amountOfSheets = totalPages%2>0? (totalPages+1)/2 : totalPages/2;
			if(totalPages<amountOfSheets*2){this.ARR_PAGES_SRC.push(this.CFG.PAGE_DEFAULT_COLOR)};
			for(var i=0;i<this.ARR_PAGES_SRC.length;i+=2){
				Sheets.push({
				front:this.ARR_PAGES_SRC[i],
				back:this.ARR_PAGES_SRC[i+1],
				opened:0
				});
			};
			this.ALLSHEETS = Sheets;
		}	
	},
	createSelfShadow:function(side,size){
		var _this = this;		
		var canvas = document.createElement('canvas');
		canvas.width = size.width; 
		canvas.height = size.height;
		var ctx = canvas.getContext('2d');
		var lingrad = ctx.createLinearGradient(0,0,canvas.width,0);
			if(side=='front'){
			lingrad.addColorStop(0, 'rgba(0,0,0,0.15)');
			lingrad.addColorStop(0.30, 'rgba(0,0,0,0)');
		}else{
			lingrad.addColorStop(0.70, 'rgba(255,255,255,0)');
			lingrad.addColorStop(1, 'rgba(255,255,255,0.15)');
		};
		ctx.fillStyle = lingrad;
		ctx.fillRect(0,0,canvas.width, canvas.height);
		return canvas;
	},

	addCeshNames :function(rnd){
		for(var i=0;i<this.ARR_PAGES_SRC.length;i++){
			var imgSrc = this.ARR_PAGES_SRC[i];
			if(imgSrc.indexOf('.png')>-1 || imgSrc.indexOf('.jpg')>-1 || imgSrc.indexOf('.gif')>-1){
				this.ARR_PAGES_SRC[i] += ('?cash='+rnd);
			}
		};
	},

	getClonedData:function(){
		return $.extend(true,{},{arr:this.FRDATA}).arr;
	},

	getLNG:function(str){
		var s = this.LNG[str]||this.LNG[str.toLowerCase()];
		return s?s[this.CFG.LANGUAGE]:'unknown';	
	},

	findBookSizeByFirstImage:function(nextFoo){
		var _this=this;
		var firstImageSrc = '';
		for(var i=0;i<this.ARR_PAGES_SRC.length && firstImageSrc=='';i++){
			var imgSrc = this.ARR_PAGES_SRC[i];
			if(imgSrc.indexOf('.png')>-1 || imgSrc.indexOf('.jpg')>-1 || imgSrc.indexOf('.gif')>-1){
				firstImageSrc = imgSrc;
			}
		};
		if(firstImageSrc!=''){
			var image = new Image();
			image.onload = function(){
				_this.FIRST_IMAGE_SIZE = {w:this.width,h:this.height};
				nextFoo&&nextFoo();
			};
			image.src = firstImageSrc;
		}else{
			
		}
	},

	isNeedResizeReposInternal:function(){
		if(this.BOOK_INTERNAL){
			var $t = this.$TARGET;
			var newsize = {top:0,left:$t.offset().left,width:$t.width(),height:100};
			var oldsize = this.TARGETSIZE;
			this.TARGETSIZE = newsize;
			if(newsize.width!==oldsize.width){
				return 'resize';
			}else if(newsize.left!==oldsize.left){
				return 'reposition';
			}else{
				return false;
			}
		}else{
			return false;
		}
	},

	behavior:function(){

		var _this=this;
		this.startDrag = false;

		if(!this.HAS_BEHAVIORS){

		$(window).bind('resize.'+this.PRE_NAME,function(){
			
			_this.zoomOut();

			if(_this.TMR_RESIZE){clearTimeout(_this.TMR_RESIZE);_this.TMR_RESIZE=null};
			_this.TMR_RESIZE = setTimeout(function(){

				if(_this.BOOK_INTERNAL){
					if(!window[G_DATA].SUPERBOOK){
						var update = _this.isNeedResizeReposInternal();
						
						update && _this.restart(update);
					}
				}else{
					
					_this.restart();
				}

			},300);
		});

		$(document).bind('keyup.'+this.PRE_NAME,function(event){
			if(window[G_DATA].CURRENT === _this.PRE_NAME){
				if(event.keyCode===39){
					_this.gotoNext();
				}else if(event.keyCode===37){
					_this.gotoPrev();
				}
			}
		});

		this.HAS_BEHAVIORS=true;
		};	
		
		var zoomWaiterCanvas = {
			id:this.PRE_NAME+'canvasZoomWaiter',
			size:this.CFG.ZOOM_WAITER_SIZE,
			create:function(){
				_this.$gZoomWaiter = $('#'+_this.divNames.zoom_waiter).css({width:this.size,height:this.size});
				_this.$gZoomWaiter.html('<canvas id="'+this.id+'" width="'+this.size+'" height="'+this.size+'"></canvas>');				
				_this.gZoomWaiterContext = document.getElementById(this.id) && document.getElementById(this.id).getContext('2d');
			}
		};
		zoomWaiterCanvas.create();		
				
		var waiter = {
			size:this.CFG.ZOOM_WAITER_SIZE,
			radius:25,
			draw:function(gr){		
				var s = this.size;
				var r = this.radius;
				var drawCircle = function(ctx){
					ctx.clearRect(0,0,s,s);
					ctx.beginPath();
					ctx.lineWidth = 2;
					ctx.strokeStyle = '#c7c7c7';
					var center = s/2;
					var ang = (gr-90)*Math.PI/180;
					var ang1= -1.5707963267948966;
					ctx.arc(center,center,r,ang1,ang);
					ctx.stroke();					
				};
				_this.gZoomWaiterContext && drawCircle(_this.gZoomWaiterContext);
			},
			show:function(){
				var stageSize = _this.STAGE_BOUNDING_BOX;
				var m = _this.MOUSE.startDragCoord;
				_this.$gZoomWaiter.css({top:m.y-30-stageSize.top,left:m.x-30-stageSize.left}).show();
			},
			hide:function(){
				_this.$gZoomWaiter.hide();
			}
		};

		var waiting_zoom = function(stop){
			var i=0,tmr,p={time:20,start:5,pause:40},k=360/(p.time-p.start),started=false;
			(waiting_zoom = function(stop){		
			
			var fn = {
				stop_waiting:function(){
					if(started){
						started = false;
						waiter.hide();
						if(i){
							i=0; 
							tmr && clearTimeout(tmr);
							tmr = null;
						}
					}
				},
				verify:function(){
					if(stop){		
						this.stop_waiting();						
					}else if(i>p.time-1){
						this.stop_waiting();
						if(!_this.GLOSSY){
							_this.getSheetByIndex(_this.CURRENT.dragged_sheet).find('.wholeimage').show();
						};
						_this.ORDER_TO_ANIMATE = false;
						_this.stop_drag();
						_this.zoomIn(_this.MOUSE.startDragCoord);
					}else{
						started = true;
						i++;
						if(i===(p.start+1)){waiter.show()};
						if(i>p.start){waiter.draw(k*(i-p.start))};						
						tmr = setTimeout(function(){waiting_zoom();},p.pause);
					}
				}
			};
			fn.verify();
			})(stop);
		};
		
		var $bookStage = $('#'+_this.divNames.book_stage);		
		
		$bookStage.unbind();		
		
		$bookStage.swipeMePls({
			preventDefault: true,
			enableMouse: false,
			distance: 100,		
		    onSwipe:function(opt){              
			  if(opt.direction==='right' || opt.direction==='left'){
				var go = opt.direction==='right'?'gotoPrev':'gotoNext';
		        _this.clickSpeedIsOk()&&_this[go]();
			  }else if(opt.direction==='up' || opt.direction==='down'){
				 _this.slopeAnimateTo(opt.direction);
			  }
			}
		});
		
		$bookStage
		.hover(function(){
			_this.MOUSE.isOverStage = true;
		},function(){
			_this.MOUSE.isOverStage = false;
			if(!_this.ANIMATION_FLAG){
				if(_this.startDrag){
					_this.stop_drag_and_animate();
				}
			};
		});
		
		$bookStage
		.mousedown(function(e){	
			_this.LAST.mousemoved = false;
			if(!_this.ZOOM_MODE){
				if(_this.ANIMATION_FLAG || !_this.isMouseOverPage()){
					return false;
				}else{			
					waiting_zoom();
					_this.start_drag(e);
					return false;
				}
			}else{
				return false;	
			}
		});
		
		$bookStage
		.mouseup(function(){
			if(!_this.ZOOM_MODE){
				waiting_zoom('stop');
				var direction = _this.CURRENT.hoverside==='front'?'next':'back';
				if(_this.ANIMATION_FLAG){
					if(!_this.LAST.mousemoved){
						_this.ORDER_TO_ANIMATE = direction;			
					};
					return false;
				}else{				
					
					if(_this.startDrag){
						_this.stop_drag_and_animate();
					};
					
					if(_this.GLOSSY && _this.GL_LINK_TO_START){
						_this.gotoSpread(0);
					};
				}
			}else{
				return false;
			}			
		});

		$bookStage
		.mousemove(function(e){

			_this.MOUSE.oldCoord = _this.MOUSE.lastCoord;
			_this.MOUSE.lastCoord = {x:e.pageX,y:e.pageY};
			_this.calculateSideAndFrame(_this.MOUSE.lastCoord);
			_this.LAST.mousemoved = true;

			!_this.ZOOM_MODE && waiting_zoom('stop');
			if(_this.ANIMATION_FLAG){ return false;};
				
			if(_this.startDrag){

				var mouseSpeedX = Math.abs(_this.MOUSE.oldCoord.x-_this.MOUSE.lastCoord.x);
				if(mouseSpeedX > _this.CFG.MAX_MOUSE_SPEED_X){
					_this.stop_drag_and_animate();
					return;
				};

				var deltaX = Math.abs(_this.MOUSE.startDragCoord.x - _this.MOUSE.lastCoord.x);
				var drag_persent = Math.round(deltaX/_this.CFG.DRAG_PARAM.px_per_persent);
				var goto_frame = drag_persent + _this.START_DRAG_FRAME || 0;
				if(goto_frame > _this.CFG.MAX_FRAME_DRAGGABLE){
					_this.stop_drag_and_animate();
					return;
				};

				_this.drag_sheet(goto_frame);				
			
			}

		});
		
		$bookStage.mousewheel &&
		$bookStage.mousewheel(function(e,d){
			if(_this.ANIMATION_FLAG || _this.startDrag){
				return false;
			}else{
				var go = d>0?'gotoPrev':'gotoNext';					
				if(_this.clickSpeedIsOk()){ _this[go](); };
				return false;
			}						
		});
	
	},
	clickSpeedIsOk:function(){
		var newTime = new Date().getTime();	
		if(!this.G_TMR_SPEED_CLICK){
			this.G_TMR_SPEED_CLICK = newTime;
			return true;
		}else{
			var oldtime = this.G_TMR_SPEED_CLICK;
			var delta = newTime-oldtime;			
			if(delta>1100){ 
				this.G_TMR_SPEED_CLICK = newTime;
				return true;					
			}else{
				return false;
			}
		}
	},

	start_drag:function(e){
		this.MOUSE.startDragCoord = {x:e.pageX,y:e.pageY};
		this.START_DRAG_FRAME = this.CURRENT.frame;
		this.startDrag = this.CURRENT.hoverside;
		var s = this.CURRENT.spread;
		this.CURRENT.dragged_sheet = this.startDrag=='front'?s:s-1;
	},

	stop_drag_and_animate:function(){
		var go = this.startDrag=='front'?'gotoNext':'gotoPrev';
		this.CURRENT.dragged_sheet = -1;
		this.startDrag = false;
		this[go]();			
	},

	stop_drag:function(){
		this.CURRENT.dragged_sheet = -1;
		this.startDrag = false;
	},

	changeSpreadTitle:function(){

		var cs = this.CURRENT.spread;
		var total = this.ARR_PAGES_TITLE.length;
		var titles = {left:"",right:""};
		var spreadTitle = '';
		
		if(cs===0){
			var first_page = true;
			titles.right = this.ARR_PAGES_TITLE[0]||'';
		}else if(cs*2-1 == total){
			var last_page = true;		
			titles.left = this.ARR_PAGES_TITLE[cs*2-1]||'';
		}else{
			titles.left = this.ARR_PAGES_TITLE[cs*2-1]||'';
			titles.right = this.ARR_PAGES_TITLE[cs*2]||'';		
		};
			
        if(first_page){
			spreadTitle = '<p>'+titles.right+'</p>';
		}else if(last_page){
			spreadTitle = '<p>'+titles.left+'</p>';
		}else{
				var strLeft = this.getLNG('left');
				var strRight = this.getLNG('right');
				if(titles.left && titles.right){
					spreadTitle = [
						'<p><span>'+strLeft+':</span> '+titles.left+'<br>',
						'<span>'+strRight+':</span> '+titles.right+'</p>'
						].join('');
				}else if(titles.left){		
					spreadTitle = '<p><span>'+strLeft+':</span> '+titles.left+'</p>';
				}else if(titles.right){		
					spreadTitle = '<p><span>'+strRight+':</span> '+titles.right+'</p>';
				};		
		};
			
		this.CURRENT.spreadTitle = spreadTitle;
		this.$gSpreadTitle.html(spreadTitle);
		
	},	

	calculateBounds:function(){
		
		var 
			_this=this,
			p = _this.CFG.ICONS_PANEL,
			iconsPanelHeight = _this.getIconsPanelHeight(),
			s = _this.STAGE,
			d = !_this.$TARGET?_this.WINSIZE:_this.TARGETSIZE,
			targetPos = !_this.$TARGET?{top:0,left:0}:{top:_this.$TARGET.offset().top,left:_this.$TARGET.offset().left},
			pasp_height = _this.CFG.PASPARTU_BEHAVIORS_PARAM.height * _this.GSCALE,
			icons_panel_offset = pasp_height*p.overlay_pr,
			top = Math.round((d.height - ( s.height + iconsPanelHeight - icons_panel_offset ))*0.5);	

		top = !_this.BOOK_INTERNAL?top+$(document).scrollTop():0;

		this.STAGE_OFFSET = offset = {
			left:Math.round(d.width*0.5-s.width*0.5)+targetPos.left,
			top:top+targetPos.top
		};

		this.STAGE_CENTER = {
			top:Math.round(offset.top + s.height*0.5),
			left:Math.round( offset.left + s.width*0.5 )
		};
		
		this.STAGE_BOUNDING_BOX = {
			width:s.width,height:s.height,
			top:offset.top,left:offset.left
		};			
		
		var iconsPanelRealWidth = this.$gIconsPanel.width();

		this.ICONS_PANEL_BOUNDS = ipb = {
			width:iconsPanelRealWidth,
			height:this.$gIconsPanel.height(),
			left:d.width*0.5-iconsPanelRealWidth*0.5 + targetPos.left,
			top:offset.top + _this.STAGE.height - icons_panel_offset
		};
		
		this.MAX_BOUNDS = {
			width:Math.max(_this.STAGE_BOUNDING_BOX.width,ipb.width),
			height:Math.round(ipb.top + ipb.height -_this.STAGE_BOUNDING_BOX.top),
			top:_this.STAGE_BOUNDING_BOX.top,
			left:Math.min(_this.STAGE_BOUNDING_BOX.left,ipb.left)
		};	

	},

	stageToCenter:function(){

		var _this=this;
		if(!this.STAGE){return;}
		if(this.tmrToCenter){clearTimeout(this.tmrToCenter);}
		this.$gStage.hide();

		this.tmrToCenter = setTimeout(function(){
			_this.calculateBounds();
			_this.$gStage.css({top:_this.STAGE_OFFSET.top,left:_this.STAGE_OFFSET.left}).show();
			_this.bgLoaderShow(false);

			var 
				ipb = _this.ICONS_PANEL_BOUNDS,
				loader = {width:_this.$gBookLoader.width(),height:_this.$gBookLoader.height()},
				saveMenu = {width:_this.$gSaveMenu.width(),height:_this.$gSaveMenu.height()},
				stage = _this.STAGE;

			_this.$gIconsPanel.css({top:ipb.top,left:ipb.left,visibility:'visible'});
			_this.$gBookLoader.css({top:stage.height*0.5-loader.height*0.5,left:stage.width*0.5-loader.width*0.5});
			_this.$gSaveMenu.css({top:stage.height*0.5-saveMenu.height*0.5+_this.STAGE_OFFSET.top,left:stage.width*0.5-saveMenu.width*0.5+_this.STAGE_OFFSET.left});
			_this.correctTargetHeight();

		},100);

	},

	correctTargetHeight:function(){
		if(this.BOOK_INTERNAL){
			this.$TARGET.css({height:this.MAX_BOUNDS.height});
			this.$TARGET.attr('onebook3d',this.PRE_NAME);
		};
		window[G_DATA].buildNextBook();
	},

	drag_sheet:function(frame){

		var		frame = frame<100?frame:100,
				sheet = this.CURRENT.dragged_sheet;

		if(this.GLOSSY){
			var 
				gl_sheet = this.getSheetByIndex(sheet),
				gl_edges = this.getEdgesFormSheet(sheet),
				forward = this.startDrag=='front'?1:0,
				SHEET_PARAM = {gl_sheet:gl_sheet,gl_edges:gl_edges,forward:forward};			
		}else{
			var 
				$sheet = this.getSheetByIndex(sheet),
				$edges = this.getEdgesFormSheet(sheet),
				forward = this.startDrag=='front'?1:0,
				SHEET_PARAM = {sheet:sheet,$edges:$edges,forward:forward};
			
			if(this.SHEET_DISPLAYED===null){
				this.SHEET_DISPLAYED = sheet;
				$sheet.find('.all_edges').show();
				$sheet.find('.wholeimage').hide();
			}
		};

		this.moveSheetTo(frame,SHEET_PARAM);

	},
	
	moveSheetTo:function(frame,param,DBG_NAME){
		var _this = this,
			frame = frame||0,
			sheet = param.sheet,
			forward = param.forward,
			edgeOffset = 2, 
			edges3d = _this.GLOSSY?this.FRAMES_GL_SCALED[forward][frame].edges3d:this.FRAMES[forward][frame].edges3d;

		if(!this.GLOSSY){
			var 
				$hlpLeft = this.$gHelpLayer.find('.hlpLeftSide'),
				$hlpRight = this.$gHelpLayer.find('.hlpRightSide'),
				totalSheets = this.getTotalSheets();

			if(_this.startDrag && !sheet && forward){
				$hlpLeft.css({opacity:(100-frame)/100});
			}else if(_this.startDrag && sheet===totalSheets-1 && !forward){				
				$hlpRight.css({opacity:(100-frame)/100});	
			};
		}else{
			var glHlp = this.getHlpLayerGL(); 		
			var totalSheets = this.getTotalSheets();
			if(glHlp.left&&glHlp.right){
				if(_this.startDrag && !sheet && forward){
					glHlp.left.material.opacity = (100-frame)/100;
				}else if(_this.startDrag && sheet===totalSheets-1 && !forward){	
					glHlp.right.material.opacity = (100-frame)/100;
				};					
			}		
		};	

		if(this.GLOSSY){

			var gl_edges = param.gl_edges;
			
			this.CURRENT.frame = frame;
			for(var m=0;m<edges3d.length;m++){
				var width = edges3d[m].width+edgeOffset;
				gl_edges[m].width = width;
				gl_edges[m].position.x = edges3d[m].x;
				gl_edges[m].position.z = -edges3d[m].z;
				gl_edges[m].rotation.y = Math.PI*edges3d[m].angle/180;
			};

			this.LAST.moved = {sheet:sheet,gl_edges:gl_edges,forward:forward};
			this.startRender();

		}else{
			
			var $edges = param.$edges;
			if($edges && $edges.size()){
				
				this.CURRENT.frame = frame;
				for(var m=0;m<edges3d.length;m++){
					var width = edges3d[m].width+edgeOffset;
					$edges.eq(m).css({
						width:width+'px',
						'-webkit-transform':'translate3d('+edges3d[m].x+'px,0px,'+(-edges3d[m].z)+'px) rotateY('+edges3d[m].angle+'deg)',
						'-moz-transform':'translate3d('+edges3d[m].x+'px,0px,'+(-edges3d[m].z)+'px) rotateY('+edges3d[m].angle+'deg)',
						'-ms-transform':'translate3d('+edges3d[m].x+'px,0px,'+(-edges3d[m].z)+'px) rotateY('+edges3d[m].angle+'deg)'
					});
				};
				this.LAST.moved = {sheet:sheet,$edges:$edges,forward:forward};
			}
		}
	},
	calculateSideAndFrame:function(mouse_coord){	
		var _this=this;	
		try{
		var deltaY = mouse_coord.y - this.STAGE_CENTER.top;
		var deltaYabs = Math.abs(deltaY);
		var deltaX = mouse_coord.x - this.STAGE_CENTER.left;		
		var paspartuWidth = this.STAGE_HALF.width - this.CFG.BOOK_SIZE.width;
		var widthSensitive = this.CFG.BOOK_SIZE.width + Math.floor(paspartuWidth*0.8);
		var widthUnsensitive = this.STAGE_HALF.width - widthSensitive;
		var kWidth = widthUnsensitive/100;
		var absDeltaX = Math.abs(deltaX);
		var mouse_over = {
				x:Math.round(absDeltaX/this.CFG.BOOK_SIZE.width*100),
				y:Math.round(100 - deltaYabs/this.STAGE_HALF.height*100)
			};
		if(deltaY<0){ mouse_over.y = mouse_over.y > 50?100:mouse_over.y*2; };
		if(absDeltaX>widthSensitive){mouse_over.x = Math.floor((this.STAGE_HALF.width-(absDeltaX-1))/kWidth);};
		if(mouse_over.x > 100){mouse_over.x = 100};
		var strong = Math.round((mouse_over.x*0.8+20)/100*mouse_over.y);		
		this.CURRENT.hoverside = deltaX<0?'back':'front';
		this.CURRENT.hoverframe = Math.round(this.CFG.SHEETS_SENSIVITY/100*strong);		
		this.LAST.sheet = this.CURRENT.sheet;
		this.CURRENT.sheet = this.CURRENT.hoverside === 'front'?this.CURRENT.spread:this.CURRENT.spread-1;

			if(this.GLOSSY){
				if(this.CURRENT.sheet == this.ALLSHEETS.length){
					if(deltaX > this.CFG.BOOK_SIZE.width*0.75 && deltaY > this.STAGE_HALF.height*0.5){
						_this.$gStage.addClass('pointer');
						_this.GL_LINK_TO_START = true;
					}else{
						_this.GL_LINK_TO_START = false;
						_this.$gStage.removeClass('pointer');
					}
				} 
			}
		
		}catch(e){
			
		}
	},
	getEdgesFormSheet:function(sheetIndex){
		if(this.GLOSSY){
			var gl_sheet = this.GL_ARR_SHEETS[sheetIndex];
			if(gl_sheet && gl_sheet.mesh){
				gl_sheet.mesh.position.z = 1*this.CFG.GL_DEPTH_STEP;
				return gl_sheet.mesh.children;
			}else{
				return false;
			}
		}else{
			var $sheet = this.$ARR_SHEETS[sheetIndex];
			if($sheet && $sheet.size()){
				$sheet.css({zIndex:20000});	
				return $sheet.find('div');
			}else{
				return false;
			}
		}
	},	
	getSheetByIndex:function(sheetIndex){
		return this.GLOSSY? this.GL_ARR_SHEETS[sheetIndex] : this.$ARR_SHEETS[sheetIndex];
	},	
	isMouseOverPage:function(){
		if(!this.MOUSE.isOverStage){
			return false;
		};		
		var isFirstPage = this.CURRENT.spread == 0;
		var isLastPage = this.CURRENT.spread == this.getTotalSheets();
		if(!isFirstPage && !isLastPage){
			return true;
		}else if(isFirstPage && this.CURRENT.hoverside=='front'){
			return true;
		}else if(isLastPage && this.CURRENT.hoverside=='back'){
			return true;
		}else{
			return false;
		}
	},
	isDirectionCorrect:function(direction){
		var dirNext = direction==='next'?1:0,
		maxspreads = this.ALLSHEETS.length;
		if(this.CURRENT.spread===0 && !dirNext){
			return false;
		}else if(this.CURRENT.spread===maxspreads && dirNext){
			return false;
		}else{
			return true;
		}
	},
	startOffsetDepth:function(forward,sheet){
		var _this = this;
		if(this.GLOSSY){
			var gl_sheet = this.getSheetByIndex(sheet),
				gl_sorted = this.getSheetsSortedBySide();
			if(forward){
				gl_sorted.sidesRight[0].mesh.position.z = 1*_this.CFG.GL_DEPTH_STEP;
				$.each(gl_sorted.sidesRight,function(i){
					if(i){
						this.mesh.position.z = ((i-1)*-1*_this.CFG.GL_DEPTH_STEP);
					}
				});	
			}else{
				 var 
				 	size = gl_sorted.sidesLeft.length,			
				 	count = 1;		
				 if(size){
				 	for(var i=size;i>0;i--){
				 		gl_sorted.sidesLeft[i-1].mesh.position.z = count*_this.CFG.GL_DEPTH_STEP;	
				 		count-=1;
				 	}
				 }
			}							
		}else{
			var $sheet = this.getSheetByIndex(sheet),
				$sidesLeft = this.$gContainter.find('.side-left'),
				$sidesRight = this.$gContainter.find('.side-right');
			if(forward){
				$sidesRight.eq(0).css({
					'-webkit-transform':'translate3d(0px,0px,1px)',
					'-moz-transform':'translate3d(0px,0px,1px)',
					'-ms-transform':'translate3d(0px,0px,1px)'
				});			
				$sidesRight.each(function(i){
					if(i){
						$(this).css({
							'-webkit-transform':'translate3d(0px,0px,'+((i-1)*-1)+'px)',
							'-moz-transform':'translate3d(0px,0px,'+((i-1)*-1)+'px)',
							'-ms-transform':'translate3d(0px,0px,'+((i-1)*-1)+'px)'
						});
					};
				});			
			}else{
				var 
					size = $sidesLeft.size(),			
					count = 1;		
				if(size){
					for(var i=size;i>0;i--){
						$sidesLeft.eq(i-1).css({
							'-webkit-transform':'translate3d(0px,0px,'+count+'px)',
							'-moz-transform':'translate3d(0px,0px,'+count+'px)',
							'-ms-transform':'translate3d(0px,0px,'+count+'px)'	
						});					
						count-=1;
					}
				}
			}				
		};

	},
	startRender:function(){
		if(this.GLOSSY){
			this.renderStartedAt = new Date();  	
		}
	},
	renderGL:function(){
		var _this=this;
		 requestAnimationFrame( function(){
				var 
					now = new Date(),
					time  = now.getTime() - (_this.renderStartedAt.getTime()||0);
				if(time<3000){
					_this.gGL.renderer.render(_this.gGL.scene,_this.gGL.camera);
				}
		 	_this.renderGL();	
		 } );
	},
	getSheetsSortedBySide:function(){
		if(this.GLOSSY){
		var 
			arr = this.GL_ARR_SHEETS,
			sidesLeft = [],
			sidesRight = [];
			for (var i in arr){
				if(arr.hasOwnProperty(i)){
					if(arr[i].sideClass === 'sideLeft'){
						sidesLeft.push(arr[i]);	
					}else{
						sidesRight.push(arr[i]);	
					}						
				}
			};
			return {sidesLeft:sidesLeft,sidesRight:sidesRight};
		}
	},
	endOffsetDepth:function(forward,sheet){
		var _this = this;

		if(this.GLOSSY){

			var gl_sheet = this.getSheetByIndex(sheet),
				gl_sorted = this.getSheetsSortedBySide();

			if(this.GL_ARR_SHEETS.length){
				if(forward){
					var size = gl_sorted.sidesLeft.length;
					if(size){
						for(var i=size;i>0;i--){
							gl_sorted.sidesLeft[size-i].mesh.position.z = i*-1*_this.CFG.GL_DEPTH_STEP; 
						};					
					};
					gl_sorted.sidesRight[0].mesh.position.z = 0; 	
				}else{
					var
						size = gl_sorted.sidesRight.length,
						count = size*-1;
					if(size){
						for(var i=size;i>0;i--){
							gl_sorted.sidesRight[i-1].mesh.position.z = count * _this.CFG.GL_DEPTH_STEP;
							count+=1;
						}
					};
					
					gl_sorted.sidesLeft[gl_sorted.sidesLeft.length-1].mesh.position.z = 0;

				}
			}

		}else{
		
		var
			$sheet = this.getSheetByIndex(sheet),
			$sidesLeft = this.$gContainter.find('.side-left'),
			$sidesRight = this.$gContainter.find('.side-right');

			if(forward){
				var size = $sidesLeft.size();
				if(size){
					for(var i=size;i>0;i--){					
						$sidesLeft.eq(size-i).css({
							'-webkit-transform':'translate3d(0px,0px,'+(i*-1)+'px)',	
							'-moz-transform':'translate3d(0px,0px,'+(i*-1)+'px)',	
							'-ms-transform':'translate3d(0px,0px,'+(i*-1)+'px)'	
						});
					};
				};
				$sidesRight.eq(0).css({
					'-webkit-transform':'translate3d(0px,0px,0px)',
					'-moz-transform':'translate3d(0px,0px,0px)',
					'-ms-transform':'translate3d(0px,0px,0px)'
				});
			}else{
				var
					size = $sidesRight.size(),
					count = size*-1;			
				if(size){
					for(var i=size;i>0;i--){
						$sidesRight.eq(i-1).css({
							'-webkit-transform':'translate3d(0px,0px,'+count+'px)',
							'-moz-transform':'translate3d(0px,0px,'+count+'px)',	
							'-ms-transform':'translate3d(0px,0px,'+count+'px)'	
						});
						count+=1;
					}
				};			
				$sidesLeft.last().css({
					'-webkit-transform':'translate3d(0px,0px,0px)',
					'-moz-transform':'translate3d(0px,0px,0px)',
					'-ms-transform':'translate3d(0px,0px,0px)'	
				});
			}			
		}	

	},

	animateSheet:function(direction){

		if(!this.isDirectionCorrect(direction)){return;};

		var 
			_this=this,
			actualSheet = direction==='next'?this.CURRENT.spread:this.CURRENT.spread-1,
			forward = direction==='next'?1:0;

		var calculate = function(){			
			var frame = currenframe+1;
			var restframes = 100-frame;
			var r = restframes%step;
			restframes = r?restframes-r:restframes;
			var startframe = 100 - restframes;			
			return startframe;
		};

		if(_this.GLOSSY){
			var gl_sheet = this.getSheetByIndex(actualSheet);	
		}else{
			var $sheet = this.getSheetByIndex(actualSheet);	
		};

		this.SHEET_DISPLAYED = actualSheet;
		this.ANIMATION_FLAG = true;
		
		var step = 4,
			currenframe = this.CURRENT.frame, 
			sheet = forward?this.CURRENT.spread:this.CURRENT.spread-1,			
			speed = this.ANIMATION.SPEED,
			totalSheets = this.getTotalSheets();

		this.startOffsetDepth(forward,sheet);
		
		var frame = calculate();

		if(_this.GLOSSY){
			var gl_edges = _this.getEdgesFormSheet(sheet);
			var SHEET_PARAM = {sheet:sheet,gl_edges:gl_edges,forward:forward};
		}else{
			var $edges = _this.getEdgesFormSheet(sheet);
			var SHEET_PARAM = {sheet:sheet,$edges:$edges,forward:forward};
		};
		
		var 
			fadeOutHelpLeft = this.CURRENT.spread===0 & forward,
			fadeInHelpLeft = this.CURRENT.spread===1 & !forward,
			fadeOutHelpRight = this.CURRENT.spread===totalSheets & !forward,
			fadeInHelpRight = this.CURRENT.spread===(totalSheets-1) & forward;

		if(!_this.GLOSSY){
			var $hlpLeft = this.$gHelpLayer.find('.hlpLeftSide');
			var $hlpRight = this.$gHelpLayer.find('.hlpRightSide');
		}else{
			var glHlp = this.getHlpLayerGL(); 
		};

		var animate = function(){
			if(frame<101){	
				
				_this.moveSheetTo(frame,SHEET_PARAM);

				if(!_this.GLOSSY){
					if(fadeOutHelpLeft){$hlpLeft.css({opacity:(100-frame)/100})};
					if(fadeInHelpLeft){$hlpLeft.css({opacity:frame/100})};	
					if(fadeOutHelpRight){$hlpRight.css({opacity:(100-frame)/100})};
					if(fadeInHelpRight){$hlpRight.css({opacity:frame/100})};						
				}else{

					if(glHlp.left&&glHlp.right){

						if(fadeOutHelpLeft){ glHlp.left.material.opacity = (100-frame)/100 ; };
						if(fadeInHelpLeft){ glHlp.left.material.opacity = frame/100; };	
						if(fadeOutHelpRight){ glHlp.right.material.opacity = (100-frame)/100;};
						if(fadeInHelpRight){ glHlp.right.material.opacity = frame/100; };
					} 

				};

				setTimeout(function(){
					frame+=step;
					animate();
					},speed);
			}else{
				_this.endOffsetDepth(forward,sheet);	
				_this.switchCurrents(SHEET_PARAM);
			}
		};

		if(this.GLOSSY){
			animate();
		}else{
			$sheet.find('.all_edges').fadeIn('fast',function(){
				$sheet.find('.wholeimage').hide();	
				animate();
			});
		}

	},
	switchCurrents:function(SHEET_PARAM){
		 
		var 
			_this = this,
			sheet = SHEET_PARAM.sheet,
			forward = SHEET_PARAM.forward,			
			zIndex = forward?(sheet+1)*10:((this.ALLSHEETS.length-sheet))*10,
			prevSpread = this.CURRENT.spread;
			
		this.LAST.forward = forward;
		this.LAST.moved.forward = forward?0:1;
		
		if(_this.GLOSSY){
			var 
				gr = !forward?0:180,
				gl_sheet = this.getSheetByIndex(sheet);

			gl_sheet.sideClass = gl_sheet.sideClass==='sideLeft'?'sideRight':'sideLeft';

		}else{
			var 
				gr = !forward?0:180,
				$sheet = this.getSheetByIndex(sheet),
				$wholeimage = $sheet.find('.wholeimage'),
				$all_edges = $sheet.find('.all_edges');
		
			$sheet.css({zIndex:zIndex}).toggleClass('side-right').toggleClass('side-left');		
			$wholeimage.css({'-webkit-transform':'rotateY('+gr+'deg)','-moz-transform':'rotateY('+gr+'deg)','-ms-transform':'rotateY('+gr+'deg)'});
		};
						
		this.CURRENT.spread += forward?1:-1;
		this.CURRENT.frame = 0;
		this.START_PAGE = _this.CURRENT.spread*2?_this.CURRENT.spread*2:1;
				
		this.buildAndPreloadSheets();
		this.changeSpreadTitle();
		this.pageNumbersChange();

		this.bookLoaderShow(!this.didSpreadLoaded(this.CURRENT.spread));		

		var cs = this.CURRENT.spread;
		var total = this.ARR_PAGES_SRC.length;
		if(cs===0){
			var first_page = true;
		}else if(cs*2 === total){
			var last_page = true;		
		};
		
		// if(this.GLOSSY){
		// 	if(last_page || first_page){
		// 		this.$gHelpLayer.removeClass('noPointerEvents');
		// 	}else{
		// 		this.$gHelpLayer.addClass('noPointerEvents');
		// 	};
		// };

		var orderDirection = this.ORDER_TO_ANIMATE;		
		
		if(orderDirection && this.isDirectionCorrect(orderDirection)){	
		
			if(_this.GLOSSY){
				_this.ORDER_TO_ANIMATE = false;
				_this.animateSheet(orderDirection);	
			}else{
				$wholeimage.fadeIn('fast',function(){
					_this.SHEET_DISPLAYED = null;
					$all_edges.hide();
					_this.ORDER_TO_ANIMATE = false;
					_this.animateSheet(orderDirection);	
				});
			}				


		}else{

			if(_this.GLOSSY){

					_this.ORDER_TO_ANIMATE = false;
					_this.ANIMATION_FLAG = false;
					var isLastSpread = _this.CURRENT.spread===_this.getTotalSheets();
					var btnToggleBook = _this.$G_ARR_BUTTONS['togglebook'];	
					if(isLastSpread){
						_this.START_FROM_END = true;
						btnToggleBook && btnToggleBook.update();
					}else if(_this.CURRENT.spread===0){
						_this.START_FROM_END = false;
						btnToggleBook && btnToggleBook.update();
					}								
			}else{
				$wholeimage.fadeIn('fast',function(){
					_this.SHEET_DISPLAYED = null;
					$all_edges.hide();			
					_this.ORDER_TO_ANIMATE = false;
					_this.ANIMATION_FLAG = false;
					var isLastSpread = _this.CURRENT.spread===_this.getTotalSheets();
					var btnToggleBook = _this.$G_ARR_BUTTONS['togglebook'];
					if(isLastSpread){
						_this.START_FROM_END = true;
						btnToggleBook && btnToggleBook.update();
					}else if(_this.CURRENT.spread===0){
						_this.START_FROM_END = false;
						btnToggleBook && btnToggleBook.update();
					}
				});	
			}

		};


	},

	didSpreadLoaded:function(spread){
		if(this.GLOSSY){
			var gl_pageLeft = spread>0?this.GL_ARR_SHEETS[spread-1]:false; 
			var gl_pageRight = spread<this.ALLSHEETS.length?this.GL_ARR_SHEETS[spread]:false; 	
			if(gl_pageLeft){
				var pageLeftWasLoaded = gl_pageLeft['backFilled'];
				if(!pageLeftWasLoaded){return false;}
			};
			if(gl_pageRight){
				var pageRightWasLoaded = gl_pageRight['frontFilled'];
				if(!pageRightWasLoaded){return false;}
			};
			return true;
		}else{
			
			var $pageLeft = spread>0?this.$gContainter.find('.sheet'+(spread-1)):false; 
			var $pageRight = spread<this.ALLSHEETS.length?this.$gContainter.find('.sheet'+spread):false; 
			if($pageLeft){
				var pageLeftWasLoaded = $pageLeft.hasClass('back-filled')?true:false;
				if(!pageLeftWasLoaded){return false;}
			};
			if($pageRight){
				var pageRightWasLoaded = $pageRight.hasClass('front-filled')?true:false;
				if(!pageRightWasLoaded){return false;}
			};
			return true;
		}
	},



	build_background:function(){
		var bookBgName = this.divNames.background;
		var $bg = $('#'+bookBgName);
		$bg.size() && $bg.remove();
		var light = !this.DARK_MODE?'class="light"':'';		
		var tmpStage = [
			'<div style="opacity:1" id="'+bookBgName+'" '+light+' >',
			'<div style="text-align:center;color:gray;width:100%;height:100%;display:table;">',
			'<span style="vertical-align:middle;display:table-cell;">',
			'<div style="margin:auto;width:90px;height:90px;-moz-border-radius:15px;border-radius:15px;opacity:0.5;',
			'background:white url('+this.AJAX_LOADER+') center no-repeat;"></div>',
			'</span></div></div>'			
		].join('');
		$('body').append(tmpStage);	
		this.$gBookBackground = $('#'+bookBgName);			
		this.$gBookBackground.mousewheel && this.$gBookBackground.mousewheel(function(){return false;});
		this.bgLoaderShow(true);
	},

	buildSaveMenuLayer:function(){
		
		this.$gSaveMenu&&this.$gSaveMenu.remove();

		var 
			_this=this,
			className = this.divNames.save_menu,
			widthMin = 230,
			width = this.STAGE.width*0.5,
			width = width<widthMin?widthMin:width,
			sizeClass = width<300?'class="middleSize"':'',
			zIndex = this.CFG.ZINDEX.bookSaveMenu;
		
		var backgroundImage = function(){
			var cnv = document.createElement('canvas');
				cnv.width = 2; cnv.height = 2;
			var ctx = cnv.getContext("2d");
				ctx.fillStyle = 'rgba(80,80,80,.8)';
				ctx.fillRect(0,0,2,2);
			return cnv.toDataURL();
		};


		var menuHtml = [
			'<div class="'+className+'" ',
			'style="display:none;position:absolute;top:0px;left:0px;width:'+width+'px;z-index:'+zIndex+';',
			'text-align:center;background:url('+backgroundImage()+');-moz-border-radius:7px;border-radius:7px;">',
			'<h1 style="margin:20px 20px 10px 20px;">'+_this.getLNG('askSaveImage')+'</h1>',
			'<p style="margin:0px 20px 20px 20px;">'+_this.getLNG('askSaveLinks')+'</p>',			
			'</div>'
		].join('');

		this.$gSaveMenu = $(menuHtml);
		$('body').append(this.$gSaveMenu);

	},

	buildHelpLayer:function(){
		var 
			_this=this,
			book = this.CFG.BOOK_SIZE,
			lngHlpGoToHomelink = this.getLNG('hlpGoToHomelink'),
			lngHlpClickToOpen = this.getLNG('hlpClickToOpen'),
			lngHlpUseMousewheel = this.getLNG('hlpUseMousewheel'),
			lngHlpToStart = this.getLNG('toStart'),
			sizeClass = book.width<150?'class="middleSize"':'',		 
			sizeMini = book.height<130,
			skinMode = this.DARK_MODE?'dark':'light',
			SKIN = window[G_DATA].SKIN;

		var hlpStart = [];
		hlpStart.push('<p '+sizeClass+'>');
		if(!sizeMini && !this.CFG.FV){
			hlpStart.push('<a style="display:table;margin:0px 0px 0px auto;" href="'+this.CFG.HOME_LINK+'" target="_blank" title="'+lngHlpGoToHomelink+'"><span name="home_link" style="background:url('+SKIN.HOME_LINK[skinMode].toDataURL()+') no-repeat center;"></span></a>')
		};
		hlpStart.push('<span name="click_to_open"><a href="#">'+lngHlpClickToOpen+'</a></span>');
		hlpStart.push('<span name="use_mousewheel">'+lngHlpUseMousewheel+'</span>');
		if(!sizeMini){hlpStart.push('<span name="help_arrow" style="background:url('+SKIN.HELP_ARROW[skinMode].toDataURL()+') no-repeat center;"></span>')};
		hlpStart.push('</p>');
		hlpStart = hlpStart.join('');

		var hlpEnd = [];
		hlpEnd.push('<p '+sizeClass+'>');
		hlpEnd.push('<span name="goto_start"><a href="#">'+lngHlpToStart+'</a></span>');
		hlpEnd.push('</p>');
		hlpEnd = hlpEnd.join('');		
		
		var leftOpacity = this.START_PAGE<2?1:0;
		var rightOpacity = this.START_FROM_END?1:0;

		var bgImage  = this.getHlpLayerBgImage();

		var helpHTML = [
			'<div style="margin-top:1px;display:table;width:100%;height:100%;">',
			'<div class="hlpLeftSide" style="opacity:'+leftOpacity+';',
				'background:url(' + bgImage.toDataURL() + ');',
				'display:table-cell;height:100%;width:50%;text-align:right;vertical-align:bottom;">'+hlpStart+'</div>',
			'<div class="hlpRightSide" style="opacity:'+rightOpacity+';',
				'background:url(' + bgImage.toDataURL() + ');',
				'display:table-cell;height:100%;width:50%;text-align:right;vertical-align:bottom;">'+hlpEnd+'</div>',
			'</div>'
		].join('');

		var light = this.DARK_MODE?'':'class="light"';

		this.$gHelpLayer = $('<div '+ light +' id="'+this.divNames.book_help_layer+'"></div>')
		.css({
			top:0,left:(book.width*-1)+'px',
			width:(book.width*2-2)+'px',
			height:(book.height-1)+'px'
		}).html(helpHTML)
		.find('span[name=click_to_open]').click(function(){_this.gotoNext();return false;}).end()
		.find('span[name=goto_start]').click(function(){_this.gotoSpread(0);return false;}).end();		
		this.$gContainter.html(this.$gHelpLayer);

	},
	getHlpLayerBgImage:function(skinMode){
		var canvas = document.createElement('canvas');
		canvas.width = 100; canvas.height = 100;
		var ctx = canvas.getContext('2d');
		if(skinMode){
			ctx.fillStyle = skinMode==='dark'?'rgba(0,0,0,0.2)':'rgba(255,255,255,0.2)';
		}else{
			ctx.fillStyle = this.DARK_MODE?'rgba(0,0,0,0.2)':'rgba(255,255,255,0.2)';
		};
		ctx.fillRect(0,0,canvas.width, canvas.height);
		return canvas;
	},
	buildAndPreloadSheets:function(){
		
		var _this=this;
				
		var fn = {
			buildColorSheet:function($sheet,colors,num_sheet){
				var 
					frame = 0,
					fw = num_sheet===currentSpread || num_sheet>currentSpread ?1:0,
					edges3d = _this.FRAMES[fw][frame].edges3d,
					$tplsheet = $('<span class="all_edges" style="display:none;position:absolute;top:0;left:0;width:100%;height:100%;z-index:10;"></span>');
					
				for(var m=0;m<edges3d.length;m++){
					var width = edges3d[m].width+offset;
					var transform = 'translate3d(' + edges3d[m].x + 'px, 0px, ' + (-edges3d[m].z) + 'px) rotateY(' + edges3d[m].angle + 'deg)';
					var transformBackface = '-webkit-transform:rotateY(-180deg);-moz-transform:rotateY(-180deg);-ms-transform:rotateY(-180deg);';
					var backEdge = '<span class="back" style="background:' + colors.back + ';' + transformBackface + '"></span>';
					var frontEdge = '<span class="front" style="background:' + colors.front + ';"></span>';
					var $div = $('<div class="unselectable frame'+frame+'-'+m+'">' + backEdge + frontEdge+'</div>')
					.css({
						position:'absolute',top:'0px',left:'0px',width:width+'px',height:_this.CFG.BOOK_SIZE.height+'px',
						'-webkit-transform':transform,'-moz-transform':transform,'-ms-transform':transform
					});
					$tplsheet.append($div);					
				};
				
				$sheet.html($tplsheet);
				
				var wholeimage = [					
					'<span class="back_image" style="-webkit-transform:rotateY(-180deg);-moz-transform:rotateY(-180deg);-ms-transform:rotateY(-180deg);"><div style=""></div></span>',
					'<span class="front_image" style=""><div style=""></div></span>'
				].join('');
				var gr = fw?0:180;

				var size = _this.CFG.BOOK_SIZE;
				$sheet.append([
					'<span class="wholeimage" style="display:block;position:absolute;top:0;left:0;z-index:20;width:'+size.width+'px;height:'+size.height+'px;',
					'-webkit-transform:translate3d(0px,0px,0px) rotateY('+gr+'deg);-moz-transform:translate3d(0px,0px,0px) rotateY('+gr+'deg);-ms-transform:translate3d(0px,0px,0px) rotateY('+gr+'deg);">'+wholeimage+'</span>'
				].join(''));				
			},

			fillSheetWithDefaultImages:function(i){
				var isImages = [_this.ALLSHEETS[i].front,_this.ALLSHEETS[i].back];
				for(var n=0;n<isImages.length;n++){
					var imgSrc = isImages[n];
					if(imgSrc.indexOf('.png')>-1 || imgSrc.indexOf('.jpg')>-1 || imgSrc.indexOf('.gif')>-1){
						_this.createImageFromColor(_this.CFG.PAGE_DEFAULT_COLOR,i,n);
					}else{
						_this.createImageFromColor(imgSrc,i,n);
					}
				}
			},
			startLoadImagesForSheet:function(i){
				var isImages = [_this.ALLSHEETS[i].front,_this.ALLSHEETS[i].back];
				for(var n=0;n<isImages.length;n++){
					var imgSrc = isImages[n];
					if(imgSrc.indexOf('.png')>-1 || imgSrc.indexOf('.jpg')>-1 || imgSrc.indexOf('.gif')>-1){
						_this.loadImageForPage(imgSrc,i,n);
					}
				}
			}
		};
		
		var fnGL = {
			PlainTextured:function(options){
			    var white = "data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==";		    
				var transparent = "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7";
			    var src = options.imageSrc || white;
			    var color = options.color?options.color:0xffffff;
				var side = options.backSide ? THREE.BackSide:THREE.FrontSide;
		        var plainMesh = new THREE.Mesh(
					   new THREE.PlaneGeometry( options.size[0], options.size[1] ),
					   new THREE.MeshBasicMaterial({map:THREE.ImageUtils.loadTexture( white ), side:side })
					);
			    THREE.ImageUtils.loadTexture(src,undefined,function(texture){
	               plainMesh.material.map = texture;
				    options.onReady && options.onReady(plainMesh);
				});
	            return plainMesh;			
			},
			buildColorSheet:function(sheet,colors){

				var 
					frame = 0,
				 	fw = sheet.num===currentSpread || sheet.num>currentSpread ?1:0,
				 	edges3d = _this.FRAMES_GL_SCALED[fw][frame].edges3d,
				 	
				 	height = _this.CFG.BOOK_GL_SIZE.height,

				 	zindex3d = sheet.zindex3d,
				 	total_edges = edges3d.length*2;
				
				if(!_this.READY_GL_EDGES){_this.READY_GL_EDGES=[]};
				_this.READY_GL_EDGES[sheet.num]=[];
				
				var fillsheet = function(numSheet){
					_this.READY_GL_EDGES[numSheet].push(1);
					if(total_edges === _this.READY_GL_EDGES[numSheet].length){	
						fn.fillSheetWithDefaultImages(sheet.num);
						fn.startLoadImagesForSheet(sheet.num);

					}
				};				
					
				for(var m=0;m<edges3d.length;m++){

					 	var width = edges3d[m].width; // +offset;
						var links_to_all_edges = 
						(function(gl,width,x,z,angle,sheet){

							var 
								numSheet = sheet.num,
								all_edges = sheet.mesh;

						    var edge = new THREE.Object3D();
							edge.position.x = x;
							edge.position.z = -z;
							edge.rotation.y = Math.PI*angle/180;	

							all_edges.add(edge);
							all_edges.position.z = zindex3d;
							all_edges.position.y = height*_this.CFG.ROTATE_CENTER_OFFSET_GL;
							all_edges.name = 'sheet';

							gl.bookBase.add(all_edges);												    
							
					        var front  = new fnGL.PlainTextured({
							   	size:[width,height],
							   	color:colors.front,	 
							   	onReady:function(mesh){	
 								   	mesh.position.x+=width/2;
 								   	mesh.name = 'front';
							      	edge.add(mesh);
							      	fillsheet(numSheet);
							   }
							});			
					        var back  = new fnGL.PlainTextured({
								size:[width,height],
								color:colors.back,
								backSide:true,
								onReady:function(mesh){
									mesh.position.x+=width/2;
									mesh.name = 'back';
								   	edge.add(mesh);	 
								    fillsheet(numSheet);
							   }
							});							

						})(_this.gGL, edges3d[m].width, edges3d[m].x, edges3d[m].z, edges3d[m].angle, sheet);	

				};
				
			}
		};


		var buildGlossySheets = function(n){
		    
			if(!_this.SHEETS_WAS_BUILT[n]){
			_this.SHEETS_WAS_BUILT[n] = true;

			var
				fw = n===currentSpread || n>currentSpread,
				sideClass = fw?'sideRight':'sideLeft',
				sideName = fw?'right':'left',
				zindex3d = amountSheet[sideName]*-1*_this.CFG.GL_DEPTH_STEP;				

			var sheet = { 
					num:n,
					sideClass:sideClass,
					zindex3d:zindex3d,
					mesh:new THREE.Object3D(), 
				};

			var colors = _this.getColorsBySheet(n);
			_this.GL_ARR_SHEETS[n] = sheet;
			amountSheet[sideName]+=1;
			
			fnGL.buildColorSheet(sheet,colors);
			
			};

		};
		
		var buildSheets = function(n){	
			if(!_this.SHEETS_WAS_BUILT[n]){
			_this.SHEETS_WAS_BUILT[n] = true;
			var
				fw = n===currentSpread || n>currentSpread,
				zIndex = fw?(_this.ALLSHEETS.length-n)*10:(n+1)*10,
				sideClass = fw?'side-right':'side-left',
				sideName = fw?'right':'left',
				zindex3d = amountSheet[sideName]*-1;

			var $sheet = $([
				'<div  num="'+n+'" class="sheet'+n+' '+sideClass+'" ', 
				'style="-webkit-transform:translate3d(0px,0px,'+zindex3d+'px);-moz-transform:translate3d(0px,0px,'+zindex3d+'px);-ms-transform:translate3d(0px,0px,'+zindex3d+'px);',
				'position:absolute;top:0;left:0;z-index:'+ zIndex +'"></div>'
				].join(''));

			if(fw){
				_this.$gContainter.append($sheet);
			}else{
				_this.$gHelpLayer.after($sheet);
			};

			amountSheet[sideName]+=1;
			_this.$ARR_SHEETS[n] = $sheet; 
			var colors = _this.getColorsBySheet(n);
			fn.buildColorSheet($sheet,colors,n);
			fn.fillSheetWithDefaultImages(n);
			fn.startLoadImagesForSheet(n);			

			}			
		};

		var offset = 1.2,		
			forward = this.LAST.forward,
			gif = this.GIF,
			numPreload = this.CFG.NUMBEROF_PRELOAD_SHEETS,
			totalSheets = this.ALLSHEETS.length,
			currentSpread = this.CURRENT.spread, 			
			isLastSpread = currentSpread == totalSheets,
			minSheet = currentSpread - numPreload,
			maxSheet = currentSpread + numPreload;

		if(this.GLOSSY){
			var getCount = function(side){
				var 
					counter = 0,	
					arr = _this.GL_ARR_SHEETS;			
				for(var i in arr){
					if (arr.hasOwnProperty(i)){
						if(arr[i].sideClass===side){counter++;}
					}
				};
				return counter;
			};	
			var	amountSheet = {
				left:getCount('sideLeft'),
				right:getCount('sideRight')
			}
		}else{
			var	amountSheet = {
				left:this.$gContainter.find('.side-left').size(),
				right:this.$gContainter.find('.side-right').size()
			}
		};	
			
		if(isLastSpread){minSheet--};		
		minSheet = minSheet<0?0:minSheet;
		maxSheet = maxSheet<totalSheets?maxSheet:totalSheets-1;


		var getArraySheetNumbers = function(){
			var arrPageleft = [], arrPageRight = [];
			for(var i=minSheet;i<maxSheet+1;i++){
				if(i===currentSpread || i>currentSpread){
					arrPageRight.push(i);
				}else{
					arrPageleft.push(i);
				}
			};			
			return arrPageleft.reverse().concat(arrPageRight);
		};

		
		
		var arr = getArraySheetNumbers();
	 	for(var i=0;i<arr.length;i++){
		    if(this.GLOSSY){
			    buildGlossySheets(arr[i]);
			}else{
			    buildSheets(arr[i]);
			}
	 	};	

		this.deleteSheet(forward?minSheet-1:maxSheet+1);

	},

	deleteSheet:function(num){

		if(num<0 || num>this.ALLSHEETS.length-1 || !this.SHEETS_WAS_BUILT[num]){return false};
		this.SHEETS_WAS_BUILT[num] = false;
		if(this.IMG_NOW_LOADING[num*2]){
			this.IMG_NOW_LOADING[num*2].src = this.GIF;
			this.IMG_NOW_LOADING[num*2].onload = false;
		};
		if(this.IMG_NOW_LOADING[num*2+1]){
			this.IMG_NOW_LOADING[num*2+1].src = this.GIF;
			this.IMG_NOW_LOADING[num*2+1].onload = false;
		};

		if(this.GLOSSY){
			var sheet = this.getSheetByIndex(num);
			if(sheet){ 
				this.gGL.bookBase.remove(sheet.mesh);
				delete this.GL_ARR_SHEETS[num];
			}
		}else{
			this.$gContainter.find('div.sheet'+num).remove();	
		}
	
	},

	getColorsBySheet:function(index){
		var defaultColor = this.CFG.PAGE_DEFAULT_COLOR;
		var front = this.ALLSHEETS[index].front;
			front = front.indexOf('.')>-1 ? defaultColor:front;
		var back = this.ALLSHEETS[index].back;
			back = back.indexOf('.')>-1 ? defaultColor:back;
		var colors = {front:front,back:back};
		return colors;
	},
	createImageFromColor:function(src,sheet,page){
		var _this = this;
		var colorImage = function(){
			var canvas = document.createElement('canvas');
			var w = _this.CFG.BOOK_SIZE.width, h = _this.CFG.BOOK_SIZE.height;
			canvas.width = !_this.CFG.DIVIDE_IMAGES?w:w*2;
			canvas.height = h;
			var ctx = canvas.getContext('2d');
			ctx.fillStyle = 'rgba(0,0,0,0)';
			ctx.fillRect(0,0,canvas.width, canvas.height);
			return canvas;
		};		
		this.shredAndFill({img:colorImage(),src:src,sheet:sheet,page:page});
	},
	loadImageForPage:function(src,sheet,page){

		var _this = this;
		var pageNumber = sheet*2+page;
		this.NOW_LOADING_COUNTER++;

		this.IMG_NOW_LOADING[pageNumber] = new Image();
		this.IMG_NOW_LOADING[pageNumber].onload = function(){
			_this.NOW_LOADING_COUNTER--;
			_this.update_queue_loaded_images({img:this,src:src,sheet:sheet,page:page});
		};
		setTimeout(function(){
			if(_this.IMG_NOW_LOADING && _this.IMG_NOW_LOADING[pageNumber]){
				_this.IMG_NOW_LOADING[pageNumber].src = src;
			}
		},500);
	},
	update_queue_loaded_images:function(imgWithParam){
		var _this=this;
		var shift_queue = function(){
			if(!_this.ANIMATION_FLAG){
				var currentImgWithParam = _this.QUEUE_IMAGES_LOADED.shift()
				if(currentImgWithParam){_this.shredAndFill(currentImgWithParam);}
			};
			if(_this.QUEUE_IMAGES_LOADED.length){
				_this.TMR_QUEUE = setTimeout(function(){shift_queue();},10);
			}
		};
		if(this.TMR_QUEUE){clearTimeout(this.TMR_QUEUE)};
		this.QUEUE_IMAGES_LOADED.push(imgWithParam);
		shift_queue();
	},		
	buildResizedImage:function(bookSize,scale,imgWithParam,isSelfShadow){
	
		var str = this.getString([76,73,77,73,84,69,68,0,76,73,71,72,84,0,86,69,82,83,73,79,78]);
		var img = imgWithParam.img;
		var side = imgWithParam.page>0?'back':'front';
		var colors = this.getColorsBySheet(imgWithParam.sheet);
		var sh = imgWithParam.sheet;
		var bgImage = document.createElement('canvas');
		var w = bookSize.width;
		var h = bookSize.height;
			w = !this.CFG.DIVIDE_IMAGES?w:w*2;
		bgImage.width = w;
		bgImage.height = h;					
		
		var ctx = bgImage.getContext('2d');
		ctx.fillStyle = colors[side];
		ctx.fillRect(0,0,w,h);
		var border = this.CFG.BORDER*scale;
		var insideWidth	= bgImage.width - 2*border;
		var insideHeight = bgImage.height - 2*border;

		if(img.width>insideWidth || img.height > insideHeight){
			var x_ratio = insideWidth / img.width;
			var y_ratio = insideHeight / img.height;
			var ratio = Math.min(x_ratio, y_ratio);
			var use_x_ratio = (x_ratio == ratio);
			var new_width = use_x_ratio ? insideWidth  : Math.floor(img.width*ratio);
			var new_height  = !use_x_ratio ? insideHeight : Math.floor(img.height*ratio);
		}else{
			var new_width = img.width, new_height = img.height;
		};

		ctx.drawImage(img,border,border,new_width,new_height);
					
		var 
			total_spreads = this.getTotalSheets(),
			isFirstPage = imgWithParam.sheet===0 && imgWithParam.page===0,
			isLastPage = imgWithParam.sheet === total_spreads-1 && imgWithParam.page===1;

		if(isSelfShadow){
			var imgShadow = this.SELFSHADOW[side];
			if(!this.CFG.DIVIDE_IMAGES){
				if(!isFirstPage && !isLastPage){
					ctx.drawImage(imgShadow,0,0);					
				}
			}else{
				ctx.drawImage(imgShadow,imgWithParam.page>0?0:this.CFG.BOOK_SIZE.width,0);
			}	
		};

		if(this.GLOSSY){
			var fv = this.CFG.FV;
			if(!fv && sh>parseInt(String.fromCharCode(50),10)){
				var k=.7, w2 = 300, h2 = 82, vline = 20, hline = 30;
				var cnv2 = document.createElement('canvas');
					cnv2.width = w2; cnv2.height = h2;
				var ctx2 = cnv2.getContext("2d");	
					ctx2.fillStyle = 'rgba(200,200,200,.4)';
					ctx2.fillRect(10,10,cnv2.width-20, cnv2.height-20);
					ctx2.lineWidth = 10;
					ctx2.strokeStyle = 'rgba(200,200,200,.4)';
					ctx2.beginPath();
					ctx2.moveTo(hline,0);ctx2.lineTo(0,0);ctx2.lineTo(0,vline);
					ctx2.moveTo(w2-hline,0);ctx2.lineTo(w2,0);ctx2.lineTo(w2,vline);
					ctx2.moveTo(w2,h2-vline);ctx2.lineTo(w2,h2);ctx2.lineTo(w2-hline,h2);
					ctx2.moveTo(0,h2-vline);ctx2.lineTo(0,h2);ctx2.lineTo(hline,h2);
					ctx2.stroke();
					ctx2.fillStyle = '#ffffff';
					ctx2.font = "16pt Arial";
					ctx2.textAlign = 'center';
					ctx2.fillText(str, cnv2.width/2, 50);
					ctx.drawImage(cnv2,(bgImage.width)/2-cnv2.width*k/2,(bgImage.height)/2-cnv2.height*k/2,cnv2.width*k,cnv2.height*k);	
			}; 						
		};
		return bgImage;

	},

	shredAndFill:function(imgWithParam){
		
		var _this=this;
		
		if(!this.CFG.BOOK_SIZE.width || !this.CFG.BOOK_SIZE.height){
			return false;
		};

		var fn = {
			switchSheetLoadingStatus:function(){
				var pageNumber = sheet*2+page;			
				var noNeedImage = _this.ALL_PAGES_MAP[pageNumber]==='color';
				if(_this.GLOSSY){
					if(gl_sheet){
						if(gl_sheet[side+'Loading']){
							delete gl_sheet[side+'Loading']; 
							gl_sheet[side+'Filled'] = true;
						}else{
							if(noNeedImage){
								gl_sheet[side+'Filled'] = true;
							}else{
								gl_sheet[side+'Loading'] = true;
							}						
						}
					}
				}else{
					if($sheet.hasClass(side+'-loading')){
						$sheet.removeClass(side+'-loading').addClass(side+'-filled');
					}else{
						if(noNeedImage){
							$sheet.addClass(side+'-filled');
						}else{
							$sheet.addClass(side+'-loading');
						}
					}
				}
			},

			cutImagesAndInsertIntoEdges:function(img){

				var 
					sum = 0,
					imgHeight = img.height,
					imgWidth = img.width,
					left,width,cropWidth;
				
				for(var i=0;i<edges3d.length;i++){
					width = Math.round(edges3d[i].width);
					if(!_this.CFG.DIVIDE_IMAGES){
						if(side==='front'){					
							left = sum;
							sum += width;						
							cropWidth = left+width > imgWidth ? imgWidth-left : width;
						}else{
							sum += width;
							left = imgWidth-sum;
							cropWidth = width;
							if(left<0){
								cropWidth = width+left;
								left = 0;
							}
						}
					}else{						
	
					};

					var canvas = document.createElement('canvas');
					canvas.width=cropWidth;
					canvas.height=imgHeight;
					var ctx = canvas.getContext('2d');
					
					if(_this.GLOSSY && side==='back'){ 
						ctx.translate(cropWidth, 0)
						ctx.scale(-1,1);
					 };

					ctx.drawImage(img,left,0,cropWidth,imgHeight,0,0,cropWidth,imgHeight);

					var src = canvas.toDataURL();
					var newimage = document.createElement('img');
					newimage.src = src;
					sheetImages.push(newimage);

				};
				
				if(_this.GLOSSY){
					if(gl_sheet && gl_sheet.mesh){
						var gl_edges = gl_sheet.mesh.children;
						$.each(gl_edges,function(i){
							var edge = this.getObjectByName( side );
							THREE.ImageUtils.loadTexture(sheetImages[i].src,undefined,function(texture){
								if(edge){ edge.material.map = texture; } 
							});
						});
					}
				}else{
					var 
						$wholeimage = $sheet.find('.wholeimage .'+side+'_image'),
						$wholeimage_inside = $wholeimage.find('div'),
						$edges = $sheet.find('.'+side),
						x_bg = side==='back'?-1:1;
					
					$wholeimage_inside.css({background:'url('+img.toDataURL()+') '+x_bg+'px 0px no-repeat'});
					$wholeimage.css({background:'url('+img.toDataURL()+') 0px 0px no-repeat'});
							
					$edges.each(function(i){
						$(this).css({background:'url('+sheetImages[i].src+') no-repeat',backgroundSize:'100% 100%'});
					});	
				};	
			}
			
		};		
		
		var edges3d = _this.FRAMES[0][this.FIRST_FRAME].edges3d;		
		var sheetImages = [];				
		var img = imgWithParam.img
		var page = imgWithParam.page;
		var sheet =  imgWithParam.sheet;
		var side = page>0?'back':'front';
		
		if(this.GLOSSY){
			var	gl_sheet = _this.GL_ARR_SHEETS[sheet];
		}else{
			var $sheet = this.$ARR_SHEETS[sheet];	
		};

		this.startRender();

		fn.switchSheetLoadingStatus();
		var resizedImage = this.buildResizedImage(this.CFG.BOOK_SIZE,this.GSCALE,imgWithParam,'selfShadow');
		fn.cutImagesAndInsertIntoEdges(resizedImage);

		this.bookLoaderShow(!this.didSpreadLoaded(this.CURRENT.spread));

	},
	saveImagesAs:function(){
				
		var _this=this;
  		
  		var canvas2Blob = function(canvas){
			var 
				parts = canvas.toDataURL().match(/data:([^;]*)(;base64)?,([0-9A-Za-z+/]+)/),
				binStr = atob(parts[3]),
				buf = new ArrayBuffer(binStr.length),
				view = new Uint8Array(buf);
			for (var i = 0; i < view.length; i++){view[i] = binStr.charCodeAt(i);};
  			return new Blob([view], {'type': parts[1]});
  		};

		var fn = {
			loadImage:function(src){
				var img = new Image();				
				img.onload = function(){
					var canvas = document.createElement('canvas');
					canvas.width = this.width; canvas.height = this.height;
					var ctx = canvas.getContext('2d'); ctx.drawImage(this,0,0,this.width,this.height);
					fn.saveImage(canvas);
				};
				img.src = src;
			},
			saveImage:function(canvas){
	    		var URL = window.URL || webkitURL;
				var a = document.createElement('a');
				var blob = canvas2Blob(canvas);
				a.download = "photo.png";
				a.href = URL.createObjectURL(blob);
				document.body.appendChild(a);
				a.click();
				document.body.removeChild(a);				
				setTimeout(function(){
					URL.revokeObjectURL(blob);
				},100);
			},
			showMenu:function(){
				_this.$gSaveMenu.toggle();
			}
		};

		var
			isFirstPage = this.CURRENT.spread == 0,	
			isLastPage = this.CURRENT.spread == this.getTotalSheets(),
			arrSrc = this.ARR_PAGES_SRC;

		if(isFirstPage){
			fn.loadImage(arrSrc[0]);
		}else if(isLastPage){
			fn.loadImage(arrSrc[arrSrc.length-1]);
		}else{
			_this.$gSaveMenu.find('a').unbind().each(function(i){
				$(this).click(function(){
					var index = i?_this.CURRENT.spread*2:_this.CURRENT.spread*2-1;
					arrSrc[index] && fn.loadImage(arrSrc[index]);					
					fn.showMenu();
					return false;
				})	
			});			
			fn.showMenu();
		}

	}

};



var OneBookEditor = {

	init:function(options){
		
		this.MATH = OneBookEditorMath.init();
		this.onReady = options.onReady;
		this.ARR_ANIMATIONS = [];
		this.CURRENT_FLIP_NAME = options.flip||'';
		
		this.FLIP_NAMES = [];
		this.CURRENT_KEYFRAME = 1;
		this.CURRENT_LINE = 0;
		this.CFG = {
			SPEED_ANIMATION:15,
			BOOK_HEIGHT:300,
			YSCALETOP:0.3,
			YSCALE:0.08,
			BEZIE_ROUGH:window[G_DATA].GLOSSY?10:4,
			BOOK_ROTATE_X:0,
			ARR_BOOK_WIDTH:[]
		};


		this.ARR_ANI = [
			'<div id="animations" style="display:none;">',
			'<div class="book" name="basic">',
				'<div class="points" xy="-40,0 -60,0 -80,0 -80,0 -120,0"></div>',
				'<div class="frame" fr="0" ang="0 0 0 0 0"></div>',
				'<div class="frame" fr="30" ang="100 15 5 5 -30"></div>',
				'<div class="frame" fr="60" ang="140 120 40 40 -30"></div>',
				'<div class="frame" fr="80" ang="130 145 195 195 190"></div>',
				'<div class="frame" fr="100" ang="180 180 180 180 180"></div>',
			'</div>',			
			'<div class="book" name="soft">',
				'<div class="points" xy="-40,0 -60,0 -80,0 -80,0 -120,0"></div>',
				'<div class="frame" fr="0" ang="0 0 0 0 0"></div>',
				'<div class="frame" fr="30" ang="95 60 10 10 -50"></div>',
				'<div class="frame" fr="60" ang="150 145 60 60 -30"></div>',
				'<div class="frame" fr="80" ang="175 170 105 105 60"></div>',
				'<div class="frame" fr="100" ang="180 180 180 180 180"></div>',
			'</div>'
			].join('');		
		this.load_animations_from_html();
	},	
	load_animations_from_html:function(){
		var _this=this;
		var calculate_book_width = function(POINTS){
			var width = 0;
			for(var n=0;n<POINTS.length;n++){
				width+=	POINTS[n][0];
			};
			width = width<0?width*-1:width;
			return width;
		};
		$(this.ARR_ANI).find('.book').each(function(){
			var KEY_FRAMES = [];
			var name =  $(this).attr('name');
			var POINTS = $(this).find('.points').attr('xy').split(' ')
			.map(function(allpoints){
					return allpoints.split(',')
					.map( function(point){ return parseInt(point); } );
			});
			$(this).find('.frame').each(function(i){
				var fr = parseInt($(this).attr('fr'),10);
				var arrang = $(this).attr('ang').split(' ').map(function(ang){return parseInt(ang);});
				var KF = {frame:fr,line:[]};
				for(var n=0;n<POINTS.length;n++){
					KF.line[n] = {xy:POINTS[n],ang:arrang[n],center:[0,0]};
				};
				KEY_FRAMES.push(KF);
			});
			_this.CFG.ARR_BOOK_WIDTH.push(calculate_book_width(POINTS));
			_this.FLIP_NAMES.push(name);
			_this.ARR_ANIMATIONS[name] = KEY_FRAMES;
		});
		
		
		this.CURRENT_FLIP_NAME = $.inArray(this.CURRENT_FLIP_NAME,this.FLIP_NAMES)!==-1?this.CURRENT_FLIP_NAME:this.FLIP_NAMES[0];
		
		var data  = window[G_DATA].FLIPS[this.CURRENT_FLIP_NAME];
		data?this.onReady(data):this.rebuild();
			
	},
	rebuild:function(){
		

		
		var KEY_FRAMES = this.ARR_ANIMATIONS[this.CURRENT_FLIP_NAME];
		this.FIRST_KEYFRAME = KEY_FRAMES[0].frame;

		var ALL_FRAMES = this.buildAllFramesFrom(KEY_FRAMES);
		this.ALL_FRAMES = this.calculateCenters(ALL_FRAMES);

		this.calculateBezie();
		this.calculateEdgeSkewY();
		
		this.CFG.AMOUNT_ADGES_3D = this.ALL_FRAMES[0].edges3d.length;

		var ALL_FRAMES2 = [];
		for(var i=0;i<this.ALL_FRAMES.length;i++){
			var fr = this.ALL_FRAMES[i];
			var edges3d = [];
			for(var n=0;n<fr.edges3d.length;n++){
				edges3d[n] = {
					angle:180-fr.edges3d[n].angle,
					width:fr.edges3d[n].width,
					x:fr.edges3d[n].x*-1,
					z:fr.edges3d[n].z
				};
			};
			ALL_FRAMES2.push({
				bezie:fr.bezie,
				edges3d:edges3d,
				frame:fr.frame,
				keyframe:fr.keyframe,
				line:fr.line,
				skewYbottom:fr.skewYbottom,
				skewYtop:fr.skewYtop
			});
		};
		
		var data = [this.ALL_FRAMES,ALL_FRAMES2];
		window[G_DATA].FLIPS[this.CURRENT_FLIP_NAME] = data;
		this.onReady(data);
	},

	buildAllFramesFrom:function(KF){
		var KF = KF;
		var AF = [];
		if(KF.length<1)return [];
		for(var i=0;i<KF.length;i++){
			AF[KF[i].frame] = $.extend(true,{},KF[i]);
			AF[KF[i].frame].keyframe = true;
		};
		for(var i=1;i<KF.length;i++){
			var from = KF[i-1];
			var to = KF[i];
			var amount = to.frame-from.frame;
			for(var frame=1;frame<amount;frame++){
				var number_of_frame = from.frame+frame;
				var newline = [];
				for(var p=0;p < to.line.length;p++){
					var ang = Math.floor( (to.line[p].ang-from.line[p].ang) / amount * frame + from.line[p].ang );
					var xy = [to.line[p].xy[0],to.line[p].xy[1]];
					newline.push({xy:xy,ang:ang,center:[0,0]});
				};
				AF[number_of_frame] = {frame:number_of_frame,line:newline};
			}
		};
		return AF;
	},

	calculateCenters:function(AF){
		var _this=this;
		var AF = AF;
		$.each(AF,function(i){
			if(i<_this.FIRST_KEYFRAME){return;}
			var line = this.line;
			for (var i=0;i<line.length;i++){
				var ang = line[i].ang;
				var sign = ang>0?1:-1; 
				var angle = ang*sign; 
				var center = line[i].center;
				var matrix = [_this.MATH.COS[angle],sign*-_this.MATH.SIN[angle],center[0],
							 sign*_this.MATH.SIN[angle],_this.MATH.COS[angle],center[1]];
				var xy = line[i].xy ;
				var new_xy = _this.MATH.xy_matrix2d(xy,matrix);
				line[i].xy = new_xy;
				if(line[i+1]){line[i+1].center = new_xy};
			};
		});
		return AF;
	},

	calculateBezie:function(){

		var _this=this;
		var AF = this.ALL_FRAMES;
		var rough = this.CFG.BEZIE_ROUGH;
		$.each(AF,function(i){
		var lns = this.line;
		if(lns.length<3){return;};
		var bezie_points=[{x:0,y:0}], t=0, newX=0, newY=0, P0=[0,0], P1=lns[0].xy, P2=lns[1].xy, P3=lns[2].xy;
			for(var n=1;n<rough;n++){
				t = 1/rough*n;
				newX = (1-t)*(1-t)*(1-t)*P0[0]  +  3*t*(1-t)*(1-t)*P1[0]  +  3*t*t*(1-t)*P2[0]  +  t*t*t*P3[0];
				newY = (1-t)*(1-t)*(1-t)*P0[1]  +  3*t*(1-t)*(1-t)*P1[1]  +  3*t*t*(1-t)*P2[1]  +  t*t*t*P3[1];
				bezie_points.push({x:newX,y:newY});
			};
			bezie_points.push({x:P3[0],y:P3[1]});
		if(lns.length===5 || lns.length>5){
		var t=0, newX=0, newY=0, P0=lns[2].xy, P1=lns[3].xy, P2=lns[4].xy;
			for(var n=1;n<rough;n++){
				t = 1/rough*n;
				newX = (1-t)*(1-t)*P0[0]  +  2*t*(1-t)*P1[0]  +  t*t*P2[0];
				newY = (1-t)*(1-t)*P0[1]  +  2*t*(1-t)*P1[1]  +  t*t*P2[1];
				bezie_points.push({x:newX,y:newY});
			};
			bezie_points.push({x:P2[0],y:P2[1]});
		};
		this.bezie = bezie_points;
		});
		this.ALL_FRAMES = AF;
	},

	calculateEdgeSkewY:function(){
		var _this=this;
		var BOOK_HEIGHT = this.CFG.BOOK_HEIGHT;
		var YSCALE = this.CFG.YSCALE;
		var YSCALETOP = this.CFG.YSCALETOP;
		var AF = this.ALL_FRAMES;

		$.each(AF,function(i){
			var edge = this.bezie;
			var skewYtop = [];
			var skewYbottom = [];
			var edges3d = [];

			for(var n=0;n<edge.length-1;n++){
				var p1,p2,y1top,y2top;
				
				p1=edge[n];
				p2=edge[n+1];
				
				var width = Math.sqrt((p2.y-p1.y)*(p2.y-p1.y)+(p2.x-p1.x)*(p2.x-p1.x));
				var angle = ((Math.atan2(p2.y-p1.y,p2.x-p1.x))*180/Math.PI).toFixed(15);
				edges3d.push({x:p1.x,z:p1.y,width:width,angle:angle});
				
				y1top = p1.y*YSCALETOP-BOOK_HEIGHT;
				y2top = p2.y*YSCALETOP-BOOK_HEIGHT;
				skewYtop.push( ((Math.atan2(y2top-y1top,p2.x-p1.x))*180/Math.PI).toFixed(15));

				y1bottom = p1.y*YSCALE-BOOK_HEIGHT;
				y2bottom = p2.y*YSCALE-BOOK_HEIGHT;
				skewYbottom.push( ((Math.atan2(y2bottom-y1bottom,p2.x-p1.x))*180/Math.PI).toFixed(15));
			};
			this.edges3d = edges3d;
			this.skewYtop = skewYtop;
			this.skewYbottom = skewYbottom;
		});
		this.ALL_FRAMES = AF;
	},

	get_total_keyframes:function(){
		var keyframes = this.ARR_ANIMATIONS[this.CURRENT_ANIMATION];
		return keyframes.length;
	},
	get_total_lines:function(){
		var totalLines = this.ALL_FRAMES[this.FIRST_KEYFRAME].line;
		return totalLines.length;
	}
};
	

var OneBookEditorMath = {
	init:function(){
		this.SIN = [];
		this.COS = [];
		this._calculate();
		return this;
	},	
	_calculate:function(){
		for(var i=0;i<360;i++){this.SIN[i] = Math.sin(i*Math.PI/180).toFixed(15)};
		for(var i=0;i<360;i++){this.COS[i] = Math.cos(i*Math.PI/180).toFixed(15)};		
		(function(fn){
			if(!fn.map){fn.map= function(f){ var len=this.length;var res = new Array(len);for(var i=0;i<len;i++){if(i in this){res[i]=f.call(false,this[i],i,this)}};return res;}}
		})(Array.prototype);
	},
	xy_matrix2d:function(xy,matrix){
		var v = xy; v.push(1);
		var m = matrix;	
		return [
			m[0]*v[0]+m[1]*v[1]+m[2]*v[2],
			m[3]*v[0]+m[4]*v[1]+m[5]*v[2]
		]
	}	
};	

	var wholeBooks = window[G_DATA].NUMBER;
	window[G_DATA].NUMBER +=1;
	window[G_DATA].queueBooksBuilding.push({arrSrc:arrSrc,options:options,target:target});
	if(!wholeBooks || !window[G_DATA].buildingNowFlag){
		window[G_DATA].buildNextBook();
	};

	return this;

};

$.fn.onebook = function (arrSrc,options) {
	$.onebook(arrSrc,options,this);
	return this;
};


})(jQuery);

 
 /**
 * riadesign
 * jquery plugin 'swipeMePls';
 */
 
(function(e){e.fn.swipeMePls=function(t){var n=e.extend({preventDefault:true,enableMouse:true,distance:100,onTouch:function(e){},onMove:function(e){},onSwipe:function(e){},onEnd:function(){}},t||{});var r;var i;return this.each(function(){var t=e(this);var s,o;var u,a;var f=false;var l={touchStart:function(e){if(e.targetTouches.length>1){return}var t=e.targetTouches[0];u=t.pageX;a=t.pageY;s=t.pageX;o=t.pageY;r=new Date;n.onTouch({clientX:t.clientX,clientY:t.clientY,pageX:t.pageX,pageY:t.pageY,screenX:t.screenX,screenY:t.screenY})},mouseDown:function(e){f=true;u=e.pageX;a=e.pageY;s=e.pageX;o=e.pageY;r=new Date;n.onTouch({clientX:e.clientX,clientY:e.clientY,pageX:e.pageX,pageY:e.pageY,screenX:e.screenX,screenY:e.screenY});n.preventDefault&&e.preventDefault()},mouseMove:function(e){if(f){n.onMove({deltaX:e.pageX-s,deltaY:e.pageY-o,clientX:e.clientX,clientY:e.clientY,pageX:e.pageX,pageY:e.pageY,screenX:e.screenX,screenY:e.screenY});s=e.pageX;o=e.pageY}n.preventDefault&&e.preventDefault()},moveEnd:function(e){if(f){f=false;l.testSwipe()}n.preventDefault&&e.preventDefault();n.onEnd()},touchEnd:function(e){f=false;l.testSwipe();n.onEnd()},touchMove:function(e){if(e.targetTouches.length>1){return}var t=e.targetTouches[0];n.onMove({deltaX:t.pageX-s,deltaY:t.pageY-o,clientX:t.clientX,clientY:t.clientY,pageX:t.pageX,pageY:t.pageY,screenX:t.screenX,screenY:t.screenY,evt:e});s=t.pageX;o=t.pageY;n.preventDefault&&e.preventDefault()},testSwipe:function(){var e=s-u;var t=o-a;i=Math.abs(new Date-r)/1e3;if(Math.abs(e)>=Math.abs(t)){if(Math.abs(e)>=n.distance){var f=e>=0?"right":"left";n.onSwipe({direction:f,distance:Math.abs(e),speed:Math.abs(e)/i,time:i})}}else{if(Math.abs(t)>=n.distance){var f=t>=0?"down":"up";n.onSwipe({direction:f,distance:Math.abs(t),speed:Math.abs(t)/i,time:i})}}},touchCancel:function(e){}};if(n.enableMouse){t.mousedown(function(e){var e=e||window.event;var t=e.keyCode||e.which;if(t==1){l.mouseDown(e)}});t.mouseup(l.moveEnd);e("body").mouseup(l.moveEnd);t.mousemove(l.mouseMove)}this.addEventListener("touchstart",l.touchStart);this.addEventListener("touchmove",l.touchMove);this.addEventListener("touchend",l.touchEnd);this.addEventListener("touchcancel",l.touchCancel)})}})(jQuery);



