
$(document).ready(function() {
  //鼠标移动至图片
  $(".floaty").mousemove(function(event) {
    var mouseX = event.pageX;
    var mouseY = event.pageY;
    var horzAngle = 0;
    var vertAngle = 0;
    var obj = $(this);
    //Maximum angle 30!
    var objX = obj.offset().left + obj.innerWidth() / 2;
    var objY = obj.offset().top + obj.innerHeight() / 2;
    
    horzAngle = -((objX - mouseX) / (obj.innerWidth()/2)) * 10;
    vertAngle = ((objY - mouseY) / (obj.innerHeight()/2)) * 10;
    
    obj.attr("style", "transform: rotateY("+horzAngle+"deg) rotateX("+vertAngle+"deg) translateZ(50px);-webkit-transform: rotateY("+horzAngle+"deg) rotateX("+vertAngle+"deg) translateZ(50px);-moz-transform: rotateY("+horzAngle+"deg) rotateX("+vertAngle+"deg) translateZ(50px)");
  });
  //鼠标由图片移开
  $(".floaty").mouseout(function() {
    var obj = $(this);
    obj.css({
      '-webkit-transform' : 'rotateY(' + 0 + 'deg)',
      '-moz-transform'    : 'rotateY(' + 0 + 'deg)',
      '-ms-transform'     : 'rotateY(' + 0 + 'deg)',
      '-o-transform'      : 'rotateY(' + 0 + 'deg)',
      'transform'         : 'rotateY(' + 0 + 'deg)'
    });
  });
});

//点击返回
$('.back').click(function(){

  $('.container-master').toggleClass('toggled');
});

//点击图片
$('.tile').click(function(){
  $('html,body').animate({scrollTop:$('.container-tile').offset().top},0);

    $('.container-master').toggleClass('toggled');
  
  $('.lyrics-wrapper').empty();
  //get title
  $('.lyrics-title').html($(this).find('.title').html());

  //第一张图轮播
  $list = $(this).find('ul.first li.first');

  $list.each(function(i, li){
   // console.log(i,li);
    var lyricsText = '<div class="lyrics-card">'+$('li.first').html()+'</div>';
      $('.lyrics-wrapper').load("main_show_banner01.html");
    });
    //第二张图轮播
    $list = $(this).find('ul.second li.second');

    $list.each(function(i, li){
        // console.log(i,li);
        var lyricsText = '<div class="lyrics-card">'+$('li.second').html()+'</div>';
        $('.lyrics-wrapper').load("main_show_banner02.html");
    });
    //第三张图轮播
    $list = $(this).find('ul.third li.third');

    $list.each(function(i, li){
        // console.log(i,li);
        var lyricsText = '<div class="lyrics-card">'+$('li.third').html()+'</div>';
        $('.lyrics-wrapper').load("main_show_banner03.html");
    });
    //第四张图轮播
    $list = $(this).find('ul.forth li.forth');

    $list.each(function(i, li){
        // console.log(i,li);
        var lyricsText = '<div class="lyrics-card">'+$('li.forth').html()+'</div>';
        $('.lyrics-wrapper').load("main_show_banner04.html");
    });
    //第五张图轮播
    $list = $(this).find('ul.fifth li.fifth');

    $list.each(function(i, li){
        // console.log(i,li);
        var lyricsText = '<div class="lyrics-card">'+$('li.fifth').html()+'</div>';
        $('.lyrics-wrapper').load("main_show_banner05.html");
    });
    //第六张图轮播
    $list = $(this).find('ul.sixth li.sixth');

    $list.each(function(i, li){
        // console.log(i,li);
        var lyricsText = '<div class="lyrics-card">'+$('li.sixth').html()+'</div>';
        $('.lyrics-wrapper').load("main_show_banner06.html");
    });

});
