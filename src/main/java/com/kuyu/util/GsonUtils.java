package com.kuyu.util;

import java.lang.reflect.Type;
import java.text.DateFormat;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class GsonUtils {

	private static final Gson gson = new GsonBuilder().setDateFormat(DateFormat.FULL, DateFormat.FULL).create();

    /**
     * 对象转换为JSON字符串
     * 
     * @param jsonObject 需要转换为JSON的对象实例
     * @return
     */
    public static String toJson(Object jsonObject) {
        return gson.toJson(jsonObject);
    }

    
    public static <T> T fromJson(String json,Class<T> clazz){
    	return gson.fromJson(json, clazz);
    }
    
    public static JsonArray toJsonArray(String json) {
        return gson.toJsonTree(json.trim()).getAsJsonArray();
    }

    public static JsonObject toJsonObject(String json) {
    	//return gson.toJsonTree(json.trim()).getAsJsonObject();
    	JsonElement jsonElement = new JsonParser().parse(json);
    	return jsonElement.getAsJsonObject();
    }
    
   	/**
   	 * 
   	 * @param json
   	 * @param type
   	 *           Type typeOfT = new com.google.gson.reflect.TypeToken<Collection<Foo>>(){}.getType();
   	 *           示例:
   	 *           List<T_adv_preload_ext> datas = (List<T_adv_preload_ext>)ObjectUtils.fromJsonToObject(json, new TypeToken<List<T_adv_preload_ext>>(){}.getType());
   	 * @return
   	 */
   	public static Object fromJson(String json, Type type) {
   		Object target = gson.fromJson(json, type);
   		return target;
   	}
}
