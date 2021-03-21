<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html lang="en">
<head>
</head>
<body>
    <div class="footer">
        <div>
            <p>淘淘电影网上购票系统</p>
            <p>
               友情链接:
                <a href="https://maoyan.com/" target="_blank" style="margin-right:30px;">猫眼电影</a>
                <span onclick="footerBtn()" style="height: 20px; cursor: pointer; border-left:0px">
                    客服：
                    <img src="../static/images/客服.jpg" style="width: 20px;">
                </span>
            </p>
            <p>
                组长：冯韵嘉
                小组成员：张乐宇、华睿祺、李新豪、仝启航、杨圣宇
                <br>
            </p>
            <p>©2021 版权归小组成员所有</p>
        </div>
    </div>
</body>
<script>
//客服
        function footerBtn(){
            layui.use(['layer'], function(){
                var layer = layui.layer;
                layer.open({
                    type: 1
                    ,title: "客服" //不显示标题栏
                    ,closeBtn: false
                    ,area: '400px;'
                    ,shade: 0.8
                    ,offset: clientHeight/20
                    ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
                    ,btn: ['确认', '取消']
                    ,yes: function(){
                        layer.close(layer.index);
                    }
                    ,btnAlign: 'c'
                    ,moveType: 0 //拖拽模式，0或者1
                    ,content: 
                        "<div style=\"text-align: center; margin: 20px 0 10px 0;\">" +
                            "<img src=\"../static/images/美女客服.jpg\" style=\"width:320px;\">" +
                        "</div>"
                });
            });
        }
</script>
</html>