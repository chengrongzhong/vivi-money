<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib uri="dbfound-tags" prefix="d" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>请假分类列表</title>
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

</script>

<body>

<d:form id="queryForm" title="查询条件" labelWidth="80">
    <d:line columnWidth="0.33">
        <d:field name="id" prompt="ID" anchor="100%" editor="numberfield" editable="false">
            <d:event name="enter" handle="query"/>
        </d:field>
        <d:field name="type_name" prompt="类型名称" anchor="100%" editor="textfield" editable="false">
            <d:event name="enter" handle="query"/>
        </d:field>
    </d:line>
</d:form>

<d:buttonGroup>
    <d:button id="query" title="查询" click="query"/>
    <d:button title="重置" click="reset"/>
</d:buttonGroup>

<d:grid id="dataGrid" isCellEditable="isCellEditable" height="$D.getFullHeight('dataGrid')"
        model="vivi/leave_type" queryForm="queryForm" autoQuery="true" forceFit="false" pagerSize="20">
    <d:toolBar>
            <d:gridButton type="add" afterAction="initDefaultValue"/>
            <d:gridButton type="save" beforeAction="beforeSave"/>
            <d:gridButton type="delete"/>
    </d:toolBar>
    <d:columns>
        <d:column name="id" prompt="ID" width="80"/>
        <d:column name="type_name" prompt="请假类型" editor="textfield" width="250"/>
        <d:column name="createtime" prompt="创建时间" width="200"/>
        <d:column name="updatetime" prompt="更新时间" width="200"/>
    </d:columns>
</d:grid>
</body>

</html>