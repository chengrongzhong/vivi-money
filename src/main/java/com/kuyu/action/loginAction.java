package com.kuyu.action;

import com.kuyu.action.base.BaseAction;
import com.nfwork.dbfound.dto.ResponseObject;
import com.nfwork.dbfound.core.Context;

import java.util.Map;

/**
 * Created by ${chengrz} on 2016/5/7 0007.
 */
public class loginAction extends BaseAction {

    public ResponseObject login(Context context) throws Exception {
        Map<String, Object> data = (Map<String, Object>) context.getData("param");
        System.out.println(data);
        ResponseObject responseObject = new ResponseObject();
        responseObject.setSuccess(true);
        return responseObject;
    }

}
