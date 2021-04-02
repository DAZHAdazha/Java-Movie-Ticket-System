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
    <script src="../static/js/header.js" charset="utf-8"></script>
    <script src="../static/js/Api.js"></script>

    <script src="../static/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="../static/layui/css/layui.css" media="all">
    <title>Tao Tao Movie-Main Page</title>
</head>
<body>
    <!-- ------------------------------------------------------------------- -->
    <!-- 导航栏 -->
    <jsp:include page="header.jsp"/>

    <!-- 占位符 -->
    <div style="margin-top: 100px;"></div>

    <!-- 主体 -->
    <div class="main">
        <div class="main-inner main-page">
            <div class="layui-carousel" id="test3" lay-filter="test4">
                <div carousel-item="">
                    <div>
                        <img src="../static/images/promote1.jpg">
                    </div>
                    <div>
                        <img src="../static/images/promote2.jpg">
                    </div>
                    <div>
                        <img src="../static/images/promote3.jpg">
                    </div>
                    <div>
                        <img src="../static/images/promote4.jpg">
                    </div>
                    <div>
                        <img src="../static/images/promote5.jpg">
                    </div>
                </div>
            </div>
            <div class="aside">
                <!-- 1 -->
                <div class="ranking-box-wrapper">
                    <div class="panel sidepanel">
                        <div class="panel-header">
                                    <span class="panel-title">
                                        <span class="textcolor_red">Overall box office</span>
                                    </span>
                        </div>
                        <div class="panel-content">
                            <ul class="ranking-wrapper ranking-box boxOffice">
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- 2 -->
                <div class="box-total-wrapper clearfix" style="height: 80px">

                </div>
                <!-- 3 -->
                <div class="most-expect-wrapper">
                    <div class="panel">
                        <div class="panel-header">
                                    <span class="panel-more">
                                      <a href="#" class="textcolor_orange" data-act="all-mostExpect-click">
                                        <span>Check the full list</span>
                                      </a>
                                      <span class="panel-arrow panel-arrow-orange"></span>
                                    </span>
                            <span class="panel-title">
                                      <span class="textcolor_orange">The most expected Movies</span>
                                    </span>
                        </div>
                        <div class="panel-content">
                            <ul class="ranking-wrapper ranking-mostExpect">
                                <li class="ranking-item ranking-top ranking-index-1">
                                    <a target="_blank" data-act="mostExpect-movie-click" data-val="{movieid:1229534}">
                                        <div class="ranking-top-left">
                                            <i class="ranking-top-icon"></i>
                                            <img class="ranking-img  default-img"
                                                 src="https://p0.meituan.net/movie/bb9f75599bfbb2c4cf77ad9abae1b95c1376927.jpg@140w_194h_1e_1c">
                                        </div>
                                        <div class="ranking-top-right">
                                            <div class="ranking-top-right-main">
                                                <span class="ranking-top-moive-name">Looking up</span>

                                                <p class="ranking-release-time">Release Date：2019-07-18</p>

                                                <p class="ranking-top-wish">
                                                    <span class="stonefont">634541</span> people like
                                                </p>
                                            </div>
                                        </div>
                                    </a>
                                </li>

                                <li class="ranking-item ranking-index-2">
                                    <a target="_blank" data-act="mostExpect-movie-click" data-val="{movieid:346210}">
                                        <i class="ranking-index">2</i>
                                        <span class="img-link"><img class="ranking-img default-img"
                                                                    src="https://p1.meituan.net/movie/268a41fb0de323c1edff30d308e48537234842.jpg@170w_118h_1e_1c"></span>
                                        <div class="name-link ranking-movie-name">The Eight Hundred</div>

                                        <span class="ranking-num-info"><span
                                                class="stonefont">517365</span> people like</span>
                                    </a>
                                </li>

                                <li class="ranking-item ranking-index-3">
                                    <a target="_blank" data-act="mostExpect-movie-click" data-val="{movieid:1227611}">
                                        <i class="ranking-index">3</i>
                                        <span class="img-link"><img class="ranking-img default-img"
                                                                    src="https://p0.meituan.net/movie/7aebe625a4a335ed1bf346374506c77a1018128.jpg@170w_118h_1e_1c"></span>
                                        <div class="name-link ranking-movie-name">The Last Wish</div>

                                        <span class="ranking-num-info"><span
                                                class="stonefont">392336</span> people like</span>
                                    </a>
                                </li>

                                <li class="ranking-item ranking-index-4">
                                    <a target="_blank" data-act="mostExpect-movie-click" data-val="{movieid:1215605}">
                                        <span class="normal-link">
                                          <i class="ranking-index">4</i>
                                          <span class="ranking-movie-name">Fast & Furious Presents: Hobbs & Shaw</span>

                                          <span class="ranking-num-info">
                                              <span class="stonefont">315230</span> people like
                                            </span>
                                        </span>
                                    </a>
                                </li>

                                <li class="ranking-item ranking-index-5">
                                    <a target="_blank" data-act="mostExpect-movie-click" data-val="{movieid:1197417}">
                                        <span class="normal-link">
                                          <i class="ranking-index">5</i>
                                          <span class="ranking-movie-name">Line Walker 2</span>

                                          <span class="ranking-num-info">
                                              <span class="stonefont">306130</span> people like
                                            </span>
                                        </span>
                                    </a>
                                </li>

                                <li class="ranking-item ranking-index-6">
                                    <a target="_blank" data-act="mostExpect-movie-click" data-val="{movieid:1217023}">
                                        <span class="normal-link">
                                          <i class="ranking-index">6</i>
                                          <span class="ranking-movie-name">Detective Chinatown 3</span>

                                          <span class="ranking-num-info">
                                              <span class="stonefont">137888</span> people like
                                            </span>
                                        </span>
                                    </a>
                                </li>

                                <li class="ranking-item ranking-index-7">
                                    <a target="_blank" data-act="mostExpect-movie-click" data-val="{movieid:1203134}">
                                        <span class="normal-link">
                                          <i class="ranking-index">7</i>
                                          <span class="ranking-movie-name">Mojin Returns</span>

                                          <span class="ranking-num-info">
                                              <span class="stonefont">112327</span> people like
                                            </span>
                                        </span>
                                    </a>
                                </li>

                                <li class="ranking-item ranking-index-8">
                                    <a target="_blank" data-act="mostExpect-movie-click" data-val="{movieid:342903}">
                                        <span class="normal-link">
                                          <i class="ranking-index">8</i>
                                          <span class="ranking-movie-name">Shanghai Fortress</span>

                                          <span class="ranking-num-info">
                                              <span class="stonefont">90324</span> people like
                                            </span>
                                        </span>
                                    </a>
                                </li>

                                <li class="ranking-item ranking-index-9">
                                    <a target="_blank" data-act="mostExpect-movie-click" data-val="{movieid:1250700}">
                                        <span class="normal-link">
                                          <i class="ranking-index">9</i>
                                          <span class="ranking-movie-name">The Climbers</span>

                                          <span class="ranking-num-info">
                                              <span class="stonefont">63547</span> people like
                                            </span>
                                        </span>
                                    </a>
                                </li>

                                <li class="ranking-item ranking-index-10">
                                    <a target="_blank" data-act="mostExpect-movie-click" data-val="{movieid:1207254}">
                                        <span class="normal-link">
                                          <i class="ranking-index">10</i>
                                          <span class="ranking-movie-name">Coward Hero</span>

                                          <span class="ranking-num-info">
                                              <span class="stonefont">35739</span> people like
                                            </span>
                                        </span>
                                    </a>
                                </li>

                            </ul>


                        </div>
                    </div>
                </div>
            </div>
            <div class="movie-grid">

                <div class="panel-header">
                            <span class="panel-more">
                                <a href="./movieList.jsp" class="textcolor_red" data-act="all-playingMovie-click">
                                    <span>ALL</span>
                                </a>
                                <span class="panel-arrow panel-arrow-red"></span>
                            </span>
                    <span class="panel-title hot-title">
                            </span>
                </div>
                <div class="panel-content">
                    <ul class="movie-list movie-hot">
                    </ul>
                </div>
                <div class="panel">
                            <span class="panel-more">
                                <a href="./movieList.jsp" class="textcolor_red" data-act="all-upcomingMovie-click">
                                    <span>ALL</span>
                                </a>
                                <span class="panel-arrow panel-arrow-blue"></span>
                            </span>
                    <span class="panel-title on-title">
                            </span>
                </div>
                <div class="panel-content">
                    <ul class="movie-list movie-on">
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <!-- 脚 -->
    <jsp:include page="footer.jsp"/>

    <!-- ------------------------------------------------------------------- -->
    <script>
        var clientHeight = document.documentElement.clientHeight;

        window.onload = function () {
            initHostMovie(); //初始化正在热映和即将上映电影
            //initBoxOffice(); //初始化总体票房
            initHeader();
        }

        //图片轮播
        layui.use(['carousel', 'form'], function () {
            var carousel = layui.carousel, form = layui.form;
            carousel.render({
                elem: '#test3'
                , width: '100%'
                , height: '368px'
                , interval: 5000
            });
        });

        //初始化正在热映和即将上映电影
        function initHostMovie() {
            var MoiveLiHot = $(".movie-hot");
            var MoiveLiOn = $(".movie-on");
            var htmlHot, htmlOn;
            var ListLength;
            var notice, sale;
            var HotNum = $(".hot-title");
            var OnNum = $(".on-title");
            var TempName;

            $.ajax({
                type: 'post',
                url: url + "/movie/findAllMovies",
                dataType: 'json',
                data: {},
                success: function (obj) {
                    console.log(obj);
                    HotNum.append("<span class=\"textcolor_red\">Now Showing（" + obj.data.length + " Movies）</span>");
                    if (obj.data.length < 8) {
                        ListLength = obj.data.length;
                    } else {
                        ListLength = 8;
                    }
                    for (var i = 0; i < ListLength; i++) {
                        htmlHot =
                            "<li>" +
                            "<div class=\"movie-item\">" +
                            "<a style='cursor: pointer' href=\"./movieDetail.jsp?movie_id=" + obj.data[i].movie_id + "\" data-act=\"playingMovie-click\" data-val=\"" + obj.data[i].movie_id + "\">" +
                            "<div class=\"movie-poster\" style=\"cursor:default;\">" +
                            "<img style='cursor: pointer' id=\"moive_picture\" src=\"" + obj.data[i].movie_picture + "\">" +
                            "<div class=\"movie-overlay movie-overlay-bg\">" +
                            "<div class=\"movie-info\">" +
                            "<div class=\"movie-score\"><i id=\"moive_score\" class=\"integer\">" + obj.data[i].movie_score + "</i></div>" +
                            // "<div class=\"movie-title movie-title-padding\" title=\"" + obj.data[i].movie_cn_name + "\">" + obj.data[i].movie_cn_name + "</div>" +
                            "<div class=\"movie-title movie-title-padding\" title=\"" + obj.data[i].movie_cn_name + "\">" + obj.data[i].movie_fg_name + "</div>" +
                            "</div>" +
                            "</div>" +
                            "</div>" +
                            "</a>" +
                            "<div class=\"movie-detail movie-detail-strong movie-sale\">" +
                            "<a href=\"./buyTickets.jsp?movie_id=" + obj.data[i].movie_id + "\" class=\"active\" target=\"_blank\" data-act=\"salePlayingMovie-click\" data-val=\"{movieid:42964}\">Buy Tickets</a>" +
                            "</div>" +
                            "</div>" +
                            "</li>";
                        MoiveLiHot.append(htmlHot);
                    }


                    OnNum.append("<span class=\"textcolor_blue\">Coming Soon（" + obj.data1.length + " Movies）</span>");
                    if (obj.data1.length < 8) {
                        ListLength = obj.data1.length;
                    } else {
                        ListLength = 8;
                    }
                    for (var i = 0; i < ListLength; i++) {
                        var random = Math.floor(Math.random(1, 10) * 50000);
                        htmlOn =
                            "<li>" +
                            "<div class=\"movie-item\">" +
                            "<a href=\"javascript:void(0)\" target=\"_blank\" data-act=\"playingMovie-click\" data-val=\"" + obj.data1[i].movie_id + "\">" +
                            "<div class=\"movie-poster\" style=\"cursor:default;\">" +
                            "<img id=\"moive_picture\" src=\"" + obj.data1[i].movie_picture + "\">" +
                            "<div class=\"movie-overlay movie-overlay-bg\">" +
                            "<div class=\"movie-info\">" +
                            "<div class=\"movie-score\"><i id=\"moive_score\" class=\"integer\">" + obj.data1[i].movie_score + "</i></div>" +
                            "<div class=\"movie-title movie-title-padding\" title=\"" + obj.data1[i].movie_cn_name + "\">" + obj.data1[i].movie_fg_name + "</div>" +
                            "</div>" +
                            "</div>" +
                            "</div>" +
                            "</a>" +
                            "<div class=\"movie-detail movie-wish\"><span class=\"stonefont\">" + random + "</span> people like</div>" +
                            "<div class=\"movie-detail movie-detail-strong movie-presale\">" +
                            "<a id=\"movie-notice\" class=\"movie-presale-sep movie-notice\">Trailer</a>" +
                            "<a id=\"movie-sale\" class=\"movie-presale-sep movie-sale\">Presell</a>" +
                            "</div>" +
                            "</div>" +
                            "</li>";
                        MoiveLiOn.append(htmlOn);
                    }
                    notice = $(".movie-on").find(".movie-notice");
                    sale = $(".movie-on").find(".movie-sale");
                    for (var i = 0; i < ListLength; i++) {
                        notice[i].index = i;
                        notice[i].onclick = function () {
                            layer.alert('‘' + obj.data1[this.index].movie_cn_name + '’电影暂未有预告片！', {
                                icon: 0,
                                offset: clientHeight / 7
                            });
                        }
                        sale[i].index = i;
                        sale[i].onclick = function () {
                            layer.alert('预售‘' + obj.data1[this.index].movie_cn_name + '’电影成功！', {
                                icon: 0,
                                offset: clientHeight / 7
                            });
                        }
                    }
                    initBoxOffice(obj);
                }
            });
        }

        //初始化总体票房
        function initBoxOffice(obj) {
            console.log(obj);
            var TempLength;
            if (obj.sort.length > 9) {
                TempLength = 9;
            } else {
                TempLength = obj.sort.length;
            }
            var BoxOffice = $(".boxOffice");
            for (var i = 0; i < TempLength; i++) {
                if (i == 0) {
                    BoxOffice.append(
                        "<li class=\"ranking-item ranking-top ranking-index-1\">" +
                        "<a href=\"./movieDetail.jsp?movie_id=" + obj.sort[i].movie_id + "\" target=\"_blank\">" +
                        "<div class=\"ranking-top-left\">" +
                        "<i class=\"ranking-top-icon\"></i>" +
                        "<img class=\"ranking-imgs  default-img\" src=\"" + obj.sort[i].movie_picture + "\">" +
                        "</div>" +
                        "<div class=\"ranking-top-right\">" +
                        "<div class=\"ranking-top-right-main\">" +
                        "<span class=\"ranking-top-moive-name\">" + obj.sort[i].movie_cn_name + "</span>" +
                        "<p class=\"ranking-top-wish\">" +
                        "<span class=\"stonefont\">" + obj.sort[i].movie_boxOffice + "</span>K Million" +
                        "</p>" +
                        "</div>" +
                        "</div>" +
                        "</a>" +
                        "</li>"
                    );

                } else {
                    BoxOffice.append(
                        "<li class=\"ranking-item ranking-index-4\">" +
                        "<a href=\"./movieDetail.jsp?movie_id=" + obj.sort[i].movie_id + "\" target=\"_blank\">" +
                        "<span class=\"normal-link\">" +
                        "<i class=\"ranking-index ranking-index-" + (i + 1) + "\">" + (i + 1) + "</i>" +
                        "<span class=\"ranking-movie-name\">" + obj.sort[i].movie_cn_name + "</span>" +
                        "<span class=\"ranking-num-info\">" +
                        "<span class=\"stonefont\">" + obj.sort[i].movie_boxOffice + "</span>K Million" +
                        "</span>" +
                        "</span>" +
                        "</a>" +
                        "</li>"
                    );
                }
            }
        }


    </script>
<!-- ------------------------------------------------------------------- -->
</body>
</html>