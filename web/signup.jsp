<%--
  Created by IntelliJ IDEA.
  User: agno3
  Date: 2019/5/9
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="js/checkSignup.js"></script>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
            integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="css/guide.css" />
    <title>用户注册</title>
</head>
<body>
<h1 style="text-align: center;margin-top: 50px;margin-bottom: 200px">OnlineDocs 用户注册</h1>
<div class="mx-auto" style="width: 500px;">
    <div class="alert alert-danger" role="alert" id="alert" style="visibility:hidden;">
    </div>
    <form action="Signup.action" method="post">
        <div class="form-group">
            <label for="username">请输入您的用户名：</label>
            <input type="text" name="username" class="form-control" id="username" placeholder="Example input" required="true" onblur="checkUsernameExist()">
        </div>
        <div class="form-group">
            <label for="password">请输入您的密码</label>
            <input type="password" name="password" class="form-control" id="password" placeholder="Another input" required="true">
        </div>
        <div class="form-group">
            <label for="confirmpassword">请再次输入您的密码</label>
            <input type="password" class="form-control" id="confirmpassword" placeholder="Another input" required="true">
        </div>
        <div class="form-group row">
            <div class="col-sm-10">
                <button type="submit" class="btn btn-primary" onclick="return validate()">Sign Up</button>
            </div>
        </div>
    </form>
    <div class="guide">
        <div class="guide-wrap">
            <a href="javascript:history.back(-1)" class="report" title="返回"><span>返回</span></a>
        </div>
    </div>
</div>

</body>
</html>
