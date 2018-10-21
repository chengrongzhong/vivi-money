package com.kuyu.util;

import java.util.Properties;

/**
 * Properties参数获取服务
 * 
 */
public class PropertyHelper {
    private static final String CONFIG_DIR = "config";

    private static Properties properties = null;

    static {
        properties = PropertiesLoader.loadProperties(CONFIG_DIR);
    }

    /**
     * 得到系统业务配置参数
     * 
     * @param key
     * @return 如果不存在，返回null
     */
    public static String getValue(String key) {
        return properties.getProperty(key);
    }

    public static Long getLongValue(String key, Long defautValue) {
        String temp = getValue(key);
        if (ObjectUtil.isNumeric(temp)) {
            return Long.parseLong(temp);
        }
        return defautValue;
    }

    public static Integer getIntValue(String key, Integer defaultValue) {
        String temp = getValue(key);
        if (ObjectUtil.isNumeric(temp)) {
            return Integer.parseInt(temp);
        }
        return defaultValue;
    }

}
