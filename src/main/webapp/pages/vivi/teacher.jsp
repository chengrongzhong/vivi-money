<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib uri="dbfound-tags" prefix="d" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>教师列表</title>
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

    var statusStore = new Ext.data.SimpleStore( {
        data: [[0, "离职"], [1, "在职"]],
        fields : [ "code", "name" ]
    });
</script>

<body>
<d:initProcedure>
    <d:dataSet id="start_list" modelName="vivi/start" queryName="queryAllStart"/>
    <d:dataSet id="duty_list" modelName="vivi/duty" queryName="queryAllDuty" />
</d:initProcedure>

<d:form id="queryForm" title="查询条件" labelWidth="80">
    <d:line columnWidth="0.33">
        <d:field name="id" prompt="ID" anchor="100%" editor="numberfield" editable="false">
            <d:event name="enter" handle="query"/>
        </d:field>
        <d:field name="teacher_name" prompt="教师名称" anchor="100%" editor="textfield" editable="false">
            <d:event name="enter" handle="query"/>
        </d:field>
        <d:field name="state" prompt="状态" anchor="100%" editor="combo" options="statusStore" displayField="name" valueField="code" editable="true">
            <d:event name="enter" handle="query"/>
        </d:field>
    </d:line>
</d:form>

<d:buttonGroup>
    <d:button id="query" title="查询" click="query"/>
    <d:button title="重置" click="reset"/>
</d:buttonGroup>

<d:grid id="dataGrid" isCellEditable="isCellEditable" height="$D.getFullHeight('dataGrid')"
        model="vivi/teacher" queryForm="queryForm" autoQuery="true" forceFit="false" pagerSize="20">
    <d:toolBar>
            <d:gridButton type="add" afterAction="initDefaultValue"/>
            <d:gridButton type="save" beforeAction="beforeSave"/>
            <d:gridButton type="delete"/>
    </d:toolBar>
    <d:columns>
        <d:column name="id" prompt="ID" width="80" sortable="true"/>
        <d:column name="teacher_name" prompt="教师名称" editor="textfield" width="80" sortable="true"/>
        <d:column name="state" prompt="状态" editor="combo" options="statusStore" displayField="name" valueField="code" editable="true" width="50" sortable="true"/>
        <d:column name="birth" prompt="生日" editor="datefield" width="100"/>
        <d:column name="join_time" prompt="入司时间" editor="datefield" width="100" sortable="true"/>
        <d:column name="duty_id" prompt="职务" width="200"  required="true" editor="combo" options="duty_list" displayField="name" valueField="code" editable="true" sortable="true"/>
        <d:column name="start_id" prompt="星级" width="100"  required="true" editor="combo" options="start_list" displayField="name" valueField="code" editable="true" sortable="true"/>
        <d:column name="shebao" prompt="社保" editor="numberfield" width="100"/>
        <d:column name="jiaotong" prompt="交通" editor="numberfield" width="100"/>
        <d:column name="class_id" prompt="班级" editor="numberfield" width="100"/>
        <d:column name="other" prompt="其他" editor="numberfield" width="100"/>
        <d:column name="sushe" prompt="宿舍" editor="numberfield" width="100"/>
        <d:column name="company_money" prompt="管理公司工资" editor="numberfield" width="100"/>
        <d:column name="education_money" prompt="学历补贴" editor="numberfield" width="100"/>
        <d:column name="education_background" prompt="教育补贴" editor="numberfield" width="100"/>
        <d:column name="certificate" prompt="证书补贴" editor="numberfield" width="100"/>
        <d:column name="education_certificate" prompt="教师证补贴" editor="numberfield" width="100"/>
        <d:column name="low_age_class_money" prompt="小龄班级补贴" editor="numberfield" width="100"/>
        <d:column name="oil_money" prompt="油费补贴" editor="numberfield" width="100"/>
        <d:column name="keshi_money" prompt="课时补贴" editor="numberfield" width="100"/>
        <d:column name="weekend_keshi_money" prompt="周末课补贴" editor="numberfield" width="100"/>

    </d:columns>
</d:grid>
</body>

</html>