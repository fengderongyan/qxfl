package qxfl.service.dachange;

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
 * 档案编号管理
 * @date 2016-2-22
 */
@Service("daCfgService")
public class DaCfgService extends BaseService {
	
	
	/**
     * 获取年度列表
     * @param request
     * @return 
     */
    public List getNdList(HttpServletRequest request){
        List<String> paramsList = new ArrayList<String>(); // 查询参数
        String user_id = this.getUser(request).getOperatorId();
        this.getUser(request).getRoleIds();
        String sql = "";
        sql = " select distinct(year) from t_jcdw_base_info where 1 = 1 ";

        return db.queryForList(sql,paramsList);
    }
	
	/**
	 * 查询用户列表
	 * @param request
	 * @return
	 */
	public List<?> getJcdwList(HttpServletRequest request) {
		String year = req.getValue(request, "year");//年度
        String bg_id = req.getValue(request, "bg_id");//报告编号
        String dw_name = req.getValue(request, "dw_name");//单位名称
        List<String> paramsList = new ArrayList<String>();//查询参数
        int pageSize = req.getPageSize(request, "pageSize"); //分页
		String sql = "select " +
					"	a.id, " +
					"	a.dw_name, " +
					"	a.dw_addr, " +
					"	a.da_id, " +
					"	a.bg_id  " +
					"from " +
					"	t_jcdw_base_info a  " +
					"where " +
					"	1 = 1 ";
		if(!"".equals(year)){
		    sql += " and a.year = ? ";
            paramsList.add(year);
		}
		if(!"".equals(bg_id)){
		    sql += " and a.bg_id = ? ";
            paramsList.add(bg_id);
		}
		if(!"".equals(dw_name)){
		    sql += " and a.dw_name like ? ";
            paramsList.add("%" + dw_name + "%");
		}
		sql += " order by a.rec_date desc ";
        logger.debug("getJcdwList : " + str.getSql(sql, paramsList.toArray()));
        return db.getForList(sql, paramsList, pageSize, request);
    }
	
	/**
	 * 工单详情
	 * @param request
	 * @return
	 */
	public Map<String, Object> getJcdwInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");
		String sql = "select " +
					"	a.id, " +
					"	a.dw_name, " +
					"	a.dw_addr, " +
					"	a.da_id, " +
					"	a.bg_id  " +
					"from " +
					"	t_jcdw_base_info a  " +
					"where " +
					"	a.id = ? ";
        return db.queryForMap(sql, new Object[]{id});
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
              "   where a.status = 1 order by a.role_level, a.role_order ";
        
        //视野权限控制
        if(this.getUser(request).hasRoles("1")){//系统管理员
            sql += " and a.role_level >= b.role_level ";
        }else {//其他权限
            sql += " and a.role_level > b.role_level ";
        }

        paramsList.add(user_id);
        logger.debug("sql :" + str.getSql(sql, paramsList));

        return db.queryForList(sql,paramsList);
    }

    /**
     * 保存信息(修改档案ID)
     * @param request
     * @return
     */
    public int saveOrUpdateDaId(HttpServletRequest request) {
        String operator = this.getOperatorId(request);
        String daId = req.getValue(request, "da_id");
        String id = req.getValue(request, "id");
        String sql = "";
        BatchSql batchSql = new BatchSql();
        sql = " update t_jcdw_base_info a set a.da_id = ? where a.id = ? ";
        batchSql.addBatch(sql, new Object[]{daId, id});
        
        return db.doInTransaction(batchSql);
    }
	

    /**
     * 验证档案号
     * @param request
     * @return
     */
    public int checkDaId(HttpServletRequest request) {
    	String daId = req.getValue(request, "da_id");
        String id = req.getValue(request, "id");
        String sql = "";
        int count = 0;
        sql = " select count(1) from t_jcdw_base_info where id <> ? and da_id = ? ";
        count = db.queryForInt(sql, new Object[]{id, daId});
        return count;
    }

}
