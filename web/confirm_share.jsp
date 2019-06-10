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
<body>


<div class="alert alert-info">
    <p>确认界面</p>
    <p style="margin-top:15px;"><span><strong><%=username%></strong></span>用户你好</p>
    <p style="margin-top:15px;"><span><strong><%=docName%></strong></span></p>
    <p style="margin-top:15px;">文档:<span><strong><%=docID%></strong></span></p>
    <p style="margin-top:15px;">获得的权限为<span><strong><%=authority%></strong></span></p>
</div>
<form action="ConfirmAction" enctype='multipart/form-data' method='post'>
    <input hidden="hidden" name="userID" value=<%=userID%>>
    <input hidden="hidden" name="docID" value=<%=docID%>>
    <input hidden="hidden" name="authority" value=<%=authority%>>
    <button type="submit" class="btn btn-default" style="margin-left:20px;">确认</button>
</form>
</body>
</html>
