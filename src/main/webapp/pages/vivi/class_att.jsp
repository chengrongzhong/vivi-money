<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib uri="dbfound-tags" prefix="d" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>班级绩效列表</title>
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
<d:initProcedure>
    <d:dataSet id="class_list" modelName="vivi/class" queryName="queryAllClass"/>
</d:initProcedure>

<d:form id="queryForm" title="查询条件" labelWidth="80">
    <d:line columnWidth="0.33">
        <d:field name="id" prompt="ID" anchor="100%" editor="numberfield" editable="false">
            <d:event name="enter" handle="query"/>
        </d:field>
        <d:field name="class_id" anchor="100%" editable="false" editor="combo" options="class_list" displayField="name" valueField="code"  prompt="选择老师" >
            <d:event name="select" handle="query"/>
        </d:field>
    </d:line>
</d:form>

<d:buttonGroup>
    <d:button id="query" title="查询" click="query"/>
    <d:button title="重置" click="reset"/>
</d:buttonGroup>

<d:grid id="dataGrid" isCellEditable="isCellEditable" height="$D.getFullHeight('dataGrid')"
        model="vivi/class_att" queryForm="queryForm" autoQuery="true" forceFit="false" pagerSize="20">
    <d:toolBar>
            <d:gridButton type="add" afterAction="initDefaultValue"/>
            <d:gridButton type="save" beforeAction="beforeSave"/>
            <d:gridButton type="delete"/>
    </d:toolBar>
    <d:columns>
        <d:column name="id" prompt="ID" width="80"/>
        <d:column name="class_id" prompt="班级" width="150"  required="true" editor="combo" options="class_list" displayField="name" valueField="code" editable="true" />
        <d:column name="count" prompt="出勤率" editor="numberfield" width="250"/>
        <d:column name="student" prompt="学生人数" editor="numberfield" width="250"/>
        <d:column name="opetime" prompt="生效时间" editor="datefield" width="200"/>
        <d:column name="createtime" prompt="创建时间" width="200"/>
        <d:column name="updatetime" prompt="更新时间" width="200"/>
    </d:columns>
</d:grid>
</body>

</html>