package com.kuyu.action.base;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.nfwork.dbfound.core.Context;
import com.nfwork.dbfound.dto.ResponseObject;
import com.nfwork.dbfound.web.base.BaseControl;

public class BaseAction implements BaseControl {
    @Override
    public ResponseObject execute(final Context context) throws Exception {
        return null;
    }

    /**
     * 在request周期中保存变量
     * 
     * @param context
     */
    public void setAttribute(Context context, String property, Object value) {
        getRequest(context).setAttribute(property, value);
    }

    /**
     * 在Session周期中保存变量
     * 
     * @param context
     */
    public void setSessionAttribute(Context context, String property, Object value) {
        getSession(context).setAttribute(property, value);
    }

    /**
     * 获取HttpServletRequest
     * 
     * @param context
     * @return
     */
    public HttpServletRequest getRequest(Context context) {
        return context.request;
    }

    /**
     * 获取HttpServletResponse
     * 
     * @param context
     * @return
     */
    public HttpServletResponse getResponse(Context context) {
        return context.response;
    }

    /**
     * 获取HttpSession
     * 
     * @param context
     * @return
     */
    public HttpSession getSession(Context context) {
        return getRequest(context).getSession();
    }

    /**
     * 获取ServletContext
     * 
     * @param context
     * @return
     */
    public ServletContext getApplication(Context context) {
        return getSession(context).getServletContext();
    }
}
