package qxfl.service.sys;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import web.service.BaseService;

import com.zcc.util.common.FileHelper;
import com.zcc.util.common.StringHelper;
import com.zcc.util.db.BatchSql;

import qxfl.action.cgjc.CgjcController;
import qxfl.action.sys.UserCfgController;

/**
 * 用户管理
 * @date 2016-2-22
 */
@Service("userCfgService")
public class UserCfgService extends BaseService {
	
	/**
	 * 查询用户列表
	 * @param request
	 * @return
	 */
	public List<?> getUserList(HttpServletRequest request) {
	    String operator_id = req.getValue(request, "operator_id");//编号
        String name = req.getValue(request, "name");//姓名
        String role_id = req.getValue(request, "role_id");//角色
        String maxRole = this.getUser(request).getMaxRoleLevel();
        String org_name = req.getValue(request, "org_name");//归属组织
        String org_id = this.getUser(request).getOrgId();//所在归属编号
        String mobile = req.getValue(request, "mobile");//手机号码
        String status = req.getValue(request, "status");//状态
        List<String> paramsList = new ArrayList<String>();//查询参数
        String org_lev = this.getUser(request).getOrgLevel();//用户归属层级
        int pageSize = req.getPageSize(request, "pageSize"); //分页
		String sql = " select a.operator_id, a.name, h.org_id, a.mobile, a.status, a.qm_name, a.qm_name_d, a.qm_url, " +
					 "         h.org_name, group_concat(b.role_name) roleNames " + 
		             /*"              h.org_name, wmsys.wm_concat(b.role_name) roleNames " +  oracle*/
		             "         from t_user a, t_role b, t_user_role c, t_organization h " + 
		             "        where a.operator_id = c.operator_id " + 
		             "          and b.role_id = c.role_id " + 
		             "          and a.org_id = h.org_id ";
		
		if(this.getUser(request).hasRoles("1,5")){//系统管理员、总经理
		    sql += " and 1 = 1 ";
		}else if(this.getUser(request).hasRoles("2,3,4")){//部长、副部长、员工
		    sql += " and h.county_id = ? ";
            paramsList.add(org_id);
		}
		
        if(!operator_id.equals("")) {
            sql += " and a.operator_id=? ";
            paramsList.add(operator_id);
        }
        
        if(!name.equals("")) {
            sql += " and a.name like ? ";
            paramsList.add("%" + name + "%");
        }
        
        if(!org_name.equals("")) {
            sql += " and h.org_name like ? ";
            paramsList.add("%" + org_name + "%");
        }
        
        if(!mobile.equals("")) {
            sql += " and a.mobile = ? ";
            paramsList.add(mobile);
        }
        
        if(!status.equals("")) {
            sql += " and a.status = ? ";
            paramsList.add(status);
        }
        sql += " group by a.operator_id, a.name, h.org_id, h.org_name, a.mobile, a.status ";
        logger.debug(str.getSql(sql, paramsList));
        
        //sql += db.addSortString(request, " a.create_date desc,b.org_id,b.org_name,a.name ");
        return db.getForList(sql, paramsList, pageSize, request);
    }
	
	/**
     * 文件上传
     * @param request
     * @return
     */
   public int impQmResult(UserCfgController action, HttpServletRequest request, CommonsMultipartFile file, String fileFileName) {
        String operator = this.getUser(request).getOperatorId();
        String operator_id = req.getValue(request, "operator_id");
        logger.debug(file.getSize());
        
        if((int)file.getSize() / 1024 >= 2048){//图片大于2M
        	return 2;
        }
        // 上传文件存档
        //String save_dir = request.getRealPath("/WEB-INF/jsp/qxfl") + "/upload/userqm/";
        String save_dir = request.getRealPath("/pic/");
        FileHelper fileHelper = new FileHelper();
        String qm_name = fileHelper.getToFileName(fileFileName);//后追加时间
        String fileName = save_dir + qm_name;
        String qm_url = save_dir + qm_name;
        fileHelper.copyFile(file, fileName);
        
        BatchSql batchSql = new BatchSql();
        
        String sql = "update t_user  " +
	        		"set qm_name = ?, qm_name_d = ?, qm_url = ?  " +
	        		"where operator_id = ? ";
        batchSql.addBatch(sql, new Object[]{ fileFileName, qm_name, qm_url, operator_id});
        
        return db.doInTransaction(batchSql);
    }
	
	
	/**
	 * 得到工号对应操作员具体信息
	 * @param request 
	 * @return
	 */
	public Map<String, Object> getUserInfo(HttpServletRequest request) {
        String operator_id = req.getValue(request, "operator_id");
        String sql = " select a.operator_id, a.name, a.password, a.org_id, a.status, a.mobile, " 
                   + "        a.email, a.user_order, b.org_name, b.org_lev " 
                   + "   from t_user a, t_organization b " 
                   + "  where operator_id = ? " 
                   + "    and a.org_id = b.org_id ";

        Map<String, Object> map = db.queryForMap(sql, new Object[] {operator_id});
        sql = " select role_id from t_user_role a where a.operator_id = ? ";
        List<Map<String, Object>> roleList = db.queryForList(sql, new Object[] {operator_id});
        String role_ids = "";
        Map<String, Object> roleMap = null;
        if(roleList.size() > 0) {
            for(int i = 0; i < roleList.size() - 1; i++) {
                roleMap = roleList.get(i);
                role_ids += StringHelper.notEmpty(roleMap.get("role_id")) + ",";
            }
            roleMap = roleList.get(roleList.size() - 1);
            role_ids += StringHelper.notEmpty(roleMap.get("role_id"));
            map.put("role_ids", role_ids);
        }
        return map;
    }
	
