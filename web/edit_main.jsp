<%--
  Created by IntelliJ IDEA.
  User: yuqLiu
  Date: 2019/5/16
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="File.*"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.File"%>
<html>
<head>
    <title>编辑文档界面</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.12.5/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <script src="jquery-3.2.0.min.js"></script>

</head>
<body onload="loadContent()">

<%
    //String filePath = request.getSession().getServletContext().getRealPath("/")+"JSP_Ajax"+"\\";
    //System.out.println("filePath=="+filePath);
    String path =request.getParameter("path");   // 这边文件目录需改成相对路径
    String content = request.getParameter("content");
    File file = new File(path);
    FileReader fr = new FileReader(file);  //字符输入流
    BufferedReader br = new BufferedReader(fr);  //使文件可按行读取并具有缓冲功能
    StringBuffer strB = new StringBuffer();   //strB用来存储jsp.txt文件里的内容
    String str = br.readLine();
    while(str!=null){
        strB.append(str);   //将读取的内容放入strB
        str = br.readLine();
    }
    br.close();    //关闭输入流
%>

<div class="row">
    <div class="col-4">
        <a href="index.jsp">&lt;返回</a>
        <p>文件名</p>
    </div>
    <div class="col-8">
        <nav class="navbar navbar-expand-lg navbar-light bg-light" style="width:800px">
            <a class="navbar-brand" href="#">Navbar</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">文件<span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Pricing</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            编辑
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                            <a class="dropdown-item" href="#">复制</a>
                            <a class="dropdown-item" href="#">粘贴</a>
                            <a class="dropdown-item" href="#">Something else here</a>
                        </div>
                    </li>
                </ul>
            </div>
        </nav>
    </div>
</div>
<div class="row">

    <div class="col-4">
        <nav class="navbar flex-column navbar-light bg-light">
            <span class="navbar-brand mb-0 h1">文档信息：</span>
            <span class="navbar-brand mb-0 h1">创建者：</span>
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
      <!--<button class="ql-indent" value="-1"></button>
      <button class="ql-indent" value="+1"></button>-->
    </span>
                <span class="ql-formats">
      <button class="ql-direction" value="rtl"></button>
      <select class="ql-align"></select>
    </span>

                <span class="ql-formats">
      <button class="ql-clean"></button>
    </span>
            </div>
            <div id="editor-container"></div>
        </div>
    </div>

</div>

<div>
    <form id="saveFileForm" action="FileSaveAction" enctype='multipart/form-data' method='post'>

        <input id="path" hidden="hidden" name="path" value=<s:property value="path"/> >
        <input id="content" hidden="hidden" name="content"/>
        <input type="submit" onclick="updateContent()" value="保存文件"/>
    </form>
</div>


<label id="existFileContent" hidden="hidden"><%=strB%></label>
<label id="updatedContent" hidden="hidden"><%=content%></label>


<!-- Include the Quill library -->
<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>

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

    function loadContent() {
        var html = document.querySelector('#editor-container').children[0].innerHTML;
        var content = document.getElementById("existFileContent").innerHTML;
        this.quill.pasteHTML(content)

    }



    function updateContent() {
        var a = document.querySelector('#editor-container').children[0].innerHTML;
        document.getElementById("content").value = a;
        console.log(a)
    }


    function ReadFiles() {
        var reader = new FileReader();//新建一个FileReader
        var path = document.getElementById("existFilePath").innerHTML;
        reader.readAsText(path, "UTF-8");//读取文件
    }


</script>




</body>
</html>