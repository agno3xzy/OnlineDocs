<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2019/5/16
  Time: 14:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form action= "uploadAction"    enctype="multipart/form-data" method="post"  >
        创建文件<input type="file" name="fileUpload"  /><br/>
        <input type="submit"  value="提交" />
    </form>

</body>
</html>
