package com.kuyu.check;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nfwork.dbfound.core.Context;
import com.nfwork.dbfound.dto.QueryResponseObject;
import com.nfwork.dbfound.model.ModelEngine;
import com.nfwork.dbfound.web.base.Interceptor;

public class AccessCheckInterceptor implements Interceptor {

    Map<String, String> map;

    @Override
    public boolean jspInterceptor(final HttpServletRequest request, final HttpServletResponse response) throws Exception {
    	Object user_id = request.getSession().getAttribute("user_id");

        String url = request.getServletPath().substring(1);
		if (user_id == null) {
			if (check(url)) {
				return true;
			} else {
				request.getRequestDispatcher("/pages/sys/sessionExpire.jsp").forward(
						request, response);
				return false;
			}
		} else {
            if (check(url)) {
                return true;
            }
            Context ct = new Context();
            ct.setParamData("user_id", user_id);
            QueryResponseObject obj = ModelEngine.query(ct, "sys/function", "query_function");
            if (!obj.getDatas().isEmpty()) {
                List<Map<String, Object>> data = (List<Map<String, Object>>) obj.getDatas();
                Map<String, String> map = new HashMap<String, String>();
                for (Map<String, Object> mapdata : data) {
                    String jsp_pager = (String)mapdata.get("jsp_pager"); // "jsp_pager" -> "pages/manage/dpuser-list.jsp"
                    map.put(jsp_pager, "1");
                }
                if (map.get(url) == null) {
                    request.setAttribute("request_url", url);
                    request.getRequestDispatcher("/pages/sys/noPower.jsp").forward(
                            request, response);
                    return false;
                }
            }
            return true;
		}
    }

    @Override
    public boolean doInterceptor(final Context context, final String className, final String method) throws Exception {
        return true;
    }

    @Override
    public boolean executeInterceptor(final Context context, final String modelName, final String executeName) throws Exception {

        return true;
    }

    @Override
    public boolean exportInterceptor(final Context context, final String modelName, final String queryName) throws Exception {
        return true;
    }

    @Override
    public boolean queryInterceptor(final Context context, final String modelName, final String queryName) throws Exception {
        return true;
    }

    public boolean check(final String url) {
        if (map.get(url) == null) {
            return false;
        } else {
            return true;
        }
    }

    @Override
    public void init() {
        map = new HashMap<String, String>();
        map.put("login.jsp", "1");
        map.put("relogin.jsp", "1");
        map.put("close.jsp", "1");
        map.put("loginWindow.jsp", "1");
        map.put("index.jsp", "1");
        map.put("pages/common/welcome.jsp", "1");
    }

}
