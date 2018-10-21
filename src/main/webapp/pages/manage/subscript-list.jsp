<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib uri="dbfound-tags" prefix="d" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>订阅者列表</title>
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

    var functionStore = new Ext.data.SimpleStore({
        //data : [[ 0, "apk下发" ],[ 1, "下发为空" ]],
        data: [[99, "活动消息"], [1, "订单下达"], [2, "发运"], [3, "运抵"], [4, "冲红"], [5, "订单取消"]],
        fields: ["code", "name"]
    });
</script>

<body>

<d:form id="queryForm" title="查询条件" labelWidth="80">
    <d:line columnWidth="0.33">
        <d:field name="id" prompt="ID" anchor="100%" editor="numberfield" editable="false">
            <d:event name="enter" handle="query"/>
        </d:field>
        <d:field name="username" prompt="用户名" anchor="100%" editor="textfield" editable="false">
            <d:event name="enter" handle="query"/>
        </d:field>
    </d:line>
</d:form>

<d:buttonGroup>
    <d:button id="query" title="查询" click="query"/>
    <d:button title="重置" click="reset"/>
</d:buttonGroup>

<d:grid id="dataGrid" isCellEditable="isCellEditable" height="$D.getFullHeight('dataGrid')"
        model="subscript_list" queryForm="queryForm" autoQuery="true" forceFit="false" pagerSize="20">
    <d:toolBar>
            <d:gridButton type="add" afterAction="initDefaultValue"/>
            <d:gridButton type="save" beforeAction="beforeSave"/>
            <d:gridButton type="delete"/>
    </d:toolBar>
    <d:columns>
        <d:column name="id" prompt="ID" width="80"/>
        <d:column name="sptuserid" prompt="userid" editor="textfield" width="250"/>
        <d:column name="username" prompt="用户名" editor="textfield" width="200"/>
        <d:column name="function" prompt="功能分配" width="150"  required="true" editor="lovcombo" options="functionStore" displayField="name" valueField="code" editable="true" /> 
    </d:columns>
</d:grid>
</body>

</html>