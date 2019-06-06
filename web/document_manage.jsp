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
    File file_create = new File(path  + "\\create\\");
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

    <title>登陆状态</title>
</head>
<body onload="dynamic()">

<div class="alert alert-success" role="alert" style="text-align: center">
    <h4 class="alert-heading" >Well done,  <s:property value="username"/> !</h4>
    <p>Aww yeah, you have successfully login in!</p>
    <hr>
    <p class="mb-0">Start OnlineDocs Now!</p>

    <label id="list_create" hidden="hidden" ><%=fnameList_create %></label>
    <label id="path" hidden="hidden" ><%=path %></label>
    <label id="username" hidden="hidden" ><s:property value="username"/></label>
    <label id="shareDocsNameList" hidden="hidden" ><%=shareDocsNameList %></label>
    <label id="shareDocsPathList" hidden="hidden" ><%=shareDocsPathList %></label>

    <div class="container">
        <h3 class='text-left'>您创建的文档：</h3>
        <div id="creat_list" class="container">
        </div>
        <form action= "uploadAction"    enctype="multipart/form-data" method="post"  >
            <input type="text" style ="display:none" name="username" value=<s:property value="username"/> >
            上传文件<input type="file" name="fileUpload"  />
            <button type='submit' class='btn btn-success ' >提交</button>
        </form>
    </div>

    <div class="container">
        <h3 class='text-left'>您合作的文档：</h3>
        <div id="coop_list" class="container">
        </div>
    </div>
</div>
</body>
</html>
