package com.kuyu.check;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kuyu.util.GsonUtils;
import com.kuyu.util.PropertyHelper;
import com.nfwork.dbfound.dto.ResponseObject;
import com.nfwork.dbfound.web.WebWriter;


public class SessionInterceptor implements Filter {

    private static final String loginout = PropertyHelper.getValue("login.url");
    
    @Override
    public void destroy() {

    }

    @Override
    public void doFilter(final ServletRequest req, final ServletResponse res, final FilterChain chain) throws IOException, ServletException {
        final HttpServletRequest request = (HttpServletRequest) req;
        final HttpServletResponse response = (HttpServletResponse) res;
        final HttpSession session = request.getSession();
        
        String requestUri = request.getRequestURI();
        if(notFilterService(requestUri)){
                chain.doFilter(request, response);
            }else {
                chain.doFilter(request, response);
        }

//        request.getSession().setAttribute("LOGIN_USER_NAME", "chengrongzhong");
        //正式环境
//        String requestUri = request.getRequestURI();
//		if (notFilterService(requestUri)) {
//			chain.doFilter(request, response);
//		} else {
//			final UserClient userClient = new UserClientImp();
//			final User user = userClient.getUser(request, SYSTEM_ID);
//			if (user == null || user.getUser() == null) {
//				if (isAjaxRequest(requestUri)) {
//					ResponseObject responseObj = new ResponseObject();
//					responseObj.setMessage("Session已过期，请重新登录！");
//					responseObj.setSuccess(false);
//					String json = GsonUtils.toJson(responseObj);
//					WebWriter.jsonWriter(response, json);
//				} else {
//                    response.sendRedirect("/login.jsp");
//				}
//			} else {
//				request.getSession().setAttribute("LOGIN_USER_NAME", user.getUser().getLoginName());
//				chain.doFilter(request, response);
//			}
//		}
    }
    
    @Override
    public void init(final FilterConfig arg0) throws ServletException {
    }

    // 不用过滤的
    public static boolean notFilterService(final String requestPath) {
        final List<String> passFilter = new ArrayList<String>();
        passFilter.add("/interface/");
        passFilter.add("/js/");
        passFilter.add("/DBFoundUI/");
        passFilter.add("/css/");
        passFilter.add("/images/");
        passFilter.add("/index.jsp");
        passFilter.add("/login.jsp");
        passFilter.add("/loginwin.jsp");
        passFilter.add("/code.jsp");
        passFilter.add("integral/loginAction.do!login");

        for (final String str : passFilter) {
            if (requestPath.contains(str)) {
                return true;
            }
        }
        return false;
    }

    // AJAX请求
    public static boolean isAjaxRequest(String requestPath) {
        List<String> passFilter = new ArrayList<String>();
        passFilter.add(".do");
        passFilter.add(".execute");
        passFilter.add(".export");
        passFilter.add(".query");
        for (final String str : passFilter) {
            if (requestPath.contains(str)) {
                return true;
            }
        }
        return false;
    }
}
