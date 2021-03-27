<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
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
    <script src="../static/js/Api.js"></script>
    <link rel="icon" type="image/x-icon" href="../static/images/logo.ico"/>
    <link href="../static/css/login.css" rel="stylesheet">

    <script></script>
    <title>淘淘电影-登录注册</title>
</head>
<body>

    <!-- ------------------------------------------------------------------- -->
    <div class="screen">
        <img class="big_logo"><br/>
        <label class="title">淘 淘 电 影</label><br/>
        <label class="ineer_one">快来淘你的电影！</label><br/>
        <label class="ineer_two"></label>
    </div>
    <!-- 登录页 -->
    <div class="content" style="float: left;">
        <ul class="tab">
            <li class="login">登录</li>
            <li class="register">注册</li>
        </ul>
        <div class="page">
            <!-- 登录界面 -->
            <div class="childpage" style="display: block">
                <div>
                    <label class="login_title">用户登录</label><br/>
                </div>
                <div class="login_page">
                    <div>
                        <label>帐号</label><br/>
                        <input id="loginUserName" type="text"/>
                    </div>
                    <div>
                        <label>密码</label><br/>
                        <input id="loginPassWord" type="password"/>
                    </div>
                </div>
                <div class="lo_error">
                    <label class="login_error"></label>
                </div>
                <div>
                    <input type="button" value="登录" class="btn btn-success login_btn" onclick="loginbtn()"/>
                </div>
                <div>
                    <label class="login_version">@版权所有</label>
                </div>
            </div>
            <!-- 注册界面 -->
            <div class="childpage" style="display: none">
                <div>
                    <label class="register_title">用户注册</label><br/>
                </div>
                <div class="register_page">
                    <div>
                        <label>帐号</label><br/>
                        <input id="registerUserName" type="text"/>
                    </div>
                    <div>
                        <label>密码</label><br/>
                        <input id="registerPassWord" type="password"/>
                    </div>
                    <div>
                        <label>邮箱</label><br/>
                        <input id="Email" type="text"/>
                    </div>
                    <div>
                        <label>验证码</label><br/>
                        <input id="Test" type="text"/>
                        <%
                            Date date = new Date();
                            pageContext.setAttribute("date",date);
                        %>

                        <script type="text/javascript">
                            function checkCode() {
                                var newDate = new Date().getTime();
                                var src = "/search/checkCode?"+ newDate.toString();
                                var img = document.getElementById("checkCode");
                                console.log(src);
                                img.src = src;
                            }
                        </script>

                        <img id="checkCode" onclick="checkCode()" src="/search/checkCode?"+ ${ date }>
                        <img onclick="checkCode()" src="../static/images/refresh.png">
                    </div>
                </div>
                <div class="re_error">
                    <label class="register_error"></label>
                </div>
                <div>
                    <input type="button" value="注册" class="btn btn-warning register_btn" onclick="registerbtn()"/>
                </div>
                <div>
                    <label class="register_version">@版权所有</label>
                </div>
            </div>
        </div>
        
    </div>

    <!-- ------------------------------------------------------------------- -->
    <script>
        //初始化
        window.onload = function(){ 
            initWindow(); //初始化登录框位置
            initLogin(); //初始化登录界面
    　　}; 

        //初始化登录框位置（垂直居中、水平4/7）
        function initWindow(){
            var middle = 3;
            var colorNum = 200;
            var clientHeight = document.documentElement.clientHeight;
            var clientWidth = document.documentElement.clientWidth;
            var content = document.getElementsByClassName('content')[0];
            var screen = document.getElementsByClassName('screen')[0];
            var title = document.getElementsByClassName('title')[0];
            var bodys = document.getElementsByTagName('body')[0];
            bodys.style.cssText = "background-size: " + clientWidth + "px auto;";
            content.style.cssText = "margin:" + (clientHeight - content.clientHeight)/2 +"px " + 
            clientWidth*4/7 + "px " +
            (clientHeight - content.clientHeight)/2 + "px;";
            screen.style.cssText = "margin:" + (content.clientHeight - screen.clientHeight)/2 +"px " + 
            (clientWidth*4/7 - screen.clientWidth)/2 + "px " +
            (content.clientHeight - screen.clientHeight)/2 + "px;";
            setInterval(function(){
                colorNum += middle;
                if(colorNum>130){
                    middle = -3;
                }else if(colorNum<80){
                    middle = 3;
                }
                // title.style.cssText = "color:rgb(255," + colorNum + ", 0)";
                title.style.cssText = "color:rgb(223,99," +  colorNum + ")";
            },30);
        }

        //初始化登录界面
        function initLogin(){
            var textNum = document.getElementById('TestNum');
            var liArr = document.getElementsByTagName('li');
    		var divArr = document.getElementsByClassName("page")[0].getElementsByClassName("childpage");
    		for(var i=0;i<liArr.length;i++){
    			liArr[i].index = i;
    			liArr[i].onclick = function(){
                    // textNum.value = TestNum();
    				for(var j=0;j<divArr.length;j++){
                        liArr[j].style.cssText = "background-color:rgba(255, 255, 255, 0.2);";
    					divArr[j].style.display = "none";
    				}
                    liArr[this.index].style.cssText = "background-color:rgba(255, 255, 255, 0);";
    				divArr[this.index].style.display = "block";
    			}
    		}
        }

         //登录账号和密码信息验证
         function loginbtn(){
            var user_name = $(".login_page").find("#loginUserName").val();
            var user_pwd = $(".login_page").find("#loginPassWord").val();
            var login_error = $(".login_error");
            if((user_name == "") || (user_pwd == "")){
                login_error.text("账号和密码不能为空");
            }
            else{
                login_error.text("");
                console.log(url + "/user/login");
                $.ajax({
                    type: "post",
                    url: url + "/user/login",
                    data: {
                        user_name: user_name,
                        user_pwd: user_pwd
                    },
                    dataType: "json",
                    success: function(obj){
                        if(obj.msg == "fail"){
                           // sessionStorage.removeItem('userJson');
                            login_error.text('账号或密码错误!');
                        }
                        else{
                            localStorage.setItem("userJson",JSON.stringify(obj.data));
                          // sessionStorage.set
                            window.location.href="./mainPage.jsp";
                        }
                    },
                    error:function(){
                        alert("network error!");
                    }
                });
            }
        }

        //注册账号和密码逻信息验证
        function registerbtn(){
            // var textNum = document.getElementById('TestNum');
            var user_name = $(".register_page").find("#registerUserName").val();
            var user_pwd = $(".register_page").find("#registerPassWord").val();

            var user_email = $(".register_page").find("#Email").val();
            var register_error = $(".register_error");
            var test = $("#Test").val();
            if((user_name == "") || (user_pwd == "") || (user_email == "")){
                register_error.text("账号和密码和邮箱不能为空");
            }
            else{
                register_error.text("");
                $.ajax({
                    type: "post",
                    url: url + "/user/register",
                    data: {
                        user_name: user_name,
                        user_pwd: user_pwd,
                        user_email: user_email,
                        test:test
                    },
                    dataType: "json",
                    success: function(data){
                        console.log(data);
                        if(data == "success"){
                            window.alert("注册成功！");
                            window.location.href="./login.jsp";
                        }else if(data == "fail"){
                            register_error.text('该账号已被注册!');
                        }else {
                            console.log(data);
                        }
                    }
                });
            }
        }

    </script>
    <!-- ------------------------------------------------------------------- -->
</body>
</html>