package qxfl.action.sys;


import qxfl.service.sys.ModuleTreeService;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import web.action.BaseController;

import com.zcc.util.common.StringHelper;

/**
 * 加载菜单树
 * @date 2016-2-22
 */
@Controller
@RequestMapping(value = "/sys/moduletree/")
public class ModuleTreeController extends BaseController {
    @Autowired
    private ModuleTreeService moduleTreeService;

    /**
     * 加载菜单树列表
     * @param response
     */
    @ResponseBody
    @SuppressWarnings({ "static-access", "unchecked" })
    @RequestMapping(value="loadModuleList.do")
    public void loadModuleList(HttpServletResponse response){
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        StringBuffer sb = new StringBuffer();
        List<?> list  = moduleTreeService.getModuleList(request);
        sb.append("[");
        Map map = null;
        for (int i = 0; i < list.size(); i++) {
            map = (Map)list.get(i);
            if(!"".equals(StringHelper.get(map, "MODULE_ICON"))){
                sb.append("{name:\"" + StringHelper.get(map, "MODULE_NAME")
                        + "\",id:\"" + StringHelper.get(map, "MODULE_ID")
                        + "\",pId:\"" + StringHelper.get(map, "SUPERIOR_ID")
                        + "\",moduleUrl:\""+ StringHelper.get(map, "MODULE_URL")
                        + "\",openFlag:\""+ StringHelper.get(map, "OPEN_FLAG")
                        + "\",icon:\"../images/menu_img/"+ StringHelper.get(map, "MODULE_ICON")
                        + "\",moduleFlag:" + StringHelper.get(map, "MODULE_FLAG")
                        );
            }else{
                sb.append("{name:\"" + StringHelper.get(map, "MODULE_NAME")
                        + "\",id:\"" + StringHelper.get(map, "MODULE_ID")
                        + "\",pId:\"" + StringHelper.get(map, "SUPERIOR_ID")
                        + "\",moduleUrl:\""+ StringHelper.get(map, "MODULE_URL")
                        + "\",openFlag:\""+ StringHelper.get(map, "OPEN_FLAG")
                        + "\",moduleFlag:" + StringHelper.get(map, "MODULE_FLAG")
                        );
            }
            sb.append("}");
            if (i < list.size() - 1) {
                sb.append(",");
            }
        }
        sb.append("]");
        //System.out.print(sb);
        this.writeText(sb, response);
    }
}
