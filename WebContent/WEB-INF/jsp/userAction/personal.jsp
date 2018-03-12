<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
    <meta charset="gb2312">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人信息</title>
 
    <link type="text/css" href="css/personal.css" rel="stylesheet">
    <!--bootstrap-->
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>

<div id="e_background" style="overflow:scroll">
    <div class="container" >
   
        <div class="your-brief-intro" style="position: relative">
            <h3>个人中心</h3>
            <p class="your-title">
                <span >
                    <img src="img/menu-top.jpg"/>
                    <br>
                    <button>修改</button>
                    <button>保存</button>
                </span>
                <span class="your-name">
                    yourname
                </span>

            </p>

        <div class="clock-container" >

            <!-- Hours -->

            <div class="spinner" id="spinner_h1">
                <div class="num num_0" id="num_0_h1">
                    <div>0</div>
                </div>
                <div class="num num_1" id="num_1_h1">
                    <div>1</div>
                </div>
                <div class="num num_2" id="num_2_h1">
                    <div>2</div>
                </div>
            </div>

            <div class="spinner" id="spinner_h2">
                <div class="num num_0" id="num_0_h2">
                    <div>0</div>
                </div>
                <div class="num num_1" id="num_1_h2">
                    <div>1</div>
                </div>
                <div class="num num_2" id="num_2_h2">
                    <div>2</div>
                </div>
                <div class="num num_3" id="num_3_h2">
                    <div>3</div>
                </div>
                <div class="num num_4" id="num_4_h2">
                    <div>4</div>
                </div>
                <div class="num num_5" id="num_5_h2">
                    <div>5</div>
                </div>
                <div class="num num_6" id="num_6_h2">
                    <div>6</div>
                </div>
                <div class="num num_7" id="num_7_h2">
                    <div>7</div>
                </div>
                <div class="num num_8" id="num_8_h2">
                    <div>8</div>
                </div>
                <div class="num num_9" id="num_9_h2">
                    <div>9</div>
                </div>
            </div>

            <!-- Minutes -->

            <div class="spinner" id="spinner_m1">
                <div class="num num_0" id="num_0_m1">
                    <div>0</div>
                </div>
                <div class="num num_1" id="num_1_m1">
                    <div>1</div>
                </div>
                <div class="num num_2" id="num_2_m1">
                    <div>2</div>
                </div>
                <div class="num num_3" id="num_3_m1">
                    <div>3</div>
                </div>
                <div class="num num_4" id="num_4_m1">
                    <div>4</div>
                </div>
                <div class="num num_5" id="num_5_m1">
                    <div>5</div>
                </div>
            </div>

            <div class="spinner" id="spinner_m2">
                <div class="num num_0" id="num_0_m2">
                    <div>0</div>
                </div>
                <div class="num num_1" id="num_1_m2">
                    <div>1</div>
                </div>
                <div class="num num_2" id="num_2_m2">
                    <div>2</div>
                </div>
                <div class="num num_3" id="num_3_m2">
                    <div>3</div>
                </div>
                <div class="num num_4" id="num_4_m2">
                    <div>4</div>
                </div>
                <div class="num num_5" id="num_5_m2">
                    <div>5</div>
                </div>
                <div class="num num_6" id="num_6_m2">
                    <div>6</div>
                </div>
                <div class="num num_7" id="num_7_m2">
                    <div>7</div>
                </div>
                <div class="num num_8" id="num_8_m2">
                    <div>8</div>
                </div>
                <div class="num num_9" id="num_9_m2">
                    <div>9</div>
                </div>
            </div>

            <!-- Seconds -->

            <div class="spinner" id="spinner_s1">
                <div class="num num_0" id="num_0_s1">
                    <div>0</div>
                </div>
                <div class="num num_1" id="num_1_s1">
                    <div>1</div>
                </div>
                <div class="num num_2" id="num_2_s1">
                    <div>2</div>
                </div>
                <div class="num num_3" id="num_3_s1">
                    <div>3</div>
                </div>
                <div class="num num_4" id="num_4_s1">
                    <div>4</div>
                </div>
                <div class="num num_5" id="num_5_s1">
                    <div>5</div>
                </div>
            </div>
            <div class="spinner" id="spinner_s2">
                <div class="num num_0" id="num_0_s2">
                    <div>0</div>
                </div>
                <div class="num num_1" id="num_1_s2">
                    <div>1</div>
                </div>
                <div class="num num_2" id="num_2_s2">
                    <div>2</div>
                </div>
                <div class="num num_3" id="num_3_s2">
                    <div>3</div>
                </div>
                <div class="num num_4" id="num_4_s2">
                    <div>4</div>
                </div>
                <div class="num num_5" id="num_5_s2">
                    <div>5</div>
                </div>
                <div class="num num_6" id="num_6_s2">
                    <div>6</div>
                </div>
                <div class="num num_7" id="num_7_s2">
                    <div>7</div>
                </div>
                <div class="num num_8" id="num_8_s2">
                    <div>8</div>
                </div>
                <div class="num num_9" id="num_9_s2">
                    <div>9</div>
                </div>
            </div>

            <div class="top">></div>

        </div>
        </div>
        <div class="content">
            <div class="content-main">
                <h4>我的照片</h4>
                <img src="img/menu-top.jpg" height="180" width="180"/>
                <img src="img/menu-top.jpg" height="180" width="180"/>
                <img src="img/menu-top.jpg" height="180" width="180"/>
                <img src="img/menu-top.jpg" height="180" width="180"/>
                <button style="color: #000;">添加照片</button>
                <br><br><br>
                <h4>我的相册</h4>
                <img src="img/menu-top.jpg" height="180" width="180"/>
                <img src="img/menu-top.jpg" height="180" width="180"/>
                <img src="img/menu-top.jpg" height="180" width="180"/>
                <img src="img/menu-top.jpg" height="180" width="180"/>
                <button style="color: #000">添加相册</button>

