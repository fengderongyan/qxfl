package qxfl.application;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;


import com.alibaba.fastjson.JSONObject;
import com.zcc.util.PropertiesHelper;
import com.zcc.util.db.BatchSql;
import com.royasoft.servlet.ServletCode;


/** 
 * 通过o了平台向人员发送信息
 * @date 2015-11-08 
 */
@Component
public class OlMmsImgTxtSend extends BaseBackgroundApplication{
    
    String transImgItfcUrl = null;
    String olServerName = null;
    String olServerId = null;
    String olServerSecret = null;
    String token = "";
    /** 
     * 线程执行默认调用方法
     */ 
    public void run() {
        
        logger.info("<ol信息发送>：=============BEGIN！");
        
        /*PropertiesHelper proHelper = new PropertiesHelper();
        transImgItfcUrl = proHelper.getPropertiesValue("TRANS_IMG_ITFC_URL");
        olServerName = proHelper.getPropertiesValue("OL_SERVER_NAME");
        olServerId = proHelper.getPropertiesValue("OL_SERVER_ID");
        olServerSecret = proHelper.getPropertiesValue("OL_SERVER_SECRET_ID");*/
        List sendList = null;
        List sendInfoList = null;
        Map sendMap = null;
        String result;
        String finish_flag;
        while(true) {    
            sendList = this.getSendList();
            if(sendList.size() == 0) {
                try {
                    Thread.sleep(10000 * 30);
                } catch (InterruptedException e) {
                    logger.info("<ol彩信方式异常>：=============ol自定义彩信发送线程冲突！");
                    continue;
                }
            } else {
                for(int i = 0; i <sendList.size(); i++){
                    try {
                        sendMap = (Map) sendList.get(i);
                    } catch (Exception e) {
                        logger.debug("<ol彩信方式异常>：=============获取单个O了自动发送信息！");
                        continue;
                    }   
                    String info_id = String.valueOf(sendMap.get("ID"));
                    String groups = String.valueOf(sendMap.get("TARGET_GROUP_ID"));
                    String users = String.valueOf(sendMap.get("TARGET_USER"));
                    sendInfoList = this.getSendInfoList(info_id);
                    String[] title = new String[sendInfoList.size()];
                    String[] html = new String[sendInfoList.size()];
                    finish_flag = "true";
                    try {
                        for(int j = 0; j < sendInfoList.size(); j++){
                            System.out.println("j:" + j);
                            Map map = (Map) sendInfoList.get(j);
                            title[j] = String.valueOf(map.get("TITLE"));
                            html[j] = this.getSqlHtml(String.valueOf(map.get("HEADER")), 
                                                      String.valueOf(map.get("SQL_STATEMENT")), 
                                                      String.valueOf(map.get("DESCRIPTION")));
                            String sql = String.valueOf(map.get("FINISH_FLAG"));
                            if("false".equals(this.checkFinishFlag(sql))){
                                finish_flag = "false";
                            }
                        }
                    }
                    catch (Exception e) {
                        logger.debug("<ol彩信方式异常>：=============循环sendInfoList！");
                        continue;
                    }  
                    try {
                        //获取发送号码
                        String msisdns = this.getGroupUserMsisdn(groups, users);
                        //保存发送结果
                        if("true".equals(finish_flag)){
                          //发送O了信息
                            setAutoSendHisInfo(info_id, " ### ### ", "4");
                            result = this.setOlInfo(msisdns, html, title, 2);
                            if(result.contains("###")){
                                setAutoSendHisInfo(info_id, result, "1");            
                            }else{
                                setAutoSendHisInfo(info_id, " ### ### ", result);
                            }
                        }
                        if("false".equals(finish_flag)){
                              setAutoSendHisInfo(info_id, " ### ### ", "3");                        
                          }
                    } catch (Exception e) {
                        logger.debug("<ol彩信方式异常>：=============发送O了信息 保存发送结果！");
                        continue;
                    }
                }
                //每五分钟跑一次数据
                try {
                    Thread.sleep(10000 * 30);
                } catch (InterruptedException e) {
                    logger.info("<ol彩信方式异常>：=============ol自定义彩信发送线程冲突！");
                    continue;
                }
            }
        }
    }
    
