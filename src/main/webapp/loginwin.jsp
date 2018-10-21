<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="dbfound-tags" prefix="d" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <d:includeLibrary/>
</head>
<script type="text/javascript">
    function login() {
        if (loginForm.form.isValid()) {
            var objectjson = loginForm.form.getValues();
            Ext.getBody().mask('正在登录...', 'x-mask-loading');
            Ext.Ajax.request({
                url: 'action/loginAction.do!login',
                params: objectjson,
                success: function (response, action) {
                    Ext.getBody().unmask();
                    var obj = Ext.util.JSON.decode(response.responseText);
                    if (obj.success == true) {
                        var p = parent.location;
                        parent.location.href = "${basePath}pages/common/main.jsp";
                    } else {
                        reloadcode();
                        Ext.Msg.alert('登录失败', obj.message + '！');
                    }
                },
                failure: function () {
                    Ext.getBody().unmask();
                    reloadcode();
                    Ext.Msg.alert('提示', '登录失败！');
                }
            });
        }
    }

    function alert(message) {
        Ext.MessageBox.show({
            title: '提示',
            msg: message,
            buttons: Ext.MessageBox.OK,
            icon: Ext.MessageBox.WARNING
        });
    }

    function reset() {
        loginForm.form.reset();
    }
    function reloadcode() {
        document.getElementById("img").setAttribute("src", "${basePath}code.jsp?rt=" + new Date().getTime());
    }
</script>
<body style="overflow:hidden">
<div class="top_table" style="width:100%">
    <p style="font-family:verdana;font-size:300%;color:#000000;text-align:center;font-weight:600">
        VIVI考勤后台
    </p>
</div>
<d:form id="loginForm" labelWidth="60">
    <d:line columnWidth="1">
        <d:choose>
            <d:when test="${cookie.user_code.value==null}">
                <d:field name="loginname" required="true" readOnly="false" editor="textfield" prompt="用户名">
                    <d:event name="enter" handle="login"/>
                </d:field>
            </d:when>
            <d:otherwise>
                <d:field name="loginname" readOnly="false" value="${cookie.user_code.value}" required="true"
                         editor="textfield" prompt="用户名"/>
            </d:otherwise>
        </d:choose>
    </d:line>
    <d:line columnWidth="1">
        <d:field name="password" required="true" editor="password" prompt="密码">
            <d:event name="enter" handle="login"/>
        </d:field>
    </d:line>
    <d:toolBar>
        <d:formButton action="" title="确 定" beforeAction="login"></d:formButton>
        <d:formButton action="" title="重 置" beforeAction="reset"></d:formButton>
    </d:toolBar>
</d:form>

<script type="text/javascript">

</script>
</body>
</html>
