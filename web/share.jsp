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
</head>

<body>

<p id="docID" hidden="hidden"><%=docID%></p>
<p id="path" hidden="hidden"><%=path%></p>
<p id="authority" hidden="hidden"><%=authority%></p>


<p>您要分享的文档为:<%=docName%></p>
<p>您授予的权限为:<s:property value="authority"/></p>
<button onclick=createLink()>确认生成链接</button>
<p id="shareLink"></p>

<script>
    function createLink() {
        var docID = document.getElementById("docID").innerHTML;
        var authority = document.getElementById("authority").innerHTML;
        var curURL = self.location.href;
        var index = curURL.lastIndexOf("/");
        var a = document.getElementById("shareLink");
        a.innerHTML = curURL.substring(0,index)+"/confirm_share_login.jsp?docID=" + docID+"&authority="+authority;
    }

</script>

</body>
</html>
