package qxfl.service.todo;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.zcc.util.common.DateHelper;

import web.service.BaseService;

/**
 * 加载系统首页相关信息
 * @date 2018-12-20
 */
@Service("todoService")
public class TodoService extends BaseService {
    
    /**
     * 提出报告信息
     * @param request
     * @return
     */
    public List tcBgList(HttpServletRequest request){
        String operatorId = this.getUser(request).getOperatorId();
        String sql = "select  " +
	        		"	a.da_id, a.bg_id, a.dw_name, b.lc_id  " +
	        		"from t_jcdw_base_info a, t_lc_info b  " +
	        		"where a.id = b.info_id  " +
	        		"and a.rec_id = ? order by a.rec_date desc ";
        return db.queryForList(sql, new Object[]{operatorId});
    }
    
    /**
     * 校核报告信息
     * @param request
     * @return->test
     */
    public List jhList(HttpServletRequest request){
    	String operatorId = this.getUser(request).getOperatorId();
        String sql = "select  " +
        		"	a.da_id, a.bg_id, a.dw_name, b.lc_id  " +
        		"from t_jcdw_base_info a, t_lc_info b  " +
        		"where a.id = b.info_id  " +
        		"and (a.jhr = ? or a.jfr = ?) order by a.rec_date desc";

        return db.queryForList(sql, new Object[]{operatorId, operatorId});
    }    


    
    /**
     * 获取年度列表
     * @param request
     * @return 
     */
    public List getNdList(HttpServletRequest request){
        List<String> paramsList = new ArrayList<String>(); // 查询参数
        this.getUser(request).getRoleIds();
        String sql = "";
        sql = " select distinct(year) from t_jcdw_base_info where 1 = 1 ";

        return db.queryForList(sql,paramsList);
    }
    
}
