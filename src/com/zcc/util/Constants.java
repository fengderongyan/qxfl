package com.zcc.util;

import java.util.HashMap;
 
public class Constants {
    public static final String SYSTEMNAME = "QXFL";
    public static String APP_HTTP_KEY = "QXFL";
    public static String COOKIE_SESSION_ID = "JSESSIONID_QXFL";
    public static String WEBROOT = "/";
    public static final String ATTACHMENT_ROOT = "/data02/filedata01/";
    public static final int ATTACHMENT_SIZE_LIMIT = 50; // 上传附件大小限制,单位M
    public static String SYSTEM_ATTACHMENT_PATH = ATTACHMENT_ROOT + "qxfl/";
    public static HashMap<String, String> MODULEPREFIX = new HashMap<String, String>();
    public static final String AMAP_KEY_JAVASCRIPT = "863d0482306f75a5ff7030705b1d6590";//AMAP_KEY_JAVASCRIPT
    public static String PUSH_ANDROID_API_KEY = "m7YOwMrlB3rlG7TvhlVNxeg2";//百度推送android-key
    public static String PUSH_ANDROID_SECRET_KEY = "zlLqhx9k0YYjNjUT2OqxAPGocBRb1Z7N";//百度推送 android-key
    public static final String DOWNLOAD = "/qxfl/servlet/download"; //下载附件
    
    /*******************   权限角色  **********************/
    public static String GLOBAL_ROLES = "1,2";       // 全视野 系统管理员、市公司
    
    /**
     * display:table 用到的图片
     */
    public static String DELETE_PNG = WEBROOT + "/images/delete.png";
    public static String ADD_PNG = WEBROOT + "/images/add.png";

    public static void init(String app) {
        MODULEPREFIX.put("PRODUCTION_MODE", "false");//生产模式标识：true, 开发模式标识false
        MODULEPREFIX.put("APP", MODULEPREFIX.get(SYSTEMNAME));
    }
}
