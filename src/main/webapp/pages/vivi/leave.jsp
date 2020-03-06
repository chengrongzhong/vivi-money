<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib uri="dbfound-tags" prefix="d" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>请假列表</title>
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
        // record.set("twoHourFlag",0);
    }

    function beforeSave(record, grid, button) {
        if( record.length > 0 ){
            //检查icon,banner图是否两个都未上传
            for(var i=0;i<record.length;i++){
                var r = record[i].data;
                if(r.twoHourFlag == -1) {
                    $D.showError('请选择“是否超过2小时”!');
                    return false;
                }
                if(r.twoHourFlag == 0 && !r.leave_day){
                    $D.showError('超过2小时的请假，需填写请假天数!');
                    return false;
                }
            }
        }
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

    var typeStore = new Ext.data.SimpleStore({
        //data : [[ 0, "apk下发" ],[ 1, "下发为空" ]],
        data: [[0, "长时假"], [1, "1小时假"], [2, "2小时假"]],
        fields: ["code", "name"]
    });

</script>

<body>
<d:initProcedure>
    <d:dataSet id="teacher_list" modelName="vivi/teacher" queryName="queryAllTeacher"/>
    <d:dataSet id="leave_type_list" modelName="vivi/leave_type" queryName="queryAllLeaveType"/>
</d:initProcedure>

<d:form id="queryForm" title="查询条件" labelWidth="80">
    <d:line columnWidth="0.33">
        <d:field name="id" prompt="ID" anchor="100%" editor="numberfield" editable="false">
            <d:event name="enter" handle="query"/>
        </d:field>
        <d:field name="teacher_id" anchor="100%" editable="false" editor="combo" options="teacher_list" displayField="name" valueField="code"  prompt="选择老师" >
            <d:event name="select" handle="query"/>
        </d:field>
        <d:field name="leave_type_id" anchor="100%" editable="false" editor="combo" options="leave_type_list" displayField="name" valueField="code"  prompt="请假类型" >
            <d:event name="select" handle="query"/>
        </d:field>
    </d:line>
</d:form>

<d:buttonGroup>
    <d:button id="query" title="查询" click="query"/>
    <d:button title="重置" click="reset"/>
</d:buttonGroup>

<d:grid id="dataGrid" isCellEditable="isCellEditable" height="$D.getFullHeight('dataGrid')"
        model="vivi/leave" queryForm="queryForm" autoQuery="true" forceFit="false" pagerSize="20">
    <d:toolBar>
            <d:gridButton type="add" afterAction="initDefaultValue"/>
            <d:gridButton type="save" beforeAction="beforeSave"/>
            <d:gridButton type="delete"/>
    </d:toolBar>
    <d:columns>
        <d:column name="id" prompt="ID" width="80"/>
        <d:column name="leave_desc" prompt="请假事由" editor="textfield" width="250"/>
        <d:column name="leave_type_id" prompt="请假类型" width="150"  required="true" editor="combo" options="leave_type_list" displayField="name" valueField="code" editable="true" />
        <d:column name="teacher_id" prompt="请假老师" width="150"  required="true" editor="combo" options="teacher_list" displayField="name" valueField="code" editable="true" />
        <d:column name="twohourflag" prompt="长短假" width="150"  required="true" editor="combo" options="typeStore" displayField="name" valueField="code" editable="true" />
        <d:column name="leave_day" prompt="请假天数" editor="numberfield" width="150"/>
        <d:column name="opetime" prompt="生效时间" editor="datefield" width="150"/>
        <d:column name="createtime" prompt="创建时间" width="200"/>
        <d:column name="updatetime" prompt="更新时间" width="200"/>
    </d:columns>
</d:grid>
</body>

</html>