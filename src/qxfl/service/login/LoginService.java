package qxfl.service.login;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import web.model.User;
import web.service.BaseService;

import com.zcc.util.common.StringHelper;
import com.zcc.util.db.BatchSql;

/**
 * 人员登录
 * @date 2016-2-22
 */
@Service("loginService")
public class LoginService extends BaseService {
	
	/**
	 * 设置用户相关信息
	 * @param user
	 * @param operator_id 工号
	 * @return
	 */
	public void setUserInfo(User user, String operator_id) {
		String sql = " select a.operator_id, " +
                     "        a.name, " + 
                     "        a.mobile, " + 
                     "        a.org_id, " +
                     "        a.email, " + 
                     "        a.password, " + 
                     "        b.org_name, " + 
                     "        b.org_lev, " + 
                     "        b.county_id, " +
                     "        b.area_id, " + 
                     "        b.town_id, " + 
                     "        b.tiny_id " + 
                     "   from t_user a, t_organization b " + 
                     "  where a.org_id = b.org_id " + 
                     "    and a.operator_id = ? ";
		Map<String, Object> userMap = db.queryForMap(sql, new Object[]{operator_id});
		
		user.setOperatorId(StringHelper.get(userMap, "operator_id"));
		user.setName(StringHelper.get(userMap, "name"));
		user.setMobile(StringHelper.get(userMap, "mobile"));
		user.setOrgId(StringHelper.get(userMap, "org_id"));
		user.setOrgName(StringHelper.get(userMap, "org_name"));
		user.setPassword(StringHelper.get(userMap, "password"));
		user.setOrgLevel(StringHelper.get(userMap, "org_lev"));
		user.setCountyId(StringHelper.get(userMap, "county_id"));
		user.setAreaId(StringHelper.get(userMap, "area_id"));
		user.setGridId(StringHelper.get(userMap, "town_id"));
		user.setTinyId(StringHelper.get(userMap, "tiny_id"));
		
		
		 //集团
        if(str.notEmpty(userMap.get("county_id")).equals("1535")){
               //user_type
            user.setUser_type("2"); 
        }else{
            user.setUser_type("1"); 
        }
		
		sql = "select a.operator_id, b.role_id, b.role_name,b.role_level " +
				" from t_user_role a, t_role b" +
				" where a.role_id=b.role_id" +
				" and a.operator_id=?";
		List<Map<String, Object>> userRoleList = db.queryForList(sql, new Object[]{operator_id});
		user.setUserRoleList(userRoleList);
		
		String role_names = "";
	    String role_ids = "";
        int roleLevel = 999999;
        int role_level;
	    Map map = null;
	    if (userRoleList.size() > 0) {
	        for (int i = 0; i < userRoleList.size() - 1; i++) {
	            map = (Map) userRoleList.get(i);
	            role_names += str.notEmpty(map.get("role_name")) + ",";
	            role_ids += str.notEmpty(map.get("role_id")) + ",";
	            role_level = Integer.parseInt(str.notEmpty(map.get("role_level")));
	            if(role_level < roleLevel){
	                roleLevel = role_level;
	            }
	        }
	        map = (Map) userRoleList.get(userRoleList.size() - 1);
	        role_names += str.notEmpty(map.get("role_name"));
	        role_ids += str.notEmpty(map.get("role_id"));
	        role_level = Integer.parseInt(str.notEmpty(map.get("role_level")));
            if(role_level < roleLevel){
                roleLevel = role_level;
            }
	    }
	        user.setRoleIds(role_ids);
	        user.setRoleNames(role_names);
	        user.setRoleLevel(roleLevel);
	}
	
