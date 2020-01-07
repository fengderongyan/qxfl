package qxfl.action.sys;

import qxfl.service.sys.LogService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import web.action.BaseController;

import com.zcc.util.common.DateHelper;

/**
 * 日志查询功能
 * @date 2018-12-25
 */
@Controller
@RequestMapping(value = "/sys/log/")
public class LogController extends BaseController {
    /**
     * spring 类型注入
     */
    @Autowired
    public LogService logService;
    
    /**
     * 系统日志主页面
     * @return
     */
    @RequestMapping(value="sysLogMain.do")
    public String sysLogMain(){
        return COM_PATH +"qxfl/sys/log/frame";
    }

    /*****************************后台菜单访问流水************************************/
    /**
     * 菜单访问流水主页面
     * @return
     */
    @RequestMapping(value="nodeHisFrame.do")
    public String nodeHisFrame(){
        request.setAttribute("begin_date", DateHelper.getToday("yyyy-MM-dd"));
        request.setAttribute("end_date", DateHelper.getToday("yyyy-MM-dd"));
        return COM_PATH +"qxfl/sys/log/nodelog/nodeHisFrame";
    }
    
    /**
     * 菜单访问流水主列表
     * @return
     */
    @RequestMapping(value="nodeHisList.do")
    public String nodeHisList(){
        request.setAttribute("list", logService.getNodeHisList(request));
        return COM_PATH +"qxfl/sys/log/nodelog/nodeHisList";
    }
    
    /*****************************后台系统登录流水************************************/
    /**
     * 系统登录流水主页面
     * @return
     */
    @RequestMapping(value="loginHisFrame.do")
    public String loginHisFrame(){
        request.setAttribute("begin_date", DateHelper.getToday("yyyy-MM-dd"));
        request.setAttribute("end_date", DateHelper.getToday("yyyy-MM-dd"));
        return COM_PATH +"qxfl/sys/log/loginlog/loginHisFrame";
    }
    
    /**
     * 系统登录流水列表
     * @return
     */
    @RequestMapping(value="loginHisList.do")
    public String loginHisList(){
        request.setAttribute("list", logService.getLoginHisList(request));
        return COM_PATH +"qxfl/sys/log/loginlog/loginHisList";
    }
    
    /**
     * 导出登录流水
     */
    @RequestMapping(value = "exportLoginHis.do")
    public void exportLoginHis(HttpServletRequest request, HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        logService.exportLoginHis(request, response);
    }
    
    /**
     * 信息下载流水主页面
     * @return
     */
    @RequestMapping(value="infoDownloadHisFrame.do")
    public String infoDownloadHisFrame(){
        request.setAttribute("begin_date", DateHelper.getToday("yyyy-MM-dd"));
        request.setAttribute("end_date", DateHelper.getToday("yyyy-MM-dd"));
        return COM_PATH +"qxfl/sys/log/infodownloadlog/infoDownloadHisFrame";
    }
    
    /**
     * 信息下载流水列表
     * @return
     */
    @RequestMapping(value="infoDownloadHisList.do")
    public String infoDownloadHisList(){
        request.setAttribute("list", logService.getDownloadHisList(request));
        return COM_PATH +"qxfl/sys/log/infodownloadlog/infoDownloadHisList";
    }
}
