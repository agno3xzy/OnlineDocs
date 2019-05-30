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
    Dao dao = new Dao();
    Connection conn = dao.getConnection();
    String docName =" ";
    try {
        PreparedStatement p1 = conn.prepareStatement("select * from document where iddocument='" + docID + "'");
        ResultSet rs1 = p1.executeQuery();
        rs1.next();
        docName = rs1.getString("document_name");
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
</body>
</html>
