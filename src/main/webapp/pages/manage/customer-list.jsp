<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib uri="dbfound-tags" prefix="d" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>经销商管理</title>
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
    <d:dataSet id="subStore" modelName="subscript_list" queryName="list"/>
</d:initProcedure>

<d:form id="queryForm" title="查询条件" labelWidth="80">
    <d:line columnWidth="0.33">
        <d:field name="customerid" prompt="ID" anchor="100%" editor="textfield" editable="false">
            <d:event name="enter" handle="query"/>
        </d:field>
        <d:field name="customername" prompt="客户名" anchor="100%" editor="textfield" editable="false">
            <d:event name="enter" handle="query"/>
        </d:field>
        <d:field name="branchcompanyname" prompt="分公司" anchor="100%" editor="textfield" editable="false">
            <d:event name="enter" handle="query"/>
        </d:field>
    </d:line>
</d:form>

<d:buttonGroup>
    <d:button id="query" title="查询" click="query"/>
    <d:button title="重置" click="reset"/>
</d:buttonGroup>

<d:grid id="dataGrid" isCellEditable="isCellEditable" height="$D.getFullHeight('dataGrid')"
        model="customer_list" queryForm="queryForm" autoQuery="true" forceFit="false" pagerSize="20">
    <d:toolBar>
            <d:gridButton type="save"/>
    </d:toolBar>
    <d:columns>
        <d:column name="customerid" prompt="ID" width="80"/>
        <d:column name="customerno" prompt="客户编号" width="100"/>
        <d:column name="customername" prompt="客户名" width="300"/>
        <d:column name="principal" prompt="负责人" width="100"/>
        <d:column name="mobile" prompt="电话" width="100"/>
        <d:column name="typename" prompt="代理关系" width="100"/>
        <d:column name="orgname" prompt="分部" width="100"/>
        <d:column name="branchcompanyname" prompt="分公司" width="100"/>
        <d:column name="area" prompt="区域" width="140"/>
        <d:column name="createtime" prompt="创建时间" width="140"/>
        <d:column name="channeluseruuid" prompt="channeluseruuid" hidden="true" width="140"/>
        <d:column name="sub_script_user" prompt="订阅" width="150" required="true" editor="lovcombo" options="subStore"
                  displayField="name" valueField="code" editable="true">
        </d:column>
    </d:columns>
</d:grid>
</body>

</html>