<%--
  Created by IntelliJ IDEA.
  User: yuqLiu
  Date: 2019/5/29
  Time: 16:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.apache.struts2.ServletActionContext" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="dao.Dao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<html>

<%
    String docID = request.getParameter("docID");
    String username = request.getParameter("username");
    String authority = request.getParameter("authority");
    String userID = " ";
    Dao dao = new Dao();
    Connection conn = dao.getConnection();
    String docName =" ";
    try {
        PreparedStatement p1 = conn.prepareStatement("select * from document where iddocument='" + docID + "'");
        ResultSet rs1 = p1.executeQuery();
        rs1.next();
        docName = rs1.getString("document_name");

        PreparedStatement p2 = conn.prepareStatement("select * from user where user_name='" + username + "'");
        ResultSet rs2 = p2.executeQuery();
        rs2.next();
        userID = rs2.getString("iduser");
    }
    catch (Exception e)
    {
        e.printStackTrace();
    }

%>

<head>
    <title>Title</title>
    <script src="js/dynamicLoadFile.js"></script>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
    <script type="text/javascript" src="/js/bootstrap.js"></script>
</head>
<body onload="setMessage()">


<div class="alert alert-info">
    <p>确认界面</p>
    <p style="margin-top:15px;"><span><strong><%=username%></strong></span>用户你好</p>
    <p style="margin-top:15px;"><span><strong><%=docName%></strong></span></p>
    <p style="margin-top:15px;">文档:<span><strong><%=docID%></strong></span></p>
    <p style="margin-top:15px;">获得的权限为<span><strong><%=authority%></strong></span></p>
</div>

<label id="wrongMessage" hidden="hidden"><s:property value="wrongMessage"/></label>

<form action="ConfirmAction" enctype='multipart/form-data' method='post'>
    <input hidden="hidden" name="userID" value=<%=userID%>>
    <input hidden="hidden" name="docID" value=<%=docID%>>
    <input hidden="hidden" name="authority" value=<%=authority%>>
    <input hidden="hidden" name="username" value=<%=username%>>
    <button type="submit" class="btn btn-default" style="margin-left:20px;">确认</button>
</form>

<div id="fail_share" class="alert alert-danger" align="center" style="padding-top:20px;font-size:15px;display: none;">
    <span><strong>确认失败！你已经有该文档的分享权限。</strong></span>
</div>

<div id="fail_read" class="alert alert-danger" align="center" style="padding-top:20px;font-size:15px;display: none;">
    <span><strong>确认失败！你已经有该文档的读取权限。</strong></span>
</div>
<form id="fail_jump" action="Signin" enctype='multipart/form-data' method='post' style="display: none;">
    <input hidden="hidden" name="username" value=<%=username%>>
    <button type="submit" class="btn btn-default" style="margin-left:20px;">前往文档主页</button>
</form>
<script>
    function setMessage(){
        var wrongMessage = document.getElementById("wrongMessage").innerHTML;
        if(wrongMessage == "share")
        {
            console.log("111");
            var a = document.getElementById("fail_share");
            var b = document.getElementById("fail_jump");
            a.style.display="block";
            b.style.display="block";

        }
        else if(wrongMessage == "read")
        {
            console.log("222");
            var a = document.getElementById("fail_read");
            var b = document.getElementById("fail_jump");
            a.style.display="block";
            b.style.display="block";
        }

    }


</script>

</body>
</html>
