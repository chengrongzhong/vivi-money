<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib uri="dbfound-tags" prefix="d" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>点击统计</title>
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

    var typeStore = new Ext.data.SimpleStore({
        //data : [[ 0, "apk下发" ],[ 1, "下发为空" ]],
        data: [[1, "采购订单"], [2, "物流详情"], [3, "评价"], [4, "冲红订单"]],
        fields: ["code", "name"]
    });

</script>

<body>

<d:form id="queryForm" title="查询条件" labelWidth="80">
    <d:line columnWidth="0.33">
        <d:field name="id" prompt="ID" anchor="100%" editor="numberfield" editable="false">
            <d:event name="enter" handle="query"/>
        </d:field>
        <d:field name="sta_type" anchor="100%" editable="false" editor="combo" options="typeStore" displayField="name" valueField="code"  prompt="类型" >
           <d:event name="select" handle="query"/>
        </d:field>
    </d:line>
</d:form>

<d:buttonGroup>
    <d:button id="query" title="查询" click="query"/>
    <d:button title="重置" click="reset"/>
</d:buttonGroup>

<d:grid id="dataGrid" isCellEditable="isCellEditable" height="$D.getFullHeight('dataGrid')"
        model="url_statistic_list" queryForm="queryForm" autoQuery="true" forceFit="false" pagerSize="20">
    <d:toolBar>
        <d:gridButton type="excel" />
    </d:toolBar>
    <d:columns>
        <d:column name="id" prompt="ID" width="80"/>
        <d:column name="sta_type" prompt="类型" width="90" required="true" editor="combo" options="typeStore" displayField="name" valueField="code" editable="false"/>
        <d:column name="url" prompt="url" editor="textfield" width="700"/>
    </d:columns>
</d:grid>
</body>

</html>