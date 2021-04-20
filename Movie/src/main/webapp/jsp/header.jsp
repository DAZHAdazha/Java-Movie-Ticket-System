<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
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
    <script src="../static/js/header.js" charset="utf-8"></script>
    <script src="../static/js/Api.js"></script>

    <script src="../static/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="../static/layui/css/layui.css" media="all">
    <title>Tao Tao Movie</title>
</head>
<body>
 	<!-- 导航栏 -->
     <div class="header navbar navbar-fixed-top">
        <div class="header-top">
            <div class="header-inner">
                <h1>
                    <a href="javascript:void(0)" class="logo"></a>
                </h1>
                <div class="nav" style="width: 25%">
                    <ul>
                        <li><a href="./mainPage.jsp">Main page</a></li>
                        <li class="active"><a href="./movieList.jsp">Movie</a></li>

                        <li><a href="./manage.jsp">Manage</a></li>

                        <script>
                            function recommend(){
                                var user = localStorage.getItem("userJson");
                                user = eval('(' + user + ')');
                                var userId;
                                if(user!=null){
                                    userId = user.user_id;
                                }
                                else{
                                    userId = 7;
                                }
                                window.location.replace("../search/recommend?userId=" + userId);

                            }
                        </script>

                        <li><a style="cursor: pointer" onclick="recommend()" >Try?</a></li>
                    </ul>
                </div>

                <div class="app-download" style="margin-left: -200px">
                    <a target="_blank" href="http://localhost:8080/jsp/getApp.jsp">
                        <span class="apptext">APP</span>
                        <span class="caret"></span>
                        <div class="download-icon">
                            <p class="down-title">扫码下载APP</p>
                            <p class="down-content">选座更优惠</p>
                        </div>
                    </a>

                </div>

                <div class="user-info">
                <div class="user-avatar J-login">
                    <ul class="layui-nav" style="background-color: #fff;">
                        <li class="layui-nav-item header-li" style="width:40px;" lay-unselect="" style="width: 40px;">
                        </li>
                    </ul>
                </div>
                </div>



                <form class="layui-form" action="/search/all" style="float: left">
                    <div class="layui-form-item">
                            <div class="layui-row">
                                <div class="layui-col-md10">
                                    <div class="layui-col-md4">
                                        <input type="radio" name="searchType" value="movie" title="movie" checked>
                                    </div>
                                    <div  class="layui-col-md4">
                                        <input type="radio" name="searchType" value="star" title="star">
                                    </div>
                                    <div  class="layui-col-md4">
                                        <input type="radio" name="searchType" value="theater" title="theater">
                                    </div>
                                </div>
                                <div class="layui-col-md2" style="float: right">
                                    <input name="searchKeyword" class="search" type="search" maxlength="32" placeholder="Search" autocomplete="off">
                                    <input class="submit" type="submit" value="">
                                </div>
                            </div>
                    </div>
                </form>

            </div>
        </div>
    </div>

    <script>
        var clientHeight = document.documentElement.clientHeight;
        window.onload = function(){
            initHeader();
        }

        
    </script>
</body>
</html>