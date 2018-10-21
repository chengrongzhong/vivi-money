<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="dbfound-tags" prefix="d"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>VIVI考勤后台</title>
		<d:includeLibrary />
	</head>
	<style>
	.x-panel-header {
		padding-top: 6px;
		padding-bottom: 6px;
	}
	</style>
	<script type="text/javascript">
	 	var currentNode ;

	 	function open(){
	 		openTab(currentNode);
		}
		
		function contextmenu(node,e){
			if(node.isLeaf()){
				currentNode = node;
				menu.showAt([e.getPageX(),e.getPageY()]);            
				node.select(); 
			}
		}

		function openTab(node) {
			if(node.isLeaf()){
				var html = "<div style='height:100%;overflow:hidden'><iframe id='"+node.id+"_iframe' src='"+node.json.url+"' frameBorder=0 width='100%' height='100%'></iframe></div>";
				menuTab.add({title:node.text,html:html,id:node.id,closable:true});
				menuTab.activate(node.id);
			}
		}

		function refresh(){
			var tab = $D.getTab(currentNode.id);
			if (tab) {
				var href= tab.location.href;
				tab.location.href = href;
			}
		}

		var menuStore = new Ext.data.JsonStore( {
			idProperty: '_id',
			url : "menu.query",
			id : "menuStore",
			root : "datas",
			totalProperty : "totalCounts",
			fields : [ "id" , "text" , "priority" , "pid" , "url" ]
		});
		var menuJson = {"datas":[
	        {"id":"M1","text":"账户管理","priority":10,"pid":"","url":""},
	        	{"id":"M1-1","text":"主账号管理","priority":10,"pid":"M1","url":"${basePath}pages/manage/dpuser-list.jsp"},
	        	{"id":"M1-2","text":"子账号管理","priority":10,"pid":"M1","url":"${basePath}pages/manage/dcuser-list.jsp"},
	        	{"id":"M1-3","text":"经销商管理","priority":10,"pid":"M1","url":"${basePath}pages/manage/customer-list.jsp"},
			{"id":"M2","text":"订阅者列表","priority":10,"pid":"","url":"${basePath}pages/manage/subscript-list.jsp"},
			{"id":"M3","text":"点击统计","priority":10,"pid":"","url":"${basePath}pages/manage/url-statistic-list.jsp"},
		]};
		menuStore.loadData(menuJson);
		//menuStore.loadData({"datas":[{"id":"33","text":"ViewForm 测试","priority":10,"pid":"M9","url":"modules\/test\/testViewForm.jsp"},{"id":"34","text":"综合测试","priority":20,"pid":"M9","url":"modules\/test\/testAll.jsp"},{"id":"35","text":"tree测试","priority":30,"pid":"M9","url":"modules\/test\/testTree.jsp"},{"id":"36","text":"grid级联测试","priority":40,"pid":"M9","url":"modules\/test\/cascadeGrid.jsp"},{"id":"37","text":"grid复合表头","priority":50,"pid":"M9","url":"modules\/test\/testGrid.jsp"},{"id":"39","text":"tab测试","priority":70,"pid":"M9","url":"modules\/test\/testTab.jsp"},{"id":"47","text":"panel测试","priority":80,"pid":"M9","url":"modules\/test\/testPanel.jsp"},{"id":"31","text":"课程开设","priority":10,"pid":"M8","url":"modules\/cos\/course.jsp"},{"id":"32","text":"开课查询","priority":20,"pid":"M8","url":"modules\/cos\/courseQuery.jsp"},{"id":"25","text":"作业新增","priority":10,"pid":"M7","url":"modules\/job\/newJob.jsp"},{"id":"26","text":"作业工作台","priority":20,"pid":"M7","url":"modules\/job\/jobManage.jsp"},{"id":"27","text":"作业历史查询","priority":30,"pid":"M7","url":"modules\/job\/jobQuery.jsp"},{"id":"28","text":"我的当前作业","priority":40,"pid":"M7","url":"modules\/job\/myJob.jsp"},{"id":"29","text":"我的历史作业","priority":50,"pid":"M7","url":"modules\/job\/myHistoryJob.jsp"},{"id":"21","text":"学生定义","priority":10,"pid":"M6","url":"modules\/fnd\/student.jsp"},{"id":"22","text":"教师定义","priority":20,"pid":"M6","url":"modules\/fnd\/teacher.jsp"},{"id":"23","text":"班级定义","priority":30,"pid":"M6","url":"modules\/fnd\/class.jsp"},{"id":"30","text":"学科定义","priority":40,"pid":"M6","url":"modules\/fnd\/branch.jsp"},{"id":"40","text":"工程定义","priority":10,"pid":"M10","url":"modules\/gc\/project.jsp"},{"id":"41","text":"工人定义","priority":20,"pid":"M10","url":"modules\/gc\/employee.jsp"},{"id":"42","text":"报工","priority":30,"pid":"M10","url":"modules\/gc\/workRegist.jsp"},{"id":"46","text":"工时补报","priority":33,"pid":"M10","url":"modules\/gc\/workRegistAdd.jsp"},{"id":"45","text":"报工取消","priority":35,"pid":"M10","url":"modules\/gc\/workUnRegist.jsp"},{"id":"43","text":"工钱结算","priority":40,"pid":"M10","url":"modules\/gc\/settlement.jsp"},{"id":"44","text":"结算查询","priority":50,"pid":"M10","url":"modules\/gc\/settlementQuery.jsp"},{"id":"1","text":"用户定义","priority":10,"pid":"M1","url":"modules\/sys\/user.jsp"},{"id":"4","text":"角色定义","priority":20,"pid":"M1","url":"modules\/sys\/role.jsp"},{"id":"3","text":"模块定义","priority":30,"pid":"M1","url":"modules\/sys\/module.jsp"},{"id":"2","text":"功能定义","priority":40,"pid":"M1","url":"modules\/sys\/function.jsp"},{"id":"5","text":"权限控制","priority":50,"pid":"M1","url":"modules\/sys\/power.jsp"},{"id":"13","text":"访问控制","priority":60,"pid":"M1","url":"modules\/sys\/accessControl.jsp"},{"id":"14","text":"系统管理","priority":70,"pid":"M1","url":"system.jsp"},{"id":"M1","text":"系统设置","priority":10,"pid":"","url":""},{"id":"M6","text":"基础定义","priority":20,"pid":"","url":""},{"id":"M7","text":"作业管理","priority":30,"pid":"","url":""},{"id":"M8","text":"课程管理","priority":40,"pid":"","url":""},{"id":"M9","text":"测试用例","priority":50,"pid":"","url":""},{"id":"M10","text":"工程计费","priority":60,"pid":"","url":""}],"message":"操作成功!","outParam":"","success":true,"totalCounts":38});
	</script>
	<body style="overflow: hidden">
	    <d:menu id="menu">
	       <d:menuItem title="打开" icon="DBFoundUI/images/add.gif" click="open"></d:menuItem>
	       <d:menuItem title="刷新" icon="DBFoundUI/images/submit.gif" click="refresh"></d:menuItem>
	    </d:menu>
		<div style="width:100%;position:absolute;left:0px;top:0px;margin:0px">
			<d:tree style="width:190px;position:absolute;left:0px;margin:0px" id="menuTree" title="菜单导航" bindTarget="menuStore" idField="id" parentField="pid" displayField="text" height="$D.getFullHeight('menuTree')" >
			    <d:event name="click" handle="openTab"></d:event>
			    <d:event name="contextmenu" handle="contextmenu"></d:event>
			</d:tree>	
		    <d:tabs style="margin-left:190px;margin-right:0px;margin-top:0px;" plain="false" id="menuTab" height="$D.getFullHeight('menuTab')">
		      <d:tab title="首页" url="${basePath}pages/common/welcome.jsp"></d:tab>
		    </d:tabs>
		</div>
	
	    <script type="text/javascript">
	    	function resize(){ 
				menuTree.setHeight($D.getFullHeight('menuTree'));
				menuTab.setHeight($D.getFullHeight('menuTab'));
			}
			window.onresize = resize;
			Ext.onReady(resize);
		</script>
	</body>
</html>