    /**
     * 获取sql语句的html代码
     * @param request
     * @return
     */
    public String getSqlHtml(String header, String sql, String description){
        String sql_statement = sql;
        sql_statement = sql_statement.replace(";", "");
        sql_statement = sql_statement.replace("；", "");
        List list = null;
        try{
            list = db.getJdbcTemplate().queryForList(sql_statement);
        }catch(Exception a){
            list = null;
        }
        String htmlStr = "";
        if(list != null){
            for(int i = 0; i < list.size(); i++){
                htmlStr += "<tr border=\"1px\">";
                    Map map = (Map) list.get(i);
                    for(Object key : map.keySet()){
                        htmlStr += "<td style=\"text-align: center;border: 1px;\">" + map.get(key) + "</td>"; 
                    }
                htmlStr += "</tr>"; 
            }            
        }
        String html = "<?xml version=\"1.0\" encoding=\"GBK\"?> " +
                    "<!DOCTYPE html>" +
                    "<html>" +
                    " <head>" +
                    "<style type=\"text/css\">" +
                    "body.mobile { " +
                    "    leftmargin: 0px; " +
                    "    topmargin: 0px; " +
                    "    color: #000000; " +
                    "    font-size: 12px; " +
                    "    padding: 0px; " +
                    "    margin: 0px; " +
                    "    font-family: \"Tahoma\", \"Arial\", \"宋体\"; " +
                    "    text-align:center; " +  
                    "} " +
                    "     .mobile {" +
                    "                 border-left: 1px solid #96ADBB !important; " +
                    "                 border-top: 1px solid #96ADBB !important;  " +
                    "             } " +
                    "             .mobile td,.mobile th { " +
                    "                 border-left: 0px !important; " + 
                    "                 border-top: 0px !important; " +
                    "                 border-bottom:1px solid #96ADBB !important; " +
                    "                 border-right:1px solid #96ADBB !important; " +
                    "             }" +
                    "body.mobile table td, body.mobile thead td, body.mobile tfoot td { " +
                    "  font-size: 12px; " + 
                    "} " + 
                    " " + 
                    "tr.even { " + 
                    "  background-color: #EDF7FA; " + 
                    "} " + 
                    " " + 
                    "tr.odd { " + 
                    "  background-color: #FFFFFF; " + 
                    "} " + 
                    " " + 
                    ".mobile { " + 
                    "  border-left: 1px solid #96ADBB !important; " + 
                    "  border-top: 1px solid #96ADBB !important; " + 
                    "} " + 
                    ".mobile td,.mobile th { " + 
                    "  border-left: 0px !important; " + 
                    "  border-top: 0px !important; " + 
                    "  border-bottom:1px solid #96ADBB !important; " + 
                    "  border-right:1px solid #96ADBB !important; " + 
                    "}" +
                    "table.mobile th,table.mobile tr,table.mobile td {" +
                    "  padding: 0px 0px 0px 10px !important;" + 
                    "  border: 1px solid #83AADA;" + 
                    "  valign: middle;" + 
                    "  font-size: 12px;" + 
                    "  text-align: center;" + 
                    "  align: center;" + 
                    "  border-collapse:collapse;" + 
                    "}" +
                    "</style>" +
                    "</head>" +
                    " <body topmargin=\"0\" leftmargin=\"0\" class=\"mobile\">";
            html += "<table style=\"border: 1px solid;\">" + header + 
                        htmlStr + 
                    "</table><p style=\"text-align: left; !important;\">  " + description + "</p>";
            html += "</body>" +
          "</html>";
        System.out.println("html:" + html);
        return html;
    }
    