	/**
	 * 获取组织树
	 * @param request
	 * @return
	 */
    public List<?> getOrgList(HttpServletRequest request){
        List<String> paramsList = new ArrayList<String>();//查询参数
        String orgId = req.getValue(request, "org_id");//组织编号
        String org_id = this.getUser(request).getOrgId();//登陆人所在组织编号
        String org_lev = this.getUser(request).getOrgLevel();//登录人组织层级
        logger.debug("test: orgId " + orgId);
        
        //修改操作时选中当前模块节点
        String sqlw = "";
        //如果组织编号不为空  则选中
        if(!"".equals(orgId)) {
            sqlw += " case when a.org_id = ? then 'true' else 'false' end checked ";
            paramsList.add(orgId);
        } else {
            sqlw += " 'false' checked ";
        }
        String sql ="select a.org_id, a.org_name, a.org_lev, a.superior_id, " +sqlw+
                    "  from t_organization a " + 
                    " where a.status = 1 " ;
        
        if(org_lev.equals("2")){
            sql += " and a.county_id = ? ";
            paramsList.add(org_id);
        }
        if(org_lev.equals("3")){
            sql += " and a.area_id = ? ";
            paramsList.add(org_id);
        }
        if(org_lev.equals("4")){
            sql += " and a.town_id = ? ";
            paramsList.add(org_id);
        }
        if(org_lev.equals("")){
            sql += " and a.tiny_id = ? ";
            paramsList.add(org_id);
        }
        
        return db.queryForList(sql,paramsList);
    }
    
  
    /**
     * 获取角色列表
     * @param request
     * @return 
     */
    public List getRoleList(HttpServletRequest request){
        List<String> paramsList = new ArrayList<String>(); // 查询参数
        String user_id = this.getUser(request).getOperatorId();
        this.getUser(request).getRoleIds();
        String sql = "";
        sql = " select a.role_id, a.role_name " +
              "    from t_role a, " + 
              "         (select min(role_level) role_level " + 
              "             from t_user_role c, t_role e " + 
              "            where operator_id = ? " + 
              "              and c.role_id = e.role_id) b " + 
              "   where a.status = 1  ";
        
        //视野权限控制
        if(this.getUser(request).hasRoles("1")){//系统管理员
            sql += " and a.role_level >= b.role_level ";
        }else {//其他权限
            sql += " and a.role_level > b.role_level ";
        }
        sql += " order by a.role_level, a.role_order ";
        paramsList.add(user_id);
        logger.debug("sql :" + str.getSql(sql, paramsList));

        return db.queryForList(sql,paramsList);
    }

    /**
     * 保存信息
     * @param request
     * @return
     */
    public int saveOrUpdateUser(HttpServletRequest request) {
        String operator = this.getOperatorId(request);
        String method = req.getValue(request, "method");
        String name = req.getValue(request, "name"); //姓名
        String mobile = req.getValue(request, "mobile");//手机号码
        String operator_id = req.getValue(request, "operator_id");//工号
        String old_operator_id = req.getValue(request, "old_operator_id");//工号
        String org_id = req.getValue(request, "org_id");//组织编号
        String[] role_list = req.getValues(request, "role_id");//角色
        String email = req.getValue(request, "email");//邮箱
        String user_order = req.getValue(request, "user_order");//排序
        String sql = "";

        BatchSql batchSql = new BatchSql();
        if (method.equals("create")) {
            //插入用户信息
        	//密码规则：工号后三位+手机号后三位
        	String password = operator_id.substring(operator_id.length()-3)+mobile.substring(mobile.length()-3);
            sql = "insert into t_user(operator_id,name,mobile,org_id,password,status,email," +
                  "create_operator,create_date) "  +
                  " values (?,?,?,?,md5(?),1,?,?,sysdate())";
            batchSql.addBatch(sql, new Object[] {operator_id, name, mobile, org_id,password, email, 
                    operator});
        } else if (method.equals("edit")) {
            //修改用户信息
            sql = "update t_user a set operator_id = ? ,a.name = ?, a.mobile = ?, a.org_id = ?," +
                  " email = ?,operating_code=? ,operating_date = sysdate()  " +
                  "  where operator_id = ? ";
            batchSql.addBatch(sql, new Object[] {operator_id, name, mobile, org_id, email,
                    operator,old_operator_id});
            
            //重新插入用户角色
            sql = "delete from t_user_role where operator_id=?";
            batchSql.addBatch(sql, new Object[]{old_operator_id});
        }
        
        for (int i = 0; i < role_list.length; i++) {
            String role_id = role_list[i];
            sql = "insert into t_user_role (operator_id,role_id) values (?,?)";
            batchSql.addBatch(sql, new Object[]{operator_id, role_id});
        }
        
        return db.doInTransaction(batchSql);
    }
	
