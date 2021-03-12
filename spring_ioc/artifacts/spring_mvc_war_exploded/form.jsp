<%--
  Created by IntelliJ IDEA.
  User: zly
  Date: 2021/3/12
  Time: 13:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Form</title>
</head>
<body>
    <form action="${pageContext.request.contextPath}/user/quick14" method="post">
        <%--表明是第几个user对象的username age--%>
        <input type="text" name="userList[0].name"><br/>
        <input type="text" name="userList[0].age"><br/>
        <input type="text" name="userList[1].name"><br/>
        <input type="text" name="userList[1].age"><br/>
        <input type="submit" value="submit">
    </form>
</body>
</html>
