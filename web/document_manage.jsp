<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="org.apache.struts2.ServletActionContext" %>
<%@ page import="java.io.File" %>
<%@ page import="dao.Dao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: agno3
  Date: 2019/5/9
  Time: 15:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String path=ServletActionContext.getServletContext().getRealPath("/fileUpload/") + request.getAttribute("username");
    File file_create = new File(path  + "/create/");
    File[] fileList_create = file_create.listFiles();
    String fnameList_create="";

    if (fileList_create!=null && fileList_create.length!=0){
        for (int i = 0; i < fileList_create.length; i++) {
            if (fileList_create[i].getName().indexOf("_t")==-1){
                fnameList_create+=fileList_create[i].getName()+",";
            }
        }
        fnameList_create=fnameList_create.substring(0,fnameList_create.length()-1);
    }

    String shareDocsNameList="";
    String shareDocsPathList="";
    Dao dao = new Dao();
    Connection conn = dao.getConnection();

    PreparedStatement p2 = conn.prepareStatement("select * from user " +
            "where user_name='"+request.getAttribute("username")+"'");
    ResultSet rs2 = p2.executeQuery();
    rs2.next();
    String uid=rs2.getString("iduser");

    PreparedStatement p1 = conn.prepareStatement("select * from cooperate " +
            "where user_iduser='"+uid+"' and permission='share'");
    ResultSet rs1 = p1.executeQuery();
    List<String> shareDocs=new ArrayList<>();
    boolean hasShare=false;
    while (rs1.next()){
        hasShare=true;
        shareDocs.add(rs1.getString("document_iddocument"));
    }

    if (hasShare){
        for (String temp_s:shareDocs){
            PreparedStatement p3 = conn.prepareStatement(
                    "select * from document " +
                            "where iddocument='"+temp_s+"'");
            ResultSet rs3 = p3.executeQuery();
            rs3.next();
            shareDocsNameList+=rs3.getString("document_name")+",";
            shareDocsPathList+=rs3.getString("text_path")+",";
            dao.close(rs3,p3);
        }

        shareDocsNameList = shareDocsNameList.substring(0,shareDocsNameList.length() - 1);
        shareDocsPathList = shareDocsPathList.substring(0,shareDocsPathList.length() - 1);

    }

    dao.close(rs1,p1);
    dao.close(rs2,p2);
    dao.close(conn);

%>
<html>
<head>
    <script src="js/dynamicLoadFile.js"></script>
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
    <link rel="stylesheet" href="css/document_manage.css" type="text/css">
    <title>登陆状态</title>
</head>
<body onload="dynamic()">
<label id="list_create" hidden="hidden" ><%=fnameList_create %></label>
<label id="path" hidden="hidden" ><%=path %></label>
<label id="username" hidden="hidden" ><s:property value="username"/></label>
<label id="shareDocsNameList" hidden="hidden" ><%=shareDocsNameList %></label>
<label id="shareDocsPathList" hidden="hidden" ><%=shareDocsPathList %></label>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">OnlineDocs</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="#">Home</a>
            </li>
        </ul>
        <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
    </div>
</nav>

<form action= "uploadAction"  enctype="multipart/form-data" method="post" id="upload" align="right" >
    <input type="text" style ="display:none" name="username" value=<s:property value="username"/> >
    <span><strong>上传新文件：</strong></span><input type="file" name="fileUpload"/>
    <button type='submit' class='btn btn-success' style="margin-left:-50px;">提交</button>
</form>

<div class="container" id="create_part">
    <h3 class='text-left'>您创建的文档：</h3>
    <div id="creat_list" class="container">
    </div>
</div>

<div class="container" id="coop_part">
    <h3 class='text-left'>您合作的文档：</h3>
    <div id="coop_list" class="container">
    </div>
</div>
</body>
</html>
