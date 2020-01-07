package qxfl.service.yqsb;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.zcc.util.db.BatchSql;

import web.service.BaseService;

/**
 * 仪器设备管理
 * @date 2018-12-10
 */
@Service("yqsbService")
public class YqsbService extends BaseService {

	/**
	 * 描述：仪器设备管理列表
	 * @param request
	 * @return
	 * @author yanbs
	 * @Date : 2019-07-10
	 */
	public List getYqsbList(HttpServletRequest request) {
		String yq_name = req.getValue(request, "yq_name");
		int pageSize = req.getPageSize(request, "pageSize"); //分页
		String sql = " select * from t_yqsb_info where 1 = 1 ";
		List paramList = new ArrayList();
		if(!"".equals(yq_name)){
			sql += " and yq_name like concat('%', ?,'%') ";
			paramList.add(yq_name);
		}
		sql += " order by record_date desc ";
		return db.getForList(sql, paramList, pageSize, request);
	}

	/**
	 * 描述：获取仪器设备详情
	 * @param request
	 * @return
	 * @author yanbs
	 * @Date : 2019-07-10
	 */
	public Map getYqsbMap(HttpServletRequest request) {
		String id = req.getValue(request, "id");
		String sql = " select * from t_yqsb_info where id = ? ";
		return db.queryForMap(sql, new Object[]{id});
	}
	
	/**
	 * 描述：保存仪器设备信息
	 * @param request
	 * @return
	 * @author yanbs
	 * @Date : 2019-07-10
	 */
	public int saveOrUpdate(HttpServletRequest request){
		String method = req.getValue(request, "method");
		String id = req.getValue(request, "id");
		String yq_bh = req.getValue(request, "yq_bh");
		String yq_name = req.getValue(request, "yq_name");
		String ggxh = req.getValue(request, "ggxh");
		String dpt_name = req.getValue(request, "dpt_name");
		String check_qk = req.getValue(request, "check_qk");
		String operatorId = this.getOperatorId(request);
		BatchSql batchSql = new BatchSql();
		String sql = "";
		if("add".equals(method)){
			sql = " INSERT INTO t_yqsb_info ( " +
					"	yq_bh, " +
					"	yq_name, " +
					"	ggxh, " +
					"	dpt_name, " +
					"	check_qk, " +
					"	record_id, " +
					"	record_date " +
					") " +
					"VALUES " +
					"	(?,?,?,?,?,?, SYSDATE()) ";
			batchSql.addBatch(sql, new Object[]{yq_bh, yq_name, ggxh, dpt_name, check_qk, operatorId});
		}else{
			sql = "INSERT INTO t_yqsb_info_his ( " +
					"	id, " +
					"	yq_bh, " +
					"	yq_name, " +
					"	ggxh, " +
					"	dpt_name, " +
					"	check_qk, " +
					"	record_id, " +
					"	record_date, " +
					"	delete_id, " +
					"	delete_date " +
					") SELECT " +
					"	id, " +
					"	yq_bh, " +
					"	yq_name, " +
					"	ggxh, " +
					"	dpt_name, " +
					"	check_qk, " +
					"	record_id, " +
					"	record_date, " +
					"	?,  " +
					"  SYSDATE() " +
					"FROM " +
					"	t_yqsb_info " +
					"WHERE " +
					"	id = ? "; 
			batchSql.addBatch(sql, new Object[]{operatorId, id});
			sql = "UPDATE t_yqsb_info " +
					"	SET yq_bh = ?, " +
					"	 yq_name = ?, " +
					"	 ggxh = ?, " +
					"	 dpt_name = ?, " +
					"	 check_qk = ?, " +
					"	 record_id = ?, " +
					"	 record_date = SYSDATE() " +
					" where id = ? ";
			batchSql.addBatch(sql, new Object[]{yq_bh, yq_name, ggxh, dpt_name, check_qk, operatorId, id});
		}
		return db.doInTransaction(batchSql);
	}
	
	public int deleteYqsb(HttpServletRequest request){
		String id = req.getValue(request, "id");
		String operatorId = this.getOperatorId(request);
		BatchSql batchSql = new BatchSql();
		String sql = "INSERT INTO t_yqsb_info_his ( " +
					"	id, " +
					"	yq_bh, " +
					"	yq_name, " +
					"	ggxh, " +
					"	dpt_name, " +
					"	check_qk, " +
					"	record_id, " +
					"	record_date, " +
					"	delete_id, " +
					"	delete_date " +
					") SELECT " +
					"	id, " +
					"	yq_bh, " +
					"	yq_name, " +
					"	ggxh, " +
					"	dpt_name, " +
					"	check_qk, " +
					"	record_id, " +
					"	record_date, " +
					"	?,  " +
					"  SYSDATE() " +
					"FROM " +
					"	t_yqsb_info " +
					"WHERE " +
					"	id = ? "; 
		batchSql.addBatch(sql, new Object[]{operatorId, id});
		sql = " delete from t_yqsb_info where id = ? ";
		batchSql.addBatch(sql, new Object[]{id});
		return db.doInTransaction(batchSql);
	}

}
