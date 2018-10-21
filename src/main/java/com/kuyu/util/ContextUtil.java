package com.kuyu.util;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.nfwork.dbfound.core.Context;

public class ContextUtil {

    /**
     * 示例 ModelEngine.query(ContextUtil.newContext("ids", ids), "/module", null);
     * 
     * @param params
     * @return
     */
    public static Context newContext(String param, Object value) {
        Context context = new Context();
        context.setParamData(param, value);
        return context;
    }

    /**
     * 示例 ModelEngine.query(ContextUtil.newContext(new Object[][]{ { "ids", ids }, { "ids", ids } }), "/module", null);
     * 
     * @param params
     * @return
     */
    public static Context newContext(Object[][] params) {
        Context context = new Context();
        if (params != null) {
            for (Object[] obj : params) {
                context.setParamData((String) obj[0], obj[1]);
            }
        }
        return context;
    }

    /**
     * 获取参数值，并转换为整型
     * 
     * @param context
     * @param arg
     * @return
     */
    public static Integer getIntegerParam(Map<String, Object> map, String key) {
        String v = getStringParam(map, key);
        if (StringUtils.isNotBlank(v)) {
        	if(v.contains(".")){
    			v = v.substring(0, v.indexOf("."));
    		}
            return Integer.parseInt(v);
        }
        return null;
    }
    
    /**
     * 获取参数值，并转换为Long型
     * 
     * @param context
     * @param arg
     * @return
     */
    public static Long getLongParam(Map<String, Object> map, String key) {
        String v = getStringParam(map, key);
        if (StringUtils.isNotBlank(v)) {
        	if(v.contains(".")){
    			v = v.substring(0, v.indexOf("."));
    		}
            return Long.parseLong(v);
        }
        return null;
    }

    /**
     * 获取参数值，并转换为String型
     * 
     * @param context
     * @param arg
     * @return
     */
    public static String getStringParam(Map<String, Object> map, String key) {
        Object obj = map.get(key);
        if (obj != null) {
            if (obj instanceof String) {
                return (String) obj;
            } else {
                return obj.toString();
            }
        }
        return null;
    }

    /**
     * 获取参数值，并转换为整型
     * 
     * @param context
     * @param arg
     * @return
     */
    public static Integer getIntegerParam(Context context, String arg) {
        String v = getStringParam(context, arg);
        if (StringUtils.isNotBlank(v)) {
        	if(v.contains(".")){
    			v = v.substring(0, v.indexOf("."));
    		}
            return Integer.parseInt(v);
        }
        return null;
    }

    /**
     * 获取参数值，并转换为字符串
     * 
     * @param context
     * @param arg
     * @return
     */
    public static String getStringParam(Context context, String arg) {
        Object v = context.getData(arg);
        return (v != null) ? v.toString() : null;
    }
    
    public static Double getDoubleParam(Context context, String arg){
    	 String v = getStringParam(context, arg);
         if (StringUtils.isNotBlank(v)) {
             return Double.parseDouble(v);
         }
         return null;
    }
    
    public static Double getDoubleParamClearNull(Context context, String arg){
   	 String v = getStringParamClearNull(context, arg);
        if (StringUtils.isNotBlank(v)) {
            return Double.parseDouble(v);
        }
        return null;
   }
    
    public static Double getDoubleParamClearNull(Map<String, Object> map, String arg) {
    	String v = getStringParamClearNull(map,  arg);
    	if(StringUtils.isNotBlank(v)){
    		return Double.parseDouble(v);
    	}
    	return null;
    }
    
    public static Double getDoubleParam(Map<String, Object> map, String arg) {
        String v = getStringParam(map, arg);
        if (StringUtils.isNotBlank(v)) {
            return Double.parseDouble(v);
        }
        return null;
    }

    /**
     * 获取参数值，并转换为字符串;若字符串值等于"null",则返回null,不返回"null"字符串
     * 
     * @param context
     * @param arg
     * @return
     */
    public static String getStringParamClearNull(Context context, String arg) {
        Object v = context.getData(arg);
        if (v != null) {
            String s = v.toString();
            return (s.toLowerCase().equals("null")) ? null : s;
        }
        return null;
    }

    /**
     * 获取参数值，并转换为字符串;若字符串值等于"null",则返回null,不返回"null"字符串
     * 
     * @param context
     * @param arg
     * @return
     */
    public static String getStringParamClearNull(Map<String, Object> map, String arg) {
        Object v = map.get(arg);
        if (v != null) {
            String s = v.toString();
            return (s.toLowerCase().equals("null")) ? null : s;
        }
        return null;
    }

    public static Integer getIntegerParamClearNull(Map<String, Object> map, String arg) {
    	String v = getStringParamClearNull(map,  arg);
    	if(StringUtils.isNotBlank(v)){
    		if(v.contains(".")){
    			v = v.substring(0, v.indexOf("."));
    		}
    		return Integer.parseInt(v);
    	}
    	return null;
    }
    
    /**
     * 清空Context参数
     * 
     * @param context
     * @return
     */
    public static Context clearContextParams(Context context) {
        if (context != null) {
            Map parmMap = (Map) context.getData("param");
            if (parmMap != null) {
                parmMap.clear();
            }
        }
        return context;
    }
}
