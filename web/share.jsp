<%@ page import="dao.Dao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: yuqLiu
  Date: 2019/5/29
  Time: 17:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%

    String docName = request.getParameter("docName");
    String path = request.getParameter("path");
    String authority = request.getParameter("authority");
    String docID =" ";

    Dao dao = new Dao();
    Connection conn = dao.getConnection();

    try {
        PreparedStatement p1 = conn.prepareStatement("select * from document where text_path='"
                + path.replace("\\","/") + "'");
        ResultSet rs1 = p1.executeQuery();
        rs1.next();
        docID = rs1.getString("iddocument");
    }

    catch (Exception e)
    {
        e.printStackTrace();
    }


%>

<html>

<head>
    <title>Title</title>
    <script src="js/dynamicLoadFile.js"></script>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
    <script type="text/javascript" src="/js/bootstrap.js"></script>
</head>

<body>

<p id="docID" hidden="hidden"><%=docID%></p>
<p id="path" hidden="hidden"><%=path%></p>
<p id="authority" hidden="hidden"><%=authority%></p>

<div class="alert alert-success" style="font-size:15px;">
    <p>您要分享的文档为:<span><strong><%=docName%></strong></span></p>
    <p style="margin-top:20px;">您授予的权限为:<span><strong><s:property value="authority"/></strong></span></p>
</div>
<button type="button" class="btn btn-default" onclick=createLink() style="margin-left:25px;">确认生成链接</button>
<div class="input-group" id="share" style="width:30%;visibility:hidden; margin-top:20px;margin-left:25px;">
    <input type="text" class="form-control" id="shareLink">
    <span class="input-group-btn">
        <button class="btn btn-default" type="button" onclick="copyText()">复制链接</button>
    </span>
</div>
<script>
    function createLink() {
        var docID = document.getElementById("docID").innerHTML;
        var authority = document.getElementById("authority").innerHTML;
        var curURL = self.location.href;
        var index = curURL.lastIndexOf("/");
        var a = document.getElementById("shareLink");
        a.value = curURL.substring(0,index)+"/confirm_share_login.jsp?docID=" + docID+"&authority="+authority;
        document.getElementById("share").style.visibility = "visible";
    }
    function copyText() {
        document.getElementById("shareLink").select();
        document.execCommand("copy");
    }
</script>

</body>
</html>
