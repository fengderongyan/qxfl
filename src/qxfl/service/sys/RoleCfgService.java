package qxfl.service.sys;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import web.service.BaseService;

import com.zcc.util.common.StringHelper;
import com.zcc.util.db.BatchSql;
import com.zcc.util.net.IpHelper;

/**
 * 角色管理
 * @date 2018-12-22
 */
@Service("roleCfgService")
public class RoleCfgService extends BaseService {
	
	/**
	 * 查询角色列表
	 * @param request
	 * @return
	 */
	public List<?> getRolesList(HttpServletRequest request) {
        String roleName = req.getValue(request, "role_name");//角色
        String status = req.getValue(request, "status");//状态
        
        List<String> paramsList = new ArrayList<String>();
        int pageSize = req.getPageSize(request, "pageSize");
        
		String sql = "select a.role_id, " +
		             "       a.role_name, " + 
		             "       a.role_order, " +
		             "       a.status, " + 
		             "       (case " + 
		             "         when a.status = 1 then " + 
		             "          '有效' " + 
		             "         when a.status = 0 then " + 
		             "          '无效' " + 
		             "       end) state, " + 
		             "       a.remark, " + 
		             "       a.role_level, " + 
		             "       a.record_id, " + 
		             "       DATE_FORMAT(a.record_date, '%Y-%m-%d %h:%i:%s') record_date, " + 
		             "       b.name " + 
		             "  from t_role a, t_user b " + 
		             " where 1 = 1 " + 
		             "   and a.record_id = b.operator_id ";
		
		if(this.getUser(request).hasRoles("1")){//系统管理员
			sql += " and 1 = 1 ";
		}else{//非系统管理员即使有可视权限，仍无法查看数据
			sql += " and 1 = 2 ";
		}
		
        if(!roleName.equals("")) {
            sql += " and a.role_name like ? ";
            paramsList.add("%" + roleName + "%");
        }
        if(!status.equals("")) {
            sql += " and a.status = ? ";
            paramsList.add(status);
        }
        sql += " order by a.role_order ";
        logger.debug(str.getSql(sql, paramsList));
        
        //sql += db.addSortString(request, " a.create_date desc,b.org_id,b.org_name,a.name ");
        return db.getForList(sql, paramsList, pageSize, request);
    }
	
	/**
     * 根据节点获取权限列表
     * @param module_id
     * @return
     */
    public List getRoleList(){
        String sql = "select * from t_role a where a.status = 1 order by a.role_order";
        return db.queryForList(sql);
    }
	
	
	/**
	 * 得到工号对应操作员具体信息
	 * @param request 
	 * @return
	 */
	public Map getRoleInfo(HttpServletRequest request) {
        String roleId = req.getValue(request, "role_id");
        String sql = "select role_id, " +
                     "             role_name, " + 
                     "             role_order, " + 
                     "             status, " + 
                     "             remark, " + 
                     "             role_level, " + 
                     "             record_id, " + 
                     "             record_date " + 
                     "        from t_role " + 
                     "       where role_id = ? ";
        
        logger.debug("map : " + str.getSql(sql, new Object[]{roleId}));
        return db.queryForMap(sql, new Object[]{roleId});
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
     * 新增、修改信息
     * @param request
     * @return
     */
    public int saveOrUpdateRole(HttpServletRequest request) {
        logger.debug("saveOrUpdateRole");
        String operator = this.getOperatorId(request);
        String method = req.getValue(request, "method");
        String roleName = req.getValue(request, "role_name");//角色名称
        String status = req.getValue(request, "status");//状态
        String roleOrder = req.getValue(request, "role_order");//角色排序
        String roleLevel = req.getValue(request, "role_level");//角色层级
        String roleId = "";//角色ID
        String sql = "";
        
        logger.debug("method : " + method);
        
        BatchSql batchSql = new BatchSql();
        
        if (method.equals("create")) {
            roleId = db.getMysqlNextSequenceValue("t_role_sid");
        	logger.debug("roleId : " + roleId);
            sql = "insert into t_role " +
                  "         (role_id, " + 
                  "          role_name, " + 
                  "          role_order, " + 
                  "          status, " + 
                  "          role_level, " + 
                  "          record_id, " + 
                  "          record_date) " + 
                  "       values " + 
                  "         (?, ?, ?, ?, ?, ?, sysdate()) ";
            logger.debug("角色新增： " + str.getSql(sql, new Object[] {roleId, roleName, roleOrder, status, roleLevel, operator}));
            batchSql.addBatch(sql, new Object[] {roleId, roleName, roleOrder, status, roleLevel, operator});
        } else if (method.equals("edit")) {
            roleId = req.getValue(request, "role_id");
            
            //修改角色信息
            sql = "update t_role " +
                  "   set role_name   = ?, " + 
                  "       role_order  = ?, " + 
                  "       status      = ?, " + 
                  "       role_level  = ?, " + 
                  "       record_id   = ?, " + 
                  "       record_date = sysdate() " + 
                  " where role_id = ? ";
            logger.debug("角色修改： " + str.getSql(sql, new Object[] {roleName, roleOrder, status, roleLevel, operator, roleId}));
            batchSql.addBatch(sql, new Object[] {roleName, roleOrder, status, roleLevel, operator, roleId});
            
        }
        
        
        return db.doInTransaction(batchSql);
    }
    
    /**
     * 删除角色信息
     * @param request
     * @return
     */
    public int delRole(HttpServletRequest request) {
        String roleId = req.getValue(request, "role_id");//角色名称
        String ipAddress = IpHelper.getIpAddr(request);//IP地址
        String operatorId = this.getUser(request).getOperatorId();//操作人
        
        String sql = "";
        BatchSql batchSql = new BatchSql();
        
        sql = "delete from t_role where role_id = ? ";
        logger.debug("del t_role : " + str.getSql(sql, new Object[]{roleId}));
        batchSql.addBatch(sql, new Object[]{roleId});
        
        //删除对应角色权限视野信息
        sql = "insert into t_role_module_his " +
              "  (operator_id, operate_time, client_address, module_id, role_id) " + 
              "  select ?, sysdate(), ?, module_id, role_id from t_role_module where role_id = ? ";
        logger.debug("t_role_module_his : " + str.getSql(sql, new Object[]{operatorId, ipAddress, roleId}));
        batchSql.addBatch(sql, new Object[]{operatorId, ipAddress, roleId});
        
        sql = "delete from t_role_module where role_id = ? ";
        batchSql.addBatch(sql, new Object[] {roleId});
        
        return db.doInTransaction(batchSql);
    }
	
}
