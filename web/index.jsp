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
    <title>欢迎页面</title>
</head>
<body>
<h1 style="text-align: center;margin-top: 50px;margin-bottom: 200px">Welcme to OnlineDocs！</h1>
<div class="mx-auto" style="width: 500px;">
    <div class="container">
        <div class="row">
            <div class="col-sm">
                <form action="mySigninAction.action" method="post">
                    <button type="submit" class="btn btn-secondary btn-lg" value="Signin" name="signin">
                        Sign In
                    </button>
                </form>

            </div>
            <div class="col-sm">
                <form action="mySignupAction.action" method="post">
                    <button type="submit" class="btn btn-secondary btn-lg" value="Signup" name="signup">
                        Sign Up
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
