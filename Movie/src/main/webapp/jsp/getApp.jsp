<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="../static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="../static/bootstrap/css/bootstrap.css" rel="stylesheet">
    <script src="../static/bootstrap/js/jquery-3.3.1.min.js"></script>
    <script src="../static/bootstrap/js/bootstrap.min.js"></script>
    <link rel="icon" type="image/x-icon" href="../static/images/logo.ico"/>
    <link rel="stylesheet" type="text/css" href="../static/css/header.css">
    <link rel="stylesheet" type="text/css" href="../static/css/main.css">
    <link rel="stylesheet" type="text/css" href="../static/css/main2.css">
    <link rel="stylesheet" type="text/css" href="../static/css/footer.css">
    <script src="../static/js/header2.js" charset="utf-8"></script>
    <script src="../static/js/Api.js"></script>

    <script src="../static/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="../static/layui/css/layui.css" media="all">
    <title>Tao Tao Recommend Page</title>



    <style>
        html {
            color: #000;
            background: #ffffff
        }

        body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, pre, code, form, fieldset, legend, input, textarea, p, blockquote, th, td {
            margin: 0;
            padding: 0;
            font-family: Microsoft Yahei, Simhei;
        }

        table {
            border-collapse: collapse;
            border-spacing: 0
        }

        fieldset, img {
            border: 0
        }

        address, caption, cite, code, dfn, em, strong, th, var {
            font-style: normal;
            font-weight: normal
        }

        ol, ul {
            list-style: none
        }

        caption, th {
            text-align: left
        }

        h1, h2, h3, h4, h5, h6 {
            font-size: 100%;
            font-weight: normal
        }

        q:before, q:after {
            content: ''
        }

        abbr, acronym {
            border: 0;
            font-variant: normal
        }

        sup {
            vertical-align: text-top
        }

        sub {
            vertical-align: text-bottom
        }

        input, textarea, select {
            font-family: inherit;
            font-size: inherit;
            font-weight: inherit;
            resize: none
        }

        input, textarea, select {
            *font-size: 100%
        }

        legend {
            color: #000;
            display: none
        }

        .clearfix {
            zoom: 1
        }

        .clearfix:after {
            content: '.';
            visibility: hidden;
            display: block;
            height: 0;
            clear: both
        }

        /*Reset End:}*/

        body {
            background: #f7f7f7;
        }

        #hd {
            background: #a11923;
            height: 61px;
        }

        #ft {
            padding: 45px 0;
            text-align: center;
            font-size: 12px;
            color: #929292;
        }

        #ft a {
            color: #929292;
            text-decoration: none;
        }

        .body {
            width: 980px;
            margin: auto;
        }

        .header {
            background: #a11923;
            width: 980px;
            margin: auto;
            position: relative;
            padding-top: 1px;
        }
        .ticket {
            position: absolute;
            right: 154px;
            top: -1px;
            width: 70px;
            height: 35px;
            background: url(http://p0.meituan.net/scarlett/2e0cfe8679a42bb739f861aeff9c22e476186.png) -777px -21px no-repeat;
            color: #d6a9ac;
            font-size: 12px;
            line-height: 31px;
            padding-left: 49px;
            text-decoration: none;
        }

        .ticket:hover {
            background: url(http://p0.meituan.net/scarlett/2e0cfe8679a42bb739f861aeff9c22e476186.png) -777px -61px no-repeat;
        }

        .ticket:active {
            background: url(http://p0.meituan.net/scarlett/2e0cfe8679a42bb739f861aeff9c22e476186.png) -777px -101px no-repeat;
        }

        .weibo {
            position: absolute;
            right: 24px;
            top: -1px;
            width: 70px;
            height: 35px;
            background: url(http://p0.meituan.net/scarlett/2e0cfe8679a42bb739f861aeff9c22e476186.png) -913px -21px no-repeat;
            color: #d6a9ac;
            font-size: 12px;
            line-height: 31px;
            padding-left: 49px;
            text-decoration: none;
        }

        .weibo:hover {
            background: url(http://p0.meituan.net/scarlett/2e0cfe8679a42bb739f861aeff9c22e476186.png) -913px -61px no-repeat;
        }

        .weibo:active {
            background: url(http://p0.meituan.net/scarlett/2e0cfe8679a42bb739f861aeff9c22e476186.png) -913px -101px no-repeat;
        }

        .item-hd {
            background: #ededed url(http://p0.meituan.net/scarlett/3594125669a576bac847c17a73caaea5305.png) repeat-x;
            background-size: 10px 100%;
            padding-top: 10px;
            border-bottom: 1px solid #cbcbcb;
            height: 515px;
            text-align: center;
        }

        .item-hd .content {
            width: 980px;
            height: 100%;
            margin: 0 auto;
        }

        .item-hd .left {
            background: url(http://p0.meituan.net/scarlett/a8c7dae374db59df7df0d7b1f624d784221840.png) no-repeat;
            float: left;
            width: 520px;
            height: 515px;
            margin-top: 32px;
        }

        .item-hd .right {
            float: left;
            width: 460px;
            height: 100%;
            text-align: left;
        }

        .item-hd h2 {
            background: url(http://p0.meituan.net/scarlett/2e0cfe8679a42bb739f861aeff9c22e476186.png) -239px -15px no-repeat;
            margin: 60px 0 5px;
            width: 460px;
            height: 132px;
        }

        .item-hd .content .line {
            margin-top: 10px;
            background: transparent url(http://p0.meituan.net/scarlett/2e0cfe8679a42bb739f861aeff9c22e476186.png) -5px -275px no-repeat;
            width: 100%;
            font-size: 5px;
            height: 5px;
        }

        .item-hd .download {
            margin-top: 20px;
        }

        .item-hd .download .iphone {
            background: url(http://p0.meituan.net/scarlett/c593b365caccf4a5e179e61f4ed903e656851.png) 0 0 no-repeat;
            display: inline-block;
            width: 225px;
            height: 80px;
            margin-left: 2px;
        }

        .item-hd .download .iphone:hover {
            background: url(http://p0.meituan.net/scarlett/c593b365caccf4a5e179e61f4ed903e656851.png) 0 -87px no-repeat;
        }

        .item-hd .download .iphone:active {
            background: url(http://p0.meituan.net/scarlett/c593b365caccf4a5e179e61f4ed903e656851.png) 0 -174px no-repeat;
        }

        .item-hd .download .android {
            background: url(http://p0.meituan.net/scarlett/c593b365caccf4a5e179e61f4ed903e656851.png) -235px 0px no-repeat;
            display: inline-block;
            width: 225px;
            height: 80px;
        }

        .item-hd .download .android:hover {
            background: url(http://p0.meituan.net/scarlett/c593b365caccf4a5e179e61f4ed903e656851.png) -235px -87px no-repeat;
        }

        .item-hd .download .android:active {
            background: url(http://p0.meituan.net/scarlett/c593b365caccf4a5e179e61f4ed903e656851.png) -235px -174px no-repeat;
        }

        .item-hd .qr-download {
            background: url(http://p0.meituan.net/scarlett/2e0cfe8679a42bb739f861aeff9c22e476186.png) -530px -172px no-repeat;
            padding-left: 20px;
            margin-top: 50px;
            float: right;
            width: 325px;
            height: 105px;
            font-size: 16px;
        }

        .item-hd .qr-download .link {
            float: left;
            margin: 33px 15px 33px 0;
            width: 185px;
            line-height: 1.4em;
            color: #7d7d7d;
            text-shadow: 1px 1px 1px #fff;
        }

        .item-hd .qr-download .link strong {
            color: #ce3133;
            font-family: arial;
        }

        .item-hd .qr-download .word {
            float: left;
            width: 20px;
            color: #a0a0a0;
            padding: 22px 0 0 3px;
            margin-left: 101px;
            font-size: 14px;
            line-height: 1.2em;
            text-shadow: 1px 1px 1px #fff;
        }

        .item {
            height: 310px;
            padding-top: 171px;
        }

        .item h2 {
            font-size: 36px;
            color: #c22830;
            margin-bottom: 7px;
        }

        .item p {
            font-size: 20px;
            color: #a0a0a0;
            letter-spacing: .1em;
        }

        .item-line {
            background: #f7f7f7 url(http://p0.meituan.net/scarlett/2e0cfe8679a42bb739f861aeff9c22e476186.png) -15px -295px no-repeat;
            height: 10px;
            overflow: hidden;
            border: 0;
            margin: 0;
        }

        .item-1 {
            background: url(http://p0.meituan.net/scarlett/855ff03274ba521b3d622a5318d28b0958867.jpg) 410px 85px no-repeat;
            margin: 0 40px 0 22px;
        }

        .item-2 {
            text-align: right;
            background: url(http://p0.meituan.net/scarlett/3ba19a1a5a4911462dff1068aacfa62933060.jpg) -60px 38px no-repeat;
            margin-left: 42px;
        }

        .item-3 {
            background: url(http://p1.meituan.net/scarlett/d8173a045b0b144a1d4a3bd9f8b95ab431895.jpg) 470px 20px no-repeat;
            margin: 0 0 0 22px;
        }

        .item-4 {
            text-align: right;
            background: url(http://p0.meituan.net/scarlett/9e17266f275de09241ac4254b0b322af34319.jpg) -65px 30px no-repeat;
            margin-left: 50px;
        }</style>




</head>
<body>
<jsp:include page="header2.jsp"/>
<br>
<br>
<br>

<div class="item-hd">
    <div class="content">

        <div class="right">

            <div class="line pngfix"></div>
            <div class="download">

                <a class="android pngfix" href="http://192.168.1.106:8080/App/movie.apk" onclick="_gaq.push(['_trackEvent', 'InnerLink', 'Click', 'web/download/android'])">
                </a>
                <a class="qrcode pngfix" href="javascript:;"></a>
                <div class="line pngfix"></div>
            </div>

        </div>
    </div>
</div>
<!-- 脚 -->
<jsp:include page="footer.jsp"/>
</body></html>