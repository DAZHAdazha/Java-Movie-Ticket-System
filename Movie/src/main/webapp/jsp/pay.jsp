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
    <link rel="stylesheet" type="text/css" href="../static/css/pay.css">
    <link rel="stylesheet" type="text/css" href="../static/css/footer.css">
    <script src="../static/js/header.js" charset="utf-8"></script>
    <script src="../static/js/Api.js"></script>
    <script src="../static/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="../static/layui/css/layui.css" media="all">
    <title>Tao Tao Movie-Payment</title>
</head>
<body>
    <!-- ------------------------------------------------------------------- -->
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
            <div class="step last">
                <span class="step-num">4</span>
                <div class="bar"></div>
                <span class="step-next">Watch movie</span>
            </div>
        </div>

        <div class="count-down-wrapper">
            <div class="count-down">
                <p class="time-left">
                    Please complete the payment in <span class="minute"></span> minutes and <span class="second"></span> seconds
                </p>
                <p class="tip">The overtime order will be cancelled automatically</p>
            </div>
        </div>

        <p class="warning">
            Please check the venue information carefully.<span class="attention">The ticket cannot be refunded or changed after it is issued</span>
        </p>

        <table class="order-table">
            <thead>
                <tr>
                    <th>Movie</th>
                    <th>Time</th>
                    <th>Theater</th>
                    <th>Seat</th>
                </tr>
            </thead>
            <tbody>
               <!-- 信息表 -->
            </tbody>
        </table>

        <div class="right">
            <div class="price-wrapper">
                <span>Price: </span>
                <span class="price"></span>
            </div>
            <div>
                <div class="pay-btn">Confirm payment</div>
            </div>
        </div>
    </div>

    <!-- 脚 -->
    <jsp:include page="footer.jsp"/>

    <!-- ------------------------------------------------------------------- -->
    <script>
        var clientHeight = document.documentElement.clientHeight;
        var json = localStorage.getItem("order");
        json = eval('(' + json + ')');
        console.log(json);
        var schedule_id = json.schedule_id;
        var payBtn = $(".pay-btn");
        window.onload = function(){
            initHeader();
            initPay(); //支付
            timeDown(); //计时器
        }

        //初始化支付页面
        function initPay(){
            var orderTable = $(".order-table").find("tbody");
            var TempLength = json.TicketSeat.split(",");
            console.log(TempLength);
            var price = json.price;
            $.ajax({
                type:'post',
                url: url + "/schedule/findScheduleById",
                dataType:'json',
                data: {
                    schedule_id: schedule_id
                },
                success:function (obj) {
                    orderTable.append(
                        "<tr>" +
                            "<td class=\"movie-name\">" + obj.data.schedule_movie.movie_cn_name + "</td>" +
                            "<td class=\"showtime\">" + obj.data.schedule_startTime + "</td>" +
                            "<td class=\"cinema-name\">" + obj.data.schedule_hall.hall_cinema.cinema_name + "</td>" +
                            "<td>" +
                                "<span class=\"hall\">" + obj.data.schedule_hall.hall_name + "</span>" +
                                "<div class=\"seats\">" +
                                    "<div class=\"choiceseat\" style=\"display: block;\">" +
                                    "</div>" +
                                "</div>" +
                            "</td>" +
                        "<tr>"
                    );
                    var choiceSeat = $(".choiceseat");
                    for(var i=0;i<TempLength.length;i++){
                        choiceSeat.append("<span class=\"border\" style=\"font-size: 15px;\">" + TempLength[i] + "</span>");
                    }
                }
            });

            var choiceSeat = $(".choiceseat");
            for(var i=0;i<TempLength.length;i++){
                choiceSeat.append("<span class=\"border\" style=\"font-size: 15px;\">" + TempLength[i] + "</span>");
            }
            $(".price").html("￥" + price);
        }

        //计时器
        function timeDown(){
            var timeMinute = $(".minute");
            var timeSecond = $(".second");
            var minute;
            var second;
            timeMinute.text(localStorage.minute);
            timeSecond.text(localStorage.second);
            setInterval(function(){
                if(second==0 && minute==0){
                    window.alert("Overtime order!!");
                    localStorage.clear();
                }
                if((localStorage.second == "NaN") || (localStorage.second == 0 && localStorage.minute == 0))
                {
                    localStorage.minute = 14;
                    localStorage.second = 59;
                }
                second = localStorage.second;
                minute = localStorage.minute; 
                if(second==0){
                    minute--;
                    second = 60;
                }
                second--;
                timeMinute.text(minute);
                timeSecond.text(second);
                localStorage.second = second;
                localStorage.minute = minute;
            },1000);
        }

        //购买
        payBtn[0].onclick = function(){
            var position = json.TicketSeat.split(",");
            var price = json.price;
            $.ajax({
                type: "post",
                url: url + "/order/buyTickets",
                data: {
                    schedule_id: schedule_id,
                    position: position,
                    price: price,
                },
                dataType: "json",
                success: function(obj){
                	localStorage.removeItem("order");
                    if(obj.code == 0){
                        layui.use(['layer'], function(){
                            var layer = layui.layer;
                            layer.alert('Successful purchase！' + "\nBalance:￥" + obj.data ,{icon: 0,offset: clientHeight/5},
                                 function (){
                                    layer.closeAll();
                                    document.location.href = "./payStatus.jsp";
                                 }
                            );
                        });
                    }else{
                        layui.use(['layer'], function(){
                            var layer = layui.layer;
                            layer.alert(obj.msg + "\nBalance:￥"   + obj.data ,{icon: 0,offset: clientHeight/5},
                                 function (){
                                    layer.closeAll();
                                 }
                            );
                        });
                    }
                },
                error: function(){
                    alert("network error");
                }
            });
        }

        //获取url参数
        function getUrlParams(name) { // 不传name返回所有值，否则返回对应值
            var url = window.location.search;
            if (url.indexOf('?') == 1) { return false; }
            url = url.substr(1);
            url = url.split('&');
            var name = name || '';
            var nameres;
            // 获取全部参数及其值
            for(var i=0;i<url.length;i++) {
                var info = url[i].split('=');
                var obj = {};
                obj[info[0]] = decodeURI(info[1]);
                url[i] = obj;
            }
            // 如果传入一个参数名称，就匹配其值
            if (name) {
                for(var i=0;i<url.length;i++) {
                    for (const key in url[i]) {
                        if (key == name) {
                            nameres = url[i][key];
                        }
                    }
                }
            } else {
                nameres = url;
            }
            // 返回结果
            return nameres;
        }

    </script>
    <!-- ------------------------------------------------------------------- -->
</body>
</html>