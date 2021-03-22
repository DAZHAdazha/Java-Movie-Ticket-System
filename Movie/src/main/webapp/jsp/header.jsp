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
                        <li><a href="javascript:void(0)">Theater</a></li>
                        <li><a href="javascript:void(0)">Top List</a></li>
                    </ul>
                </div>
<%--                <div class="app-download">--%>
<%--                </div>--%>
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
                                    <div class="layui-col-md4">
                                        <input type="radio" name="searchType" value="star" title="star">
                                    </div>
                                    <div class="layui-col-md4">
                                        <input type="radio" name="searchType" value="theater" title="theater">
                                    </div>
                                </div>
                                <div class="layui-col-md2" style="float: right">
                                    <input name="searchKeyword" class="search" type="search" maxlength="32" placeholder="Find movie,cinema,performer" autocomplete="off">
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