<%--
  Created by IntelliJ IDEA.
  User: yuqLiu
  Date: 2019/5/16
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>文档编辑界面</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/quill.snow.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
    <script src="js/DiffToStringArray.js"></script>
    <script src="js/saveFile.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.12.5/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/guide.css"/>
</head>
<body onload="loadContent()">

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
                        <input hidden="hidden" name="docName" value=<s:property value="docName"/>>
                        <input hidden="hidden" name="path" value=<s:property value="oldPath"/>>
                        <input hidden="hidden" name="authority" value="read">
                        <button type="submit">分享查看权限</button>
                    </form>

                    <form action="ShareAction" enctype='multipart/form-data' method='post'>
                        <input hidden="hidden" name="docName" value=<s:property value="docName"/>>
                        <input hidden="hidden" name="path" value=<s:property value="oldPath"/>>
                        <input hidden="hidden" name="authority" value="share">
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

<div class="alert alert-success" role="alert" id="save_success"
     style="visibility: hidden;position:absolute;top:40%;left:40%;">保存成功！
</div>
<div class="container">
    <div class="row">
        <div class="col-sm" style="width:15px;margin-top: 50px;">
            <h6>文档信息：</h6>
            <h6>创建者：<s:property value="docOwner"/></h6>
            <h6>共享合作者：<s:property value="docSharer"/></h6>
            <p>
                <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample"
                        aria-expanded="false" aria-controls="collapseExample">
                    历史版本
                </button>
            </p>

            <div class="collapse" id="collapseExample" style="width: 250px">
                    <div class="list-group" style="width: 250px;">
                    <s:iterator value="versionLog" status="L">
                        <form action='versionAction' enctype='multipart/form-data' method='post'>
                            <button type="button" class="list-group-item list-group-item-action">
                                <p class="font-weight-bold" style="color: <s:property value="color[#L.index]"/>"">
                                <s:property value="key"/>
                                </p>
                                <input type='text' style='display:none' name='timestamp'
                                       value='<s:property value="key"/>'>
                                <input hidden="hidden" name="username" value="<s:property value="username"/>">
                                <input hidden="hidden" name="oldPath" value="<s:property value="oldPath"/>">
                                <input hidden="hidden" name="newPath" value="<s:property value="newPath"/>">
                                <input type='submit' value='revert'>
                            </button>
                        </form>
                    </s:iterator>
        </div>
            </div>
        </div>
        <div class="col-sm">
            <div id="standalone-container" style="margin-left: -100px;width:600px;height: 400px">
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
                <div id="editor-container"></div>
            </div>
        </div>
    </div>


    <label id="username" hidden="hidden"><s:property value="username"/></label>
    <label id="oldpath" hidden="hidden"><s:property value="oldPath"/></label>
    <label id="newpath" hidden="hidden"><s:property value="newPath"/></label>

    <div style="text-align: center;margin-top: 150px">
        <form action="fileSaveAction" enctype='multipart/form-data' method='post'>
            <input hidden="hidden" name="oldPath" value="<s:property value="oldPath"/>">
            <input hidden="hidden" name="newPath" value="<s:property value="newPath"/>">
            <input hidden="hidden" name="username" value="<s:property value="username"/>">
            <input type="submit" class="btn btn-primary" value="保存文件"/>
        </form>
    </div>

    <div class="guide">
        <div class="guide-wrap">
            <a href="javascript:window.scrollTo(0,0)" class="top" title="回顶部"><span>回顶部</span></a>
            <a href="javascript:history.back(-1)" class="report" title="返回"><span>返回</span></a>
        </div>
    </div>
    <label id="existFileContent" hidden="hidden"><s:property value="content"/></label>


    <!-- Include the Quill library -->
    <script type="text/javascript" src="js/quill.js"></script>
    <script type="text/javascript" src="js/diff_match_patch.js"></script>
    <script type="text/javascript" src="js/diff.js"></script>
    <!-- Initialize Quill editor -->


    <script type="text/javascript">
        setInterval(timeUpdate, 100);

        var quill = new Quill('#editor-container', {
            modules: {
                toolbar: '#toolbar-container'
            },
            placeholder: 'Compose an epic...',
            theme: 'snow'
        });
    </script>


</body>
</html>
