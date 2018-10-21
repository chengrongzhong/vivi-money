<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib uri="dbfound-tags" prefix="d" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>子账号管理</title>
    <%@include file="/pages/common/public.jsp" %>
</head>
<script type="text/javascript">
    function query() {
        dataGrid.query();
    }
    function reset() {
        queryForm.reset();
    }

    //新增时，初始化默认值
    function initDefaultValue(record, grid) {
    }

    function beforeSave(record, grid, button) {
        return true
    }

    //新增或者编辑时，控制各单元格是否可编辑
    function isCellEditable(col, row, name, record) {
        if (record.json && (name == "id")) {
            return false;
        } else {
            return true;
        }
    }

    function selectHandle(fields) {
    }

</script>

<body>

<d:form id="queryForm" title="查询条件" labelWidth="80">
    <d:line columnWidth="0.33">
        <d:field name="loginname" prompt="账号名" anchor="100%" editor="textfield" editable="false">
            <d:event name="enter" handle="query"/>
        </d:field>
        <d:field name="mobile" prompt="手机号" anchor="100%" editor="numberfield" editable="false">
            <d:event name="enter" handle="query"/>
        </d:field>
        <d:field name="wxmobile" prompt="微信手机号" anchor="100%" editor="numberfield" editable="false">
            <d:event name="enter" handle="query"/>
        </d:field>
    </d:line>
</d:form>

<d:buttonGroup>
    <d:button id="query" title="查询" click="query"/>
    <d:button title="重置" click="reset"/>
</d:buttonGroup>

<d:grid id="dataGrid" isCellEditable="isCellEditable" height="$D.getFullHeight('dataGrid')"
        model="duser_list" queryForm="queryForm" queryUrl="duser_list.query!child" autoQuery="true" forceFit="false" pagerSize="20">
    <d:columns>
        <d:column name="userid" prompt="ID" width="80"/>
        <d:column name="employeename" prompt="姓名" width="250"/>
        <d:column name="loginname" prompt="账号名" width="200"/>
        <d:column name="mobile" prompt="手机号" width="200"/>
        <d:column name="wxmobile" prompt="微信手机号" width="100"/>
    </d:columns>
</d:grid>
</body>

</html>