    /**
     * 存入报表自动发送数据
     * @param info_id 编号
     * @param msisdn_result 发送手机号码结果  未定阅### 失败 ### 成功
     * @param result 0 发送失败 2 含有不能解析内容 3 数据标记未完成 4 正在发送 其他：发送成功
     * @return
     */
    public void setAutoSendHisInfo(String info_id, String msisdn_result, String result){
        BatchSql batchSql = new BatchSql();
        String sql = null;
        String[] wdy_msisdn = null;//未定阅手机号码
        if(!"".equals(msisdn_result.split("###")[0])){
            wdy_msisdn = msisdn_result.split("###")[0].split(",");
        }
        List wdy_list = new ArrayList();
        for(int i = 0; i< wdy_msisdn.length; i++){
            if(!wdy_list.contains(wdy_msisdn[i])){
                wdy_list.add(wdy_msisdn[i].trim());
            }
        }
        String[] fail_msisdn = null;//失败手机号码
        if(!"".equals(msisdn_result.split("###")[1])){
            fail_msisdn = msisdn_result.split("###")[1].split(",");
        }
        String[] success_msisdn = null;//成功手机号码
        if(!"".equals(msisdn_result.split("###")[2])){
            success_msisdn = msisdn_result.split("###")[2].split("\",\"");
        }
        int success_num;
        int fail_num;
        int wdy_num;
        if(success_msisdn.length == 1 && "".equals(success_msisdn[0].trim())){
           success_num = 0;
        }else{
            success_num = success_msisdn.length;
        }
        if(wdy_msisdn.length == 1 && "".equals(wdy_msisdn[0].trim())){
            wdy_num = 0;
         }else{
             wdy_num = wdy_msisdn.length;
         }
        if(fail_msisdn.length == 1 && "".equals(fail_msisdn[0].trim())){
            fail_num = 0;
         }else{
             fail_num = fail_msisdn.length - wdy_num;
         }

        //删除当天发送失败的数据
        sql = " delete t_Ol_send_auto_result a " +
            "    where a.send_srl = ? " + 
            "      and a.day_num = to_char(sysdate, 'yyyymmdd') ";
        batchSql.addBatch(sql, new Object[]{info_id});
        if("0".equals(result)){
            sql =  " insert into t_Ol_send_auto_result " +
                    "  (send_srl, status, day_num, remark, specific_date) values " + 
                    "  (?, 2, to_char(sysdate, 'yyyymmdd'), '发送失败!', sysdate) ";
            batchSql.addBatch(sql, new Object[]{info_id});
        }else 
        if("2".equals(result)){
            sql =  " insert into t_Ol_send_auto_result " +
                    "  (send_srl, status, day_num, remark, specific_date) values " + 
                    "  (?, 2, to_char(sysdate, 'yyyymmdd'), '含有不能解析内容!', sysdate) ";
            batchSql.addBatch(sql, new Object[]{info_id});            
        }else if("3".equals(result)){
            sql =  " insert into t_Ol_send_auto_result " +
                    "  (send_srl, status, day_num, remark, specific_date) values " + 
                    "  (?, 3, to_char(sysdate, 'yyyymmdd'), '数据标记未完成!', sysdate) ";
            batchSql.addBatch(sql, new Object[]{info_id});            
        }else if("4".equals(result)){
            sql =  " insert into t_Ol_send_auto_result " +
                    "  (send_srl, status, day_num, remark, specific_date) values " + 
                    "  (?, 4, to_char(sysdate, 'yyyymmdd'), '正在发送!', sysdate) ";
            batchSql.addBatch(sql, new Object[]{info_id});            
        }
        else{
            sql =  " insert into t_Ol_send_auto_result " +
                    "  (send_srl, status, day_num, remark, specific_date) values " + 
                    "  (?, 1, to_char(sysdate, 'yyyymmdd'), " +
                    " '发送成功 成功：" 
                    + success_num + ", 未定阅：" 
                    + wdy_num + ", 失败：" 
                    + fail_num + "', " +
                    " sysdate) ";
            batchSql.addBatch(sql, new Object[]{info_id});  
            //插入发送人员结果
            //删除当天发送失败的数据
            sql = " delete t_ol_send_auto_user_result a " +
                "    where a.send_srl = ? " + 
                "      and a.day_num = to_char(sysdate, 'yyyymmdd') "; 
            
            //插入未订阅的数据
            for(int i = 0; i < wdy_msisdn.length; i++){
                if(!"".equals(wdy_msisdn[i].trim())){
                    sql =  " insert into t_ol_send_auto_user_result " +
                            "  (send_srl, user_name, user_msisdn, result_flag, day_num) " + 
                            "  select ?, " + 
                            "         ifnull((select b.user_name " + 
                            "               from t_mms_rpt_send_target_user b " + 
                            "              where b.msisdn = ?), ?)," +
                            "         ?, " + 
                            "         3, " +
                            "         to_char(sysdate, 'yyyymmdd') " + 
                            "    from dual ";
                    batchSql.addBatch(sql, new Object[]{info_id, wdy_msisdn[i], wdy_msisdn[i], wdy_msisdn[i]});                
                }
            }
            //插入发送失败的数据
            for(int i = 0; i < fail_msisdn.length; i++){
                //剔除未定义的数据
                if(!wdy_list.contains(fail_msisdn[i].trim())){
                    if(!"".equals(fail_msisdn[i].trim())){
                        sql =  " insert into t_ol_send_auto_user_result " +
                                "  (send_srl, user_name, user_msisdn, result_flag, day_num) " + 
                                "  select ?, " + 
                                "         ifnull((select b.user_name " + 
                                "               from t_mms_rpt_send_target_user b " + 
                                "              where b.msisdn = ?), ?)," +
                                "         ?, " + 
                                "         2, " +
                                "         to_char(sysdate, 'yyyymmdd') " + 
                                "    from dual ";
                        batchSql.addBatch(sql, new Object[]{info_id, fail_msisdn[i], fail_msisdn[i], fail_msisdn[i]});                    
                    }
                }
            }
            //插入发送成功的数据
            for(int i = 0; i < success_msisdn.length; i++){
                if(!"".equals(success_msisdn[i].trim())){
                    sql =  " insert into t_ol_send_auto_user_result " +
                            "  (send_srl, user_name, user_msisdn, result_flag, day_num) " + 
                            "  select ?, " + 
                            "         ifnull((select b.user_name " + 
                            "               from t_mms_rpt_send_target_user b " + 
                            "              where b.msisdn = ?), ?)," +
                            "         ?, " + 
                            "         1, " +
                            "         to_char(sysdate, 'yyyymmdd') " + 
                            "    from dual ";
                    batchSql.addBatch(sql, new Object[]{info_id, success_msisdn[i], success_msisdn[i], success_msisdn[i]});
                }
            }
        } 
        db.doInTransaction(batchSql);
    }
    
