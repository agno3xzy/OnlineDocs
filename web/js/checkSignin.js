function checklogin(){
    var xhr = new XMLHttpRequest();
    var urlString = "passwordCheck.action?";
    var args="username=" + document.getElementById("username").value;

    //window.alert(document.getElementById("username").value);
    xhr.open("post",urlString,true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;");//不加上这句，那么后台Request.Form获取不到参数a,b的数值
    xhr.send(args);
    //检查响应状态
    xhr.onreadystatechange = function() {
        if(xhr.readyState == 4) {
            if((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304) {
                //console.log(xhr.responseText);
                //console.log(document.getElementById("password").value);
                if(xhr.responseText == "") {
                    document.getElementById("alert").style.visibility = "visible";
                    $("#alert").html("用户名或密码错误");
                } else {
                    if(xhr.responseText== document.getElementById("password").value)
                    {
                        document.getElementById("alert").style.visibility = "hidden";
                    } else
                    {
                        document.getElementById("alert").style.visibility = "visible";
                        $("#alert").html("用户名或密码错误");
                    }
                }
            }
        }
    };
}
function validate() {
    if(document.getElementById("alert").style.visibility == "visible") {
        return false;
    } else {
        return true;
    }
}