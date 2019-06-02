<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="org.apache.struts2.ServletActionContext" %>
<%@ page import="java.io.File" %>
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
%>
<html>
<head>
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
<body>

<div class="alert alert-success" role="alert" style="text-align: center">
    <h4 class="alert-heading" >Well done,  <s:property value="username"/> !</h4>
    <p>Aww yeah, you have successfully login in!</p>
    <hr>
    <p class="mb-0">Start OnlineDocs Now!</p>

    <label id="list_create" hidden="hidden" ><%=fnameList_create %></label>
    <label id="path" hidden="hidden" ><%=path %></label>
    <label id="username" hidden="hidden" ><s:property value="username"/></label>
    <label id="shareDocsNameList" hidden="hidden" ><s:property value="shareDocsNameList"/></label>
    <label id="shareDocsPathList" hidden="hidden" ><s:property value="shareDocsPathList"/></label>

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
<script type="text/javascript">

    var path=document.getElementById("path").innerHTML;
    var username=document.getElementById("username").innerHTML;
    var fnameList_create=document.getElementById("list_create").innerHTML;
    fnameList_create=fnameList_create.split(",");
    var num_create;
    if (fnameList_create[0]=="")
        num_create=0
    else
        num_create=fnameList_create.length;
    for (var i=0;i<num_create;i++)
    {
        document.getElementById("creat_list").innerHTML+=
            "<div class='row bg-info'>"+
            "<div class='col text-left'>"+
            fnameList_create[i]+
            "</div>"+
            "<form action= 'editAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='path' value='"+path+"\\create\\"+fnameList_create[i]+"'>"+
            "<button type='submit' class='btn btn-primary '>编辑</button>"+
            "</form>"+
            "<form action= 'downloadAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='path' value='"+path+"\\create\\"+fnameList_create[i]+"'>"+
            "<button type='submit' class='btn btn-success '>下载</button>"+
            "</form>"+
            "<form action= 'deleteAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='path' value='"+path+"\\create\\"+fnameList_create[i]+"'>"+
            "<button type='submit' class='btn btn-danger '>删除</button>"+
            "</form>"+
            "<form action= 'historyAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='path' value='"+path+"\\create\\"+fnameList_create[i]+"'>"+
            "<button type='submit' class='btn btn-success '>历史</button>"+
            "</form>"+
            "</div>"
    }

    var fnameList_coop=document.getElementById("shareDocsNameList").innerHTML;
    fnameList_coop=fnameList_coop.split(",")
    var fpathList_coop=document.getElementById("shareDocsPathList").innerHTML;
    fpathList_coop=fpathList_coop.split(",")
    var num_coop;
    if (fnameList_coop[0]=="")
        num_coop=0
    else
        num_coop=fnameList_coop.length;
    for (var i=0;i<num_coop;i++)
    {
        document.getElementById("coop_list").innerHTML+=
            "<div class='row bg-info'>"+
            "<div class='col text-left'>"+
            fnameList_coop[i]+
            "</div>"+
            "<form action= 'editAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='path' value='"+fpathList_coop[i]+"'>"+
            "<button type='submit' class='btn btn-primary '>编辑</button>"+
            "</form>"+
            "<form action= 'downloadAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='path' value='"+fpathList_coop[i]+"'>"+
            "<button type='submit' class='btn btn-success '>下载</button>"+
            "</form>"+
            "<form action= 'deleteAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='path' value='"+fpathList_coop[i]+"'>"+
            "<button type='submit' class='btn btn-danger '>删除</button>"+
            "</form>"+
            "</div>"
    }
</script>
</body>
</html>
