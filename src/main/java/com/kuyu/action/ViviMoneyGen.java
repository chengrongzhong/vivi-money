package com.kuyu.action;

import com.alibaba.fastjson.JSONObject;
import com.kuyu.action.base.BaseAction;
import com.kuyu.util.ContextUtil;
import com.nfwork.dbfound.core.Context;
import com.nfwork.dbfound.dto.QueryResponseObject;
import com.nfwork.dbfound.dto.ResponseObject;
import com.nfwork.dbfound.model.ModelEngine;
import org.apache.commons.lang3.StringUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class ViviMoneyGen extends BaseAction {

    public ResponseObject moneyGen(Context context) throws  Exception {
        ResponseObject responseObject = new ResponseObject();
        responseObject.setSuccess(false);
        responseObject.setMessage("");

        Map<String, Object> requestMap = (Map<String, Object>) context.getData("param");
        String value = (String) requestMap.get("value");
        String monthGen = value.substring(0, value.length()-3);

        // 生成月份 yyyy-mm 格式
        Context ctx = ContextUtil.newContext("name", monthGen);
        ModelEngine.execute(ctx, "vivi/month_money", "add");
        QueryResponseObject executeResponse = ModelEngine.query(new Context(), "vivi/month_money", "queryAllMonthMoney");
        Map<String, Object> newone = (Map<String, Object>) executeResponse.getDatas().get(0);
        Integer month_money_id = Integer.parseInt(newone.get("id").toString());
        System.out.println("===========主表" + month_money_id);
        QueryResponseObject obj = ModelEngine.query(context, "vivi/teacher", "queryD");
        List datas = obj.getDatas();
        int count = 0;
        if (!datas.isEmpty()) {
            for (int i = 0; i < datas.size(); i++) {
                Map<String, Object> dataMap = new HashMap<String, Object>();
                dataMap.put("month_money_id", month_money_id);
                Map<String, Object> data = (Map<String, Object>) datas.get(i);
                Integer teacher_id = ContextUtil.getIntegerParam(data, "id");
                String teacher_name = ContextUtil.getStringParam(data, "teacher_name");
                Integer jiaotong = ContextUtil.getIntegerParam(data, "jiaotong");
                Integer shebao = ContextUtil.getIntegerParam(data, "shebao");
                Integer sushe = ContextUtil.getIntegerParam(data, "sushe");
                String special_str = ContextUtil.getStringParam(data, "other");
                float special = Float.parseFloat(special_str);
                Integer company_money = ContextUtil.getIntegerParam(data, "company_money");
                dataMap.put("teacher_id", teacher_id);
                dataMap.put("teacher_name", teacher_name);
                dataMap.put("jiaotong_money", jiaotong);
                dataMap.put("shebao", shebao);
                dataMap.put("sushe", sushe);
                dataMap.put("special", special);
                dataMap.put("company_money", company_money);

                dataMap.put("quanqin", 100);
                Integer duty_id = ContextUtil.getIntegerParam(data, "duty_id");
                String join_time = ContextUtil.getStringParam(data, "join_time");
                String birth = ContextUtil.getStringParam(data, "birth");
                int birthMoney = getBirthMoney(birth, monthGen, duty_id);
                dataMap.put("birth_day_money", birthMoney);

                int workYearMoney = getWorkYearMoney(join_time, value, duty_id);
                dataMap.put("work_year_money", workYearMoney);

                Integer start_id = ContextUtil.getIntegerParam(data, "start_id");
                setDutyData(dataMap, duty_id);
                setStartData(dataMap, start_id);
                setMonthData(dataMap, monthGen + "%", teacher_id);

                if (duty_id == 8 || duty_id == 11 || duty_id == 14 || duty_id == 15 || duty_id == 16) {
                    dataMap.put("performance_money", 0);
                }
                if (duty_id == 12) {
                    dataMap.put("quanqin", 0);
                    dataMap.put("performance_money", 0);
                    dataMap.put("security_money", 0);
                }
                // 算请假前要把所有应付工资算出来
                float shouldPay = getShouldPay(dataMap);
                dataMap.put("should_pay", shouldPay);
                QueryResponseObject monthLeave = ModelEngine.query(context, "vivi/leave", "monthLeave");
                setMonthLeave(teacher_id, dataMap, monthLeave.getDatas());
                // 修改了全勤工资之后，再算一次应付工资
                dataMap.put("should_pay", getShouldPay(dataMap));
                float realPay = getRealPay(dataMap);
                dataMap.put("real_pay", realPay);
                if (insertGen(context, dataMap)) {
                    count++;
                }
            }
        }
        responseObject.setMessage(responseObject.getMessage() + "生成成功！ 共成功 " + count + "条记录！");
        return responseObject;
    }

    private int getBirthMoney(String birth, String now, int duty_id) {
        System.out.println(birth);
        int money = 0;
        String birthMonth = birth.substring(5, 7);
        String nowMonth = now.substring(5, 7);
        if (duty_id == 11 || duty_id == 12 || duty_id == 14 || duty_id == 15 || duty_id == 16) {
            return money;
        }
        if (nowMonth.equals(birthMonth)) {
            money = 100;
        }
        return money;
    }

    private int getWorkYearMoney(String joinTime, String now, int duty_id) throws ParseException {
        System.out.println(joinTime);
        int money = 0;

        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        Date d1=sdf.parse(joinTime);
        Date d2=sdf.parse(now);
        String joinDay = joinTime.substring(8, 10);
        long daysBetween=(d2.getTime()-d1.getTime())/(3600*24*1000);
        if (Integer.parseInt(joinDay) > 5) {
            daysBetween = daysBetween - 30;
        }
        long days = daysBetween / 365;
        int countYear = Integer.parseInt(days+"");

        if (duty_id == 17 || duty_id == 10 || duty_id == 8 || duty_id == 1) {
            if (countYear >= 1) {
                countYear = countYear - 1;
            }
        }
//        int joinYear = Integer.parseInt(joinTime.substring(0, 4));
//        int nowYear = Integer.parseInt(now.substring(0, 4));
//        int countYear = nowYear - joinYear;
        money = countYear * 50 + (countYear / 3) * 50;
        return money > 500 ? 500 : money;
    }

    private void setDutyData(Map<String, Object> dataMap, int dutyId) {
        Context context = ContextUtil.newContext("id", dutyId);
        QueryResponseObject query = ModelEngine.query(context, "vivi/duty", "queryD");

        List datas = query.getDatas();
        if (!datas.isEmpty()) {
            for (int i = 0; i < datas.size(); i++) {
                Map<String, Object> queryData = (Map<String, Object>) datas.get(i);
                String duty_name = ContextUtil.getStringParam(queryData, "duty_name");
                Integer base_money = ContextUtil.getIntegerParam(queryData, "base_money");
                Integer other_money = ContextUtil.getIntegerParam(queryData, "other_money");
                Integer position_money = ContextUtil.getIntegerParam(queryData, "position_money");

                dataMap.put("duty_name", duty_name);
                dataMap.put("base_money", base_money);
                dataMap.put("other_money", other_money);
                dataMap.put("position_money", position_money);
                return;
            }
        }
    }

    private void setStartData(Map<String, Object> dataMap, int startId) {
        Context context = ContextUtil.newContext("id", startId);
        QueryResponseObject query = ModelEngine.query(context, "vivi/start", "queryD");
        List datas = query.getDatas();
        if (!datas.isEmpty()) {
            for (int i = 0; i < datas.size(); i++) {
                Map<String, Object> queryData = (Map<String, Object>) datas.get(i);
                Integer start_id = ContextUtil.getIntegerParam(queryData, "id");
                String start_name = ContextUtil.getStringParam(queryData, "start_name");
                Integer start_money = ContextUtil.getIntegerParam(queryData, "money");

                dataMap.put("start_id", start_id);
                dataMap.put("start_name", start_name);
                dataMap.put("start_money", start_money);
                return;
            }
        }
    }

    private void setMonthData(Map<String, Object> dataMap, String month, int teacherId) {
        Context context = ContextUtil.newContext("opetime", month);
        QueryResponseObject monthPerf = ModelEngine.query(context, "vivi/performance", "monthPerf");
        setMonthPerf(teacherId, dataMap, monthPerf.getDatas());
        QueryResponseObject monthAtt = ModelEngine.query(context, "vivi/class_att", "monthAtt");
        setMonthAtt(teacherId, dataMap, monthAtt.getDatas());
        QueryResponseObject monthSecurity = ModelEngine.query(context, "vivi/security", "monthSecurity");
        setMonthSecurity(teacherId, dataMap, monthSecurity.getDatas());
    }

    // 月度绩效
    private void setMonthPerf(int teacherId, Map<String, Object> dataMap, List<Map<String, Object>> list) {
        dataMap.put("performance_money", 200);
        for (Map<String, Object> map : list) {
            Integer teacher_id = ContextUtil.getIntegerParam(map, "teacher_id");
            if (teacher_id == teacherId) {
                int base = 200;
                Integer count = ContextUtil.getIntegerParam(map, "count");
                Integer addCount = ContextUtil.getIntegerParam(map, "add_count");
                if (addCount == null) {
                    addCount = 0;
                }
                if (count >= 91) {
                    base = base;
                } else if (count >= 81) {
                    base = base - (100 - count) * 2;
                } else if (count >= 71) {
                    base = base - (100 - count) * 3;
                }
                System.out.println("教师id=" + teacherId + "， 基本绩效=" + base + "， 加分绩效=" + addCount * 10);
                base = base + addCount * 10;
                dataMap.put("performance_money", base);
                return;
            }
        }
    }

    private void setMonthLeave(int teacherId, Map<String, Object> dataMap, List<Map<String, Object>> list) {
        JSONObject leave_desc = new JSONObject();
        float reduce = 0;
        int teacher_type = getTeacherType(teacherId);
        if (teacher_type == 0) {
            return;
        }
        for (Map<String, Object> map : list) {
            Integer teacher_id = ContextUtil.getIntegerParam(map, "teacher_id");
            // 新增请假时长，以天为单位
            if (teacherId == teacher_id) {

                int leave_type_id = ContextUtil.getIntegerParam(map, "leave_type_id");
                int twoHourFlag = ContextUtil.getIntegerParam(map, "twohourflag");
                String leave_day_str = ContextUtil.getStringParam(map, "leave_day");
                System.out.println(leave_day_str);
                float leave_day = Float.parseFloat(leave_day_str);
                if (leave_desc.containsKey(leave_type_id + "")) {
                    float oldDay = (float) leave_desc.get(leave_type_id + "");
                    float total = leave_day + oldDay;
                    leave_desc.put(leave_type_id + "", total);
                } else {
                    leave_desc.put(leave_type_id + "", leave_day);
                }

                // 计算请假扣钱
                if (twoHourFlag == 1){
                    reduce = reduce + 10;
                    continue;
                } else if (twoHourFlag == 2){
                    reduce = reduce + 20;
                    continue;
                }
            }
        }
        if (teacher_type == 1) {
            if (leave_desc.size() > 0) {
                if (leave_desc.containsKey("1")) {
                    String leave_day_str = leave_desc.get("1").toString();
                    float leave_day = Float.parseFloat(leave_day_str);
                    if (leave_day > 0 && leave_day <= 0.5) {
                        dataMap.put("quanqin", 75);
                    } else if (leave_day > 0.5) {
                        dataMap.put("quanqin", 50);
                    }
                }
                if (leave_desc.containsKey("5")) {
                    String leave_day_str = leave_desc.get("5").toString();
                    float leave_day = Float.parseFloat(leave_day_str);
                    if (leave_day > 0) {
                        dataMap.put("quanqin", 0);
                    }
                }
            }
        }
        float base_money = 0;
        // 正式
        if (teacher_type == 1) {
            base_money = (Integer) dataMap.get("base_money");
            int company_money = (Integer) dataMap.get("company_money");
            base_money = base_money + company_money;
        }
        // 试用期
        if (teacher_type == 2) {
            base_money = (float) dataMap.get("should_pay");
        }
        if (leave_desc.containsKey("1")) {
            // 病假
            String leave_day_str = leave_desc.get("1").toString();
            float leave_day = Float.parseFloat(leave_day_str);
            reduce = reduce + base_money / 30 * leave_day / 2;
        }
        if (leave_desc.containsKey("5")) {
            // 事假
            String leave_day_str = leave_desc.get("5").toString();
            float leave_day = Float.parseFloat(leave_day_str);
            reduce = reduce + base_money / 30 * leave_day;
        }
        dataMap.put("leave_money", reduce);

        String desc = getLeaveDesc(leave_desc);
        dataMap.put("leave_desc", desc);
    }

    private void setMonthAtt(int teacherId, Map<String, Object> dataMap, List<Map<String, Object>> list) {
        for (Map<String, Object> map : list) {
            Integer class_id = ContextUtil.getIntegerParam(map, "class_id");
            Integer count = ContextUtil.getIntegerParam(map, "count");
            Integer student = ContextUtil.getIntegerParam(map, "student");
            int dianshu = 10;
            if (student > 4 && student <= 6) {
                dianshu = 10;
            } else if (student <= 10) {
                dianshu = 15;
            } else if (student <= 15) {
                dianshu = 20;
            } else if (student <= 30) {
                dianshu = 30;
            }
            float money = 0f;
            if (dataMap.containsKey("class_att_money")) {
                money = (float) dataMap.get("class_att_money");
            }
            Context ctx = ContextUtil.newContext("id", class_id);
            QueryResponseObject obj = ModelEngine.query(ctx, "vivi/class", "queryD");
            Map<String, Object> sngClass = (Map<String, Object>) obj.getDatas().get(0);
            String main_teacher_id = ContextUtil.getStringParam(sngClass, "main_teacher_id");
            String vice_teacher_id = ContextUtil.getStringParam(sngClass, "vice_teacher_id");
            String life_teacher_id = ContextUtil.getStringParam(sngClass, "life_teacher_id");
            int percen = 0;
            boolean viceFlag = false;
            boolean lifeFlag = false;
            if (!StringUtils.isEmpty(vice_teacher_id)) {
                String[] viceTeacher = vice_teacher_id.split(",");
                for (String str : viceTeacher) {
                    if (str.equals(teacherId + "")) {
                        viceFlag = true;
                    }
                }
            }
            if (!StringUtils.isEmpty(life_teacher_id)) {
                String[] lifeTeacher = life_teacher_id.split(",");
                for (String str : lifeTeacher) {
                    if (str.equals(teacherId + "")) {
                        lifeFlag = true;
                    }
                }
            }
            if (!StringUtils.isEmpty(main_teacher_id) && main_teacher_id.equals(teacherId + "")) {
                percen = ContextUtil.getIntegerParam(sngClass, "main_get");
            } else if (!StringUtils.isEmpty(vice_teacher_id) && viceFlag) {
                percen = ContextUtil.getIntegerParam(sngClass, "vice_get");
            } else if (!StringUtils.isEmpty(life_teacher_id) && lifeFlag) {
                percen = ContextUtil.getIntegerParam(sngClass, "life_get");
            }
            float total = (count - 80) * dianshu * percen;
            float nowmoney = total / 100;
            money = money + nowmoney;
            dataMap.put("class_att_money", money);
        }
    }

    private void setMonthSecurity(int teacherId, Map<String, Object> dataMap, List<Map<String, Object>> list) {
        int base = 100;
        for (Map<String, Object> map : list) {
            String teacher_id = ContextUtil.getStringParam(map, "teacher_id");
            String[] split = teacher_id.split(",");
            for (String str : split) {
                if (str.equals(teacherId + "")) {
                    int id = ContextUtil.getIntegerParam(map, "id");
                    int reduceMoney = ContextUtil.getIntegerParam(map, "reduce_money");
                    base = base - reduceMoney;
                    System.out.println("教师id=" + teacherId + "， 安全扣除=" + reduceMoney + "， 安全id=" + id);
                }
            }
        }
        System.out.println("教师id=" + teacherId + "， 安全最终=" + base);
        dataMap.put("security_money", base);
    }

    private boolean insertGen(Context context, Map<String, Object> dataMap) {
        ContextUtil.clearContextParams(context);
        Set<String> keys = dataMap.keySet();
        for (String key : keys) {
            context.setParamData(key, dataMap.get(key));
        }
        ResponseObject executeResponse = ModelEngine.execute(context, "vivi/month_money_detail", "add");
        return executeResponse.isSuccess();
    }

    /**
     * 获取现在时间
     *
     * @return 返回短时间字符串格式yyyy-MM-dd
     */
    public static String getStringDateShort() {
        Date currentTime = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String dateString = formatter.format(currentTime);
        return dateString;
    }

    public int getTeacherType(int teacherId) {
        int type = 0;
        Context ctx = ContextUtil.newContext("id", teacherId);
        QueryResponseObject obj = ModelEngine.query(ctx, "vivi/teacher", "queryD");
        List<Map<String, Object>> datas = (List<Map<String, Object>>) obj.getDatas();
        for (Map<String, Object> teacher : datas) {
            int duty_id = ContextUtil.getIntegerParam(teacher, "duty_id");
            if (duty_id == 11 || duty_id == 12 || duty_id == 14 || duty_id == 15 || duty_id == 16) {
                type = 2;
            } else {
                type = 1;
            }
        }
        return type;
    }

    public float getShouldPay(Map<String, Object> dataMap) {
        int base_money = (Integer) dataMap.get("base_money");
        int position_money = (Integer) dataMap.get("position_money");
        int start_money = (Integer) dataMap.get("start_money");
        int performance_money = (Integer) dataMap.get("performance_money");
        int jiaotong_money = (Integer) dataMap.get("jiaotong_money");
        int security_money = (Integer) dataMap.get("security_money");
        float class_att_money = (float) dataMap.get("class_att_money");
        int quanqin = (Integer) dataMap.get("quanqin");
        int birth_day_money = (Integer) dataMap.get("birth_day_money");
        int work_year_money = (Integer) dataMap.get("work_year_money");
        int other_money = (Integer) dataMap.get("other_money");
        int company_money = (Integer) dataMap.get("company_money");

        float shouldPay = base_money + position_money+start_money+performance_money+jiaotong_money+security_money+class_att_money+quanqin+birth_day_money+work_year_money+other_money+company_money;
        return shouldPay;
    }

    public float getRealPay(Map<String, Object> dataMap) {
        float shouldPay = (float) dataMap.get("should_pay");
        int shebao = (Integer) dataMap.get("shebao");
        int sushe = (Integer) dataMap.get("sushe");
        float leave_money = (float) dataMap.get("leave_money");
        float special = (float) dataMap.get("special");
        float realPay = shouldPay - shebao - sushe - leave_money - special;
        return realPay;
    }

    public String getLeaveDesc(JSONObject jsonObject) {
        String desc = "";
        if (jsonObject.containsKey("1")) {
            desc = desc + "病假：" + jsonObject.getString("1") + "天 ";
        }
        if (jsonObject.containsKey("2")) {
            desc = desc + "丧假：" + jsonObject.getString("2") + "天 ";
        }
        if (jsonObject.containsKey("3")) {
            desc = desc + "婚假：" + jsonObject.getString("3") + "天 ";
        }
        if (jsonObject.containsKey("4")) {
            desc = desc + "产假：" + jsonObject.getString("4") + "天 ";
        }
        if (jsonObject.containsKey("5")) {
            desc = desc + "事假：" + jsonObject.getString("5") + "天 ";
        }
        return desc;
    }
}
