/*******************************************************************************
 * 定义DBFound第三方JS方法 提供公用的方法
 * make by heweifeng 2014-07-18
 ******************************************************************************/
$DP = {
	//openWin弹出一个窗口，自定义HTML代码
	openWin:function(id, title, width, height, html,closeFunction,buttons){
		if (!closeFunction){
			closeFunction = function() {};
		}
		if( !buttons ){
			buttons = [];
		}
		var bodyWidth = $D.getFullWidth(); // 网页可见区域宽
		var bodyHeight = $D.getFullHeight(); // 网页可见区域高
		if (width > bodyWidth - 20) {
			width = bodyWidth - 20;
		}
		if (height > bodyHeight - 18) {
			height = bodyHeight - 18;
		}
		var win = new Ext.Window( {
			id : id,
			width : width,
			height : height,
			closable : true,
			layout : 'fit',
			modal : true,
			plain : true,
			frame : true,
			html : html,
			resizable : false,
			buttonAlign:'center',  
            buttons : buttons,
			listeners : {
				"close" : closeFunction
			}
		});
		//打开子窗口后 隐藏父窗口的滚动条
		var style = document.body.style;
		var of = style.overflow;
		style.overflow = "hidden";
		win.on("close",function(){style.overflow = of;});
		
		win.show();
		win.setTitle(title);
		return win;
	},
	openUrl:function(id, title, width, height, url,closeFunction,buttons){
		var html = '<iframe id="'+id+'_frame" style="BACKGROUND:#FFFFFF;margin-top:-1px;" name="'
		+ id + 'frame" src="' + url + '" frameBorder=0 width="100%" height="100%"> </iframe>';
		return this.openWin(id, title, width, height, html, closeFunction,buttons);
	}
};