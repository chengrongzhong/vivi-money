package com.kuyu.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

public class ObjectUtil {
    public static Long longValue(final Object o) {
        if (o == null) {
            return null;
        } else if (o instanceof Long) {
            return (Long) o;
        } else {
            return Long.parseLong(o.toString());
        }
    }

    public static Integer intValue(final Object o) {
        if (o == null) {
            return null;
        } else if (o instanceof Integer) {
            return (Integer) o;
        } else {
            return Integer.parseInt(o.toString());
        }
    }

    public static String stringValue(final Object o) {
        if (o == null) {
            return null;
        } else if (o instanceof String) {
            return (String) o;
        } else {
            return o.toString();
        }
    }

    public static Boolean boolValue(final Object o) {
        if (o == null) {
            return null;
        } else if (o instanceof Boolean) {
            return (Boolean) o;
        } else {
            return Boolean.parseBoolean(o.toString());
        }
    }

    public static boolean isNumeric(String str) {
        if (str == null) {
            return false;
        }
        if (str.equals("")) {
            return false;
        }
        for (int i = str.length(); --i >= 0;) {
            if (!Character.isDigit(str.charAt(i))) {
                return false;
            }
        }
        return true;
    }

    /**
     * 去除字符串两边空格，包括全角空格,解决String自带的trim()方法不能去除中文全角空格
     * 
     * @param str
     * @return
     */
    public static String trim(String str) {
        if (str != null) {
            str = str.trim();
            while (str.startsWith(" ")) {
                str = str.substring(1, str.length()).trim();
            }
            while (str.endsWith(" ")) {
                str = str.substring(0, str.length() - 1).trim();
            }
        }
        return str;
    }

    /**
     * 去除字符串两边指定的字符
     * 
     * @param sourceString
     * @param trim 是否去除sourceString两边的空字符
     * @param arg 需要替换为空的字符,可以传多个
     * @return
     */
    public static String trimString(String sourceString, boolean trim, String... arg) {
        if (sourceString != null) {
            sourceString = trim ? trim(sourceString) : sourceString;
            if (arg != null && arg.length > 0) {
                for (String string : arg) {
                    while (sourceString.startsWith(string)) {
                        String s = sourceString.substring(1, sourceString.length());
                        sourceString = trim ? trim(s) : s;
                    }
                    while (sourceString.endsWith(string)) {
                        String s = sourceString.substring(0, sourceString.length() - 1);
                        sourceString = trim ? trim(s) : s;
                    }
                }
            }
        }
        return sourceString;
    }

    /**
     * 拼接所有MAP对象某一属性值，并用splitStr进行分隔
     * 
     * @param map 格式：Map<Object,Map<String,Object>>
     * @param splitStr 分隔符
     * @param single 是否去重
     * @return
     */
    public static String joinProperty(List<Map<String, Object>> mapList, Object property, String splitStr, boolean single) {
        if (mapList != null) {
            String rtString = "";
            HashSet<Object> m = new HashSet<Object>();

            for (Map<String, Object> kmap : mapList) {
                Object object = kmap.get(property);
                if (object != null) {
                    if (!single || !m.contains(object)) {
                        rtString += (StringUtils.isNotBlank(rtString) ? splitStr : "") + object;
                    }
                    m.add(object);
                }
            }
            return rtString;
        }
        return "";
    }

    /**
     * 根据map的某一属性分类map对象,通常是一对一关系,如:每一map对象均有一个ID，将ID抽出来做为KEY值，原map是value
     * 
     * @param datas
     * @param key
     * @return
     */
    public static Map<Object, Map<String, Object>> keyMapObject(List<Map<String, Object>> datas, String key) {
        if (datas != null) {
            Map<Object, Map<String, Object>> result = new HashMap<Object, Map<String, Object>>();
            for (Map<String, Object> map : datas) {
                if (map.containsKey(key)) {
                    result.put(map.get(key), map);
                }
            }
            return result;
        }
        return null;
    }

    /**
     * 将数据对象集合中的某属性强制转换为Long型，并返回array,若为NULL则不返回
     * 
     * @param datas
     * @param key
     * @return
     */
    public static List<Long> mapPropertyLongArray(List<Map<String, Object>> datas, String key) {
        if (datas != null) {
            List<Long> result = new ArrayList<Long>();
            for (Map<String, Object> objMap : datas) {
                Object obj = objMap.get(key);
                if (obj != null) {
                    result.add(longValue(obj));
                }
            }
            return result;
        }
        return null;
    }
}
