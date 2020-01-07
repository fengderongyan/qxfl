package qxfl.application;


import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.zcc.util.spring.SpringHelper;


public class BackgroundApplication implements ServletContextListener {
    
    public void contextDestroyed(ServletContextEvent arg0) {

    }
    public void contextInitialized(ServletContextEvent arg0) {
        System.setProperty("dir_path", arg0.getServletContext().getRealPath("/"));  
        //本地上线需开启（通过O了平台向人员发送图文信息）
        //OlMmsImgTxtSend olMmsImgTxtSend = (OlMmsImgTxtSend)SpringHelper.getBean("olMmsImgTxtSend");
        //olMmsImgTxtSend.start();
    }
}
