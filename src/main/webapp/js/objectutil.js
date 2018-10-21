//自适应高度
/*$(window.parent.document).find("#iframe_content").load(function() {
	var main = $(window.parent.document).find("#iframe_content");
	var thisheight = $(document).height() + 30;
	if (thisheight <= 900) {
		thisheight = 1550;
	}
	main.height(thisheight);
});*/

// 模板
/*(function($) {
	$.extend({

	});

})(jQuery);
*/
//使用示例:$TOOL.validate.isInt("6d")
$TOOL = {
	// 时间工具
	timeUtil : {
		/**
		 * 日期 转换为 Unix时间戳
		 * 
		 * @param <int>
		 *            year 年
		 * @param <int>
		 *            month 月
		 * @param <int>
		 *            day 日
		 * @param <int>
		 *            hour 时
		 * @param <int>
		 *            minute 分
		 * @param <int>
		 *            second 秒
		 * @return <int> unix时间戳(秒)
		 */
		DateToUnix : function(year, month, day, hour, minute, second) {
			var oDate = new Date(Date.UTC(parseInt(year), parseInt(month),
					parseInt(day), parseInt(hour), parseInt(minute),
					parseInt(second)));
			return (oDate.getTime() / 1000);
		},
		/**
		 * 时间戳转换日期
		 * 
		 * @param <int>
		 *            unixTime 待时间戳(秒)
		 * @param <bool>
		 *            isFull 返回完整时间(Y-m-d 或者 Y-m-d H:i:s)
		 * @param <int>
		 *            timeZone 时区
		 */
		UnixToDate : function(unixTime, isFull, timeZone) {
			if (typeof (timeZone) == 'number') {
				unixTime = parseInt(unixTime) + parseInt(timeZone) * 60
						* 60;
			}
			var time = new Date(unixTime * 1000);
			var ymdhis = "";
			ymdhis += time.getUTCFullYear() + "-";
			ymdhis += time.getUTCMonth() + "-";
			ymdhis += time.getUTCDate();
			if (isFull === true) {
				ymdhis += " " + time.getUTCHours() + ":";
				ymdhis += time.getUTCMinutes() + ":";
				ymdhis += time.getUTCSeconds();
			}
			return ymdhis;
		},
		// 东8区
		UnixToDefaultDate : function(unixTime) {
			return $.timeUtil.UnixToDate(unixTime / 1000, true, 8);
		}
	},
	// cookie工具
	cookieUtil : {
		set : function(name, value) {
			var Days = 365; // 此 cookie 将被保存 365 天
			var exp = new Date(); // new Date("December 31, 9998");
			exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
			document.cookie = name + "=" + escape(value) + ";expires="
					+ exp.toGMTString();
		},
		get : function(name) {
			var arr = document.cookie.match(new RegExp("(^| )" + name
					+ "=([^;]*)(;|$)"));
			if (arr != null)
				return unescape(arr[2]);
			return null;
		},
		del : function(name) {
			var exp = new Date();
			exp.setTime(exp.getTime() - 1);
			var cval = $.cookieUtil.get(name);
			if (cval != null)
				document.cookie = name + "=" + cval + ";expires="
						+ exp.toGMTString();
		}
	},
	// 验证工具
	validate : {
		// 整数
		isInt : function(str) {
			var reg = /^(-|\+)?\d+$/;
			return reg.test(str);
		},
		// 小数
		isFloat : function(str) {
			if (isInt(str))
				return true;
			var reg = /^(-|\+)?\d+\.\d*$/;
			return reg.test(str);
		},
		// 中文
		isCn : function(str) {
			var re1 = /[\u4e00-\u9fa5]/;
			return re1.test(str);
		},
		// 是否为空
		isEmpty : function(str) {
			if (str != null && str != "") {
				return false;
			}
			return true;
		},
		is_email : function(email) {
			var reg = /^\s*([A-Za-z0-9_-]+(\.\w+)*@(\w+\.)+\w{2,3})\s*$/;
			return reg.test(email);
		},
		isMobile : function(str) {
			if (/^1[345689]\d{9}/.test(str)) {
				return true;
			}
			return false;

		},
		isIdcard:function(id) {
			 var idNum = id.toLocaleUpperCase();
			 var errors = new Array(
			  "验证通过",
			  "身份证号码位数不对",
			   "身份证含有非法字符",
			  "身份证号码校验错误",
			  "身份证地区非法"
			 );
			 //身份号码位数及格式检验
			 var re;
			 var len = idNum.length;
			 //身份证位数检验
			 if (len != 15 && len != 18) {
			     //return errors[1];
			     return false;
			 } else if (len == 15) {
			     re = new RegExp(/^(\d{6})()?(\d{2})(\d{2})(\d{2})(\d{3})$/);
			 } else {
			     re = new RegExp(/^(\d{6})()?(\d{4})(\d{2})(\d{2})(\d{3})([0-9xX])$/);
			 }
			 var area = { 11: "北京", 12: "天津", 13: "河北", 14: "山西",
			     15: "内蒙古", 21: "辽宁", 22: "吉林", 23: "黑龙江", 31: "上海",
			     32: "江苏", 33: "浙江", 34: "安徽", 35: "福建", 36: "江西",
			     37: "山东", 41: "河南", 42: "湖北", 43: "湖南", 44: "广东",
			     45: "广西", 46: "海南", 50: "重庆", 51: "四川", 52: "贵州",
			     53: "云南", 54: "西藏", 61: "陕西", 62: "甘肃", 63: "青海",
			     64: "宁夏", 65: "新疆", 71: "台湾", 81: "香港", 82: "澳门",
			     91: "国外"
			 }
			 var idcard_array = new Array();
			 idcard_array = idNum.split("");
			 //地区检验
			 if (area[parseInt(idNum.substr(0, 2))] == null) {
			     return false;
			     //return errors[4];
			 }
			 //出生日期正确性检验
			 var a = idNum.match(re);
			 if (a != null) {
			     if (len == 15) {
			         var DD = new Date("19" + a[3] + "/" + a[4] + "/" + a[5]);
			         var flag = DD.getYear() == a[3] && (DD.getMonth() + 1) == a[4] && DD.getDate() == a[5];
			     }
			     else if (len == 18) {
			         var DD = new Date(a[3] + "/" + a[4] + "/" + a[5]);
			         var flag = DD.getFullYear() == a[3] && (DD.getMonth() + 1) == a[4] && DD.getDate() == a[5];
			     }
			     if (!flag) {
			         return false;
			         //return "身份证出生日期不对！"; 
			     }
			     //检验校验位
			     if (len == 18) {
			         S = (parseInt(idcard_array[0]) + parseInt(idcard_array[10])) * 7
			            + (parseInt(idcard_array[1]) + parseInt(idcard_array[11])) * 9
			            + (parseInt(idcard_array[2]) + parseInt(idcard_array[12])) * 10
			            + (parseInt(idcard_array[3]) + parseInt(idcard_array[13])) * 5
			            + (parseInt(idcard_array[4]) + parseInt(idcard_array[14])) * 8
			            + (parseInt(idcard_array[5]) + parseInt(idcard_array[15])) * 4
			            + (parseInt(idcard_array[6]) + parseInt(idcard_array[16])) * 2
			            + parseInt(idcard_array[7]) * 1
			            + parseInt(idcard_array[8]) * 6
			            + parseInt(idcard_array[9]) * 3;
			         Y = S % 11;
			         M = "F";
			         JYM = "10X98765432";
			         M = JYM.substr(Y, 1); //判断校验位
			         //检测ID的校验位
			         if (M == idcard_array[17]) {
			             return true;
			             //return ""; 
			         }
			         else {
			             return false;
			             //return errors[3];
			         }
			     }
			 } else {
			     return false;
			     //return errors[2];
			 }
			 return true;
			},
			isZipCode : function (str) {
				var pattern = /^\d{6}$/;
				return pattern.test(str);
			},
			//校验密码字符串：由6-20位数字、字母和特殊符号组成。
			isPassword : function(str){
				var pattern=/^[\w\W]{6,20}$/;
				return pattern.test(str);
			},
			//校验字符串——由5-20位字母、数字、下划线(常用于校验用户名)
			isUserName : function(str){
				var pattern=/^(\w){5,20}$/;
				return pattern.test(str);
			},
			//是否为时间
			isDate : function (str) {
				if(!/\d{4}(\.|\/|\-)\d{1,2}(\.|\/|\-)\d{1,2}/.test(str)){return false;}
				var r = str.match(/\d{1,4}/g);
				if(r==null){return false;};
				var d= new Date(r[0], r[1]-1, r[2]);
				return (d.getFullYear()==r[0]&&(d.getMonth()+1)==r[1]&&d.getDate()==r[2]);
			}
	},
	// http操作
	httplib : {
		ajaxPost : function(the_url, the_param, succ_callback) {
			$.ajax({
				type : 'POST',
				cache : false,
				url : the_url,
				data : the_param,
				success : succ_callback
			});
		},
		ajaxPostSync : function(the_url, the_param, succ_callback) {
			$.ajax({
				type : 'POST',
			    async:false,  // 设置同步方式
				cache : false,
				url : the_url,
				data : the_param,
				success : succ_callback
			});
		},
		// 使用ajax获取数据
		ajaxGet : function(the_url, succ_callback, error_callback) {
			$.ajax({
				type : 'GET',
				cache : true,
				url : the_url,
				success : succ_callback,
				error : error_callback

			});
		},
		// 发送json格式数据
		ajaxPostJson : function(the_url, data_pro, succ_callback,
				error_callback) {
			$.ajax({
				async : false,// 同步更新
				type : 'POST',
				dataType : 'json',
				data : data_pro,
				url : the_url,
				success : succ_callback,
				error : error_callback
			});
		},
                    responseValidate : function(responseText){
                           var jsonText = $.parseJSON(responseText);
                        if("404"==jsonText.code){
                                alert("操作失败,404错误");
                                return false;
                        }else if("503"==jsonText.code){
                                alert("操作失败,您没有权限");
                                return false;
                        }else if("401"==jsonText.code){
                                alert("登录用户已经失效,请重新登录");
                                return false;
                        }else if("402"==jsonText.code){
                                alert("数据异常,请刷新后重新提交");
                                return false;
                        }
                        else if("200"==jsonText.code){
                                return true;
                        }
                  },
                  /*不拦截跳转*/
                  newWindow:function(url){
                        var a = $("<a href='"+url+"' target='_blank'>newWindow</a>").get(0);
                        var e = document.createEvent('MouseEvents');
                        e.initEvent( 'click', true, true );
                        a.dispatchEvent(e);
                  }
                },
	stringUtil : {
		// 去除空格
		trim : function(str) {
			return str.replace(/(^\s*)|(\s*$)/g, '');
		},
		// 字符串长度
		getWordSize : function(str) {
			if (!str)
				return null;
			var length = 0;
			var regDoub = /[^x00-xff]/g;
			var regSingl = /[x00-xff]/g;
			var douL = str.match(regDoub);
			var singL = str.match(regSingl);
			if (douL) {
				length += douL.length * 2;
			}
			if (singL) {
				length += singL.length;
			}
			length /= 2;
			length = Math.ceil(length);
			return length;
		},
		//密码强度 校验密码强度 说明：1：弱；2：中；3：强；
		passwordStrength : function(password){
			if (password.length < 6) {
				return 1;
			}
			return password.match(/[a-z](?![^a-z]*[a-z])|[A-Z](?![^A-Z]*[A-Z])|\d(?![^\d]*\d)|[^a-zA-Z\d](?![a-zA-Z\d]*[^a-zA-Z\d])/g).length;
		}
	}
}

