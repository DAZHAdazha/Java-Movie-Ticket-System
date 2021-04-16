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
            if(cookie.getName().equals("user")) {
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
<html>
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
    <link rel="stylesheet" type="text/css" href="../static/css/manage.css">
    <link rel="stylesheet" type="text/css" href="../static/css/footer.css">
    <script src="../static/js/header.js" charset="utf-8"></script>
    <script src="../static/js/echarts.js"></script>
    <script src="../static/js/Api.js"></script>
    <script src="../static/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="../static/layui/css/layui.css" media="all">
    <title>Tao Tao Movie-Management</title>
</head>
<body>
    <!-- ------------------------------------------------------------------- -->
    <!-- 导航栏 -->
    <jsp:include page="header.jsp"/>

    <!-- 占位符 -->
    <div style="margin-top: 110px;"></div>

    <!-- 主体 -->
    <div class="container">
        <div class="contents">
            <div class="nav-next">
                <div class="nav-title">
                    <h3>Management</h3>
                </div>
                <a class="cardId">User Managment</a>
                <a class="cardId">Movie Managment</a>
                <a class="cardId">Time Management</a>
                <a class="cardId">Comment Management</a>
                <a class="cardId">Order Management</a>
                <a class="cardId">Ticket Office Statistics</a>
            </div>
            <div class="nav-body">
                <!-- 用户管理 -->
                <div class="one card" style="display: block;">
                    <div>
                        <div class="title">User Management</div>
                        <hr/>
                    </div>
                    <!-- 用户列表 -->
                    <div class="userlist">
                        <table class="layui-hide" id="user_table_id" lay-filter="UserTable" style="margin-right: 5%;"></table>
                    </div>
                </div>
                <!-- 电影管理 -->
                <div class="two card" style="display: none;">
                    <div>
                        <div class="title">Movie Managment</div>
                        <hr/>
                    </div>
                    <div class="main-inner">
                        <div class="addMovie">
                            <img alt="" src="../static/images/addMovie.png" onclick="addConfirm(-1)">
                            <span>Add Movie</span>
                        </div>
                        <div class="movie-grid">
                            <div class="panel-header">
                                <span class="panel-title">
                                </span>
                            </div>
                            <div class="panel-content">
                                <ul class="movies-list">
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 场次管理 -->
                <div class="three card" style="display: none;">
                    <div>
                        <div class="title">Launch Time Management</div>
                        <hr/>
                    </div>
                    <!-- 场次列表 -->
                    <div class="schedulelist">
                        <table class="layui-hide" id="schedule_table_id" lay-filter="ScheduleTable" style="margin-right: 5%;"></table>
                    </div>
                </div>
                <!-- 评论管理 -->
                <div class="four card" style="display: none;">
                    <div>
                        <div class="title">Comment Management</div>
                        <hr/>
                    </div>
                    <!-- 评论列表 -->
                    <div class="commentlist">
                        <table class="layui-hide" id="comment_table_id" lay-filter="CommentTable" style="margin-right: 5%;"></table>
                    </div>
                </div>
                <!-- 订单管理 -->
                <div class="five card" style="display: none;">
                    <div>
                        <div class="title">Order Management</div>
                        <hr/>
                    </div>
                    <!-- 订单列表 -->
                    <div class="ticketlist">
                        <table class="layui-hide" id="ticket_table_id" lay-filter="TicketTable" style="margin-right: 5%;"></table>
                    </div>
                </div>
                <!-- 票房统计 -->
                <div class="six card" style="display: none;">
                    <div>
                        <div class="title">Ticket Office Statistics</div>
                        <hr/>
                    </div>
                    <div id="aaa"></div>
                </div>
            </div>
        </div>
    </div>

    <!-- 脚 -->
    <jsp:include page="footer.jsp"/>

    <!-- ------------------------------------------------------------------- -->

    <!--     用户管理      -->
    <script type="text/html" id="userbar">
        <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">Details</a>
        <a class="layui-btn layui-btn-xs" lay-event="edit">Save</a>
    </script>
    <script type="text/html" id="usertoolbar">
<%--        <div class="layui-btn-container adduserbtn">--%>
<%--            <button class="layui-btn layui-btn-warm layui-btn-sm" lay-event="useradd">Add User</button>--%>
<%--        </div>--%>
        <div class="usercheck">
            <input id="userfindtext" type="text" name="title" lay-verify="title" autocomplete="off" placeholder="Please Enter Username" class="layui-input">
            <button class="layui-btn layui-btn-sm" lay-event="finduserbtn">Search</button>
        </div>
    </script>

    <!--     场次管理      -->
    <script type="text/html" id="schedulebar">
        <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">Details</a>
        <a class="layui-btn layui-btn-xs" lay-event="edit">Drop off</a>
    </script>
    <script type="text/html" id="scheduletoolbar">
        <div class="layui-btn-container addbtn">
            <button class="layui-btn layui-btn-warm layui-btn-sm" lay-event="scheduleadd">Add</button>
        </div>
        <div class="schedulecheck">
            <input id="scheduletext" type="text" name="title" lay-verify="title" autocomplete="off" placeholder="Please Enter Movie Name" class="layui-input">
            <button class="layui-btn layui-btn-sm" lay-event="findschedulebtn">Search</button>
        </div>
        <div class="scheduleonall">
            <button class="layui-btn layui-btn-sm" lay-event="scheduleonallbtn">Show All</button>
        </div>
        <div class="scheduledownall">
            <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="scheduledownallbtn">Show Drop Off</button>
        </div>
    </script>
    <script type="text/html" id="scheduledownbar">
        <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">Details</a>
    </script>

    <!--     评论管理      -->
    <script type="text/html" id="commentbar">
        <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">Details</a>
        <a class="layui-btn layui-btn-xs" lay-event="edit">Save</a>
        <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete">Delete</a>
    </script>
    <script type="text/html" id="commenttoolbar">
        <div class="commentcheck">
            <input id="commentfindtext" type="text" name="title" lay-verify="title" autocomplete="off" placeholder="Please Enter Username" class="layui-input">
            <button class="layui-btn layui-btn-sm" lay-event="findcommentbtn">Search</button>
        </div>
        <div class="commentall">
            <button class="layui-btn layui-btn-sm" lay-event="findcommentall">Show All</button>
        </div>
    </script>

    <!--     订单管理      -->
    <script type="text/html" id="ticketbar">
        <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">Details</a>
    </script>
    <script type="text/html" id="tickettoolbar">
        <div class="ticketcheck">
            <input type="button" class="layui-btn-primary layui-btn-sm changeticketBtn" style="width:70px;" lay-event="changeticketbtn" value="用户帐号">
            <input id="ticketfindtext" type="text" name="title" lay-verify="title" autocomplete="off" placeholder="Please Enter Username" class="layui-input">
            <button class="layui-btn layui-btn-sm" lay-event="findticketbtn">Search</button>
        </div>
        <div class="orderall">
            <button class="layui-btn layui-btn-sm" lay-event="findorderall">Show All</button>
        </div>
        <div class="backorder">
            <button class="layui-btn layui-btn-sm layui-btn-normal changeorderBtn" lay-event="backorderbtn">Refund Request</button>
        </div>
    </script>
    <script type="text/html" id="backticketbar">
        <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">Details</a>
        <a class="layui-btn layui-btn-xs" lay-event="pass">Pass</a>
    </script>

    

    <script>
        var clientHeight = document.documentElement.clientHeight;
        var AddUserHtml;
        var MoviesListHtml;
        var addScheduleContent;
        var AddMoviesHtml;
        var ActorNum = 1;
        var temp, flag;
        var changeticketbtn1 = $('.changeticketBtn');
        var selectmovieName;
        var movieArr = [];
        var cinemaArr = [];
        var cinemaJsonArr = [];
        var boxOffice = []; //票房数组
        var movieArray = []; //电影数组
        var movieType = []; //电影类型数组
        var movieTypeBoxOffice = []; //电影类型票房数组
        var type = [];
        window.onload = function(){
            initHeader();
            initHtml(); //初始化html
            initCard(); //选项卡
            initUser(); //用户界面
            initMovies(); //电影界面
            initSchedule(); //场次界面
            initComment(); //评论界面
            initTicket();  //订单界面
            initBoxOffice();//票房统计
        }

        //选项卡
        function initCard(){
            var aArr = $(".nav-next").find(".cardId");
            var divArr = $(".nav-body").find(".card");
            if(localStorage.getItem("cardId")==null){
                localStorage.setItem("cardId",0);
            }
            for(var i=0; i<aArr.length; i++){
                aArr[i].index = i;
                aArr[i].onclick = function(){
                    localStorage.setItem("cardId",this.index);
                    for(var j=0;j<divArr.length;j++){
                        divArr[j].style.display = "none";
                        aArr[j].style.cssText = "background-color: #f4f3f4; color: #333;";
                    }
                    divArr[this.index].style.display = "block";
                    aArr[this.index].style.cssText = "background-color: #ed3931; color: #fff;";
                }
            }
            for(var p=0;p<aArr.length;p++){
                divArr[p].style.display = "none";
                aArr[p].style.cssText = "background-color: #f4f3f4; color: #333;";
                if(localStorage.getItem("cardId",this.index)==p){
                    divArr[p].style.display = "block";
                    aArr[p].style.cssText = "background-color: #ed3931; color: #fff;";
                }
            }
        }
        //初始化html
        function initHtml(){
            AddUserHtml =
            "<h3 class=\"addusertitle\">User Information</h3>" +
            "<div class=\"layui-form-item\">" +
                "<label class=\"layui-form-label\">Username</label>" +
                "<div class=\"layui-input-block addusertext\">" +
                    "<input id=\"user_name\" type=\"text\" name=\"title\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"username\" class=\"layui-input\">" +
                "</div>" +
            "</div>" +
            "<div class=\"layui-form-item\">" +
                "<label class=\"layui-form-label\">Password</label>" +
                "<div class=\"layui-input-block addusertext\">" +
                    "<input id=\"user_pwd\" type=\"text\" name=\"title\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"password\" class=\"layui-input\">" +
                "</div>" +
            "</div>" +
            "<div class=\"layui-form-item\">" +
                "<label class=\"layui-form-label\">Email</label>" +
                "<div class=\"layui-input-block addusertext\">" +
                    "<input id=\"user_email\" type=\"text\" name=\"title\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"email\" class=\"layui-input\">" +
                "</div>" +
            "</div>";

            AddMoviesHtml =
            "<h3 class=\"addusertitle\">Movie information</h3>" +
            "<div class=\"textside\">" +
                "<div class=\"layui-form-item\">" +
                    "<label class=\"layui-form-label\">Movie Name</label>" +
                    "<div class=\"layui-input-block addusertext\">" +
                        "<input id=\"movie_cn_name\" type=\"text\" name=\"title\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"MovieCnName\" class=\"layui-input\">" +
                    "</div>" +
                "</div>" +
                "<div class=\"layui-form-item\">" +
                    "<label class=\"layui-form-label\">Movie English Name</label>" +
                    "<div class=\"layui-input-block addusertext\">" +
                        "<input id=\"movie_fg_name\" type=\"text\" name=\"title\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"MovieFgName\" class=\"layui-input\">" +
                    "</div>" +
                "</div>" +
                "<div class=\"layui-form-item\">" +
                    "<label class=\"layui-form-label\">Director</label>" +
                    "<div class=\"layui-input-block addusertext\">" +
                        "<input id=\"movie_director\" type=\"text\" name=\"title\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"MovieDirector\" class=\"layui-input\">" +
                    "</div>" +
                "</div>" +
                "<div class=\"layui-form-item\">" +
                    "<label class=\"layui-form-label\" style=\"display:inline-block;\">Actors/Actrsses</label>" +
                    "<div class=\"layui-input-block addusertext\" style=\"display:inline-block; margin-left: 10px !important; width: 118px;\">" +
                        "<input id=\"movie_actor1\" type=\"text\" name=\"title\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"MovieActor1\" class=\"layui-input\">" +
                    "</div>" +
                    "<span style=\"margin-left:10px\">Play Role As</span>" +
                    "<div class=\"layui-input-block addusertext\" style=\"display:inline-block; margin-left: 10px !important; width: 118px;\">" +
                        "<input id=\"movie_role1\" type=\"text\" name=\"title\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"MovieRole1\" class=\"layui-input\">" +
                    "</div>" +
                    "<button type=\"button\" class=\"layui-btn layui-btn-xs\" onclick=\"addActor()\">+</button>" +
                    "<button type=\"button\" class=\"layui-btn layui-btn-xs\" onclick=\"deleteActor()\">-</button>" +
                "</div>" +
                "<div class=\"layui-form-item temp\">" +
                    "<label class=\"layui-form-label\">Movie Details</label>" +
                    "<div class=\"layui-input-block addusertext\">" +
                        "<textarea id=\"movie_detail\" placeholder=\"MovieDetail\" class=\"layui-textarea\"></textarea>" +
                    "</div>" +
                "</div>" +
                "<div class=\"layui-form-item\">" +
                    "<label class=\"layui-form-label\">Movie Length</label>" +
                    "<div class=\"layui-input-block addusertext\">" +
                        "<input id=\"movie_duration\" type=\"text\" name=\"title\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"MovieDuration\" class=\"layui-input\">" +
                    "</div>" +
                "</div>" +
                "<div class=\"layui-form-item\">" +
                    "<label class=\"layui-form-label\">Movie Type</label>" +
                    "<div class=\"layui-input-block addusertext\">" +
                        "<input id=\"movie_type\" type=\"text\" name=\"title\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"MovieType\" class=\"layui-input\">" +
                    "</div>" +
                "</div>" +
                "<div class=\"layui-form-item\">" +
                    "<label class=\"layui-form-label\">Launch Time</label>" +
                    "<div class=\"layui-input-block addusertext\">" +
                        "<input id=\"movie_releaseDate\" type=\"text\" name=\"title\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"MovieReleaseDate\" class=\"layui-input\">" +
                    "</div>" +
                "</div>" +
                "<div class=\"layui-form-item\">" +
                    "<label class=\"layui-form-label\">District</label>" +
                    "<div class=\"layui-input-block addusertext\">" +
                        "<input id=\"movie_country\" type=\"text\" name=\"title\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"MovieCountry\" class=\"layui-input\">" +
                    "</div>" +
                "</div>" +
            "</div>" +
            "<div class=\"pictureside\">" +
                "<div class=\"layui-upload\">" +
                    "<p class=\"movie-picture\">Movie Poster</p>" +
                    "<div class=\"layui-upload-list\">" +
                        "<img class=\"layui-upload-img\" id=\"demo1\">" +
                        "<p id=\"demoText\"></p>" +
                    "</div>" +
                    "<a href=\"javascript:;\" class=\"file\">Choose File" +
                        "<input type=\"file\" name=\"file\" id=\"file\">" +
                    "</a>" +
                "</div>" +
            "</div>";


            addScheduleContent =
            "<h3 class=\"addtitle\">Film Launch Time Information</h3>" +
            "<div class=\"layui-form-item schedule-div aaaaaaa\">" +
                "<label class=\"scheduleLabel\">Movie</label>" +
                "<div class=\"layui-form layui-input-inline addselect drop-cinema\" lay-filter=\"selectMovie\">" + 
                    "<select id=\"select_movie_name\" name=\"modules\" lay-verify=\"required\" lay-search=\"\">" +
                        "<option>Choose Movie</option>" +
                    "</select>" +
                "</div>" +
            "</div>" +
            "<div class=\"layui-form-item schedule-div\">" +
                "<label class=\"scheduleLabel\">Theater</label>" +
                "<div class=\"layui-form layui-input-inline addselect drop-cinema\">" + 
                    "<select id=\"select_cinema_name\" name=\"modules\" lay-verify=\"required\" lay-search=\"\" lay-filter=\"selectCinema\">" +
                        "<option >Choose Theater</option>" +
                    "</select>" +
                "</div>" +
            "</div>" +
            "<div class=\"layui-form-item schedule-div\">" +
                "<label class=\"scheduleLabel\">Hall</label>" +
                "<div class=\"layui-form layui-input-inline addselect drop-hall\" lay-filter=\"select\">" + 
                    "<select id=\"select_schedule_hall\" name=\"modules\" lay-verify=\"required\" lay-search=\"\">" +
                        "<option>Choose Hall</option>" +
                    "</select>" +
                "</div>" +
            "</div>" +
            "<div class=\"layui-form-item schedule-div\">" +
                "<label class=\"scheduleLabel\">Launch Time </label>" +
                "<div class=\"layui-input-inline addselect\">" +
                    "<input type=\"text\" class=\"layui-input\" id=\"schedule_startTime_Text\" placeholder=\"yyyy-MM-dd HH:mm\">" +
                "</div>" +
            "</div>" +
            "<div class=\"layui-form-item schedule-div\">" +
                "<label class=\"scheduleLabel\">Price</label>" +
                "<div class=\"layui-input-inline addselect\">" +
                    "<input id=\"schedule_price_Text\" type=\"text\" name=\"title\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"money\" class=\"layui-input\">" +
                "</div>" +
            "</div>";
        }

        //初始化用户管理界面
        function initUser(){
            var actionUrl = "";
            //用户列表
            layui.use(['laypage', 'layer', 'table'], function(){
                var laypage = layui.laypage;
                var layer = layui.layer;
                var table = layui.table;
                table.render({
                    elem: '#user_table_id'
                    ,url: url + '/user/findAllUser'
                    ,method: 'post'
                    ,toolbar: '#usertoolbar'
                    ,title: 'User list'
                    ,cols: [[
                        {field:'user_id', title:'User ID', width:102, unresize: true, sort: true}
                        ,{field:'user_name', title:'Username', width:270, unresize: true,sort: true}
                        ,{field:'user_pwd', title:'Password', width:270, unresize: true, edit: "text"}
                        ,{field:'user_email', title:'Email', width:270, unresize: true, sort: true, edit: "text"}
                        ,{title:'Command', width:300, unresize: true, align:'center', toolbar: '#userbar'}
                    ]]
                    ,page: {layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                        ,curr: 1 //设定初始在第 1 页
                        ,groups: 5 //只显示 5 个连续页码
                        ,first: false //显示首页
                        ,last: false //显示尾页
                        ,limits: [10,15,20]
                    }
                    ,response: {
                        statusCode: 0 //重新规定成功的状态码为 200，table 组件默认为 0
                    }
                    ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                        return {
                            "code": res.code, //解析接口状态
                            "msg": res.msg, //解析提示文本
                            "count": res.count, //解析数据长度
                            "data": res.data //解析数据列表
                        };
                    }
                });
                //监听工具条
                table.on('tool(UserTable)', function(obj){
                    var data = obj.data;
                    if(obj.event === 'detail'){
                        layer.msg('ID：'+ data.user_id + '</br>Username：'+ data.user_name + '</br>Password：'+ data.user_pwd  + '</br>邮箱：'+ data.user_email, {offset: clientHeight/4,area: '300px;'});
                    }
                    else if(obj.event === 'edit'){
                        layer.alert('Are you sure to change the ID“'+ JSON.stringify(data.user_id) + '” and save?',{icon: 0,offset: clientHeight/5},
                            function () {
                                $.ajax({
                                    type:'post',
                                    url: url + "/user/updateUser",
                                    dataType:'json',
                                    data: {
                                        user_id: data.user_id,
                                        user_name: data.user_name,
                                        user_pwd: data.user_pwd,
                                        user_email: data.user_email,
                                    },
                                    success:function (date) {
                                        if(date == "success"){
                                            layer.alert('Change successfully!',{icon: 0,offset: clientHeight/5},
                                                function (){
                                                    layer.closeAll();
                                                    location.reload();
                                                }
                                            );
                                        }else{
                                            layer.alert('Username is already existed, please try a different name!',{icon: 0,offset: clientHeight/5},
                                                function (){
                                                    layer.closeAll();
                                                }
                                            );
                                        }
                                    }
                                });
                            }
                        );
                    }
                });
                //监听头工具条
                table.on('toolbar(UserTable)', function(obj){
                    var checkStatus = table.checkStatus(obj.config.id);
                    switch(obj.event){
                        // case 'useradd':
                        //     //添加用户
                        //     layer.open({
                        //         type: 1
                        //         ,title: "Add User" //不显示标题栏
                        //         ,closeBtn: false
                        //         ,area: '400px;'
                        //         ,shade: 0.8
                        //         ,offset: clientHeight/5
                        //         ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
                        //         ,btn: ['Add', 'Cancel']
                        //         ,yes: function(){
                        //             var user_name = $('#user_name').val(),
                        //                 user_pwd = $('#user_pwd').val()
                        //                 user_email = $('#user_email').val();
                        //             if((user_name == "") || (user_pwd == "") || (user_email == "")){
                        //                 layer.alert('Add information cannot be null, add failed!',{icon: 0,offset: clientHeight/5},
                        //                     function (){
                        //                         layer.close(layer.index);
                        //                     }
                        //                 );
                        //             }
                        //             else{
                        //                 $.ajax({
                        //                     type:'post',
                        //                     url: url + "/user/register",
                        //                     dataType:'json',
                        //                     data: {
                        //                         user_name: user_name,
                        //                         user_pwd: user_pwd,
                        //                         user_email: user_email,
                        //                     },
                        //                     success:function (date) {
                        //                         if(date == "success"){
                        //                             layer.alert('Add successfully!',{icon: 0,offset: clientHeight/5},
                        //                                 function (){
                        //                                     layer.closeAll();
                        //                                     location.reload();
                        //                                 }
                        //                             );
                        //                         }else{
                        //                             layer.alert('Username is already existed, please try a different name!',{icon: 0,offset: clientHeight/5},
                        //                                 function (){
                        //                                     layer.closeAll();
                        //                                 }
                        //                             );
                        //                         }
                        //                     }
                        //                 });
                        //             }
                        //
                        //         }
                        //         ,btnAlign: 'c'
                        //         ,moveType: 0 //拖拽模式，0或者1
                        //         ,content: AddUserHtml
                        //         ,success: function(layero){
                        //             var btn = layero.find('.layui-layer-btn');
                        //             btn.find('.layui-layer-btn0').attr({
                        //             });
                        //         }
                        //     });
                        // break;
                        case 'finduserbtn':
                            var user_name = $('#userfindtext').val();
                            table.reload('user_table_id', {
                                url: url + '/user/findUserInfosByName'
                                ,method: "POST"
                                ,where: {
                                    user_name: user_name
                                }
                                ,page: {
                                    curr: 1 //重新从第 1 页开始
                                }
                            });
                        break;
                            
                    };
                });
            });
        }

        //初始化电影管理界面
        function initMovies(){
            var MoviesNum = $(".two").find(".panel-title");
            var MovieLi =  $(".two").find(".movies-list");

            $.ajax({
                type:'post',
                url: url + "/movie/findAllMovies",
                dataType:'json',
                data: {},
                success:function (obj) {
                    console.log(obj);
                    MoviesNum.append("<span class=\"textcolor_red\">Now all " + obj.data.length + "films</span>");
                    for(var i=0;i<obj.data.length;i++){
                        MoviesListHtml =
                        "<li>" +
                            "<div class=\"movie-item\">" +
                                "<a href=\"javascript:void(0)\" target=\"_blank\" data-act=\"playingMovie-click\" data-val=\""+ obj.data[i].movie_id +"\">" +
                                    "<div class=\"movie-poster\">" +
                                        "<img src=\""+ obj.data[i].movie_picture +"\" onclick=\"movieDetail("+obj.data[i].movie_id+")\">" +
                                        "<div class=\"movie-overlay movie-overlay-bg\">" +
                                            "<div class=\"movie-info\">" +
                                                "<div class=\"movie-score\"><i class=\"integer\">"+ obj.data[i].movie_score +"</i></div>" +
                                                "<div class=\"movie-title movie-title-padding\" title=\"\">"+ obj.data[i].movie_cn_name +"</div>\"" +
                                            "</div>" +
                                        "</div>" +
                                    "</div>" +
                                "</a>" +
                                "<div class=\"moive-btn\">" +
                                    "<div class=\"movies-detail movie-detail-strong movie-sale\">" +
                                        "<a class=\"active\" onclick=\"addConfirm("+ obj.data[i].movie_id +")\" target=\"_blank\" data-act=\"salePlayingMovie-click\" data-val=\"\">Modifiy</a>" +
                                    "</div>" +
                                    "<div class=\"movies-detail movie-detail-strong movie-sale\">" +
                                        "<span id=\"deleteId\" style=\"display:none;\">${u.id}</span>" +
                                        "<a class=\"active\" onclick=\"deleteConfirm("+ obj.data[i].movie_id +")\" data-act=\"salePlayingMovie-click\" id=\"delete\">Drop Off</a>" +
                                    "</div>" +
                                "</div>" +
                            "</div>" +
                        "</li>";
                        MovieLi.append(MoviesListHtml);
                    }
                }
            });


        }
        function movieDetail(movie_id){
            window.open("./movieDetail.jsp?movie_id=" + movie_id);
        }
        //电影添加&修改点击事件
        function addConfirm(movie_id){
            var file;
            var formData = new FormData();
            var tempurl;
            //添加电影
            if(movie_id == -1){
                tempurl = "/movie/addMovie";
                temp = "Add";
                flag = 0;
            }
            //修改电影
            else{
                tempurl = "/movie/updateMovie";
                temp = "Change";
                flag = 1;
            }
            layui.use(['laypage', 'layer', 'table'], function(){
                var laypage = layui.laypage;
                var layer = layui.layer;
                var table = layui.table
                //电影添加
                layer.open({
                    type: 1
                    ,title: temp + "Movie" //不显示标题栏
                    ,closeBtn: false
                    ,area: '750px;'
                    ,shade: 0.8
                    ,offset: clientHeight/20
                    ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
                    ,btn: ['Conform' + temp, 'Cancel']
                    ,yes: function(){
                        var movie_cn_name = $('#movie_cn_name').val(),
                            movie_fg_name = $('#movie_fg_name').val(),
                            movie_director = $('#movie_director').val(),
                            movie_actor = "",
                            movie_detail = $('#movie_detail').val(),
                            movie_duration = $('#movie_duration').val(),
                            movie_type = $('#movie_type').val(),
                            movie_releaseDate = $('#movie_releaseDate').val(),
                            movie_country = $('#movie_country').val();
                        for(var i = 1;i<(ActorNum+1);i++){
                            movie_actor += $("#movie_actor" + i).val() + ":";
                            if(i==ActorNum){
                                movie_actor += $("#movie_role" + i).val();
                            }
                            else{
                                movie_actor += $("#movie_role" + i).val() + ",";
                            }
                        }
                        if((movie_cn_name == "") || (movie_director == "") || (movie_actor == "") ||
                            (movie_detail == "") || (movie_duration == "") || (movie_type == "") || 
                            (movie_fg_name == "") || (movie_releaseDate == "") || (movie_country == "")){
                            layer.alert(temp + 'Information cannot be null,' + temp + 'failed!',{icon: 0,offset: clientHeight/5},
                                function (){
                                    layer.close(layer.index);
                                }
                            );
                        }
                        //添加
                        if(flag == 0){
                            if(file == null){
                                layer.alert('Image cannot be null,' + temp + 'failed!',{icon: 0,offset: clientHeight/5},
                                    function (){
                                        layer.close(layer.index);
                                    }
                                );
                            }else{
                                formData.append("movie_cn_name",movie_cn_name);
                                formData.append("movie_fg_name",movie_fg_name);
                                formData.append("movie_director",movie_director);
                                formData.append("movie_actor",movie_actor);
                                formData.append("movie_detail",movie_detail);
                                formData.append("movie_duration",movie_duration);
                                formData.append("movie_type",movie_type);
                                formData.append("movie_releaseDate",movie_releaseDate);
                                formData.append("movie_country",movie_country);
                                formData.append("file",file);
                                $.ajax({
                                    type:'post',
                                    url: url + tempurl,
                                    data: formData,
                                    processData: false,
                                    contentType: false,
                                    success:function (result) {
                                        var obj = eval('(' + result + ')');
                                        if(obj.code == 0){
                                            layer.alert(temp + 'Success!',{icon: 0,offset: clientHeight/5},
                                                function (){
                                                    layer.closeAll();
                                                    location.reload();
                                                }
                                            );
                                        }else{
                                            layer.alert(temp + 'Fail!',{icon: 0,offset: clientHeight/5},
                                                function (){
                                                    layer.closeAll();
                                                }
                                            );
                                        }
                                    }
                                });
                            }
                           // 修改电影
                        } else{
                            if(file != null){
                                formData.append("file",file);
                            }
                            formData.append("movie_cn_name",movie_cn_name);
                            formData.append("movie_fg_name",movie_fg_name);
                            formData.append("movie_director",movie_director);
                            formData.append("movie_actor",movie_actor);
                            formData.append("movie_detail",movie_detail);
                            formData.append("movie_duration",movie_duration);
                            formData.append("movie_type",movie_type);
                            formData.append("movie_releaseDate",movie_releaseDate);
                            formData.append("movie_country",movie_country);
                            formData.append("movie_id",movie_id);
                            $.ajax({
                                type:'post',
                                url: url + tempurl,
                                data: formData,
                                processData: false,
                                contentType: false,
                                success:function (result) {
                                    var obj = eval('(' + result + ')');
                                    if(obj.code == 0){
                                        layer.alert(temp + 'Success!',{icon: 0,offset: clientHeight/5},
                                            function (){
                                                layer.closeAll();
                                                location.reload();
                                            }
                                        );
                                    }else{
                                        layer.alert(temp + 'Fail!',{icon: 0,offset: clientHeight/5},
                                            function (){
                                                layer.closeAll();
                                            }
                                        );
                                    }
                                }
                            });
                        }
                    }
                    ,btnAlign: 'c movie-last'
                    ,moveType: 0 //拖拽模式，0或者1
                    ,content: AddMoviesHtml
                    ,success: function(layero){
                        if(flag == 1){
                            var TextSide = $(".textside").find(".temp");
                            var StrActor,StrRole;            
                            $.ajax({
                                type:'post',
                                url: url + "/movie/findMovieById",
                                dataType:'json',
                                data: {
                                    movie_id: movie_id
                                },
                                success:function (obj) {
                                    $('#movie_cn_name').val(obj.data.movie_cn_name);
                                    $('#movie_director').val(obj.data.movie_director);
                                    ActorTemp = obj.data.movie_actor;
                                    $('#movie_detail').val(obj.data.movie_detail);
                                    $('#movie_duration').val(obj.data.movie_duration);
                                    $('#movie_type').val(obj.data.movie_type);
                                    $('#movie_fg_name').val(obj.data.movie_fg_name);
                                    $('#movie_releaseDate').val(obj.data.releaseDate);
                                    $('#movie_country').val(obj.data.movie_country);
                                    $('#demo1').attr('src', obj.data.movie_picture);

                                    StrActor = ActorTemp.split(',');
                                    $('#movie_actor1').val(StrActor[0].split(':')[0]);
                                    $('#movie_role1').val(StrActor[0].split(':')[1]);
                                    for(var i = 1;i<StrActor.length;i++){
                                        StrRole = StrActor[i].split(':');
                                        TextSide.before(
                                            "<div class=\"layui-form-item\">" +
                                                "<label class=\"layui-form-label\" style=\"display:inline-block;\">Actors/Actress:" + (i+1) + "</label>" +
                                                "<div class=\"layui-input-block addusertext actor\" style=\"display:inline-block; margin-left: 10px !important; width: 118px;\">" +
                                                    "<input id=\"movie_actor" + (i+1) + "\" type=\"text\" name=\"title\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"MovieActor" + (i+1) + "\" class=\"layui-input\">" +
                                                "</div>" +
                                                "<span style=\"margin-left:10px\">Play Role As</span>" +
                                                "<div class=\"layui-input-block addusertext\" style=\"display:inline-block; margin-left: 10px !important; width: 118px;\">" +
                                                    "<input id=\"movie_role" + (i+1) + "\" type=\"text\" name=\"title\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"MovieRole" + (i+1) + "\" class=\"layui-input\">" +
                                                "</div>" +
                                            "</div>"
                                        );
                                        $('#movie_actor'+(i+1)).val(StrRole[0]);
                                        $('#movie_role'+(i+1)).val(StrRole[1]);
                                    }
                                    ActorNum = StrActor.length;
                                }
                            });
                        }
                        else{
                            ActorNum = 1;
                        }
                        //图片上传
                        layui.use('upload', function(){
                            var $ = layui.jquery
                            ,upload = layui.upload;         
                            //普通图片上传
                            var uploadInst = upload.render({
                                elem: '#file'
                                ,auto: false
                                , choose: function (obj) {
                                    //预读本地文件
                                    obj.preview(function (index, file, result) {
                                        $('#demo1').attr('src', result); //图片链接（base64）
                                    })
                                    file = $('#file')[0].files[0];
                                }
                            });
                        });
                    }
                });
            });
        }
        //电影下架点击事件
        function deleteConfirm(movie_id){
            console.log(movie_id);
            layui.use(['layer'], function(){
                var layer = layui.layer;
                layer.alert('Are you sure to remove“'+ movie_id + '”and drop off?',{icon: 0,offset: clientHeight/5},
                    function () {
                        $.ajax({
                            type:'post',
                            url: url + "/movie/deleteMovie",
                            dataType:'json',
                            data: {
                                movie_id: movie_id,
                            },
                            success:function (date) {
                                if(date.code == 0){
                                    layer.alert('Delete successfully!',{icon: 0,offset: clientHeight/5},
                                        function (){
                                            layer.closeAll();
                                            location.reload();
                                        }
                                    );
                                }else{
                                    layer.alert('Delete failed!',{icon: 0,offset: clientHeight/5},
                                        function (){
                                            layer.closeAll();
                                        }
                                    );
                                }
                            }
                        });
                    }
                );
            });
        }
        //电影添加演员
        function addActor(){
            var TextSide = $(".textside").find(".temp");
            if(ActorNum<5){
                ActorNum++;
                TextSide.before(
                    "<div class=\"layui-form-item\">" +
                        "<label class=\"layui-form-label\" style=\"display:inline-block;\">Staff" + ActorNum + "</label>" +
                        "<div class=\"layui-input-block addusertext actor\" style=\"display:inline-block; margin-left: 10px !important; width: 118px;\">" +
                            "<input id=\"movie_actor" + ActorNum + "\" type=\"text\" name=\"title\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"MovieActor" + ActorNum + "\" class=\"layui-input\">" +
                        "</div>" +
                        "<span style=\"margin-left:10px\">饰</span>" +
                        "<div class=\"layui-input-block addusertext\" style=\"display:inline-block; margin-left: 10px !important; width: 118px;\">" +
                            "<input id=\"movie_role" + ActorNum + "\" type=\"text\" name=\"title\" lay-verify=\"title\" autocomplete=\"off\" placeholder=\"MovieRole" + ActorNum + "\" class=\"layui-input\">" +
                        "</div>" +
                    "</div>"
                );
            }
            else{
                layui.use(['laypage', 'layer'], function(){
                var laypage = layui.laypage;
                var layer = layui.layer;
                    layer.alert('There should be at most 5 staffs!',{icon: 0,offset: clientHeight/5},
                        function (){
                            layer.close(layer.index);
                        }
                    );
                });
            }
        }
        //电影删除演员
        function deleteActor(){
            console.log(ActorNum);
            if(ActorNum>1){
                var TextSide = $(".textside").find(".layui-form-item");
                TextSide[(ActorNum+2)].remove();
                ActorNum--;
            }
            else{
                layui.use(['laypage', 'layer'], function(){
                var laypage = layui.laypage;
                var layer = layui.layer;
                    layer.alert('There should be at least 1 staff!',{icon: 0,offset: clientHeight/5},
                        function (){
                            layer.close(layer.index);
                        }
                    );
                });
            }
        }

        //初始化场次管理界面      (未完成)
        function initSchedule(){
            //场次列表
            layui.use(['table'], function(){
                var table = layui.table;
                table.render({
                    id: "ScheduleTable"
                    ,elem: '#schedule_table_id'
                    ,url: url + ''
                    ,method: 'post'
                    ,toolbar: '#scheduletoolbar'
                    ,title: 'Movie Launch Time List'
                    ,cols: [[
                        {field:'schedule_id', title:'ID', width:102, unresize: true, sort: true}
                        ,{field:'schedule_cinema', title:'Theater', width:270, unresize: true,sort: true}
                        ,{field:'schedule_hall', title:'Hall', width:270, unresize: true, sort: true, edit: "text"}
                        ,{field:'schedule_startTime', title:'Launch Time', width:270, unresize: true, sort: true, edit: "text"}
                        ,{field:'schedule_price', title:'Price', width:270, unresize: true, edit: "text"}
                        ,{title:'Command', width:300, unresize: true, align:'center', toolbar: '#schedulebar'}
                    ]]
                    ,page: {layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                        ,curr: 1 //设定初始在第 1 页
                        ,groups: 5 //只显示 5 个连续页码
                        ,first: false //显示首页
                        ,last: false //显示尾页
                        ,limit: 10
                    }
                    ,response: {
                        statusCode: 0 //重新规定成功的状态码为 200，table 组件默认为 0
                    }
                    ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                        return {
                            "code": res.code, //解析接口状态
                            "msg": res.msg, //解析提示文本
                            "count": res.count, //解析数据长度
                            "data": res.data //解析数据列表
                        };
                    }
                });
                //监听工具条
                table.on('tool(ScheduleTable)', function(obj){
                    var data = obj.data;
                    if(obj.event === 'detail'){
                        layer.msg('ID：'+ data.schedule_id + '</br>Theater:'+ data.schedule_cinema + '</br>Hall:'+ data.schedule_hall  + '</br>放映时间：'+ data.schedule_startTime + '</br>售价：' + data.schedule_price, {offset: clientHeight/5});
                    }
                    else if(obj.event === 'edit'){
                        layer.alert('Are you sure to save ID“'+ JSON.stringify(data.schedule_id) + '”for modification?',{icon: 0,offset: clientHeight/5},
                            function () {
                                $.ajax({
                                    type:'post',
                                    url: url + "",
                                    dataType:'json',
                                    data: {
                                        schedule_id: data.schedule_id,
                                        schedule_cinema: data.schedule_cinema,
                                        schedule_hall: data.schedule_hall,
                                        schedule_startTime: data.schedule_startTime,
                                        schedule_price: data.schedule_price,
                                    },
                                    success:function (date) {
                                        if(date == "success"){
                                            layer.alert('Modify successfully!',{icon: 0,offset: clientHeight/5},
                                                function (){
                                                    layer.closeAll();
                                                    location.reload();
                                                }
                                            );
                                        }else{
                                            layer.alert('Modify failed!',{icon: 0,offset: clientHeight/5},
                                                function (){
                                                    layer.closeAll();
                                                }
                                            );
                                        }
                                    }
                                });
                            }
                        );
                    }
                });
                //头工具栏事件
                table.on('toolbar(ScheduleTable)', function(obj){
                    var checkStatus = table.checkStatus(obj.config.id);
                    switch(obj.event){
                        case 'scheduleadd':
                            //示范一个公告层
                            layer.open({
                                type: 1
                                ,title: 'Add launch time' //不显示标题栏
                                ,closeBtn: false
                                ,area: '400px;'
                                ,shade: 0.8
                                ,offset: clientHeight/5
                                ,id: 'scheduleadd' //设定一个id，防止重复弹出
                                ,btn: ['Add', 'Cancel']
                                ,yes: function(){
                                    var schedule_cinema = $('#schedule_cinema').val();;
                                        schedule_hall = $('#schedule_hall').val();
                                        schedule_startTime = $('#schedule_startTime').val();
                                        schedule_price = $('#schedule_price').val();
                                    if((schedule_cinema == "直接选择或搜索选择") || (schedule_hall == "直接选择或搜索选择") || (schedule_startTime == "") || (schedule_price =="")){
                                        layer.alert('Add information cannot be null, failed!',{icon: 0,offset: clientHeight/5},
                                            function (){
                                                layer.close(layer.index);
                                            }
                                        );
                                    }
                                    else{
                                        layer.alert(schedule_cinema +'</br>'+ schedule_hall + '</br>'+ schedule_startTime + '</br>'+ schedule_price,{icon: 0,offset: clientHeight/5},
                                            function (){
                                                layer.close(layer.index);
                                            }
                                        );
                                        // $.ajax({
                                        //     type:'post',
                                        //     url: url + "",
                                        //     dataType:'json',
                                        //     data: {
                                        //         schedule_cinema:schedule_cinema,
                                        //         schedule_hall:schedule_hall,
                                        //         schedule_startTime:schedule_startTime,
                                        //         schedule_price:schedule_price,
                                        //     },
                                        //     success:function (date) {
                                        //         if(date == "success"){
                                        //             layer.alert('添加成功！',{icon: 0,offset: clientHeight/5},
                                        //                 function (){
                                        //                     layer.closeAll();
                                        //                     location.reload();
                                        //                 }
                                        //             );
                                        //         }else{
                                        //             layer.alert('添加失败！',{icon: 0,offset: clientHeight/5},
                                        //                 function (){
                                        //                     layer.closeAll();
                                        //                 }
                                        //             );
                                        //         }
                                        //     }
                                        // });
                                    }

                                }
                                ,btnAlign: 'c'
                                ,moveType: 1 //拖拽模式，0或者1
                                ,content: addScheduleContent
                                ,success: function(layero){
                                    layui.use(['form','laydate','layedit'], function(){
                                        var form = layui.form, 
                                        layedit = layui.layedit, 
                                        laydate = layui.laydate;
                                        laydate.render({
                                          elem: '#schedule_startTime'
                                          ,type: 'datetime'
                                          ,format:'yyyy-MM-dd HH:mm'
                                        });
                                        //form.render();
                                        form.render('select' ,'select');
                                    });
                                
                                    // layer._indexTemp = layer._indexTemp||{};
                                    // $(document).on('click','.layui-table-view .layui-select-title, .layui-layer-content .layui-select-title, .select_option_in_layer .layui-select-title'
                                    //     ,function (event){
                                    //     layui.stope(event);
                                    //     top.layer.close(top.layer._indexTemp['selectInTable']);
                                    //     var titleElem = $(this);
                                    //     if(!titleElem.parent().hasClass('layui-form-selected')){
                                    //         return;
                                    //     }
                                    //     var dlElem = titleElem.next();
                                    //     var titleElemPosition = getPostiton(titleElem);
                                    //     var topTemp = titleElemPosition.top + titleElem.outerHeight();
                                    //     var leftTemp = titleElemPosition.left;
                                    // });
                                }
                            });
                        break;
                    };
                });
            });
        }

        //初始化评论管理界面
        function initComment(){
            //评论列表
            layui.use('table', function(){
                var table = layui.table;
                table.render({
                    elem: '#comment_table_id'
                    ,url: url + '/comment/findAllCommentsPage'
                    ,method: 'post'
                    ,toolbar: '#commenttoolbar'
                    ,title: 'Comment List'
                    ,cols: [[
                        {field:'comment_id', title:'Comment number', width:102, unresize: true, sort: true}
                        ,{field:'comment_user', title:'User', width:100, unresize: true,templet: '<div>{{d.comment_user.user_name}}</div>'}
                        ,{field:'comment_time', title:'Comment Time', width:180, unresize: true, sort: true}
                        ,{field:'comment_content', title:'Comment Content', width:590, unresize: true, edit: "text"}
                        ,{title:'Command', width:240, unresize: true, align:'center', toolbar: '#commentbar'}
                    ]]
                    ,page: {layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                        ,curr: 1 //设定初始在第 1 页
                        ,groups: 5 //只显示 5 个连续页码
                        ,first: false //显示首页
                        ,last: false //显示尾页
                        ,limits: [10,15,20]
                    }
                    ,response: {
                        statusCode: 0 //重新规定成功的状态码为 200，table 组件默认为 00
                    }
                    ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                        return {
                            "code": res.code, //解析接口状态
                            "msg": res.msg, //解析提示文本
                            "count": res.count, //解析数据长度
                            "data": res.data //解析数据列表
                        };
                    }
                });
                //监听工具条
                table.on('tool(CommentTable)', function(obj){
                    var data = obj.data;
                    if(obj.event === 'detail'){
                        layer.msg('ID：'+ data.comment_id + '</br>Username'+ data.comment_user.user_name + '</br>Time:'+ data.comment_time  + '</br>Content:'+ data.comment_content, {offset: clientHeight/4});
                    }
                    else if(obj.event === 'edit'){
                        console.log(obj);
                        layer.alert('Are you sure to change ID“'+ JSON.stringify(data.comment_id) + '”and save it?',{icon: 0,offset: clientHeight/5},
                            function () {
                                $.ajax({
                                    type:'post',
                                    url: url + "/comment/updateComment",
                                    dataType:'json',
                                    data: {
                                        comment_id: data.comment_id,
                                        comment_content: data.comment_content
                                    },
                                    success:function (date) {
                                        if(date.code == 0){
                                            layer.alert('Change successfully!',{icon: 0,offset: clientHeight/5},
                                                function (){
                                                    layer.closeAll();
                                                }
                                            );
                                        }else{
                                            layer.alert('Change failed!',{icon: 0,offset: clientHeight/5},
                                                function (){
                                                    layer.closeAll();
                                                }
                                            );
                                        }
                                    }
                                });
                            }
                        );
                    }
                    else if(obj.event === 'delete'){
                        layer.alert('Are you sure to delete id“'+ JSON.stringify(data.comment_id) + '”？',{icon: 0,offset: clientHeight/5},
                            function () {
                                $.ajax({
                                    type:'post',
                                    url: url + "/comment/deleteComemnt",
                                    dataType:'json',
                                    data: {
                                        comment_id: data.comment_id,
                                    },
                                    success:function (date) {
                                        if(date.code == 0){
                                            layer.alert('Delete successfully!',{icon: 0,offset: clientHeight/5},
                                                function (){
                                                    layer.closeAll();
                                                    location.reload();
                                                }
                                            );
                                        }else{
                                            layer.alert('Delete failed!',{icon: 0,offset: clientHeight/5},
                                                function (){
                                                    layer.closeAll();
                                                }
                                            );
                                        }
                                    }
                                });
                            }
                        );
                    }
                });
                //监听头工具条
                table.on('toolbar(CommentTable)', function(obj){
                    var checkStatus = table.checkStatus(obj.config.id);
                    switch(obj.event){
                        case 'findcommentbtn':
                            var user_name = $('#commentfindtext').val();
                            table.reload('comment_table_id', {
                                url: url + '/comment/findCommentsByUserName'
                                ,method: "POST"
                                ,where: {
                                    user_name: user_name
                                }
                                ,page: {
                                    curr: 1 //重新从第 1 页开始
                                }
                            });
                        break;
                        case 'findcommentall':
                            table.render({
                                elem: '#comment_table_id'
                                ,url: url + '/comment/findAllCommentsPage'
                                ,method: 'post'
                                ,toolbar: '#commenttoolbar'
                                ,title: 'Order List'
                                ,cols: [[
                                    {field:'comment_id', title:'Comment ID', width:102, unresize: true, sort: true}
                                    ,{field:'comment_user', title:'Comment User', width:100, unresize: true,templet: '<div>{{d.comment_user.user_name}}</div>'}
                                    ,{field:'comment_time', title:'Comment Time', width:180, unresize: true, sort: true}
                                    ,{field:'comment_content', title:'Comment Content', width:590, unresize: true, edit: "text"}
                                    ,{title:'Command', width:240, unresize: true, align:'center', toolbar: '#commentbar'}
                                ]]
                                ,page: {layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                                    ,curr: 1 //设定初始在第 1 页
                                    ,groups: 5 //只显示 5 个连续页码
                                    ,first: false //显示首页
                                    ,last: false //显示尾页
                                    ,limits: [10,15,20]
                                }
                                ,response: {
                                    statusCode: 0 //重新规定成功的状态码为 200，table 组件默认为 00
                                }
                                ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                                    return {
                                        "code": res.code, //解析接口状态
                                        "msg": res.msg, //解析提示文本
                                        "count": res.count, //解析数据长度
                                        "data": res.data //解析数据列表
                                    };
                                }
                            });
                        break;
                    };
                });
            });
        }

        //初始化订单管理界面
        function initTicket(){
            var PageStatus=0;
            var actionUrl = "";
            //订单列表
            layui.use('table', function(){
                var table = layui.table;
                table.render({
                    elem: '#ticket_table_id'
                    ,url: url + "/order/findAllOrdersPage"
                    ,method: 'post'
                    ,toolbar: '#tickettoolbar'
                    ,title: 'Order List'
                    ,cols: [[
                        {field:'order_id', title:'Order ID', width:160,unresize:true,sort: true,fixed:'left'}
                        ,{field:'order_user', title:'Order User', width:100, unresize: true,templet:'<div>{{d.order_user.user_name}}</div>'}
                        ,{field:'order_schedule', title:'Order Schedule', width:180, unresize: true,templet:'<div>{{d.order_schedule.schedule_startTime}}</div>'}
                        ,{field:'order_position',title:'Position',width:100,unresize:true}
                        ,{field:'order_schedule',title:'Price',width:80,unresize:true,templet:'<div>￥{{d.order_schedule.schedule_price}}</div>'}
                        ,{field:'order_schedule',title:'Movie',width:240,unresize:true,templet:'<div>{{d.order_schedule.schedule_movie.movie_cn_name}}</div>'}
                        ,{field:'order_schedule', title:'Hall', width:100, unresize: true, templet:'<div>{{d.order_schedule.schedule_hall.hall_name}}</div>'}
                        ,{field:'order_schedule',title:'Theater',width:240,unresize:true,templet:'<div>{{d.order_schedule.schedule_hall.hall_cinema.cinema_name}}</div>'}
                        ,{field:'order_state',title:'Order Status',width:100,unresize:true,align:'center',templet:function(d){if(d.order_state == 1) return '<div style="color:#337ab7">Completed</div>';else if(d.order_state == 0) return '<div style="color:#ef4238">Request for refund</div>';else return '<div style="color:#5cb85c">Refunded</div>';}}
                        ,{title:'Command', width:100, unresize: true, align:'center', toolbar: '#ticketbar'}
                    ]]
                    ,page: {layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                        ,curr: 1 //设定初始在第 1 页
                        ,groups: 5 //只显示 5 个连续页码
                        ,first: false //显示首页
                        ,last: false //显示尾页
                        ,limits: [10,15,20]
                    }
                    ,response: {
                        statusCode: 0 //重新规定成功的状态码为 200，table 组件默认为 0
                    }
                    ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                        return {
                            "code": res.code, //解析接口状态
                            "msg": res.msg, //解析提示文本
                            "count": res.count, //解析数据长度
                            "data": res.data //解析数据列表
                        };
                    },
                });
              
                //监听工具条
                table.on('tool(TicketTable)', function(obj){
                    var data = obj.data;
                    if(obj.event === 'detail'){
                        layer.msg('Order ID:'+ data.order_id + '&nbsp;&nbsp;&nbsp;User:' + data.order_user.user_name + '<br>Schedule:'+ data.order_schedule.schedule_startTime + '&nbsp;&nbsp;&nbsp;Position:' + data.order_position + '<br>Movie:' + data.order_schedule.schedule_movie.movie_cn_name + '&nbsp;&nbsp;&nbsp;Price:￥' + data.order_schedule.schedule_price + '<br>Theater:'+ data.order_schedule.schedule_hall.hall_cinema.cinema_name + '&nbsp;&nbsp;&nbsp;Hall:' + data.order_schedule.schedule_hall.hall_name, {offset: clientHeight/4,area:['400px','140px']});
                    }
                    else if(obj.event === 'pass'){
                        layer.alert('Are you sure to allow ID“' + data.order_id + '”for refund?',{icon: 0,offset: clientHeight/5},
                            function () {
                                $.ajax({
                                    type:'post',
                                    url: url + "/order/agreeForRefund",
                                    dataType:'json',
                                    data: {
                                        order_id: data.order_id
                                    },
                                    success:function (data) {
                                        if(data.code == 0){
                                            layer.alert(data.msg,{icon: 0,offset: clientHeight/5},
                                                function (){
                                                    layer.closeAll();
                                                    location.reload();
                                                }
                                            );
                                        }else{
                                            layer.alert(data.msg,{icon: 0,offset: clientHeight/5},
                                                function (){
                                                    layer.closeAll();
                                                }
                                            );
                                        }
                                    }
                                });
                            }
                        );
                    }
                });
                //监听头工具条
                table.on('toolbar(TicketTable)', function(obj){
                    var checkStatus = table.checkStatus(obj.config.id);
                    var changeticketbtn = $('.changeticketBtn');
                    var ticketfindtext = $('#ticketfindtext');
                    switch(obj.event){
                        case 'findticketbtn':
                            var url_temp;
                            var find_temp = $('#ticketfindtext').val();
                            find_temp = find_temp.toString();
                            //订单管理
                            if(PageStatus == 0){
                                if(changeticketbtn.val()=="Order ID"){
                                    url_temp = '/order/findOrderById';
                                    table.reload('ticket_table_id', {
                                        url: url + url_temp
                                        ,method: "POST"
                                        ,where: {
                                            order_id: find_temp
                                        }
                                        ,page: {
                                            curr: 1 //重新从第 1 页开始
                                        }
                                    });
                                }
                                else{
                                    url_temp = '/order/findOrderByUserName';
                                    table.reload('ticket_table_id', {
                                        url: url + url_temp
                                        ,method: "POST"
                                        ,where: {
                                            user_name: find_temp
                                        }
                                        ,page: {
                                            curr: 1 //重新从第 1 页开始
                                        }
                                    });
                                }
                            }
                            //退票审核
                            else{
                                if(changeticketbtn.val()=="Order ID"){
                                    url_temp = '/order/findOrderById';
                                    table.reload('ticket_table_id', {
                                        url: url + url_temp
                                        ,method: "POST"
                                        ,where: {
                                            order_id: find_temp
                                        }
                                        ,page: {
                                            curr: 1 //重新从第 1 页开始
                                        }
                                    });
                                }
                                else{
                                    url_temp = '/order/findRefundOrderByUser';
                                    table.reload('ticket_table_id', {
                                        url: url + url_temp
                                        ,method: "POST"
                                        ,where: {
                                            user_name: find_temp
                                        }
                                        ,page: {
                                            curr: 1 //重新从第 1 页开始
                                        }
                                    });
                                }
                            }
                        break;
                        case 'changeticketbtn':
                            if(changeticketbtn.val()=="Order ID"){
                                changeticketbtn.val("Username");
                                ticketfindtext.attr("placeholder","Please enter username");
                            }
                            else{
                                changeticketbtn.val("Order ID");
                                ticketfindtext.attr("placeholder","Please enter order id");
                            }
                        break;
                        case 'findorderall':
                            PageStatus = 0;
                            table.render({
                                elem: '#ticket_table_id'
                                ,url: url + "/order/findAllOrdersPage"
                                ,method: 'post'
                                ,toolbar: '#tickettoolbar'
                                ,title: 'Order List'
                                ,cols: [[
                                    {field:'order_id', title:'Order ID', width:160,unresize:true,sort: true,fixed:'left'}
                                    ,{field:'order_user', title:'User', width:100, unresize: true,templet:'<div>{{d.order_user.user_name}}</div>'}
                                    ,{field:'order_schedule', title:'Schedule', width:180, unresize: true,templet:'<div>{{d.order_schedule.schedule_startTime}}</div>'}
                                    ,{field:'order_position',title:'Position',width:100,unresize:true}
                                    ,{field:'order_schedule',title:'Price',width:80,unresize:true,templet:'<div>￥{{d.order_schedule.schedule_price}}</div>'}
                                    ,{field:'order_schedule',title:'Movie',width:240,unresize:true,templet:'<div>{{d.order_schedule.schedule_movie.movie_cn_name}}</div>'}
                                    ,{field:'order_schedule', title:'Hall', width:100, unresize: true, templet:'<div>{{d.order_schedule.schedule_hall.hall_name}}</div>'}
                                    ,{field:'order_schedule',title:'Theater',width:240,unresize:true,templet:'<div>{{d.order_schedule.schedule_hall.hall_cinema.cinema_name}}</div>'}
                                    ,{field:'order_state',title:'Order Status',width:100,unresize:true,align:'center',templet:function(d){if(d.order_state == 1) return '<div style="color:#337ab7">Completed</div>';else if(d.order_state == 0) return '<div style="color:#ef4238">Request Refund</div>';else return '<div style="color:#5cb85c">Refunded</div>';}}
                                    ,{title:'Command', width:100, unresize: true, align:'center', toolbar: '#ticketbar'}
                                ]]
                                ,page: {layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                                    ,curr: 1 //设定初始在第 1 页
                                    ,groups: 5 //只显示 5 个连续页码
                                    ,first: false //显示首页
                                    ,last: false //显示尾页
                                    ,limits: [10,15,20]
                                }
                                ,response: {
                                    statusCode: 0 //重新规定成功的状态码为 200，table 组件默认为 0
                                }
                                ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                                    return {
                                        "code": res.code, //解析接口状态
                                        "msg": res.msg, //解析提示文本
                                        "count": res.count, //解析数据长度
                                        "data": res.data //解析数据列表
                                    };
                                },
                            });
                        break;
                        case 'backorderbtn':
                            PageStatus = 1;
                            table.render({
                                elem: '#ticket_table_id'
                                ,url: url + "/order/findAllRefundOrder"
                                ,method: 'post'
                                ,toolbar: '#tickettoolbar'
                                ,title: 'Order List'
                                ,cols: [[
                                    {field:'order_id', title:'Order ID', width:160,unresize:true,sort: true,fixed:'left'}
                                    ,{field:'order_user', title:'User', width:100, unresize: true,templet:'<div>{{d.order_user.user_name}}</div>'}
                                    ,{field:'order_schedule', title:'Schedule', width:180, unresize: true,templet:'<div>{{d.order_schedule.schedule_startTime}}</div>'}
                                    ,{field:'order_position',title:'Position',width:100,unresize:true}
                                    ,{field:'order_schedule',title:'Price',width:80,unresize:true,templet:'<div>￥{{d.order_schedule.schedule_price}}</div>'}
                                    ,{field:'order_schedule',title:'Movie',width:240,unresize:true,templet:'<div>{{d.order_schedule.schedule_movie.movie_cn_name}}</div>'}
                                    ,{field:'order_schedule', title:'Hall', width:100, unresize: true, templet:'<div>{{d.order_schedule.schedule_hall.hall_name}}</div>'}
                                    ,{field:'order_schedule',title:'Theater',width:240,unresize:true,templet:'<div>{{d.order_schedule.schedule_hall.hall_cinema.cinema_name}}</div>'}
                                    ,{field:'order_state',title:'Order Status',width:100,unresize:true,align:'center',templet:function(d){if(d.order_state == 1) return '<div style="color:#337ab7">Completed</div>';else if(d.order_state == 0) return '<div style="color:#ef4238">Request Refund</div>';else return '<div style="color:#5cb85c">Refunded</div>';}}
                                    ,{title:'Command', width:200, unresize: true, align:'center', toolbar: '#backticketbar'}
                                ]]
                                ,page: {layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                                    ,curr: 1 //设定初始在第 1 页
                                    ,groups: 5 //只显示 5 个连续页码
                                    ,first: false //显示首页
                                    ,last: false //显示尾页
                                    ,limits: [10,15,20]
                                }
                                ,response: {
                                    statusCode: 0 //重新规定成功的状态码为 200，table 组件默认为 0
                                }
                                ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                                    return {
                                        "code": res.code, //解析接口状态
                                        "msg": res.msg, //解析提示文本
                                        "count": res.count, //解析数据长度
                                        "data": res.data //解析数据列表
                                    };
                                },
                            });
                        break;
                    };
                });
            });
        }

         //初始化场次管理界面
         function initSchedule(){
            var ScheduleStatus=0; //0：上映      1：下架
            //场次列表
            layui.use(['table','form'], function(){
                var table = layui.table;
                var form = layui.form;
                table.render({
                    elem: '#schedule_table_id'
                    ,url: url + '/schedule/findAllScheduleByState'
                    ,method: 'post'
                    ,where: {"schedule_state": 1}
                    ,toolbar: '#scheduletoolbar'
                    ,title: 'Schedule List'
                    ,cols: [[
                        {field:'schedule_id', title:'Schedule ID', width:100, unresize: true, sort: true}
                        ,{field:'schedule_hall', title:'Theater', width:240, unresize: true,templet:'<div>{{d.schedule_hall.hall_cinema.cinema_name}}</div>'}
                        ,{field:'schedule_hall', title:'Position', width:300, unresize: true,templet:'<div>{{d.schedule_hall.hall_cinema.cinema_address}}</div>'}
                        ,{field:'schedule_hall', title:'Hall', width:100, unresize: true, templet:'<div>{{d.schedule_hall.hall_name}}</div>'}
                        ,{field:'schedule_movie', title:'Movie', width:240, unresize: true,templet:'<div>{{d.schedule_movie.movie_cn_name}}</div>'}
                        ,{field:'schedule_startTime', title:'Start Time', width:180, unresize: true, sort: true}
                        ,{field:'schedule_price', title:'Price', width:100,align:'center', unresize: true}
                        ,{field:'orderList',title:'Order Number',width:100,unresize:true,align:'center',templet:'<div>{{d.orderList.length}}</div>'}
                        ,{field:'schedule_remain',title:'Remaining Tickets',width:100,align:'center',unresize:true}
                        ,{field:'orderList',title:'Sales in total',width:120,align:'center',unresize:true,templet:'<div>{{d.orderList.length * d.schedule_price}}</div>'}
                        ,{title:'Command', width:200, unresize: true, align:'center', toolbar: '#schedulebar'}
                    ]]
                    ,page: {layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                        ,curr: 1 //设定初始在第 1 页
                        ,groups: 5 //只显示 5 个连续页码
                        ,first: false //显示首页
                        ,last: false //显示尾页
                        ,limits: [10,15,20]
                    }
                    ,response: {
                        statusCode: 0 //重新规定成功的状态码为 200，table 组件默认为 0
                    }
                    ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                        return {
                            "code": res.code, //解析接口状态
                            "msg": res.msg, //解析提示文本
                            "count": res.count, //解析数据长度
                            "data": res.data, //解析数据列表
                        };
                    }
                });
                //监听工具条
                table.on('tool(ScheduleTable)', function(obj){
                    var data = obj.data;
                    if(obj.event === 'detail'){
                        console.log(obj);
                        layer.msg('ID:'+ data.schedule_id + '</br>Theater:'+ data.schedule_hall.hall_cinema.cinema_name + '&nbsp;&nbsp;&nbsp;Hall:'+ data.schedule_hall.hall_name  + '</br>Position:'+ data.schedule_hall.hall_cinema.cinema_address + '</br>Movie:'+ data.schedule_movie.movie_cn_name + '</br>Schedule:' + data.schedule_startTime + '&nbsp;&nbsp;&nbsp;Price:' + data.schedule_price, {offset: clientHeight/5});
                    }
                    else if(obj.event === 'edit'){
                        layer.alert('Are you sure to put“'+ data.schedule_id + '”to drop off?',{icon: 0,offset: clientHeight/5},
                            function () {
                                $.ajax({
                                    type:'post',
                                    url: url + "/schedule/offlineSchedule",
                                    dataType:'json',
                                    data: {
                                        schedule_id: data.schedule_id,
                                    },
                                    success:function (result) {
                                        console.log(data.schedule_id);
                                        if(result.code == 0){
                                            layer.alert(result.mgs,{icon: 0,offset: clientHeight/5},
                                                function (){
                                                    layer.closeAll();
                                                    location.reload();
                                                }
                                            );
                                        }else{
                                            layer.alert(result.mgs,{icon: 0,offset: clientHeight/5},
                                                function (){
                                                    layer.closeAll();
                                                }
                                            );
                                        }
                                    }
                                });
                            }
                        );
                    }
                });
                //头工具栏事件
                table.on('toolbar(ScheduleTable)', function(obj){
                    var checkStatus = table.checkStatus(obj.config.id);
                    switch(obj.event){
                        case 'scheduleadd':
                            //示范一个公告层
                            layer.open({
                                type: 1
                                ,title: 'Add schedule' //不显示标题栏
                                ,closeBtn: false
                                ,area: '400px;'
                                ,shade: 0.8
                                ,offset: clientHeight/10
                                ,id: 'scheduleadd' //设定一个id，防止重复弹出
                                ,btn: ['Add', 'Cancel']
                                ,yes: function(){
                                    console.log("queding");
                                    var select_movie_name = $('#select_movie_name').val();
                                    var select_cinema_name = $("#select_cinema_name").val();
                                    var select_schedule_hall = $('#select_schedule_hall').val();
                                    var schedule_startTime_Text = $("#schedule_startTime_Text").val();
                                    var schedule_price_Text = $('#schedule_price_Text').val();
                                    if((select_movie_name == "Choose Movie") || (select_cinema_name == "Choose Theater") || (select_schedule_hall == "Choose Hall") ||
                                        (schedule_startTime_Text =="") || (schedule_price_Text =="")){
                                        layer.alert('Add information cannot be null, failed!',{icon: 0,offset: clientHeight/5},
                                            function (){
                                                layer.close(layer.index);
                                            }
                                        );
                                    }
                                    else{
                                        $.ajax({
                                            type:'post',
                                            url: url + "/schedule/addSchedule",
                                            dataType:'json',
                                            data: {
                                                movie_name: select_movie_name,
                                                cinema_name: select_cinema_name,
                                                hall_name: select_schedule_hall,
                                                schedule_startTime: schedule_startTime_Text,
                                                schedule_price: schedule_price_Text,
                                            },
                                            success:function (result) {
                                                if(result.code == 0){
                                                    layer.alert(result.mgs,{icon: 0,offset: clientHeight/5},
                                                        function (){
                                                            layer.closeAll();
                                                            location.reload();
                                                        }
                                                    );
                                                }else{
                                                    layer.alert(result.mgs,{icon: 0,offset: clientHeight/5},
                                                        function (){
                                                            layer.closeAll();
                                                        }
                                                    );
                                                }
                                            }
                                        });
                                    }
                                }
                                ,end: function(){
                                    cinemaJsonArr = [];
                                }
                                ,btnAlign: 'c'
                                ,moveType: 1 //拖拽模式，0或者1
                                ,content: addScheduleContent
                                ,success: function(layero){
                                    layui.use(['form','laydate','layedit'], function(){
                                        var form = layui.form, 
                                        layedit = layui.layedit, 
                                        laydate = layui.laydate;
                                        laydate.render({
                                          elem: '#schedule_startTime_Text'
                                          ,type: 'datetime'
                                          ,format:'yyyy-MM-dd HH:mm'
                                        });
                                        form.render('select' ,'select');
                                    });
                                    $.ajax({
                                        type:'post',
                                        url: url + "/schedule/findAllSchedule",
                                        dataType:'json',
                                        data: {},
                                        success:function (objs) {
                                            movieArr = objs.movieName;
                                            cinemaArr = objs.cinema;
                                            //解析json数组 简化
                                            for(var i = 0;i < cinemaArr.length;i++){
                                                var cinemaJson = {};
                                                for(var key in cinemaArr[i]){
                                                    var cinemaName = key; 
                                                    var hallArr = [];
                                                    for(var j = 0;j < cinemaArr[i][key].length; j++){
                                                        hallArr.push(cinemaArr[i][key][j].hall_name);
                                                    }
                                                    cinemaJson.cinema = key;
                                                    cinemaJson.hallArr = hallArr;
                                                }
                                                cinemaJsonArr.push(cinemaJson);
                                            }

                                            console.log(cinemaJsonArr);
                                            for(var i=0;i<movieArr.length;i++){
                                               $("#select_movie_name").append(new Option(movieArr[i]));
                                               layui.form.render("select");
                                            }

                                            for(var i=0;i<cinemaJsonArr.length;i++){
                                                $("#select_cinema_name").append(new Option(cinemaJsonArr[i].cinema));
                                                layui.form.render("select");
                                            }
                                        }
                                    });
                                }
                            });
                        break;
                        case 'findschedulebtn':
                            var find_temp = $('#scheduletext').val();
                            //上映
                            if(ScheduleStatus==0){
                                table.reload('schedule_table_id', {
                                    url: url + "/schedule/findScheduleByMovieName"
                                    ,method: "POST"
                                    ,where: {
                                        movie_name: find_temp
                                    }
                                    ,page: {
                                        curr: 1 //重新从第 1 页开始
                                    }
                                });
                            }
                            //下架
                            else{
                                table.reload('schedule_table_id', {
                                    url: url + "/schedule/findOffScheduleByMovieName"
                                    ,method: "POST"
                                    ,where: {
                                        movie_name: find_temp
                                    }
                                    ,page: {
                                        curr: 1 //重新从第 1 页开始
                                    }
                                });
                            }
                        break;
                        case 'scheduleonallbtn':
                            ScheduleStatus = 0;
                            table.render({
                                elem: '#schedule_table_id'
                                ,url: url + '/schedule/findAllScheduleByState'
                                ,method: 'post'
                                ,where: {"schedule_state": 1}
                                ,toolbar: '#scheduletoolbar'
                                ,title: 'Shcedule List'
                                ,cols: [[
                                    {field:'schedule_id', title:'Schedule ID', width:100, unresize: true, sort: true}
                                    ,{field:'schedule_hall', title:'Theater', width:240, unresize: true,templet:'<div>{{d.schedule_hall.hall_cinema.cinema_name}}</div>'}
                                    ,{field:'schedule_hall', title:'Position', width:300, unresize: true,templet:'<div>{{d.schedule_hall.hall_cinema.cinema_address}}</div>'}
                                    ,{field:'schedule_hall', title:'Hall', width:100, unresize: true, templet:'<div>{{d.schedule_hall.hall_name}}</div>'}
                                    ,{field:'schedule_movie', title:'Movie', width:240, unresize: true,templet:'<div>{{d.schedule_movie.movie_cn_name}}</div>'}
                                    ,{field:'schedule_startTime', title:'Start Time', width:180, unresize: true, sort: true}
                                    ,{field:'schedule_price', title:'Price', width:100,align:'center', unresize: true}
                                    ,{field:'orderList',title:'Order Number',width:100,unresize:true,align:'center',templet:'<div>{{d.orderList.length}}</div>'}
                                    ,{field:'schedule_remain',title:'Remaining Tickets',width:100,align:'center',unresize:true}
                                    ,{field:'orderList',title:'Sales in total',width:120,align:'center',unresize:true,templet:'<div>{{d.orderList.length * d.schedule_price}}</div>'}
                                    ,{title:'Command', width:200, unresize: true, align:'center', toolbar: '#schedulebar'}
                                ]]
                                ,page: {layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                                    ,curr: 1 //设定初始在第 1 页
                                    ,groups: 5 //只显示 5 个连续页码
                                    ,first: false //显示首页
                                    ,last: false //显示尾页
                                    ,limits: [10,15,20]
                                }
                                ,response: {
                                    statusCode: 0 //重新规定成功的状态码为 200，table 组件默认为 0
                                }
                                ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                                    return {
                                        "code": res.code, //解析接口状态
                                        "msg": res.msg, //解析提示文本
                                        "count": res.count, //解析数据长度
                                        "data": res.data, //解析数据列表
                                        "income": res.income //解析数据列表
                                    };
                                }
                            });
                        break;
                        case 'scheduledownallbtn':
                            ScheduleStatus = 1;
                            table.render({
                                elem: '#schedule_table_id'
                                ,url: url + '/schedule/findAllScheduleByState'
                                ,method: 'post'
                                ,where: {"schedule_state": 0}
                                ,toolbar: '#scheduletoolbar'
                                ,title: 'Schedule List'
                                ,cols: [[
                                    {field:'schedule_id', title:'Schedule ID', width:100, unresize: true, sort: true}
                                    ,{field:'schedule_hall', title:'Theater', width:240, unresize: true,templet:'<div>{{d.schedule_hall.hall_cinema.cinema_name}}</div>'}
                                    ,{field:'schedule_hall', title:'Position', width:300, unresize: true,templet:'<div>{{d.schedule_hall.hall_cinema.cinema_address}}</div>'}
                                    ,{field:'schedule_hall', title:'Theater', width:100, unresize: true, templet:'<div>{{d.schedule_hall.hall_name}}</div>'}
                                    ,{field:'schedule_movie', title:'Movie', width:240, unresize: true,templet:'<div>{{d.schedule_movie.movie_cn_name}}</div>'}
                                    ,{field:'schedule_startTime', title:'Start Time', width:180, unresize: true, sort: true}
                                    ,{field:'schedule_price', title:'Price', width:100,align:'center', unresize: true}
                                    ,{field:'orderList',title:'Order Number',width:100,unresize:true,align:'center',templet:'<div>{{d.orderList.length}}</div>'}
                                    ,{field:'schedule_remain',title:'Remaining Tickets',width:100,align:'center',unresize:true}
                                    ,{field:'orderList',title:'Sales in total',width:120,align:'center',unresize:true,templet:'<div>{{d.orderList.length * d.schedule_price}}</div>'}
                                    ,{title:'Command', width:200, unresize: true, align:'center', toolbar: '#scheduledownbar'}
                                ]]
                                ,page: {layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                                    ,curr: 1 //设定初始在第 1 页
                                    ,groups: 5 //只显示 5 个连续页码
                                    ,first: false //显示首页
                                    ,last: false //显示尾页
                                    ,limits: [10,15,20]
                                }
                                ,response: {
                                    statusCode: 0 //重新规定成功的状态码为 200，table 组件默认为 0
                                }
                                ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                                    return {
                                        "code": res.code, //解析接口状态
                                        "msg": res.msg, //解析提示文本
                                        "count": res.count, //解析数据长度
                                        "data": res.data, //解析数据列表
                                        "income": res.income //解析数据列表
                                    };
                                }
                            });
                        break;
                    };
                });
                //监听影院二级联动
                form.on('select(selectCinema)',function(data){
                    $("#select_schedule_hall").empty();
                    layui.form.render("select");
                    for(var i = 0;i < cinemaJsonArr.length;i++){
                        if(cinemaJsonArr[i].cinema == data.value){
                            for(var j=0;j<cinemaJsonArr[i].hallArr.length;j++){
                                $("#select_schedule_hall").append(new Option(cinemaJsonArr[i].hallArr[j]));
                                layui.form.render("select");
                            }
                        }
                    }
                });
            });
        }

        function sortUp(a,b){
                return a-b;
         }
         //初始化票房统计界面
        function initBoxOffice(){
            $.ajax({
                type:'post',
                url: url + "/movie/findAllMovies",
                dataType:'json',
                data: {},
                //获取数据  根据类型：统计票房   type:['喜剧','动作','爱情','动画','科幻','惊悚','冒险','犯罪','悬疑'] typeIncome: []  场次管理接口 下架之后数据更新    //头像为null时 默认设置为某一张 
                success:function (obj) {
                    if(obj.sort.length > 10){
                        obj.sort.length = 10;
                    }
                    for(var i = obj.sort.length - 1;i >= 0;i--){
                        movieArray.push(obj.sort[i].movie_cn_name);
                        boxOffice.push(Math.ceil(obj.sort[i].movie_boxOffice * 10000));
                    }
                    for(var i = 0;i < obj.type.length;i++){
                        var typeJson = {};
                        for(var key in obj.type[i]){
                            movieType.push(key);
                            movieTypeBoxOffice.push(obj.type[i][key]);
                            var num = parseFloat(obj.type[i][key]);
                            typeJson.value = Math.ceil(num * 10000);
                            typeJson.name = key;
                        }
                        type.push(typeJson);
                    }
                    console.log(movieArray);
                    console.log(boxOffice);
                     //扇形图
                    var aaa = $("#aaa");
                    aaa.append("<div id=\"main1\" style=\"width: 1100px;height:400px;\"></div>")
                    var myChart1 = echarts.init(document.getElementById('main1'));   
                    option1 = {
                        title : {
                            text: 'Type',
                            x:'center'
                        },
                        tooltip : {
                            trigger: 'item',
                            formatter: "{a} <br/>{b} : {c} ({d}%)"
                        },
                        color: ['#6dd8da', '#b6a2de', '#58afed', '#9AC0CD','#ff99cc'],
                        legend: {
                            orient : 'vertical',
                            x : '10%',
                            y : '15%',
                            data:movieType
                        },
                        toolbox: {
                            show : true,
                            feature : {
                                mark : {show: true},
                                dataView : {show: true, readOnly: false},
                                magicType : {
                                    show: true, 
                                    type: ['pie', 'funnel'],
                                    option: {
                                        funnel: {
                                            x: '25%',
                                            width: '50%',
                                            funnelAlign: 'left',
                                            max: 1548
                                        }
                                    }
                                },
                                restore : {show: true},
                                saveAsImage : {show: true}
                            }
                        },
                        calculable : true,
                        series : [
                            {
                                name:'Type,Ticket Office',
                                type:'pie',
                                radius : '60%',
                                center: ['50%', '50%'],
                                data: type,
                            }
                        ]
                    };
                    myChart1.setOption(option1);

                    //统计图
                    var aaa = $("#aaa");
                    aaa.append("<div id=\"main2\" style=\"width: 1200px;height:450px;margin-top:100px;\"></div>")
                    var myChart2 = echarts.init(document.getElementById('main2'));  
                    option2 = {
                        title : {
                            text: 'Ticket Office Rank',
                            subtext: 'Top 10'
                        },
                        tooltip : {
                            trigger: 'axis'
                        },
                        legend: {
                            data:['Ticket Office in total']
                        },
                        toolbox: {
                            show : true,
                            feature : {
                                mark : {show: true},
                                dataView : {show: true, readOnly: false},
                                magicType: {show: true, type: ['line', 'bar']},
                                restore : {show: true},
                                saveAsImage : {show: true}
                            }
                        },
                        calculable : true,
                        xAxis : [
                            {
                                type : 'value',
                                boundaryGap : [0, 0.01]
                            }
                        ],
                        
                        yAxis : [
                            {
                                type : 'category',
                                data : movieArray,
                            }
                        ],
                        series : [
                            {
                                name:'Ticket Office in total',
                                type:'bar',
                                data: boxOffice,
                                color:'#11EEC2'
                            },
                        ]
                    };
                    myChart2.setOption(option2);
                }
            });
        }

    </script>
    <!--------------------------------------------------------------------- -->
</body>
</html>