    /**
     * 验证数据完成标识
     * @param sql sql语句
     * @return
     */
    public String checkFinishFlag(String sql){
        sql = sql.replace(";", "");
        sql = sql.replace("；", "");
        List list = null;
        try{
            list = db.getJdbcTemplate().queryForList(sql);   //判断是否有数据
        }
        catch(Exception e){
            logger.debug("验证数据完成标识:异常false");
            return "false";
        }
        if(list == null){ //没有返回false
            logger.debug("验证数据完成标识:false");
            return "false";
        }
        try{
            if(list.size() == 0){
                return "false";
            }
            Map map = (Map) list.get(0);
            for(Object key : map.keySet()){
                String key_str = (String) key;  //判断数据是否为空
                if(key_str.length() == 0){
                    return "false";
                }
                if(key_str.matches("-?[0-9]+")){//判断数据是否为数字
                   int key_int = Integer.parseInt(key_str);
                   if(key_int >= 1){       //数字大于等于1返回true    
                       return "true";
                   }else{
                       return "false";    //数字小于1返回false
                   }
                }else{ 
                    if("".equals(key_str.trim())){ //空值返回false
                        return "false";
                    }else{
                        return "true";
                    }          
                }   
            }
        }
        catch(Exception e){
            logger.debug("验证数据完成标识:判断数据是否为空异常");
            return "false";
        }
        return "true";
    }
    
