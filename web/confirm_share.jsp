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
</head>
<body>



<p>确认界面</p>
<p><%=username%>用户你好</p>
<p><%=docName%></p>
<p><%=docID%></p>
<p>获得的权限为<%=authority%></p>
<form action="ConfirmAction" enctype='multipart/form-data' method='post'>
    <input hidden="hidden" name="userID" value=<%=userID%>>
    <input hidden="hidden" name="docID" value=<%=docID%>>
    <input hidden="hidden" name="authority" value=<%=authority%>>
    <button type="submit">确认</button>
</form>
</body>
</html>
