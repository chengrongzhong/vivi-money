<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib uri="dbfound-tags" prefix="d" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>工资列表</title>
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

    //获取展现样式
    function linkStyle(arg0,arg1){
        return ' class=\"' + ((arg0 == arg1)?'link-underline-gray':'link-underline-blue') + '\" ';
    }

    //操作列展现
    function showOpt(id, cellmeta, record, row, col, store) {
        if (id == null || id == '') {
            return '';
        } else {

            var moduleid= record.json.id;
            var modulename= record.json.name;
            var htmlcode = '<div class="opt">';
            htmlcode += '<font'+linkStyle(2,0)+'onclick="openAbTestModuleWin(' + moduleid + ',' + modulename + ');">查看</font>';
            htmlcode += '</div>';
            return htmlcode;
        }
    }

    //标签模块依从窗口
    function openAbTestModuleWin(moduleid, modulename){
        $D.open('LangWin', "工资详情", $D.getFullWidth('dataGrid')-50, $D.getFullHeight('dataGrid'),
            '${basePath}pages/vivi/month_money_detail.jsp?month_money_id=' + moduleid, query);
    }

    Date.prototype.format = function(format)
    {
        var o = {
            "M+" : this.getMonth()+1, //month
            "d+" : this.getDate(),    //day
            "h+" : this.getHours(),   //hour
            "m+" : this.getMinutes(), //minute
            "s+" : this.getSeconds(), //second
            "q+" : Math.floor((this.getMonth()+3)/3),  //quarter
            "S" : this.getMilliseconds() //millisecond
        }
        if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
            (this.getFullYear()+"").substr(4 - RegExp.$1.length));
        for(var k in o)if(new RegExp("("+ k +")").test(format))
            format = format.replace(RegExp.$1,
                RegExp.$1.length==1 ? o[k] :
                    ("00"+ o[k]).substr((""+ o[k]).length));
        return format;
    }

    function genMonthMoney(){
        var genMonth = Ext.getCmp('genMonth').getValue();
        var formatDate = genMonth.format("yyyy-MM-dd");
        console.log("================");
        console.log(formatDate);
        $D.showConfirm('确定生成工资单吗??',function(v){
            if(v=='yes'){
                Ext.getBody().mask('正在生成...', 'x-mask-loading');
                var param = {};
                param = {name:"genMonth",value:formatDate};
                $D.request('${basePath}action/viviMoneyGen.do!moneyGen',param,function(resObj){
                    $D.showMessage(resObj.message);
                    Ext.getBody().unmask();
                    dataGrid.query();
                });


                <%--genForm.form.submit({--%>
                    <%--url:'${basePath}action/viviMoneyGen.do!moneyGen',--%>
                    <%--data:param,--%>
                    <%--method:'post',--%>
                    <%--success:function(response, action){--%>
                        <%--Ext.getBody().unmask();--%>
                        <%--if(action.result.message!=''){--%>
                            <%--$D.showMessage(action.result.message );--%>
                        <%--}--%>
                    <%--},--%>
                    <%--failure:function(response,action){--%>
                        <%--Ext.getBody().unmask();--%>
                        <%--$D.showError(action.result.message);--%>
                    <%--}--%>
                <%--});--%>
                <%--var url='${basePath}action/viviMoneyGen.do!moneyGen';--%>
                <%--$D.request(url,{"genMonth":genMonth},function(res){--%>
                    <%--if(res.success == true){--%>
                        <%--$D.showMessage(res.message);--%>
                        <%--query();--%>
                    <%--}else {--%>
                        <%--$D.showError(res.message);--%>
                    <%--}--%>
                <%--},true,'正在处理，请稍候...');--%>
            }
        } );
    }

</script>

<body>
<d:initProcedure>
    <d:dataSet id="start_list" modelName="vivi/start" queryName="queryAllStart"/>
    <d:dataSet id="duty_list" modelName="vivi/duty" queryName="queryAllDuty" />
</d:initProcedure>

<d:form id="genForm" title="生成" labelWidth="80">
    <d:line columnWidth="0.33">
        <d:field id='genMonth' name="genMonth" prompt="生成日期" anchor="100%" editor="datefield">
        </d:field>
    </d:line>
    <d:toolBar>
        <d:gridButton icon="DBFoundUI/images/disk.png" title="生成工资" beforeAction="genMonthMoney" />
    </d:toolBar>
</d:form>

<d:buttonGroup>
    <d:button id="query" title="查询" click="query"/>
    <d:button title="重置" click="reset"/>
</d:buttonGroup>

<d:grid id="dataGrid" isCellEditable="isCellEditable" height="$D.getFullHeight('dataGrid')"
        model="vivi/month_money" autoQuery="true" forceFit="false" pagerSize="20">
    <d:toolBar>
        <d:gridButton type="delete"/>
    </d:toolBar>
    <d:columns>
        <d:column name="id" prompt="ID" width="80" renderer="showOpt" sortable="true"/>
        <d:column name="name" prompt="名称" width="250" sortable="true"/>
        <d:column name="descript" prompt="描述" width="200" sortable="true"/>
        <d:column name="createtime" prompt="创建时间" width="200" sortable="true"/>
        <d:column name="updatetime" prompt="更新时间" width="200" sortable="true"/>
    </d:columns>
</d:grid>
</body>

</html>