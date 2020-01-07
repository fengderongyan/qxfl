package qxfl.application;

import org.apache.log4j.Logger;

import com.zcc.util.common.StringHelper;
import com.zcc.util.db.DBHelperSpring;



public class BaseBackgroundApplication extends Thread {
    protected static Logger logger = Logger.getLogger(BaseBackgroundApplication.class
            .getName());
    protected DBHelperSpring db;
    
    public StringHelper str = new StringHelper();
    
    public void sendSms(String msisdn, String content) {
        if(!msisdn.trim().equals("")) {
            String sql = "INSERT INTO lygweb.cdz_kfjk_to_send_sms" +
                        "  (serial_no, orgaddr, destaddr, to_send_time, flag, sms_detail)" + 
                        "VALUES" + 
                        "  (lygweb.my_sn.nextval , '防雷系统' , '" + msisdn + "', sysdate , 0 , '" + content + "')";
            logger.debug(sql);
            db.update(sql);
        }
    }
    
    public DBHelperSpring getDb() {
        return db;
    }

    public void setDb(DBHelperSpring db) {
        this.db = db;
    }
}
