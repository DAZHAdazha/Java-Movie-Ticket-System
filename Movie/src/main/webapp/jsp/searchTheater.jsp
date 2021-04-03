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
    <title>Tao Tao Search Page</title>
</head>
<body>
    <!-- ------------------------------------------------------------------- -->
    <!-- 导航栏 -->
    <jsp:include page="header2.jsp"/>

    <!-- 占位符 -->
    <div style="margin-top: 100px;"></div>

    <!-- 主体 -->
    <div class="main">
        <div  class="main-inner main-page">
            <div class="movie-grid2">

                <div class="panel-header">
                            <span class="panel-more">

                            </span>
                    <span class="panel-title hot-title">
                            </span>
                </div>
                <div class="panel-content">
                    <ul class="movie-list movie-hot">
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
            initHeader();
        }


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



            var obj = ${ searchObj };

            console.log(obj);

            if(obj.data.length==0){
                HotNum.append("<h2 style='color: red'> Sorry, no movies matching! </h2>")
            }
                    HotNum.append("<span class=\"textcolor_red\">Now Showing（" + obj.data.length + " Theaters）</span>");
                    ListLength = obj.data.length;
                    for (var i = 0; i < ListLength; i++) {
                        htmlHot =
                            "<li>" +
                            "<div class=\"movie-item\">" +
                            "<a style='cursor: pointer' href=\"../jsp/movieDetail.jsp?movie_id=" + obj.data[i].movie_id + "\" data-act=\"playingMovie-click\" data-val=\"" + obj.data[i].movie_id + "\">" +
                            "<div class=\"movie-poster\" style=\"cursor:default;\">" +
                            "<img style='cursor: pointer' id=\"moive_picture\" src=\"" + "../static/images/cinemas/" + obj.data[i].cinema_name + ".jpg\">" +
                            "<div class=\"movie-overlay movie-overlay-bg\">" +
                            "</div>" +
                            "</div>" +
                            "</a>" +
                            "<div>"
                            + obj.data[i].cinema_name
                            + "</div>"
                            "</div>" +
                            "</li>";
                        MoiveLiHot.append(htmlHot);
                    }

        }



    </script>
<!-- ------------------------------------------------------------------- -->
</body>
</html>