    /** 
     * 根据群组信息，用户信息，电话号码，生成发送用户
     * @param groups 群组id 逗号分隔
     * @param users 用户id 逗号分隔
     * @return 返回需要发送的手机号码，逗号分隔
     */ 
     public String getGroupUserMsisdn(String groups, String users) {
        logger.debug("groups:" + groups + ";users:" + users);
        //获取用户群组里面的用户
        String sql = " select listagg(a.user_ids, ',') within " +
                     "   group( " + 
                     "   order by id) user_ids " + 
                     "    from t_mms_send_target_group a " + 
                     "   where a.id in (" + groups + ") ";
        String user_ids = "";
        if(!"".equals(groups)){
            user_ids = db.queryForString(sql);
        }
        if(!"".equals(users)){
            user_ids += "," + users;
        }
        if(user_ids.startsWith(",")){//没有群组的时候，去除第一个','
            user_ids = user_ids.substring(1);
        }
        //获取用户的手机号码
        sql = " select LISTAGG(a.msisdn, ',') within " +
                " group( " + 
                " order by id) user_ids from t_mms_rpt_send_target_user a " + 
                " where a.id in(" + user_ids + ") ";
        String msisdns = "";
        if(!"".equals(user_ids)){
            msisdns = db.queryForString(sql);
        }
        //去除重复的手机号码
        String []msisdn = msisdns.split(",");
        String msisdn_str = "";
        ArrayList list = new ArrayList();
        for(int i = 0; i< msisdn.length; i++){
            if(!list.contains(msisdn[i])){
                list.add(msisdn[i]);
            }
        }
        for(int i = 0; i < list.size(); i++){
            if(!"".equals(list.get(i))){
                msisdn_str += "," + list.get(i);                
            }
        }
        String ret_msisdn = msisdn_str.substring(1);
        logger.debug("ret_msisdn:" + ret_msisdn);
        return ret_msisdn;
    }
    /**
     * 获取要发送的数据报表
     * @return
     */
    public List getSendList(){
        String sql =  " select a.id, a.target_group_id, a.target_user, a.record_date, a.record_code " +
                    "     from t_mms_send_srl a " + 
                    "    where a.auto_send_flag = 1 " + 
                    "      and not exists " + 
                    "    (select 1 " + 
                    "             from t_ol_send_auto_result b " + 
                    "            where a.id = b.send_srl " + 
                    "              and b.status = 1 " + 
                    "              and b.day_num = to_char(sysdate, 'yyyymmdd')) ";
        logger.debug("获取要发送的数据报表sql:" + sql);
        return db.queryForList(sql);
    }