	/**
     * 判断某个工号是否已存在 注意：即使是失效工号也不能有重复。
     * @param request
     * @return 1：已存在 0：不存在
     */
    public int getUserCountByOperatorId(HttpServletRequest request) {
        String oper_id = req.getValue(request, "operator_id");
        String sql = "select count(1) from t_user a where operator_id=? ";
        return db.queryForInt(sql, new Object[] {oper_id});
    }

    /**
     * 验证手机号码加状态正常唯一
     * @param request
     * @return
     */
    public int checkUserMsisdn(HttpServletRequest request) {
        String method = req.getValue(request, "method");
        String mobile = req.getValue(request, "mobile");//手机号码
        String operator_id = req.getValue(request, "operator_id");//工号
        String sql = "";
        int count = 0;
        if("create".equals(method)) {
            sql = "select count(1) from t_user a where a.mobile=? and a.status=1 ";
            count = db.queryForInt(sql, new Object[] {mobile});
        } else if("edit".equals(method)) {
            sql = "select count(1) from t_user a where a.mobile=? and a.operator_id<>? and a.status=1";
            count = db.queryForInt(sql, new Object[] {mobile, operator_id});
        }
        //logger.debug("用户号码是否已存在:" + count);
        return count;
    }

    /**
     * 工号失效，恢复，密码复位操作
     * @param request
     * @return
     */
    public int deleteUser(HttpServletRequest request) {
        String operator_id = req.getValue(request, "operator_id");
        String flag = req.getValue(request, "flag");
        String sql = "";
        BatchSql batchSql = new BatchSql();
        if("".equals(flag)) {
            return 0;
        }
        if(flag.equals("1")) {//删除
            sql = "update t_user a set a.status=0  where operator_id=?";
            batchSql.addBatch(sql, new Object[] {operator_id});
            sql = "update t_user_role a set a.status=0  where operator_id=?";
            batchSql.addBatch(sql, new Object[] {operator_id});

        } else if(flag.equals("0")) {//恢复有效
            sql = "update t_user a set a.status=1 where operator_id=?";
            batchSql.addBatch(sql, new Object[] {operator_id});
            sql = "update t_user_role a set a.status=1 where operator_id=?";
            batchSql.addBatch(sql, new Object[] {operator_id});

        } else if(flag.equals("3")) {//密码复位
        	sql = "select a.mobile from t_user a where a.operator_id = ?";
        	String mobile = db.queryForString(sql, new Object[] {operator_id});
        	
        	String password = operator_id.substring(operator_id.length()-3)+mobile.substring(mobile.length()-3);
            sql = "update t_user a set a.password= md5(?) where operator_id=?";
            batchSql.addBatch(sql, new Object[] {password,operator_id});
        }
        return db.doInTransaction(batchSql);
    }
    
    /**
     * 根据组织获取角色列表
     * @param request
     * @return
     */
    public List<?> getRoleListByOgrLevel(HttpServletRequest request) {
        String org_level = req.getValue(request, "org_level");//组织层级
        String org_id = req.getValue(request, "org_id");//组织编号
        List<String> paramsList = new ArrayList<String>(); // 查询参数
        String sql ="select a.role_id, a.role_name " +
                    "  from t_role a " + 
                    " where a.status = 1 " ;
        if("99".equals(org_id)||"0".equals(org_id)){//如果是根或者省公司，只加载省公司角色
            sql+=" and a.role_level = 1 ";
        }else{
            if("2".equals(org_level)){//如果是地市层级，只加载地市角色
                sql+=" and a.role_level = 2 ";
            }else if("3".equals(org_level)){//如果是县区层级，加载县区角色和客户经理
                sql+=" and a.role_level >= 3 ";
            }else{//其它的不加载角色
                sql+=" and 1 = 2 ";
            }
        }
        sql+= " order by a.role_order ";
        return db.queryForList(sql,paramsList);
    }
    
    public int checkUserOperId(HttpServletRequest request) {
        String method = req.getValue(request, "method");
        String operator_id = req.getValue(request, "operator_id");//工号
        String sql = "";
        int count = 0;
        if("create".equals(method)) {
            sql = " select count(1) from t_user a where a.operator_id = ? ";
            count = db.queryForInt(sql, new Object[] {operator_id});
        } 
        //logger.debug("用户号码是否已存在:" + count);
        return count;
    }
}
