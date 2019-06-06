<%--
  Created by IntelliJ IDEA.
  User: yuqLiu
  Date: 2019/5/16
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="dao.Dao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="File.*" %>
<%@page import="java.io.BufferedReader" %>
<%@page import="java.io.FileReader" %>
<%@page import="java.io.File" %>
<html>
<head>
    <title>编辑文档界面</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/quill.snow.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
    <script src="js/DiffToStringArray.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.12.5/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <script src="jquery-3.2.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/guide.css"/>

</head>
<body onload="loadContent()">

<%

    Dao dao = new Dao();
    Connection conn = dao.getConnection();
    String docName = " ";

    String oldpath = request.getParameter("path");
    String[] string_t=request.getParameter("path").split("\\\\");
    String[] string_tt=string_t[string_t.length-1].split("\\.");
    string_tt[0]+="_t";
    string_t[string_t.length-1]=String.join(".",string_tt);
    String newpath = String.join("\\",string_t);   // 这边文件目录需改成相对路径
    String content = request.getParameter("content");
    String docOwner = request.getParameter("docOwner");
    String docSharer = request.getParameter("docSharer");

    try {
        PreparedStatement p1 = conn.prepareStatement("select * from document where text_path='"
                + oldpath.replace("\\","/") + "'");
        ResultSet rs1 = p1.executeQuery();
        rs1.next();
        docName = rs1.getString("document_name");
    }
    catch (Exception e)
    {
        e.printStackTrace();
    }
    File file = new File(newpath);
    FileReader fr = new FileReader(file);  //字符输入流
    BufferedReader br = new BufferedReader(fr);  //使文件可按行读取并具有缓冲功能
    StringBuffer strB = new StringBuffer();   //strB用来存储jsp.txt文件里的内容
    String str = br.readLine();
    while (str != null) {
        strB.append(str);   //将读取的内容放入strB
        str = br.readLine();
    }
    br.close();    //关闭输入流
%>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">OnlineDocs</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Link</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
                   aria-haspopup="true" aria-expanded="false">
                    分享
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">

                    <form action="ShareAction" enctype='multipart/form-data' method='post'>
                        <input hidden="hidden" name="docName" value=<%=docName%>>
                        <input hidden="hidden" name="path" value=<%=oldpath%>>
                        <input hidden="hidden" name="authority" value="查看">
                        <button type="submit">分享查看权限</button>
                    </form>

                        <form action="ShareAction" enctype='multipart/form-data' method='post'>
                            <input hidden="hidden" name="docName" value=<%=docName%>>
                            <input hidden="hidden" name="path" value=<%=oldpath%>>
                            <input hidden="hidden" name="authority" value="编辑">
                            <button type="submit">分享编辑权限</button>
                        </form>
                    </div>
            </li>
            <li class="nav-item">
                <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
            </li>
        </ul>
        <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
    </div>
</nav>

<div class="row" style="margin-top: 50px">
    <div class="col-4" style="margin-top: 50px">
        <nav class="navbar flex-column navbar-light bg-light">
            <span class="navbar-brand mb-0 h1">文档信息：</span>
            <span class="navbar-brand mb-0 h1">创建者：<label value=<%=docOwner%>/></span>
            <span class="navbar-brand mb-0 h1">共享合作者：<label value=<%=docSharer%>/></span>
        </nav>
    </div>
    <div class="col-8">
        <div id="standalone-container" style="width:800px;height: 400px">
            <div id="toolbar-container">
    <span class="ql-formats">
      <select class="ql-font"></select>
      <select class="ql-size"></select>
    </span>
                <span class="ql-formats">
      <button class="ql-bold"></button>
      <button class="ql-italic"></button>
      <button class="ql-underline"></button>
      <button class="ql-strike"></button>
    </span>
                <span class="ql-formats">
      <select class="ql-color"></select>
      <select class="ql-background"></select>
    </span>
                <span class="ql-formats">
      <button class="ql-header" value="1"></button>
      <button class="ql-header" value="2"></button>
      <button class="ql-blockquote"></button>
      <button class="ql-code-block"></button>
    </span>
                <span class="ql-formats">
      <button class="ql-list" value="ordered"></button>
      <button class="ql-list" value="bullet"></button>

    </span>
                <span class="ql-formats">
      <button class="ql-direction" value="rtl"></button>
      <select class="ql-align"></select>
    </span>
                <span class="ql-formats">
      <button class="ql-clean"></button>
    </span>
            </div>
            <div id="editor-container" ></div>
        </div>
    </div>
</div>
<label id="username" hidden="hidden" ><s:property value="username"/></label>
<label id="oldpath" hidden="hidden" ><%=oldpath%></label>
<label id="newpath" hidden="hidden" ><%=newpath%></label>

<div style="text-align: center;margin-top: 50px">
    <form id="saveFileForm" action="FileSaveAction" enctype='multipart/form-data' method='post'>
        <input hidden="hidden" name="path" value=<s:property value="oldpath"/>>
        <input hidden="hidden" name="username" value=<s:property value="username"/>>
        <input hidden="hidden" name="content"/>
        <input type="submit" class="btn btn-primary" onclick="updateContent()" value="保存文件"/>
    </form>
</div>

<div class="guide">
    <div class="guide-wrap">
        <a href="javascript:window.scrollTo(0,0)" class="top" title="回顶部"><span>回顶部</span></a>
        <a href="javascript:history.back(-1)" class="report" title="返回"><span>返回</span></a>
    </div>
</div>
<label id="existFileContent" hidden="hidden"><%=strB%></label>
<label id="updatedContent" hidden="hidden"><%=content%></label>


<!-- Include the Quill library -->
<script src="js/quill.js"></script>
<script type="text/javascript" src="js/diff_match_patch.js"></script>
<script type="text/javascript" src="js/diff.js"></script>
<!-- Initialize Quill editor -->

<script>
    //var BackgroundClass = Quill.import('attributors/class/background');
    //var ColorClass = Quill.import('attributors/class/color');
    //var SizeStyle = Quill.import('attributors/style/size');
    //Quill.register(BackgroundClass, true);
    //Quill.register(ColorClass, true);
    //Quill.register(SizeStyle, true);

    var quill = new Quill('#editor-container', {
        modules: {
            toolbar: '#toolbar-container'
        },
        placeholder: 'Compose an epic...',
        theme: 'snow'
    });

</script>


<script type="text/javascript">
    setInterval(timeUpdate,1000);

</script>


</body>
</html>
