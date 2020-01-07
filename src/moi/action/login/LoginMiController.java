package moi.action.login;

import qxfl.service.login.LoginService;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import moi.service.login.LoginMiSevice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import web.action.BaseController;
import web.model.User;

/** 
 * 手机端登录
 * @date 2016-2-26
 */
@Controller
@RequestMapping(value = "/mobile/loginmi/")
public class LoginMiController extends BaseController{

    @Autowired
    LoginMiSevice loginMiSevice;
    
    @Autowired
    LoginService loginService;
    
    /**
     * 登录验证
     * @param response
     */
    @RequestMapping(value="checkLogin.do")
    public void checkLogin(HttpServletResponse response) {
    	String imsi = req.getValue(request, "imsi");
		String operator_id = req.getValue(request, "userName");
		String password = req.getValue(request, "userPwd");
		String adimin_flag = "";
		int result = loginMiSevice.checkUserLogin(operator_id, password);
		User user = new User();
		// System.out.println("operator_id:"+operator_id);


		// 如果工号不存在
		if (result == 1)
		{
			response.addCookie(new Cookie("username", operator_id));
			user.setOperatorId(operator_id);
			// 设置用户信息 user
			System.out.println("成功登录.");
			loginService.setUserInfo(user,operator_id);
			
			// 记录登陆日志
            loginService.recordLoginLog(request, user.getOperatorId(), "clientLogin", "客户端登录", "2", "", user.getOrgId(),
                    user.getCountyId());
			request.getSession().setAttribute("FCK.userDir", "/upload/userfiles/" + user.getOperatorId() + "/");
			request.getSession().setAttribute("user", user);
		}
		logger.debug("客户端登录！");
		Map map = new HashMap();
		map.put("operator_id", operator_id);
		map.put("name", user.getName());
		map.put("loginRes", String.valueOf(result));
		map.put("adimin_flag", adimin_flag);
		map.put("orgName", user.getOrgName());
		map.put("roleNames", user.getRoleNames());
		map.put("orgId", user.getOrgId());
		this.writeJsonData(map, response);
    }
    
    /**
     * 退出登录
     * @param response
     */
    @RequestMapping(value="/loginOut.do")
    public void loginOut(HttpServletResponse response) {
    	request.getSession().setMaxInactiveInterval(0);
    	this.writeJsonData(1, response);
    }
}
