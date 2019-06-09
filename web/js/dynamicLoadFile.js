function dynamic(){
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
            "<div class='row create_item' style='padding-right:20px'>"+
            "<div class='col text-left' style='margin-top:20px;'>"+
            fnameList_create[i]+
            "</div>"+
            "<form action= 'editAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='path' value='"+path+"\\create\\"+fnameList_create[i]+"'>"+
            "<button type='submit' class='btn btn-primary ' style='margin-top:15px;margin-right: 15px;'>编辑</button>"+
            "</form>"+
            "<form action= 'downloadAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='path' value='"+path+"\\create\\"+fnameList_create[i]+"'>"+
            "<button type='submit' class='btn btn-success ' style='margin-top:15px;margin-right: 15px;'>下载</button>"+
            "</form>"+
            "<form action= 'deleteAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='path' value='"+path+"\\create\\"+fnameList_create[i]+"'>"+
            "<button type='submit' class='btn btn-danger ' style='margin-top:15px;margin-right: 15px;'>删除</button>"+
            "</form>"+
            "<form action= 'historyAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='path' value='"+path+"\\create\\"+fnameList_create[i]+"'>"+
            "<button type='submit' class='btn btn-success ' style='margin-top:15px;margin-right: 15px;'>历史</button>"+
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
            "<div class='row create_item' style='padding-right:20px'>"+
            "<div class='col text-left' style='margin-top:20px;'>"+
            fnameList_coop[i]+
            "</div>"+
            "<form action= 'editAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='path' value='"+fpathList_coop[i]+"'>"+
            "<button type='submit' class='btn btn-primary ' style='margin-top:15px;margin-right: 15px;'>编辑</button>"+
            "</form>"+
            "<form action= 'downloadAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='path' value='"+fpathList_coop[i]+"'>"+
            "<button type='submit' class='btn btn-success ' style='margin-top:15px;margin-right: 15px;'>下载</button>"+
            "</form>"+
            "<form action= 'deleteAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='path' value='"+fpathList_coop[i]+"'>"+
            "<button type='submit' class='btn btn-danger ' style='margin-top:15px;margin-right: 15px;'>删除</button>"+
            "</form>"+
            "<form action= 'historyAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='path' value='"+fpathList_coop[i]+"'>"+
            "<button type='submit' class='btn btn-success ' style='margin-top:15px;margin-right: 15px;'>历史</button>"+
            "</form>"+
            "</div>"
    }
}