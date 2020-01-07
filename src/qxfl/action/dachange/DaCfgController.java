package qxfl.action.dachange;


import qxfl.service.dachange.DaCfgService;
import qxfl.service.sys.UserCfgService;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import web.action.BaseController;

import com.zcc.util.common.StringHelper;

/**
 * 档案编号管理
 * @date 2019-04-01
 */
@Controller
@RequestMapping(value = "/daCfg/")
public class DaCfgController extends BaseController {
    /**
     * spring 类型注入
     */
    @Autowired
    public DaCfgService daCfgService;
    private String file;

    /**
     * frame
     * @return
     */
    @RequestMapping(value = "frame.do")
    public String frame() {
    	 request.setAttribute("yearsList", daCfgService.getNdList(request));
        return COM_PATH +"qxfl/dachange/frame";
    }

    /**
     * 查询列表
     * @return
     */
    @RequestMapping(value = "list.do")
    public String list() {
        request.setAttribute("jcInfoList", daCfgService.getJcdwList(request));
        
        return COM_PATH +"qxfl/dachange/list";
    }
    

    /**
     * 修改档案编码
     * @return
     */
    @RequestMapping(value = "changeDaId.do")
    public String changeDaId() {
        String id = req.getValue(request, "id");
        request.setAttribute("daInfo", daCfgService.getJcdwInfo(request));
        return COM_PATH +"qxfl/dachange/edit";
    }

    
    /**
     * 插入或新增一个用户
     * @return
     */
    @RequestMapping(value = "saveOrUpdateDaId.do")
    public String saveOrUpdateDaId() {
        request.setAttribute("result", daCfgService.saveOrUpdateDaId(request));
        return COM_PATH +"qxfl/global/saveResult";
    }

    /**
     * 验证档案编号唯一
     * @param response
     */
    @RequestMapping(value = "checkDaIdOnly.do")
    public void checkDaIdOnly(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        this.writeText(daCfgService.checkDaId(request), response);
    }
}
