<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib uri="dbfound-tags" prefix="d" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>工资详情</title>
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
    <d:dataSet id="teacher_list" modelName="vivi/teacher" queryName="queryAllTeacher"/>
</d:initProcedure>

<%--<d:form id="queryForm" title="查询条件" labelWidth="80">--%>
    <%--<d:line columnWidth="0.33">--%>
        <%--<d:field name="id" prompt="ID" anchor="100%" editor="numberfield" editable="false">--%>
            <%--<d:event name="enter" handle="query"/>--%>
        <%--</d:field>--%>
        <%--<d:field name="teacher_id" anchor="100%" editable="false" editor="combo" options="teacher_list" displayField="name" valueField="code"  prompt="选择老师" >--%>
            <%--<d:event name="select" handle="query"/>--%>
        <%--</d:field>--%>
    <%--</d:line>--%>
<%--</d:form>--%>

<%--<d:buttonGroup>--%>
    <%--<d:button id="query" title="查询" click="query"/>--%>
    <%--<d:button title="重置" click="reset"/>--%>
<%--</d:buttonGroup>--%>

<d:grid id="dataGrid" pagerSize="100" height="$D.getFullHeight('dataGrid')" isCellEditable="isCellEditable"
        queryUrl="vivi/month_money_detail.query?month_money_id=${param.month_money_id}" selectFirstRow="false"
        model="vivi/month_money_detail" autoQuery="true" forceFit="false">
    <d:toolBar>
        <d:gridButton type="excel" />
    </d:toolBar>
    <d:columns>
        <%--<d:column name="id" prompt="ID" width="50"/>--%>
        <d:column name="teacher_name" prompt="姓名" width="70" sortable="true"/>
        <d:column name="duty_name" prompt="岗位" width="160"/>
        <d:column name="base_money" prompt="基本工资" sortable="true" width="80"/>
        <d:column name="position_money" prompt="岗位" sortable="true" width="60"/>
        <d:column name="performance_money" prompt="绩效工资" sortable="true"  width="80"/>
        <d:column name="jiaotong_money" prompt="交通" sortable="true" width="60"/>
        <d:column name="security_money" prompt="安全" sortable="true" width="60"/>
        <d:column name="quanqin" prompt="全勤" sortable="true" width="60"/>
        <d:column name="class_att_money" prompt="班级出勤" sortable="true" width="80"/>
        <d:column name="lunch_att_money" prompt="后厨提成" sortable="true" width="80"/>
        <d:column name="start_name" prompt="星级名称" width="80"/>
        <d:column name="start_money" prompt="星级工资" sortable="true"  width="80"/>
        <d:column name="performance_add" prompt="绩效奖励" sortable="true"  width="80"/>
        <d:column name="work_year_money" prompt="工龄" sortable="true" width="60"/>
        <d:column name="other_money" prompt="补助" sortable="true" width="60"/>
        <d:column name="birth_day_money" prompt="生日" sortable="true" width="60"/>

        <d:column name="company_money" prompt="管理公司" sortable="true" width="80"/>

        <d:column name="education_money" prompt="学历补贴" width="100"/>
        <d:column name="education_background" prompt="教育补贴" width="100"/>
        <d:column name="certificate" prompt="证书补贴" width="100"/>
        <d:column name="education_certificate" prompt="教师证补贴" width="100"/>
        <d:column name="low_age_class_money" prompt="小龄班级补贴" width="100"/>
        <d:column name="oil_money" prompt="油费补贴" width="100"/>
        <d:column name="keshi_money" prompt="课时补贴" width="100"/>
        <d:column name="weekend_keshi_money" prompt="周末课补贴" width="100"/>


        <d:column name="should_pay" prompt="应发" sortable="true" width="60"/>

        <d:column name="shebao" prompt="社保" sortable="true"  width="60"/>
        <d:column name="sushe" prompt="宿舍" sortable="true" width="60"/>
        <d:column name="leave_desc" prompt="请假" width="160"/>
        <d:column name="leave_money" prompt="请假扣除" sortable="true" width="80"/>
        <d:column name="special" prompt="其他" sortable="true" width="80"/>
        <d:column name="real_pay" prompt="实发" sortable="true" width="60"/>



    </d:columns>
</d:grid>
</body>

</html>