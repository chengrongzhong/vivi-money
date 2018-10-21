package com.kuyu.action;

import com.kuyu.action.base.BaseAction;
import com.nfwork.dbfound.core.Context;
import com.nfwork.dbfound.dto.QueryResponseObject;
import com.nfwork.dbfound.dto.ResponseObject;
import com.nfwork.dbfound.model.ModelEngine;

import java.util.*;

/**
 * Created by ${chengrz} on 2016/7/8 0008.
 */
public class DealerActionStatistics  extends BaseAction {

    public static Map<Integer, List<String>> staMap = new HashMap<Integer, List<String>>();

    static {
        staMap.put(11, new ArrayList(Arrays.asList("子账号管理", "创建账号")));
        staMap.put(12, new ArrayList(Arrays.asList("采购单确认", "确认列表")));
        staMap.put(13, new ArrayList(Arrays.asList("入库管理", "采购历史")));
        staMap.put(14, new ArrayList(Arrays.asList("采购单确认", "采购历史")));
        staMap.put(15, new ArrayList(Arrays.asList("采购单在途查询", "在途查询")));
        staMap.put(16, new ArrayList(Arrays.asList("零售订单创建", "零售开单")));
        staMap.put(17, new ArrayList(Arrays.asList("财务管理", "账户余额")));
        staMap.put(18, new ArrayList(Arrays.asList("账务查询", "账务查询")));
        staMap.put(19, new ArrayList(Arrays.asList("财务管理", "发票管理")));
        staMap.put(20, new ArrayList(Arrays.asList("入库管理", "收货入库")));
        staMap.put(21, new ArrayList(Arrays.asList("库存管理", "库存查询")));
        staMap.put(22, new ArrayList(Arrays.asList("库存管理", "库存调拨查询")));
        staMap.put(23, new ArrayList(Arrays.asList("商返管理", "退货查询")));
        staMap.put(24, new ArrayList(Arrays.asList("商返管理", "退货申请")));
        staMap.put(25, new ArrayList(Arrays.asList("扫码出库", "扫码出库")));
        staMap.put(26, new ArrayList(Arrays.asList("零售订单创建", "零售开单")));
        staMap.put(27, new ArrayList(Arrays.asList("零售订单创建", "代客下单")));
        staMap.put(28, new ArrayList(Arrays.asList("销售管理", "开单列表")));
        staMap.put(29, new ArrayList(Arrays.asList("销售管理", "零售退单")));
        staMap.put(30, new ArrayList(Arrays.asList("子账号管理", "账号列表")));
        staMap.put(31, new ArrayList(Arrays.asList("调查问卷", "调查问卷")));
    }

    public ResponseObject type(Context context) throws Exception {
        return ModelEngine.execute(context, "url_statistic_list", "type");
    }

    public ResponseObject query(Context context) throws  Exception {
        QueryResponseObject obj = ModelEngine.query(context, "dealer_action_statistics", "query");
        List datas = obj.getDatas();
        List<Map<String, Object>> newDatas = new ArrayList<Map<String, Object>>();
        if (!datas.isEmpty()) {
            for (int i = 0; i < datas.size(); i++) {
                Map<String, Object> data = (Map<String, Object>) datas.get(i);
                if(Integer.parseInt(data.get("actcount").toString()) > 0) {
                    String purchase_uuid = data.get("purchase_uuid").toString();
                    Context ct = new Context();
                    ct.setParamData("purchase_uuid", purchase_uuid);
                    QueryResponseObject result = ModelEngine.query(ct, "dealer_action_statistics", "countdays");
                    int days = result.getDatas().size();
                    data.put("days", days);
                    newDatas.add(setAttributeByType(data));
                }
            }
            obj.setDatas(newDatas);
        }
        return obj;
    }

    public Map<String, Object> setAttributeByType(Map<String, Object> data) {
        int sta_type = (Integer)data.get("sta_type");
        List<String> strings = staMap.get(sta_type);
        data.put("firstlevel", strings.get(0));
        data.put("secondlevel", strings.get(1));
        return data;
    }
}
