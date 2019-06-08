function validate(){
    var word1= document.getElementById("password").value;
    var word2 = document.getElementById("confirmpassword").value;
    if(word1 != word2){
        document.getElementById("alert").style.visibility = "visible";
        $("#alert").html("两次输入密码不一致!");
        document.getElementById("confirmpassword").focus();
        return false;
    }
    //如果此时警告框还存在 说明注册信息有问题 不提交
    if(document.getElementById("alert").style.visibility == "visible")
    {
        return false;
    }
    return true;
}
function checkUsernameExist() {
    var xhr = new XMLHttpRequest();
    var urlString = "usernameCheck.action?username="
        + document.getElementById("username").value;
    //window.alert(document.getElementById("username").value);
    xhr.open("post",urlString,true);
    xhr.send(null);

    //检查响应状态
    xhr.onreadystatechange = function() {
        //window.alert(xhr.readyState);
        if(xhr.readyState == 4) {
            //window.alert(xhr.status);
            if((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304) {
                if(xhr.responseText == "1") {
                    document.getElementById("alert").style.visibility = "visible";
                    $("#alert").html("用户名已被注册");
                } else {
                    document.getElementById("alert").style.visibility = "hidden";
                }
            }
        }
    };
}
    