    /**
     * 获取要发送的数据报表内容
     * @return
     */
    public List getSendInfoList(String info_id){
        String sql = " select a.send_srl, " +
                     "        a.title, " + 
                     "        a.html, " + 
                     "        finish_flag, " + 
                     "        header, " + 
                     "        description, " + 
                     "        sql_statement " + 
                     "   from t_mms_send_detail_info a " + 
                     "  where a.send_srl = ? ";
            
        logger.debug("获取要发送的数据报表内容sql:" + str.getSql(sql, new Object[]{info_id}));
        return db.queryForList(sql, new Object[]{info_id});
    }
//    
//    public static void main(String[] args) {
//        //String res = ol.sendOlInfo("18795555039", "连云港系统测试", "连云港系统测试、连云港系统测试", "1");
//        String token = "";
//        String res = "2";
//        ServletCode sCode = new ServletCode();
//        //重新获取token
//        String successToken = sCode.getServiceNumberToken("lygzcpt", "lygzcptlygzcptlygzcphj");
//        System.out.println("successToken：" + successToken); 
//        if(successToken == null || successToken.equals("null") || successToken.equals("")){
//            token = "";
//            System.out.println("res：获取token失败"); //获取token失败
//        } else {
//            JSONObject json = JSONObject.parseObject(successToken);
//            if(json.containsKey("token")) { //将最新token放入变量中
//                token = json.getString("token");
//            } else {
//                token = "";
//                System.out.println("res：获取token失败"); 
//            }
//        }
//
//        String content =
//            "<table style='border: 1px solid #83AADA;'>\n" +
//            "  <tr style='border: 1px solid #83AADA;'>\n" + 
//            "    <td style='text-align: center;border: 1px solid #83AADA;' rowspan=2>日期</td>\n" + 
//            "    <td style='text-align: center;border: 1px solid #83AADA;' rowspan=2>集团用户归属</td>\n" + 
//            "    <td style='text-align: center;border: 1px solid #83AADA;' colspan=4 >实名认证类型</td>\n" + 
//            "    <td style='text-align: center;border: 1px solid #83AADA;' colspan=4 >证件类型</td>\n" + 
//            "    <td style='text-align: center;border: 1px solid #83AADA;' colspan=3 >办理情况</td>\n" + 
//            "  </tr>\n" + 
//            "  <tr border='1'>\n" + 
//            "    <td style='text-align: center;border: 1px solid #83AADA;'>用户数</td>\n" + 
//            "    <td style='text-align: center;border: 1px solid #83AADA;'>已审核</td>\n" + 
//            "    <td style='text-align: center;border: 1px solid #83AADA;'>已登记</td>\n" + 
//            "    <td style='text-align: center;border: 1px solid #83AADA;'>未登记</td>\n" + 
//            "    <td style='text-align: center;border: 1px solid #83AADA;'>集团证件</td>\n" + 
//            "    <td style='text-align: center;border: 1px solid #83AADA;'>个人证件</td>\n" + 
//            "    <td style='text-align: center;border: 1px solid #83AADA;'>身份证</td>\n" + 
//            "    <td style='text-align: center;border: 1px solid #83AADA;'>其他</td>\n" + 
//            "    <td style='text-align: center;border: 1px solid #83AADA;'>当日审核数</td>\n" + 
//            "    <td style='text-align: center;border: 1px solid #83AADA;'>当周审核数</td>\n" + 
//            "    <td style='text-align: center;border: 1px solid #83AADA;'>当月审核数</td>\n" + 
//            "  </tr>\n" + 
//            "</table>";
//        String title = "连云港系统测试";
//        String type = "1";
//        
//        //发送O了消息
//        /*String sendResult = sCode.sendMuServiceMsg("lygzcpt", "lygzcptlygzcptlygzcphj", token, "18795555039", 
//                new SimpleDateFormat("yyyy-mm-dd hh:MM:ss").format(new Date()), type, "连云港账务", 
//                content, title+"1", "http://ww4.sinaimg.cn/mw690/519d036dgw1exze65aphrj20ik0c30ux.jpg", 
//                content, title+"2", "http://img.taopic.com/uploads/allimg/131110/234654-1311100H35899.jpg", 
//                content, title+"3", "http://img02.tooopen.com/images/20140701/sy_64171725437.jpg", 
//                content, title+"4", "http://img02.tooopen.com/images/20140701/sy_64171945833.jpg");*/
//        String sendResult = sCode.sendMuServiceMsg("lygzcpt", "lygzcptlygzcptlygzcphj", token, "18795555039", 
//                new SimpleDateFormat("yyyy-mm-dd hh:MM:ss").format(new Date()), type, "连云港账务", 
//                content, title+"1", "http://ww41.sinaimg.cn/mw690/519d036dgw1exze65aphrj20ik0c30ux.jpg", 
//                content, title+"2", "http://ww41.sinaimg.cn/mw690/519d036dgw1exze65aphrj20ik0c30ux.jpg", 
//                content, title+"3", "", 
//                content, title+"4", "");   
//
//        System.out.println("OL发送结果：" + sendResult);
//        JSONObject sendResJson = null;
//        try {
//            sendResJson = JSONObject.parseObject(sendResult);
//            if(sendResJson != null && sendResJson.containsKey("result") && sendResJson.getString("result").equals("200")) {
//                res = "1";
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }  
//        System.out.println("res:"+res);
//        
//    }
    /**
     * 发送O了信息
     * @param msisdn 手机号码，逗号分隔
     * @param html 发送的文本信息
     * @param title 发送的标题
     * @param type_flag 报表 2；文本 3；
     * @return 0 发送失败 2 含有不能解析内容 未定阅号码 ### 发送失败号码 ### 发送成功号码 发送成功
     */
    public String setOlInfo(String msisdn, String []html, String []title, int type_flag) {
        //String res = ol.sendOlInfo("18795555039", "连云港系统测试", "连云港系统测试、连云港系统测试", "1");
        String token = "";
        String res = "2";
        ServletCode sCode = new ServletCode();
        PropertiesHelper proHelper = new PropertiesHelper();
        olServerId = proHelper.getPropertiesValue("OL_SERVER_ID");
        olServerSecret = proHelper.getPropertiesValue("OL_SERVER_SECRET_ID");
        //重新获取token
        String successToken = sCode.getServiceNumberToken(olServerId, olServerSecret);
        System.out.println("successToken：" + successToken); 
        if(successToken == null || successToken.equals("null") || successToken.equals("")){
            token = "";
            System.out.println("res：获取token失败"); //获取token失败
            return "0";
        } else {
            JSONObject json = null;
            try{
                json = JSONObject.parseObject(successToken);
            }
            catch(Exception e){
                return "0";
            }
            
            if(json.containsKey("token")) { //将最新token放入变量中
                token = json.getString("token");
            } else {
                token = "";
                System.out.println("res：获取token失败"); 
                return "0";
            }
        }
        String sql = "select a.url from t_ol_picture a where a.type = 1"; //获取主页图片路径
        String main_picture = db.queryForString(sql);
        sql = "select a.url from t_ol_picture a where a.type = " + type_flag;//获取下面三个小图片（文本和表格是不同的）
        List list = db.queryForList(sql);

        String picture_url1 = (String) ((Map) list.get(0)).get("url");
        String picture_url2 = (String) ((Map) list.get(1)).get("url");
        String picture_url3 = (String) ((Map) list.get(2)).get("url");
        
        String type = "1";
        String sendResult = sCode.sendMuServiceMsg(olServerId, olServerSecret, token, msisdn, 
                new SimpleDateFormat("yyyy-mm-dd hh:MM:ss").format(new Date()), type, "连云港账务", 
                html.length > 0 ? html[0].trim() : "", 
                title.length > 0 ? title[0].trim() : "", 
                title.length > 0 ? main_picture : "", 
                title.length > 1 ? html[1].trim() : "", 
                title.length > 1 ? title[1].trim() : "", 
                title.length > 1 ? picture_url1 : "", 
                title.length > 2 ? html[2].trim() : "", 
                title.length > 2 ? title[2].trim() : "", 
                title.length > 2 ? picture_url2 : "", 
                title.length > 3 ? html[3].trim() : "", 
                title.length > 3 ? title[3].trim() : "", 
                title.length > 3 ? picture_url3 : "");  
            logger.debug("OL发送结果：" + sendResult);
            JSONObject sendResJson = null;
            try {
                sendResJson = JSONObject.parseObject(sendResult);
                if(sendResJson != null && sendResJson.containsKey("result") && sendResJson.getString("result").equals("200")) {
                    res = "1";
                    if(msisdn.contains(",")){
                        //获取成功和失败的用户,用###作为分隔符
                        String wdy_user = sendResJson.getString("resultNotSubscribeMsg");
                        String sb_user = sendResJson.getString("resultFailMsg");
                        String cg_user = sendResJson.getString("resultSuccess");
                        if(wdy_user.length() > 15){
                            res = wdy_user.substring(10).substring(0, wdy_user.substring(10).length() - 1) + "###";
                        }else{
                            res = " ###";
                        }
                        if(sb_user.length() > 15){
                            res += sb_user.substring(8).substring(0, sb_user.substring(8).length() - 1) + "###" ;
                        }else{
                            res += " ###";
                        }
                        if(cg_user.length() > 10){
                            res += cg_user.substring(2).substring(0, cg_user.substring(2).length() - 2);
                        }else{
                            res += " ";
                        }                        
                    }else{
                        res = " ### ### " + msisdn;
                    }
                }
                //没有人订阅的情况
                if(sendResJson != null && sendResJson.containsKey("result") && sendResJson.getString("result").equals("300")) {
                    String sb_user = sendResJson.getString("resultFailMsg");
                    if(sb_user.contains("含有不能解析的图片")){
                        res = "2";
                    }else{
                        res = msisdn + " ### " + msisdn + " ### ";
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                return "0";
            } 
            logger.debug("res:" + res);
        return res;
    }
}