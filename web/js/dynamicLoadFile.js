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
        var oldPath=path+"\\create\\"+fnameList_create[i];
        var string_t=fnameList_create[i].split(".");
        var newPath=path+"\\create\\"+string_t[0]+"_t."+string_t[1];
        console.log(oldPath);
        console.log(newPath);
        document.getElementById("creat_list").innerHTML+=
            "<div class='row create_item' style='padding-right:20px'>"+
            "<div class='col text-left' style='margin-top:20px;'>"+
            fnameList_create[i]+
            "</div>"+
            "<form action= 'editAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='oldPath' value='"+oldPath+"'>"+
            "<input type='text' style ='display:none' name='newPath' value='"+newPath+"'>"+
            "<button type='submit' class='btn btn-primary ' style='margin-top:15px;margin-right: 15px;'>编辑</button>"+
            "</form>"+
            "<form action= 'downloadAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='path' value='"+oldPath+"'>"+
            "<button type='submit' class='btn btn-success ' style='margin-top:15px;margin-right: 15px;'>下载</button>"+
            "</form>"+
            "<form action= 'deleteAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='oldPath' value='"+oldPath+"'>"+
            "<input type='text' style ='display:none' name='newPath' value='"+newPath+"'>"+
            "<button type='submit' class='btn btn-danger ' style='margin-top:15px;margin-right: 15px;'>删除</button>"+
            "</form>"+
            "<form action= 'historyAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='path' value='"+oldPath+"'>"+
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
        var oldPath = fpathList_coop[i];
        var string_t=oldPath.split("/");
        var string_tt=string_t[string_t.length-1].split(".");
        string_tt[0]+="_t";
        string_t[string_t.length-1]=string_tt.join(".");
        var newPath = string_t.join("\\");
        console.log(oldPath);
        console.log(newPath);
        document.getElementById("coop_list").innerHTML+=
            "<div class='row create_item' style='padding-right:20px'>"+
            "<div class='col text-left' style='margin-top:20px;'>"+
            fnameList_coop[i]+
            "</div>"+
            "<form action= 'editAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='oldPath' value='"+oldPath+"'>"+
            "<input type='text' style ='display:none' name='newPath' value='"+newPath+"'>"+
            "<button type='submit' class='btn btn-primary ' style='margin-top:15px;margin-right: 15px;'>编辑</button>"+
            "</form>"+
            "<form action= 'downloadAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='path' value='"+fpathList_coop[i]+"'>"+
            "<button type='submit' class='btn btn-success ' style='margin-top:15px;margin-right: 15px;'>下载</button>"+
            "</form>"+
            "<form action= 'deleteAction'  enctype='multipart/form-data' method='post'>"+
            "<input type='text' style ='display:none' name='username' value='"+username+"'>"+
            "<input type='text' style ='display:none' name='oldPath' value='"+oldPath+"'>"+
            "<input type='text' style ='display:none' name='newPath' value='"+newPath+"'>"+
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