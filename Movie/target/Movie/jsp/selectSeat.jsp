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
    <link rel="stylesheet" type="text/css" href="../static/css/main.css">
    <link rel="stylesheet" type="text/css" href="../static/css/footer.css">
    <link rel="stylesheet" type="text/css" href="../static/css/buyTickets.css">
    <link rel="stylesheet" type="text/css" href="../static/css/movieDetail.css">
    <link rel="stylesheet" type="text/css" href="../static/css/selectSeat.css">
    <script src="../static/js/header.js" charset="utf-8"></script>
    <script src="../static/js/Api.js"></script>
    <script src="../static/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="../static/layui/css/layui.css" media="all">
    <title>Tao Tao Movie-Choose Movie</title>
</head>
<body>
    <!-- ------------------------------------------------------------------- -->
    <!-- 导航栏 -->
    <jsp:include page="header.jsp"/>
    
    <!-- 占位符 -->
    <div style="margin-top: 80px;"></div>

    <!-- 巨幕 -->
    <div class="banner2">
        <div class="wrapper clearfix">
            <div class="cinema-left">
                <div class="avatar-shadow">

                </div>
            </div>

            <div class="cinema-main clearfix">
                <div class="cinema-brief-container">
                    <div class="telphone">Tele：0335-2661222</div>
                    <div class="features-group">
                        <div class="group-title">Service</div>

                        <div class="feature">
                            <span class="tag ">3D </span>
                            <p class="desc text-ellipsis" title="免押金">No deposit</p>
                        </div>
                        <div class="feature">
                            <span class="tag ">Parking</span>
                            <p class="desc text-ellipsis" title="可停车">Free within 3 hours</p>
                        </div>
                    </div>
                </div>
            </div>
                
        </div>
    </div>

    <!-- 占位符 -->
    <div style="margin-top: 50px;"></div>

    <!-- 主体 -->
    <div class="main">
        <div class="main-inner main-bodyz">
            <div class="movie-list-container" data-cinemaid="8330">
                <!-- 电影海报 -->
                <div class="movie-list">
                    <!--<span class="pointer" style="left: 395px;"></span>-->
                </div>
                <span class="scroll-prev scroll-btn"></span>
                <span class="scroll-next scroll-btn"></span>
            </div>

            <div class="show-list active" data-index="0">
                <!-- 电影信息 -->
                <div class="movie-info">
                </div>
                <!-- 观影时间 -->
                <div class="show-date">
                    <span>Viewing time:</span>
                </div>
                <!-- 场次列表 -->
                <div class="plist-container active">
                    <table class="plist">
                        <thead>
                            <tr>
                                <th>Runtime</th>
                                <th>Language</th>
                                <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Hall</th>
                                <th>Price(CNY)</th>
                                <th>&nbsp;&nbsp;Ticket</th>
                            </tr>
                        </thead>
                        <tbody>
                          
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

     <!-- 脚 -->
     <jsp:include page="footer.jsp"/>

    <!-- ------------------------------------------------------------------- -->
    <script>
        window.onload = function(){
            initBanner(); //初始化巨幕
            initHeader();
        }

        //初始化巨幕
        function initBanner(){
            movie_id = getUrlParams('movie_id');
            cinema_id = getUrlParams('cinema_id');
            var cinemaBriefContainer = $(".cinema-brief-container");
            var avatarShadow = $(".avatar-shadow");
            $.ajax({
                type:'post',
                url: url + "/schedule/findScheduleByCinemaAndMovie",
                dataType:'json',
                data: {
                    movie_id: movie_id,
                    cinema_id: cinema_id
                },
                success:function (obj) {
                    console.log(obj);
                    cinemaBriefContainer.prepend(
                        "<h3 class=\"name text-ellipsis\">" + obj.data[0].schedule_hall.hall_cinema.cinema_name + "</h3>" +
                        "<div class=\"address text-ellipsis\">" + obj.data[0].schedule_hall.hall_cinema.cinema_address + "</div>"
                    );
                    avatarShadow.append(
                        "<img class=\"avatar\" src=\"../static/images/cinemas/" + obj.data[0].schedule_hall.hall_cinema.cinema_name + ".jpg\">" +
                        "<div class=\"avatar-num\">See all pictures</div>"
                    );
                    initMoive(obj); //初始化电影信息
                    initSchedule(obj); //初始化场次信息
                }
            });
        }

        //初始化电影信息
        function initMoive(obj){
           // console.log(obj);
            var Data = new Date();
            var Month = Data.getMonth() + 1;
            var Day = Data.getDate();
            var movieList = $(".movie-list");
            var movieInfo = $(".movie-info");
            var showDate = $(".show-date");
            for(var i=0;i<5;i++){
                movieList.append(
                    "<div class=\"movie active\" data-index=\"0\">" +
                        "<img src=\"../static/images/stills/" + obj.data[0].schedule_movie.movie_cn_name + "/" + (i+1) + ".jpg\" alt=\"\">" +
                    "</div>"
                );
            }
         
            movieInfo.append(
                "<div>" +
                    "<h3 class=\"movie-name\">"+ obj.data[0].schedule_movie.movie_cn_name +"</h3>" +
                    "<span class=\"score sc\">"+ obj.data[0].schedule_movie.movie_score +"</span>" +
                "</div>" +
                "<div class=\"movie-desc\">" +
                    "<div>" +
                        "<span class=\"key\">Length: </span>" +
                        "<span class=\"value\">"+ obj.data[0].schedule_movie.movie_duration +"</span>" +
                    "</div>" +
                    "<div>" +
                        "<span class=\"key\">Type: </span>" +
                        "<span class=\"value\">"+ obj.data[0].schedule_movie.movie_type +"</span>" +
                    "</div>" +
                    "<div>" +
                        "<span class=\"key\">Director: </span>" +
                        "<span class=\"value\">"+ obj.data[0].schedule_movie.movie_director+"</span>" +
                    "</div>" +
                "</div>"
            )
            showDate.append("<span class=\"date-item active\" data-index=\"${status.index}\">Today " + Month + "-" + (Day+i) + "</span>  ");
        }

        //初始化场次信息
        function initSchedule(obj){
            var plist = $(".plist").find("tbody");

            for(var i = 0;i < obj.data.length;i++){
                plist.append(
                    "<tr class=\"\">" +
                        "<td> <span class=\"begin-time\">"+ obj.data[i].schedule_startTime +"</span> <br> </td>" +
                        "<td> <span class=\"lang\">" + obj.data[i].schedule_movie.movie_country +"</span> </td>" +
                        "<td> <span class=\"hall\">" + obj.data[i].schedule_hall.hall_name + "</span> </td>" +
                        "<td> <span class=\"sell-price\"> <span class=\"stonefont\">" + obj.data[i].schedule_price + "</span> </span> </td>" +
                        "<td> <a href=\"./buySeat.jsp?schedule_id="+ obj.data[i].schedule_id +"\" class=\"buy-btn normal\">Purchase</a> </td>" +
                    "</tr>"   
                            );
            }
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