<script>
    //These functions help add, remove or toggle css classes

    function tog_class(id, cl) {
        var elem = document.getElementById(id);
        if (elem == null) {
            return 0;
        }
        if (elem.classList.contains(cl) === true) {
            elem.classList.remove(cl);
        } else {
            elem.classList.add(cl);
        }
    }

    function add_class(id, cl) {
        var elem = document.getElementById(id);
        if (elem == null) {
            return 0;
        }
        if (elem.classList.contains(cl) !== true) {
            elem.classList.add(cl);
        }
    }

    function rem_class(id, cl) {
        var elem = document.getElementById(id);
        if (elem == null) {
            return 0;
        }
        if (elem.classList.contains(cl) === true) {
            elem.classList.remove(cl);
        }
    }

    //This function gets the date and does operations using H/M/S

    function startTime() {
        var today = new Date();
        var h = today.getHours();
        var m = today.getMinutes();
        var s = today.getSeconds();

        var h1 = (h - h % 10) / 10;
        var h2 = h % 10;

        var m1 = (m - m % 10) / 10;
        var m2 = m % 10;

        var s1 = (s - s % 10) / 10;
        var s2 = s % 10;

        set_spin_class("s1", s1);
        set_spin_class("s2", s2);

        set_spin_class("m1", m1);
        set_spin_class("m2", m2);

        set_spin_class("h1", h1);
        set_spin_class("h2", h2);

        var t = setTimeout(startTime, 500);
    }

    //This function calls the appropriate class changes

    // It receives the type of spinner to change (m1 for example) and changes classes based on the current time

    function set_spin_class(target, val) {
        for (i = 0; i < 10; i++) {
            if (i != val) {
                rem_class("spinner_" + target, "spinner_" + target + "_" + i);
                rem_class("num_" + i + "_" + target, "lit");
            }
        }
        add_class("spinner_" + target, "spinner_" + target + "_" + val);
        add_class("num_" + val + "_" + target, "lit");

        if (val === 0) {
            deswitcher(target, val);
        } /*These functions prevent the clock from changing direction*/
        setTimeout(function() {
            switcher(target, val);
        }, 500);
    }

    function switcher(target, val) {
        switch ("spinner_" + target + "_" + val) {
            case "spinner_h1_2":
                rem_class("spinner_h1", "spinner_h1_2");
                add_class("spinner_h1", "spinner_h1_switch");
                break;
            case "spinner_h2_9":
                rem_class("spinner_h2", "spinner_h1_2");
                add_class("spinner_h2", "spinner_h2_switch");
                break;

            case "spinner_m1_5":
                rem_class("spinner_m1", "spinner_m1_5");
                add_class("spinner_m1", "spinner_m1_switch");
                break;
            case "spinner_m2_9":
                rem_class("spinner_m2", "spinner_m2_9");
                add_class("spinner_m2", "spinner_m2_switch");
                break;

            case "spinner_s1_5":
                rem_class("spinner_s1", "spinner_s1_5");
                add_class("spinner_s1", "spinner_s1_switch");
                break;
            case "spinner_s2_9":
                rem_class("spinner_s2", "spinner_s2_9");
                add_class("spinner_s2", "spinner_s2_switch");
                break;
        }
    }
    function deswitcher(target, val) {
        rem_class("spinner_" + target, "spinner_" + target + "_switch");
    }

    //Do stuff here

    window.onload = function() {
        startTime();
    };
</script>
</body>
</html>
