package qxfl.action.sys;


import qxfl.service.sys.RoleCfgService;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import web.action.BaseController;

import com.zcc.util.common.StringHelper;

/**
 * 角色管理
 * @date 2018-12-12
 */
@Controller
@RequestMapping(value = "/sys/rolecfg/")
public class RoleCfgController extends BaseController {
    /**
     * spring 类型注入
     */
    @Autowired
    public RoleCfgService roleCfgService;

    /**
     * 角色查询主界面
     * @return
     */
    @RequestMapping(value = "roleFrame.do")
    public String roleFrame() {
        //request.setAttribute("rolesList", roleCfgService.getRoleList(request));
        return COM_PATH +"qxfl/sys/rolecfg/frame";
    }

    /**
     * 角色列表
     * @return
     */
    @RequestMapping(value = "roleList.do")
    public String roleList() {
        request.setAttribute("roleList", roleCfgService.getRolesList(request));
        
        return COM_PATH +"qxfl/sys/rolecfg/list";
    }
    
    /**
     * 角色列表main
     * @return
     */
    @RequestMapping(value = "roleEdit.do")
    public String roleEdit() {
    	request.setAttribute("method", req.getValue(request, "method"));
    	request.setAttribute("role_id", req.getValue(request, "role_id"));
        
        return COM_PATH +"qxfl/sys/rolecfg/editqx";
    }
    
    
    /**
     * 修改角色的信息
     * @return
     */
    @RequestMapping(value = "edit.do")
    public String edit() {
        //request.setAttribute("userInfo", roleCfgService.getUserInfo(request));
        String roleId = req.getValue(request, "role_id");
        logger.debug("roleId : " + roleId);
        request.setAttribute("roleId", roleId);
        request.setAttribute("roles", roleCfgService.getRoleList());
        
        request.setAttribute("roleInfo", roleCfgService.getRoleInfo(request));
        
        return COM_PATH +"qxfl/sys/rolecfg/edit";
    }

    /**
     * 加载组织树
     * @param response
     */
    @SuppressWarnings( {"static-access", "unchecked"})
    @RequestMapping(value = "loadOrgListTree.do")
    public void loadOrgListTree(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        StringBuffer sb = new StringBuffer();
        List<?> list = roleCfgService.getOrgList(request);
        sb.append("[");
        Map map = null;
        for(int i = 0; i < list.size(); i++) {
            map = (Map) list.get(i);

            sb.append("{name:\"" + StringHelper.get(map, "ORG_NAME") 
                    + "\",id:\"" + StringHelper.get(map, "ORG_ID") 
                    + "\",pId:\"" + StringHelper.get(map, "SUPERIOR_ID") 
                    + "\",org_level:\"" + StringHelper.get(map, "ORG_LEVEL") 
                    + "\",checked:" + StringHelper.get(map, "CHECKED"));
            sb.append("}");
            if(i < list.size() - 1) {
                sb.append(",");
            }
        }
        sb.append("]");
        this.writeText(sb, response);
    }
    
    /**
     * 新增或修改角色信息
     * @param response
     * @return
     */
    @RequestMapping(value="roleSave.do")
    public void roleSave(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        logger.debug("roleSave.do");
        this.writeText(roleCfgService.saveOrUpdateRole(request), response);
    }

    /**
     * 删除用户
     * @return
     */
    @RequestMapping(value = "deleteRole.do")
    public void deleteUser(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        this.writeText(roleCfgService.delRole(request), response);
    }
    
}
