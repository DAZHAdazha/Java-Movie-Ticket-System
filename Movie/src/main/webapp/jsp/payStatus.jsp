<%@page import="com.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    //	User user = (User)request.getSession().getAttribute("user");
    int flag = 0;
    Cookie[] cookies = request.getCookies();
    System.out.println("cokkies!");
    if(cookies != null){
        for (Cookie cookie : cookies) {
            if(cookie.getName().equals("user")){
                System.out.println(cookie);
                flag = 1;
                break;
            }
        }
    }
    if(flag == 0){
        response.sendRedirect("./login.jsp");
    }
%>
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
    <link rel="stylesheet" type="text/css" href="../static/css/paystatus.css">
    <link rel="stylesheet" type="text/css" href="../static/css/footer.css">
    <script src="../static/js/header.js" charset="utf-8"></script>
    <script src="../static/js/Api.js"></script>
    <script src="../static/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="../static/layui/css/layui.css" media="all">
    <title>Tao Tao Movie-Payment Completed</title>
</head>
<body>

    <!-- 导航栏 -->
    <jsp:include page="header.jsp"/>

    <!-- 占位符 -->
    <div style="margin-top: 90px;"></div>

    <!-- 主体 -->
    <div class="container">
        <div class="order-progress-bar">
            <div class="step first done">
                <span class="step-num">1</span>
                <div class="bar"></div>
                <span class="step-next">Choose movie</span>
            </div>
            <div class="step done">
                <span class="step-num">2</span>
                <div class="bar"></div>
                <span class="step-next">Choose seats</span>
            </div>
            <div class="step done">
                <span class="step-num">3</span>
                <div class="bar"></div>
                <span class="step-next">Payment</span>
            </div>
            <div class="step last done">
                <span class="step-num">4</span>
                <div class="bar"></div>
                <span class="step-next">Watch movie</span>
            </div>
        </div>
        <div class="main-paystatus">
            <img src="../static/images/success.jpg"/>
            <p class="statustext">Payment completed</p>
        </div>
        <div class="right">
            <p class="warning">
                View order information on<span class="attention"> personal order page</span>
            </p>
            <div>
                <div class="pay-btn" onclick="returnCenter()">Return personal order page</div>
            </div>
        </div>
    </div>

    <!-- 脚 -->
    <jsp:include page="footer.jsp"/>

    <script>
        var clientHeight = document.documentElement.clientHeight;

        window.onload = function(){
			 initHeader();
        }
        
        function returnCenter(){
            window.location.href = "./center.jsp"
        }

    </script>
</body>
</html>