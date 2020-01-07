package qxfl.action.yqsb;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import qxfl.service.yqsb.YqsbService;
import web.action.BaseController;

/**
 * 仪器设备管理
 * @date 2018-12-10
 */
@Controller
@RequestMapping(value = "/yqsb")
public class YqsbController extends BaseController {
   
    @Autowired
    private YqsbService yqsbService;
    
    /**
     * 描述：仪器设备管理首页
     * @return
     * @author yanbs
     * @Date : 2019-07-10
     */
    @RequestMapping(value = "/yqsbFrame")
    public String yqsbFrame(){
    	return  COM_PATH + "qxfl/yqsb/yqsbFrame";
    }
    
    /**
     * 描述：仪器设备管理列表
     * @return
     * @author yanbs
     * @Date : 2019-07-10
     */
    @RequestMapping(value = "/yqsbList")
    public String yqsbList(){
    	request.setAttribute("list", yqsbService.getYqsbList(request));
    	return  COM_PATH + "qxfl/yqsb/yqsbList";
    }
    
    /**
     * 描述：新增、编辑仪器设备
     * @return
     * @author yanbs
     * @Date : 2019-07-10
     */
    @RequestMapping(value = "/yqsbEdit")
    public String yqsbEdit(){
    	String method = req.getValue(request, "method");
    	if(!"add".equals(method)){
    		request.setAttribute("map", yqsbService.getYqsbMap(request));
    	}
    	return  COM_PATH + "qxfl/yqsb/yqsbEdit";
    }
    
    /**
     * 描述：保存信息
     * @return
     * @author yanbs
     * @Date : 2019-07-10
     */
    @RequestMapping(value = "/saveOrUpdate")
    public String saveOrUpdate(){
    	request.setAttribute("result", yqsbService.saveOrUpdate(request));
    	return COM_PATH +"qxfl/global/saveResult";
    }
    
    /**
     * 描述：删除信息
     * @param response
     * @author yanbs
     * @Date : 2019-07-10
     */
    @RequestMapping(value = "/deleteYqsb")
    public void deleteYqsb(HttpServletResponse response){
    	int result = yqsbService.deleteYqsb(request);
    	this.writeText(result, response);
    }
}
