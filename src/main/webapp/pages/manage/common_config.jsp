<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="dbfound-tags" prefix="d"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>通用配置列表</title>
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
		function initDefaultValue(record,grid){
		}
		//新增或者编辑时，控制各单元格是否可编辑
		function isCellEditable(col, row,name,record) {
			if (record.json && (name == "serviceid" || name == "cid" || name == "ckey" )) {
				return false;
			} else {
				return true;
			}
		}
	</script>
	<body>
	
		<d:form id="queryForm" title="查询条件" labelWidth="80">
			<d:line columnWidth="0.33">
				<d:field name="id" anchor="100%" editor="textfield" prompt="ID" >
					<d:event name="enter" handle="query"/>
				</d:field>
				<d:field name="ckey"  anchor="100%" editor="textfield" prompt="键" >
				   	<d:event name="enter" handle="query"/>
				</d:field>
				<d:field name="remark"  anchor="100%" editor="textfield" prompt="备注" >
				   	<d:event name="enter" handle="query"/>
				</d:field>
			</d:line>
		</d:form>
		
		<d:buttonGroup>
			<d:button id="query" title="查询" click="query" />
			<d:button title="重置" click="reset" />
		</d:buttonGroup>
		
		<d:grid id="dataGrid" title="通用配置列表" pagerSize="50" height="$D.getFullHeight('dataGrid')" isCellEditable="isCellEditable"
				model="common_config" queryForm="queryForm" autoQuery="true" forceFit="false">
			<d:toolBar>
				<d:gridButton type="add" afterAction="initDefaultValue"/>
				<d:gridButton type="delete" />
				<d:gridButton type="save" />
			</d:toolBar>
			<d:columns>
				<d:column name="id" prompt="ID" width="80"/>
				<d:column name="ckey" prompt="键" sortable="true" required="true" editor="textfield" width="160"  />
				<d:column name="cvalue" prompt="值" sortable="true" required="true" editor="textfield" width="280"  />
				<d:column name="remark" prompt="备注" sortable="true" editor="textfield" width="280"  />
			</d:columns>
		</d:grid>
		
	</body>
</html>
