<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib uri="dbfound-tags" prefix="d" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>经销商操作统计</title>
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
        <d:field name="timefrom" editor="datetimefield" prompt="起始日期" />
        <d:field name="timeto" editor="datetimefield" prompt="结束日期" />
    </d:line>
</d:form>

<d:buttonGroup>
    <d:button id="query" title="查询" click="query"/>
    <d:button title="重置" click="reset"/>
</d:buttonGroup>

<d:grid id="dataGrid" isCellEditable="isCellEditable" height="$D.getFullHeight('dataGrid')"
        model="dealer_action_statistics" queryUrl="action/dealerActionStatistics.do!query" queryForm="queryForm" autoQuery="true" forceFit="false" pagerSize="20">
    <d:toolBar>
        <d:gridButton type="excel" />
    </d:toolBar>
    <d:columns>
        <d:column name="customerno" prompt="经销商编码" width="70"/>
        <d:column name="customername" prompt="经销商" width="160"/>
        <d:column name="branchcompanyname" prompt="分公司" width="90"/>
        <d:column name="orgname" prompt="分部" width="80"/>
        <d:column name="salesmanname" prompt="业务员" width="70"/>
        <d:column name="loginname" prompt="经销商账号" width="90"/>
        <d:column name="firstlevel" prompt="一级菜单" width="90"/>
        <d:column name="secondlevel" prompt="二级菜单" width="90"/>
        <d:column name="actcount" prompt="操作次数" width="60"/>
        <d:column name="days" prompt="登陆次数" width="60"/>
    </d:columns>
</d:grid>
</body>

</html>