	/**
	 * 校验用户
	 * @param request
	 * @return 0：用户不存在  2：用户密码不正确  1：校验通过
	 */
	public int checkUser(HttpServletRequest request){
		String operator_id = req.getValue(request, "loginName");
		String password = req.getValue(request, "loginPassword");
		String loginType = req.getValue(request, "loginType");//登陆类型  1 人员编号登陆  2手机号码登陆
		String sql = "select a.password from t_user a where a.status=1";
		if("1".equals(loginType)){//人员编号登陆
		    sql+=" and a.operator_id=? ";
		}else {
		    sql+=" and a.mobile=? ";
		}
		String userPwd = db.queryForString(sql, new Object[]{operator_id});
		if (userPwd.equals("")) {
			return 0;
		} 
		if (userPwd.equals(StringHelper.md5(password))) {
			return 1;
		}else {
		    return 2;
		}
		
		
	}
	
	/**
	 * 
	 * 检查密码是否为初始密码
	 * @param request
	 * @return 1 否  -4 是初始密码
	 */
	public int checkPassword(HttpServletRequest request){
	    int p = 1;
	    String operator_id = req.getValue(request, "loginName");
	    String password = req.getValue(request, "loginPassword");
        int exc = checkLoginHis(operator_id,password); 
	    if(exc == 0){
	        p = -4;
	    }
        logger.debug("test: p:" + p);
        return p;
	}

	/**
     * 验证密码是否是初始密码
     */
    public int checkLoginHis(String operator_id,String password){
        int result = 1;
        String begin_password = this.checkPwd(operator_id);
        //数据库中用户密码
        String sql = "select password from t_user a where a.operator_id = " + operator_id;
        String user_password = db.queryForString(sql);
        //页面用户输入密码
        sql = " select md5(?) from dual ";
        String pwd = db.queryForString(sql, new Object[]{password});
        logger.debug("test: istrue:" + begin_password.equals(user_password));
        logger.debug("test: jsp_: " + pwd.equals(user_password));
        if(pwd.equals(user_password)){//输入密码和库中密码是否相符
            if (begin_password.equals(user_password) ){//相符则判断库中密码是否为初始密码
                result = 0;
            }
        }

        return result;
    }
    
    /**
     * 
     * 用户初始化的密码
     * @return
     */
    public String checkPwd(String operator_id){
        String sql = "";
        
        sql = "select a.mobile from t_user a where a.operator_id = ?";
        String mobile = db.queryForString(sql, new Object[] {operator_id});
        
        String password = operator_id.substring(operator_id.length()-3)+mobile.substring(mobile.length()-3);
        logger.debug("test: FirstPassword: " + password);
        sql = " select md5(?) from dual";
        
        return db.queryForString(sql, new Object[] {password});
    }
    
    /**
     * 修改密码
     * @param user
     * @param request
     * @return
     */
    public int editpwd(HttpServletRequest request){
        BatchSql batchSql = new BatchSql();
        String operator_id = req.getAjaxValue(request, "operator_id");
        String newpwd = req.getAjaxValue(request, "newpwd");
        String sql = "";
        //更新密码
        sql = " update t_user a set a.password = md5('" + newpwd + "')" +
              "  where a.operator_id = '" + operator_id + "' and a.status = 1 ";
        batchSql.addBatch(sql, null);
        return db.doInTransaction(batchSql);
    }
    
    public String getOperIdByMd5(String operator_md5){
		String sql = "select a.operator_id from t_user a where a.operator_id = ?";
		String operId = db.queryForString(sql, new Object[]{operator_md5});
		return operId;
	}
    
    /**
     * 获取人员编号
     * @param request
     * @return
     */
    public String getOperatorIdByMobile(HttpServletRequest request,String mobile) {
        String sql = " select operator_id from t_user a where a.mobile = ? ";
        return db.queryForString(sql, new Object[] {mobile});
    }
    
    /** 
     * @author 颜丙胜 2018年2月13日
     * @param mobile
     * @param bossId
     * @param empId
     * @return
     */ 
    public String checkUserLoginCmc(String mobile, String operatorId) {
        String sql = " select count(1) " +
                "   from t_user " + 
                "  where mobile = ? " + 
                "    and operator_id = ? " + 
                "    and status = 1 ";
       int exc = db.queryForInt(sql, new Object[]{mobile, operatorId});
       logger.debug(exc);
       if (exc == -1) {
           return "-3";
       }
       if (exc == 0) {
           return "-1";
       }
       return "1";
    }
}
