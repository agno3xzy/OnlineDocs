<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: agno3
  Date: 2019/5/30
  Time: 14:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<html>
<head>
    <title>history</title>
</head>
<body>
<div class="list-group">
    <s:iterator value="versionLog" status="L">
        <form action= 'versionAction'  enctype='multipart/form-data' method='post'>
        <button type="button" class="list-group-item list-group-item-action">
            <p class="font-weight-bold">
                <s:property value="key"/>
            </p>
           <%--
            <li style="color: <s:property value="color[#L.index]"/>">
                <s:property value="value"/>
            </li>
            --%>
            <input type='text' style='display:none' name='timestamp' value='<s:property value="key"/>'>
            <input type='text' style ='display:none' name='logpath' value='<s:property value="path"/>'>
            <input type='submit'   value='revert'>
        </button>
        </form>
    </s:iterator>
</div>
</body>
</html>
