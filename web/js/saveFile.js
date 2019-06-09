function saveFile() {
    var xhr = new XMLHttpRequest();
    var urlString = "FileSaveAction.action?";
    var args="username=" + document.getElementById("username").innerHTML
        + "&newPath="+document.getElementById("newpath").innerHTML
        + "&oldPath="+document.getElementById("oldpath").innerHTML;
    //console.log(args);
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
                //显示更新成功标签
                document.getElementById("save_success").style.visibility = "visible";
                window.setTimeout(function(){
                    document.getElementById("save_success").style.visibility = "hidden";
                },1000)
            }
        }
    };
}