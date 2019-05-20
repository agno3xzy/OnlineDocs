<%--
  Created by IntelliJ IDEA.
  User: agno3
  Date: 2019/4/25
  Time: 16:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
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
    <title>用户登录</title>
</head>
<body>
<h1 style="text-align: center;margin-top: 50px;margin-bottom: 200px">OnlineDocs 用户登录</h1>
<div class="mx-auto" style="width: 500px;">

    <form action="Signin.action" method="post">
        <div class="alert alert-danger" role="alert" id="alert" style="visibility:hidden;">
        </div>
        <div class="form-group row">
            <label for="username" class="col-sm-2 col-form-label">Username</label>
            <div class="col-sm-10">
                <input type="text" name="username" class="form-control" id="username" placeholder="Username">
            </div>
        </div>
        <div class="form-group row">
            <label for="password" class="col-sm-2 col-form-label">Password</label>
            <div class="col-sm-10">
                <input type="password" name="password" class="form-control" id="password" placeholder="Password" onblur="checklogin()">
            </div>
        </div>
        <div class="form-group row">
            <div class="col-sm-10">
                <button type="submit" class="btn btn-primary" onclick="return validate()">Sign in</button>
            </div>
        </div>
    </form>
</div>

<script type="text/javascript">
    function checklogin(){
        var xhr = new XMLHttpRequest();
        var urlString = "/OnlineDocs/passwordCheck.action?username="
            + document.getElementById("username").value;
        xhr.open("post",urlString,true);
        xhr.send(null);
        //检查响应状态
        xhr.onreadystatechange = function() {
            if(xhr.readyState == 4) {
                if((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304) {
                    console.log(xhr.responseText);
                    console.log(document.getElementById("password").value);
                    if(xhr.responseText == "") {
                        flag = false;
                    } else {
                        if(xhr.responseText== document.getElementById("password").value)
                        {
                            document.getElementById("alert").style.visibility = "hidden";
                        } else
                        {
                            document.getElementById("alert").style.visibility = "visible";
                            $("#alert").html("用户名或密s码错误");
                        }
                    }
                }
            }
        };
    }
    function validate() {
        if(document.getElementById("alert").style.visibility == "visible") {
            return false;
        } else {
            return true;
        }
    }

</script>
</body>
</html>

