<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib uri="dbfound-tags" prefix="d" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>经销商信息推送统计</title>
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
        <d:field name="salesmanname" prompt="业务员" anchor="100%" editor="textfield" editable="false">
            <d:event name="enter" handle="query"/>
        </d:field>
        <d:field name="customername" prompt="经销商名称" anchor="100%" editor="textfield" editable="false">
            <d:event name="enter" handle="query"/>
        </d:field>
    </d:line>
    <d:line columnWidth="0.33">
        <d:field name="timefrom" editor="datefield" prompt="起始日期" />
        <d:field name="timeto" editor="datefield" prompt="结束日期" />
    </d:line>
</d:form>

<d:buttonGroup>
    <d:button id="query" title="查询" click="query"/>
    <d:button title="重置" click="reset"/>
</d:buttonGroup>

<d:grid id="dataGrid" isCellEditable="isCellEditable" height="$D.getFullHeight('dataGrid')"
        model="push_order_statistics" queryForm="queryForm" autoQuery="true" forceFit="false" pagerSize="20">
    <d:toolBar>
        <d:gridButton type="excel" />
    </d:toolBar>
    <d:columns>
        <d:column name="order_id" prompt="采购单" width="130"/>
        <d:column name="purchase_time" prompt="订单日期" width="140"/>
        <d:column name="branchcompanyname" prompt="分公司" width="90"/>
        <d:column name="orgname" prompt="分部" width="80"/>
        <d:column name="customername" prompt="目标经销商名称" width="220"/>
        <d:column name="ordercount" prompt="订单确认" width="60"/>
        <d:column name="tracecount" prompt="发运" width="60"/>
        <d:column name="signcount" prompt="运抵" width="60"/>
        <d:column name="redcount" prompt="冲红" width="60"/>
        <d:column name="salesmanname" prompt="业务员" width="60"/>
        <d:column name="loginname" prompt="主账号" width="100"/>
        <d:column name="childnum" prompt="子账号数量" width="80"/>
    </d:columns>
</d:grid>
</body>

</html>