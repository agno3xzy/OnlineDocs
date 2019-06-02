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

    String path = request.getParameter("path");   // 这边文件目录需改成相对路径
    String content = request.getParameter("content");
    String docOwner = request.getParameter("docOwner");
    String docSharer = request.getParameter("docSharer");

    try {
        PreparedStatement p1 = conn.prepareStatement("select * from document where text_path='" + path + "'");
        ResultSet rs1 = p1.executeQuery();
        rs1.next();
        docName = rs1.getString("document_name");
    }
    catch (Exception e)
    {
        e.printStackTrace();
    }
    File file = new File(path);
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
                        <input hidden="hidden" name="path" value=<%=path%>>
                        <input hidden="hidden" name="authority" value="查看">
                        <button type="submit">分享查看权限</button>
                    </form>

                        <form action="ShareAction" enctype='multipart/form-data' method='post'>
                            <input hidden="hidden" name="docName" value=<%=docName%>>
                            <input hidden="hidden" name="path" value=<%=path%>>
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
            <div id="editor-container"></div>
        </div>
    </div>
</div>
<label id="username" hidden="hidden" ><s:property value="username"/></label>
<label id="path" hidden="hidden" ><s:property value="path"/></label>

<div style="text-align: center;margin-top: 50px">
    <form id="saveFileForm" action="FileSaveAction" enctype='multipart/form-data' method='post'>
        <input hidden="hidden" name="path" value=
        <s:property value="path"/>>
        <input hidden="hidden" name="username" value=
        <s:property value="username"/>>
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
<label id="existFileContent" hidden="hidden"><%=strB%>
</label>
<label id="updatedContent" hidden="hidden"><%=content%>
</label>


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
var content;
var new_content;
var flag = false
    function loadContent() {
        var html = document.querySelector('#editor-container').children[0].innerHTML;
        content = document.getElementById("existFileContent").innerHTML;
        this.quill.pasteHTML(content)
    }
    function replaceAll(str1,str2)
    {
        while(str1.indexOf(str2) != -1)
        {
            str1 = str1.replace(str2,"");
        }
        return str1;
    }
    function timeUpdate() {
        var dmp = new diff_match_patch();
        if(flag){
            content = new_content;
        } else
        {
            flag = true;
        }
        new_content = document.getElementById('editor-container').children[0].innerHTML;
        var diff = dmp.diff_main(content.replace('<br>',''),new_content.replace('<br>',''));
        var linecount = 0;
        var position = 0;//记录删除的插入的位置
        //var diff = Diff.diffChars(content.replace('<br>',''),new_content.replace('<br>',''))
        console.log(new_content.replace('<br>',''));
        var result = ""; //最终发送给后端的数据 格式:"ins"/"del","line","startposition","content".
        for(var i = 0; i < diff.length; i++)
        {
            var difflist = Array.from(diff[i]); //格式:[插入(1)/删除(-1)/相等(0),对应的字符串]
            var difftype = difflist[0]; //0：相等 1：插入 -1：删除
            var diffstring = difflist[1];
            var re = new RegExp("<p>","g");
            var re2 = new RegExp("</p>","g");
            var startcount = 0; //<p>出现的次数
            var endcount = 0; //</p>出现的次数
            if(diffstring.match(re) != null)
            {
                startcount = diffstring.match(re).length;
            }
            if(diffstring.match(re2) != null)
            {
                endcount = diffstring.match(re2).length;
            }
            if(diffstring.replace('\n','') !== '') //可能会出现一个单独的换行符
            {
                if(difftype === 1) //如果是插入操作 四种情况 aaa </p><p>aaa</p><p>bbb aaa</p><p>bbb</p><p> <p>aaa</p><p>bbb</p>
                {
                    if(startcount == 0) //还是同一行的操作 类似于 aaa或者aaa</p>
                    {
                        if(endcount == 0) //aaa的情况
                        {
                            var beforedifflist = Array.from(diff[i-1]);
                            var nextdifflist = Array.from(diff[i+1]);
                            var beforediffstring = beforedifflist[1];
                            var nextdiffstring = nextdifflist[1];
                            var beforedifftype = beforedifflist[0];
                            var nextdifftype = nextdifflist[0];
                            if(beforediffstring.lastIndexOf("<p>") == beforediffstring.length - 3 && nextdiffstring.indexOf("</p>") == 0
                                && beforedifftype == 0 && nextdifftype == 0)
                            {
                                console.log("+1");
                                position = 0;
                                linecount += 1;
                            }
                            result = result + "ins," + linecount.toString() + "," + position.toString() + "," + diffstring.toString() + ",false.";
                            //position += diffstring.length; //位置向后挪
                        }
                    } else //分行
                    {
                        /*
                            if(endcount == 0) //在本操作中 新起一行没有结束 类似于 aaa<p>bbb 或者 <p>aaa
                        {
                            if(diffstring.indexOf("<p>") == 0) //<p>aaa的情况
                            {
                                position = 0;
                                //linecount += 1;//遇到p标签新起一行
                                result = result + "ins," + linecount.toString() + "," + position.toString() + "," + diffstring.replace("<p>","") + ".";
                            } else //aaa<p>bbb的情况
                            {
                                var textlist = diffstring.split("<p>"); //分割成['aaa','bbb']的格式
                                result = result + "ins," + linecount.toString() + "," + position.toString() + "," + textlist[0] + ".";
                                position = 0;//下一行
                                //linecount += 1;
                                result = result + "ins," + linecount.toString() + "," + position.toString() + "," + textlist[1] + ".";
                                //position += textlist[1].length; //位置向后挪
                            }
                        } else //有结束标签</p>
                        {
                            if(diffstring.indexOf("<p>") == 0) //<p>aaa</p><p>bbb</p><p>ccc</p> 或者 <p>aaa</p><p>bbb</p><p>ccc两种情况
                            {
                                diffstring = replaceAll(diffstring,"<p>");
                                var textlist = diffstring.split("</p>");
                                console.log(textlist);
                                if(diffstring.lastIndexOf("</p>") == diffstring.length - 4) //</p>在字符串的最后 <p>aaa</p><p>bbb</p><p>ccc</p>这种情况
                                {
                                    for(var j = 0; j < textlist.length - 1; j++) //字符串分割时 最后会出现一个""
                                    {
                                        position = 0;
                                        //linecount += 1;//遇到p标签新起一行
                                        result = result + "ins," + linecount.toString() + "," + position.toString() + "," + textlist[j] + ".";
                                    }
                                    position = 0;
                                } else //</p>标签不在最后 <p>aaa</p><p>bbb</p><p>ccc的情况
                                {
                                    for(var j = 0; j < textlist.length; j++)
                                    {
                                        position = 0;
                                        //linecount += 1;//遇到p标签新起一行
                                        result = result + "ins," + linecount.toString() + "," + position.toString() + "," + textlist[j] + ".";
                                    }
                                    //position += textlist[textlist.length-1].length;
                                }
                            } else //开头不是<p>标签 aaa</p><p>bbb</p><p>ccc</p> 或者 aaa</p><p>bbb</p><p>ccc两种情况
                            {
                                var isLPlabelEnd = false; //是否为<p>结尾
                                var isRPlabelIndex = false; //是否为</p>开头
                                if(diffstring.lastIndexOf("<p>") == diffstring.length - 3)
                                {
                                    isLPlabelEnd = true;
                                }
                                if(diffstring.indexOf("</p>") == 0)
                                {
                                    position = 0;
                                    isRPlabelIndex = true;
                                }
                                diffstring = replaceAll(diffstring,"<p>");
                                var textlist = diffstring.split("</p>");
                                if(isRPlabelIndex)
                                {
                                    textlist.splice(0,1); //把数组第一个空字符串剔除
                                }
                                result = result + "ins," + linecount.toString() + "," + position.toString() + "," + textlist[0] + ".";
                                if(diffstring.lastIndexOf("</p>") == diffstring.length - 4) //</p>在字符串的最后 aaa</p><p>bbb</p><p>ccc</p>这种情况
                                {
                                    for(var j = 1; j < textlist.length - 1; j++) //字符串分割时 最后会出现一个""
                                    {
                                        position = 0;
                                        //linecount += 1;
                                        result = result + "ins," + linecount.toString() + "," + position.toString() + "," + textlist[j] + ".";
                                    }
                                    position = 0;
                                    if(isLPlabelEnd && i != diff.length-1) //如果diffstring的最后是<p> 且不是最后一个条目
                                    {
                                        if(Array.from(diff[i+1][0]) == 0)
                                        {
                                            linecount += 1;
                                        }
                                    }
                                } else // </p>标签不在最后 aaa</p><p>bbb</p><p>ccc这种情况
                                {
                                    for(var j = 1; j < textlist.length; j++) //字符串分割时 最后会出现一个""
                                    {
                                        position = 0;
                                        //linecount += 1;
                                        result = result + "ins," + linecount.toString() + "," + position.toString() + "," + textlist[j] + ".";
                                    }
                                    //position += textlist[textlist.length-1].length;
                                }
                            }
                        }
                         */
                        if(diffstring.indexOf("<p>") == 0 && diffstring.lastIndexOf("</p>") == diffstring.length - 4) //<p>aaa</p>
                        {
                            diffstring = replaceAll(diffstring,"<p>");
                            var textlist = diffstring.split("</p>");
                            textlist.splice(textlist.length-1,1);
                            for(var j = 0; j < textlist.length; j++)
                            {
                                result = result + "ins," + linecount.toString() + "," + position.toString() + "," + textlist[j].toString() + ",true.";
                            }
                        }
                        if(diffstring == "</p><p>") //在中间新起一行 两种情况 新起一行或者把原有一行的一部分换行
                        {
                            var beforedifflist = Array.from(diff[i-1]);
                            var nextdifflist = Array.from(diff[i+1]);
                            var beforediffstring = beforedifflist[1];
                            var nextdiffstring = nextdifflist[1];
                            var beforedifftype = beforedifflist[0];
                            var nextdifftype = nextdifflist[0];
                            if(beforedifftype == 0 && beforediffstring.lastIndexOf("<p>") == beforediffstring.length - 3) //说明是新起一行
                            {
                                result = result + "ins," + linecount.toString() + "," + position.toString() + "," + "" + ",true.";
                            } else
                            {
                                console.log(nextdiffstring.indexOf("</p>"));
                                var alterstring = nextdiffstring.slice(0,nextdiffstring.indexOf("</p>"));
                                result = result + "del," + linecount.toString() + "," + position.toString() + "," + alterstring.toString() + ",false.";
                                position = 0;
                                result = result + "ins," + linecount.toString() + "," + position.toString() + "," + alterstring.toString() + ",true.";

                            }
                        }
                        position = 0;
                    }
                } else if (difftype == 0) //相等的匹配操作
                {
                    if(startcount == 0) //aaa或者 aaa</p>
                    {
                        if(endcount == 0) //aaa 另一种情况不需要操作
                        {
                            position += diffstring.length;
                        }
                    } else //有<p>标签
                    {
                        if(endcount == 0) //<p>aaa或者 aaa<p>bbb
                        {
                            var textlist = diffstring.split("<p>");
                            linecount += 1;
                            position = textlist[1].length;
                        } else //有</p>标签
                        {
                            linecount += startcount; //<p>标签的个数等于新的行数
                            if(diffstring.lastIndexOf("</p>") != diffstring.length - 4)
                            {
                                if(diffstring.lastIndexOf("<p>") == diffstring.length - 3 && i != diff.length - 1) //说明有下一条信息 需要进行判断最后的新建行是否为插入操作
                                {
                                    if(Array.from(diff[i+1])[0] == 1) //如果下一行是插入操作 则行数-1
                                    {
                                        console.log("-1");
                                        linecount -= 1;
                                    }
                                }
                                diffstring = replaceAll(diffstring,"<p>");
                                var textlist = diffstring.split("</p>");
                                position = textlist[textlist.length-1].length;
                            }
                        }
                    }
                } else if(difftype == -1) //删除操作
                {
                    if(startcount == 0 && endcount == 0)
                    {
                        result = result + "del," + linecount.toString() + "," + position.toString() + "," + diffstring.toString() + ",false.";
                    }
                    else
                    {
                        if(diffstring.indexOf("<p>") == 0 && diffstring.lastIndexOf("</p>") == diffstring.length - 4) //删除的整行
                        {
                            if(startcount == 1 && endcount == 1) //只删除一行
                            {
                                linecount += 1;
                                result = result + "del," + linecount.toString() + "," + position.toString() + "," + "" + ",true.";
                            } else //删除多行
                            {
                                diffstring = replaceAll(diffstring,"<p>");
                                var textlist = diffstring.split("</p>");
                                textlist.splice(textlist.length-1,1); //最后会多一个空字符串
                                for(var j = 0; j < textlist.length; j++)
                                {
                                    linecount += 1;
                                    result = result + "del," + linecount.toString() + "," + position.toString() + "," + textlist[j].toString() + ",true.";
                                }
                            }
                        } else
                        {
                            var textlist = diffstring.split("</p><p>");
                            var beforedifflist = Array.from(diff[i-1]);
                            var nextdifflist = Array.from(diff[i+1]);
                            var beforediffstring = beforedifflist[1];
                            var nextdiffstring = nextdifflist[1];
                            var beforedifftype = beforedifflist[0];
                            var nextdifftype = nextdifflist[0];
                            if(beforedifftype == 0 && nextdifftype == 0)
                            {
                                if(diffstring == "</p><p>") //只把下一行切到本行
                                {
                                    linecount += 1;
                                    result = result + "del," + linecount.toString() + "," + "0" + "," + nextdiffstring.slice(0,nextdiffstring.indexOf("</p>")) + ",true.";
                                    result = result + "ins," + (linecount-1).toString() + "," + position.toString() + "," + nextdiffstring.slice(0,nextdiffstring.indexOf("</p>")) + ",false.";
                                    position = 0;
                                } else
                                {
                                    if(beforediffstring.lastIndexOf("<p>") == beforediffstring.length - 3 && nextdiffstring.indexOf("</p>") == 0)
                                    {
                                        for(var j = 0; j < textlist.length - 1; j++)
                                        {
                                            result = result + "del," + linecount.toString() + "," + position.toString() + "," + textlist[j].toString() + ",true.";
                                            linecount += 1;
                                        }
                                        result = result + "del," + linecount.toString() + "," + position.toString() + "," + textlist[textlist.length-1].toString() + ",false.";
                                    } else
                                    {
                                        var isFirstLineDel = true; //第一行是否完全删除
                                        var firstdelline = linecount; //删除的第一行位置
                                        var appendposition = position;
                                        if(beforediffstring.lastIndexOf("<p>") == beforediffstring.length - 3)
                                        {
                                            result = result + "del," + linecount.toString() + "," + position.toString() + "," + textlist[0].toString() + ",true.";
                                        } else
                                        {
                                            result = result + "del," + linecount.toString() + "," + position.toString() + "," + textlist[0].toString() + ",false.";
                                            position = 0;
                                            isFirstLineDel = false;
                                        }
                                        for(var j = 1; j < textlist.length - 1; j++)
                                        {
                                            linecount += 1;
                                            result = result + "del," + linecount.toString() + "," + position.toString() + "," + textlist[j].toString() + ",true.";
                                        }
                                        linecount += 1;
                                        if(nextdiffstring.indexOf("</p>") == 0)
                                        {
                                            result = result + "del," + linecount.toString() + "," + position.toString() + "," + textlist[textlist.length-1].toString() + ",true.";
                                        } else
                                        {
                                            if(isFirstLineDel)
                                            {
                                                result = result + "del," + linecount.toString() + "," + position.toString() + "," + textlist[textlist.length-1].toString() + ",false.";
                                            } else
                                            {
                                                var appendstring = nextdiffstring.slice(0,nextdiffstring.indexOf("</p>"));
                                                result = result + "del," + linecount.toString() + "," + position.toString() + "," + textlist[textlist.length-1].toString() + appendstring + ",true.";
                                                result = result + "ins," + firstdelline.toString() + "," + appendposition.toString() + "," + appendstring.toString() + ",false.";
                                            }
                                        }
                                    }
                                }

                            }
                        }
                    }
                }
            }
        }
        var xhr = new XMLHttpRequest();
        var urlString = "handleConflict.action?"
        var args="username=" + document.getElementById("username").innerHTML
            + "&operation="+result
            + "&path="+document.getElementById("path").innerHTML;

        //window.alert(document.getElementById("username").value);
        xhr.open("post",urlString,true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;");//不加上这句，那么后台Request.Form获取不到参数a,b的数值
        xhr.send(args);

        //检查响应状态
        xhr.onreadystatechange = function() {
            //console.log("xhr.readyState"+xhr.readyState);
            if(xhr.readyState == 4) {
                //console.log("xhr.status"+xhr.status);
                if((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304) {
                    //console.log(xhr.responseText);
                    //console.log(document.getElementById("password").value);

                }
            }
        };
        console.log(urlString);
        console.log(args);
        console.log(diff);
        console.log(result);
    }
    setInterval(timeUpdate,500);
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
