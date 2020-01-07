package qxfl.service.cgjc;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import web.service.BaseService;

import com.zcc.util.common.DateHelper;
import com.zcc.util.common.FileHelper;
import com.zcc.util.common.StringHelper;
import com.zcc.util.db.BatchSql;
import com.zcc.util.db.ProcHelper;
import com.zcc.util.excel.HssfHelper;
import com.opensymphony.webwork.components.Date;

import qxfl.action.cgjc.CgjcController;

/**
 * 常规检测
 * @date 2018-12-10
 */
@Service("cgjcService")
public class CgjcService extends BaseService {
	
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
	 * 查询检测单位列表
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
					 "	(case when a.jc_sx = 1 then '首检' when a.jc_sx = 2 then '年检' else '' end) jc_sx_name, jc_sx, " +
					 "	a.lx_bm, " +
					 "	a.bm_phone, " +
					 "	a.lxr, " +
					 "	a.lxr_phone, " +
					 "	a.lj_date, " +
					 "	a.yb, " +
					 "	a.hy_type, " +
					 "	a.dlhj, " +
					 "	a.jd, " +
					 "	a.wd, " +
					 "	a.xzqy, " +
					 "	a.jc_group, " +
					 "	a.ydy_num, " +
					 "	a.da_id, " +
					 "	a.bg_id, " +
					 "	a. year, " +
					 "	a.rec_id, " +
					 "	a.rec_date, " +
					 "	( " +
        			 "		case " +
        			 "		when DATE_FORMAT(jc_date, '%Y-%m-%d')= '2000-01-01' then " +
        			 "			'' " +
        			 "		else " +
        			 "			DATE_FORMAT(jc_date, '%Y-%m-%d') " +
        			 "		end " +
        			 "	) jc_date, " +
        			 "	( " +
        			 "		case " +
        			 "		when DATE_FORMAT(yx_date, '%Y-%m-%d')= '2000-01-01' then " +
        			 "			'' " +
        			 "		else " +
        			 "			DATE_FORMAT(yx_date, '%Y-%m-%d') " +
        			 "		end " +
        			 "	) yx_date, b.lc_id " +
					 "from " +
					 "	t_jcdw_base_info as a, t_lc_info b " +
					 "where " +
					 "	a.id = b.info_id ";
		
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
        //sql = str.getSql(sql, paramsList);
        
        return db.getForList(sql, paramsList, PAGE_SIZE, request);
    }
	
	
	/**
     * 复制信息为年检信息
     * @param request
     * @return
     */
    public int copyJcdwInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");
        String operatorId = this.getUser(request).getOperatorId();
        BatchSql batchSql = new BatchSql();
       
        String sql = "";
        //基本信息表数据复制
        String baseInfoId = this.getNValue("t_jcdw_base_info_sid");
        Calendar now = Calendar.getInstance();  
        String nowYear = Integer.toString(now.get(Calendar.YEAR));
        //报告编码
        String bgId = "BG" + "011000" + nowYear + this.getNextValue("t_jcdw_base_bg_sid");
        //档案编码
        String daId = "DA" + "011000" + nowYear + this.getNextValue("t_jcdw_base_bg_sid");
        
        sql = "insert into t_jcdw_base_info " +
        		"	(id,dw_name,dw_addr,lx_bm,bm_phone,lxr, " +
        		"	lxr_phone,lj_date,yb,hy_type,dlhj,jd,wd, " +
        		"	xzqy,jc_group,ydy_num,da_id,bg_id,year, " +
        		"	rec_id,rec_date, " +
        		"	dw_fr,jc_way,nzddl,npjmd,jc_date,weather, " +
        		"	jc_yj,bg_gc,remark,jcr,jhr,jfr,yqsb_info, " +
        		"	jc_zq,update_time,yx_date,jyj,zgyj_date,zgyj,jy,jc_sx) " +
//        		"select ? ,concat(dw_name, '（年检）'),dw_addr,lx_bm,bm_phone,lxr, " +
				"select ? ,dw_name,dw_addr,lx_bm,bm_phone,lxr, " +
        		"	lxr_phone,lj_date,yb,hy_type,dlhj,jd,wd, " +
        		"	xzqy,jc_group,0, ?, ?, ?, " +
        		"	?, sysdate(), " +
        		"	dw_fr,jc_way,nzddl,npjmd,jc_date,weather, " +
        		"	jc_yj,bg_gc,remark,jcr,jhr,jfr,yqsb_info, " +
        		"	jc_zq,update_time,yx_date,jyj,zgyj_date,zgyj,jy,2 " +
        		"from t_jcdw_base_info where id = ? ";
        batchSql.addBatch(sql, new Object[] {baseInfoId, daId, bgId, nowYear, operatorId, id});
        
        //流程信息更新为待提交
        String lcId = this.getNValue("t_lc_info_sid");
        sql = "insert into t_lc_info " +
        		"(id,info_id,lc_id,rec_id,rec_date) " +
        		"values " +
        		"(?, ?, 1, ?, SYSDATE()) ";
        batchSql.addBatch(sql, new Object[] {lcId, baseInfoId, operatorId});
        
        //防直击雷信息复制
        sql = "insert into t_fzjl_info(id,base_id,bbhw_name,fl_type,ckg,sjq_xz,sjq_xz_rst, " +
        		"	sjq_gd,sjq_gd_rst,sjq_fsfs,sjq_fsfs_rst,sjq_ggcz,sjq_ggcz_rst,sjq_fscd,sjq_fscd_rst, " +
        		"	sjq_gdxz,sjq_gdxz_rst,sjq_hjcd,sjq_hjcd_rst,sjq_bhfw,sjq_bhfw_rst,sjq_wg,sjq_wg_rst, " +
        		"	sjq_dzjjj,sjq_dzjjj_rst,yxx_fsfs,yxx_sl,yxx_sl_rst,yxx_jj,yxx_jj_rst,yxx_fscd,yxx_fscd_rst, " +
        		"	yxx_gdzk,yxx_gdzk_rst,yxx_hjcd,yxx_hjcd_rst,yxx_ggcz,yxx_ggcz_rst,yxx_mfzjjj,yxx_mfzjjj_rst, " +
        		"	jdx_ggcz,jdx_ggcz_rst,jdx_fscd,jdx_fscd_rst,pb_zdy_fsfs,pb_zdy_fsfs_rst,pb_zxh_fsfs,pb_zxh_fsfs_rst, " +
        		"	pb_zdy_sx,pb_zdy_sx_rst,pb_zxh_sx,pb_zxh_sx_rst,dx_result,result,zgyj,jy,state,rec_id,rec_date) " +
        		"select nextval('t_fzjl_info_sid'), ?, bbhw_name,fl_type,ckg,sjq_xz,sjq_xz_rst, " +
        		"	sjq_gd,sjq_gd_rst,sjq_fsfs,sjq_fsfs_rst,sjq_ggcz,sjq_ggcz_rst,sjq_fscd,sjq_fscd_rst, " +
        		"	sjq_gdxz,sjq_gdxz_rst,sjq_hjcd,sjq_hjcd_rst,sjq_bhfw,sjq_bhfw_rst,sjq_wg,sjq_wg_rst, " +
        		"	sjq_dzjjj,sjq_dzjjj_rst,yxx_fsfs,yxx_sl,yxx_sl_rst,yxx_jj,yxx_jj_rst,yxx_fscd,yxx_fscd_rst, " +
        		"	yxx_gdzk,yxx_gdzk_rst,yxx_hjcd,yxx_hjcd_rst,yxx_ggcz,yxx_ggcz_rst,yxx_mfzjjj,yxx_mfzjjj_rst, " +
        		"	jdx_ggcz,jdx_ggcz_rst,jdx_fscd,jdx_fscd_rst,pb_zdy_fsfs,pb_zdy_fsfs_rst,pb_zxh_fsfs,pb_zxh_fsfs_rst, " +
        		"	pb_zdy_sx,pb_zdy_sx_rst,pb_zxh_sx,pb_zxh_sx_rst,dx_result,result,zgyj,jy,state,?, SYSDATE() " +
        		"from t_fzjl_info " +
        		"where base_id = ? ";
        batchSql.addBatch(sql, new Object[] { baseInfoId, operatorId, id });
        
        //屏蔽、等电位及接地 信息复制
        sql = "insert into t_pbddw_info " +
        		"(id,base_id,jzwly,jzw,jcd,ggcz,dzz,dx_result,sx,rec_id,rec_date,state) " +
        		"select nextval('t_pbddw_info_sid'), ?, jzwly,jzw,jcd,ggcz,dzz,dx_result,sx,?, SYSDATE(),state  " +
        		"from t_pbddw_info " +
        		"where base_id = ? ";
        batchSql.addBatch(sql, new Object[] { baseInfoId, operatorId, id });
        
        //电子系统电涌保护器 信息复制
        sql = "insert into t_xhtkdybhq_info " +
        		"	(id,base_id,bjcwwz,type,xh,azrq,baqk,baqk_rst, " +
        		"	azsl,azsl_rst,bctll,bctll_rst,crsh,crsh_rst, " +
        		"	jdjm,jdjm_rst,jdxcd,jdxcd_rst,sggy,sggy_rst,dyzbb, " +
        		"	dyzbb_rst,edgzdy,edgzdy_rst,dybhsp,dybhsp_rst,szflq, " +
        		"	szflq_rst,dx_result,result,zgyj,jy,state,rec_id,rec_date) " +
        		"select nextval('t_xhtkdybhq_info_sid'), ?, bjcwwz,type,xh,azrq,baqk,baqk_rst, " +
        		"	azsl,azsl_rst,bctll,bctll_rst,crsh,crsh_rst, " +
        		"	jdjm,jdjm_rst,jdxcd,jdxcd_rst,sggy,sggy_rst,dyzbb, " +
        		"	dyzbb_rst,edgzdy,edgzdy_rst,dybhsp,dybhsp_rst,szflq, " +
        		"	szflq_rst,dx_result,result,zgyj,jy,state,?, SYSDATE() " +
        		"from t_xhtkdybhq_info " +
        		"where base_id = ? ";
        batchSql.addBatch(sql, new Object[] { baseInfoId, operatorId, id});
        
        //电子系统 信息删除 
        sql = "insert into t_dzxt_info " +
        		"	(id,base_id,jf_name,jf_wz,jfmj,jf_fldj,szdl_fldj, " +
        		"	szdl_fllb,zjl_fhqk,kjs_wd,kjs_wd_rst,kjs_sd,kjs_sd_rst, " +
        		"	qzcjl,qzcjl_rst,jfdy_fsfs,jfdy_fsfs_rst,jfdy_sx,jfdy_sx_rst, " +
        		"	jfxh_fsfs,jfxh_fsfs_rst,jfxh_sx,jfxh_sx_rst,ddw_ljjg,ddw_ljjg_rst, " +
        		"	ddw_czgg,ddw_czgg_rst,ddw_jdx_fscd,ddw_jdx_fscd_rst,ddw_jdx_ljqk, " +
        		"	ddw_jdx_ljqk_rst,ddw_hlpggcz,ddw_hlpggcz_rst,ddw_hlpfscd,ddw_hlpfscd_rst, " +
        		"	ddw_hlpljzk,ddw_hlpljzk_rst,ddw_zxggcz,ddw_zxggcz_rst,ddw_zxjdggcz,ddw_zxjdggcz_rst, " +
        		"	ddw_zxjdxljzk,ddw_zxjdxljzk_rst,ddw_spjdxgg,ddw_spjdxggf_rst,ddw_sbjdxlj,ddw_sbjdxlj_rst, " +
        		"	ddw_gljdxgg,ddw_gljdxgg_rst,ddw_gljdxlj,ddw_gljdxlj_rst,ddw_dhxggcz, " +
        		"	ddw_dhxggcz_rst,ddw_dhxlj,ddw_dhxlj_rst,ups_dyz,ups_dyz_rst,ups_pl, " +
        		"	ups_pl_rst,ups_bxszl,ups_bxszl_rst,ups_lddy,ups_lddy_rst,ups_jdfs, " +
        		"	ups_jdfs_rst,ups_jdw,ups_jdw_rst,ups_dzl,ups_dzl_rst,ups_jdxgg,ups_jdxgg_rst, " +
        		"	ups_ljzk,ups_ljzk_rst,tx_xz,tx_xz_rst,tx_ggcz,tx_ggcz_rst,tx_fscd,tx_fscd_rst, " +
        		"	tx_bhfw,tx_bhfw_rst,tx_jdxggcz,tx_jdxggcz_rst,tx_jdxfscd,tx_jdxfscd_rst,dx_result, " +
        		"	result,zgyj,jy,state,rec_id,rec_date) " +
        		"select nextval('t_dzxt_info_sid'), ?, jf_name,jf_wz,jfmj,jf_fldj,szdl_fldj, " +
        		"	szdl_fllb,zjl_fhqk,kjs_wd,kjs_wd_rst,kjs_sd,kjs_sd_rst, " +
        		"	qzcjl,qzcjl_rst,jfdy_fsfs,jfdy_fsfs_rst,jfdy_sx,jfdy_sx_rst, " +
        		"	jfxh_fsfs,jfxh_fsfs_rst,jfxh_sx,jfxh_sx_rst,ddw_ljjg,ddw_ljjg_rst, " +
        		"	ddw_czgg,ddw_czgg_rst,ddw_jdx_fscd,ddw_jdx_fscd_rst,ddw_jdx_ljqk, " +
        		"	ddw_jdx_ljqk_rst,ddw_hlpggcz,ddw_hlpggcz_rst,ddw_hlpfscd,ddw_hlpfscd_rst, " +
        		"	ddw_hlpljzk,ddw_hlpljzk_rst,ddw_zxggcz,ddw_zxggcz_rst,ddw_zxjdggcz,ddw_zxjdggcz_rst, " +
        		"	ddw_zxjdxljzk,ddw_zxjdxljzk_rst,ddw_spjdxgg,ddw_spjdxggf_rst,ddw_sbjdxlj,ddw_sbjdxlj_rst, " +
        		"	ddw_gljdxgg,ddw_gljdxgg_rst,ddw_gljdxlj,ddw_gljdxlj_rst,ddw_dhxggcz, " +
        		"	ddw_dhxggcz_rst,ddw_dhxlj,ddw_dhxlj_rst,ups_dyz,ups_dyz_rst,ups_pl, " +
        		"	ups_pl_rst,ups_bxszl,ups_bxszl_rst,ups_lddy,ups_lddy_rst,ups_jdfs, " +
        		"	ups_jdfs_rst,ups_jdw,ups_jdw_rst,ups_dzl,ups_dzl_rst,ups_jdxgg,ups_jdxgg_rst, " +
        		"	ups_ljzk,ups_ljzk_rst,tx_xz,tx_xz_rst,tx_ggcz,tx_ggcz_rst,tx_fscd,tx_fscd_rst, " +
        		"	tx_bhfw,tx_bhfw_rst,tx_jdxggcz,tx_jdxggcz_rst,tx_jdxfscd,tx_jdxfscd_rst,dx_result, " +
        		"	result,zgyj,jy,state,?, SYSDATE() " +
        		"from t_dzxt_info " +
        		"where base_id = ? ";
        batchSql.addBatch(sql, new Object[] {baseInfoId, operatorId, id});
        
        //材料上传 信息复制
        sql = "insert into t_clsc_info " +
        		"	(id,base_id,cl_name,cl_type,sc_date,cl_dx,cl_url,remark,rec_id,cl_name_d) " +
        		"select nextval('t_clsc_info_sid'), ?, cl_name,cl_type,sc_date,cl_dx,cl_url,remark, ?, cl_name_d " +
        		"from t_clsc_info " +
        		"where base_id = ? ";
        batchSql.addBatch(sql, new Object[] {baseInfoId, operatorId, id});
        
        return db.doInTransaction(batchSql);
    }
	
	/**
     * 删除检测单位信息
     * @param request
     * @return
     */
    public int deleteJcdwInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");
        String operatorId = this.getUser(request).getOperatorId();
        BatchSql batchSql = new BatchSql();
        //删除基本信息表数据
        //插入历史表
        String sql = "insert into t_jcdw_base_info_his " +
	        		"(id,dw_name,dw_addr,lx_bm,bm_phone,lxr,lxr_phone,lj_date,yb,hy_type,dlhj,jd,wd,xzqy,jc_group, " +
	        		"ydy_num,da_id,bg_id,year,rec_id,rec_date,jc_sx,dw_fr,jc_way,nzddl,npjmd,jc_date,weather,jc_yj,bg_gc,remark, " +
	        		"jcr,jhr,jfr,yqsb_info,jc_zq,update_time,yx_date,jyj,zgyj_date,zgyj,jy, del_id, del_date) " +
	        		"select id,dw_name,dw_addr,lx_bm,bm_phone,lxr,lxr_phone,lj_date,yb,hy_type,dlhj,jd,wd,xzqy,jc_group, " +
	        		"	ydy_num,da_id,bg_id,year,rec_id,rec_date,jc_sx,dw_fr,jc_way,nzddl,npjmd,jc_date,weather,jc_yj,bg_gc, " +
	        		"	remark,jcr,jhr,jfr,yqsb_info,jc_zq,update_time,yx_date,jyj,zgyj_date,zgyj,jy, ?, SYSDATE() " +
	        		"from t_jcdw_base_info where id = ? ";
        batchSql.addBatch(sql, new Object[] {operatorId, id});
        //删除
        sql = " delete from t_jcdw_base_info where id = ? ";
        batchSql.addBatch(sql, new Object[] {id});
        
        //流程信息删除
        sql = " delete from t_lc_info where info_id = ? ";
        batchSql.addBatch(sql, new Object[] {id});
        
        //防直击雷信息删除 
        sql = " update t_fzjl_info set state = 0 where base_id = ? ";
        batchSql.addBatch(sql, new Object[] {id});
        
        //屏蔽、等电位及接地 信息删除 
        sql = " update t_pbddw_info set state = 0 where base_id = ? ";
        batchSql.addBatch(sql, new Object[] {id});
        
        //电子系统电涌保护器 信息删除 
        sql = " update t_xhtkdybhq_info set state = 0 where base_id = ? ";
        batchSql.addBatch(sql, new Object[] {id});
        
        //电子系统 信息删除 
        sql = " update t_dzxt_info set state = 0 where base_id = ? ";
        batchSql.addBatch(sql, new Object[] {id});
        
        //材料上传 信息删除
        //插入历史表
        sql = "insert into t_clsc_info_his( " +
        		"	id, " +
        		"	base_id, " +
        		"	cl_name, " +
        		"	cl_type, " +
        		"	sc_date, " +
        		"	cl_dx, " +
        		"	cl_url, " +
        		"	remark, " +
        		"	rec_id, " +
        		"	cl_name_d, " +
        		"	del_id, " +
        		"	del_date " +
        		")select " +
        		"	id, " +
        		"	base_id, " +
        		"	cl_name, " +
        		"	cl_type, " +
        		"	sc_date, " +
        		"	cl_dx, " +
        		"	cl_url, " +
        		"	remark, " +
        		"	rec_id, " +
        		"	cl_name_d, " +
        		"	?, SYSDATE() " +
        		"from t_clsc_info " +
        		"where " +
        		"	base_id = ? ";
        batchSql.addBatch(sql, new Object[] {operatorId, id});
        
        //删除材料上传 信息
        sql = " delete from t_clsc_info where base_id = ? ";
        batchSql.addBatch(sql, new Object[] {id});
        
        //发票信息删除
        sql = " delete from t_bill_info where base_id = ? ";
        batchSql.addBatch(sql, new Object[] {id});
        
        return db.doInTransaction(batchSql);
    }
	
	
    /**
     * 获取配置信息
     * @param request
     * @return 
     */
    public List getHyTypeList(HttpServletRequest request, String data_type_code){
        List<String> paramsList = new ArrayList<String>(); // 查询参数
        String sql = "";
        sql = " select dd_item_name, dd_item_code "
            + "   from t_ddw "
            + "  where data_type_code = ? "
            + "  order by dd_item_code ";
        paramsList.add(data_type_code);
        
        return db.queryForList(sql,paramsList);
    }
    
    public List getHyTypeList2(HttpServletRequest request, String data_type_code){
    	String id = req.getValue(request, "infoId");
        List<String> paramsList = new ArrayList<String>(); // 查询参数
        String sql = "";
        sql = "SELECT " +
        		"	DD_ITEM_CODE, " +
        		"	DD_ITEM_NAME  " +
        		"FROM " +
        		"	t_ddw  " +
        		"WHERE " +
        		"	DATA_TYPE_CODE = '10006'  " +
        		"	AND FIND_IN_SET(DD_ITEM_CODE,(SELECT bg_gc FROM t_jcdw_base_info WHERE id = ?))";
        paramsList.add(id);
        logger.debug("报告构成" + str.getSql(sql, paramsList));
        return db.queryForList(sql,paramsList);
    }
    
    public List getHyTypeList1(HttpServletRequest request, String data_type_code){
    	String id = req.getValue(request, "infoId");
        List<String> paramsList = new ArrayList<String>(); // 查询参数
        String sql = "";
        sql = "SELECT " +
        		"	DD_ITEM_CODE, " +
        		"	DD_ITEM_NAME  " +
        		"FROM " +
        		"	t_ddw  " +
        		"WHERE " +
        		"	DATA_TYPE_CODE = '10025'  " +
        		"	AND FIND_IN_SET(DD_ITEM_CODE,(SELECT jyj FROM t_jcdw_base_info WHERE id = ?))";
        paramsList.add(id);
        
        return db.queryForList(sql,paramsList);
    }

    /**
     * 保存信息
     * @param request
     * @return
     */
    public int jcdwSave(HttpServletRequest request) {
        String operator = this.getOperatorId(request);
        String dw_name = req.getValue(request, "dw_name"); //单位名称
        String dw_addr = req.getValue(request, "dw_addr"); //单位地址
        String lx_bm = req.getValue(request, "lx_bm"); //联系部门
        String bm_phone = req.getValue(request, "bm_phone"); //联系电话
        String lxr = req.getValue(request, "lxr"); //联系人
        String lxr_phone = req.getValue(request, "lxr_phone"); //联系电话
        String lj_date = req.getValue(request, "lj_date"); //雷击时间
        String yb = req.getValue(request, "yb"); //邮编
        String hy_type = req.getValue(request, "hy_type"); //行业类别
        String dlhj = req.getValue(request, "dlhj"); //地理环境
        String jd = req.getValue(request, "jd"); //经度
        String wd = req.getValue(request, "wd"); //纬度
        String xzqy = req.getValue(request, "xzqy"); //行政区域
        String jc_group = req.getValue(request, "jc_group"); //检测组别
        String ydy_num = "0"; //已打印次数
        String da_id = req.getValue(request, "da_id");
        String bg_id = req.getValue(request, "bg_id");
        String nowYear = req.getValue(request, "nowYear");
        
        String sql = "";
        
        if(lj_date.equals("")){
        	lj_date = "2000-01-01";
        }
        
        //id
        String id = this.getNValue("t_jcdw_base_info_sid");
        
        
        BatchSql batchSql = new BatchSql();
        
        sql = "insert into t_jcdw_base_info( " +
        	  "	id, jc_sx, " +
        	  "	dw_name, " +
        	  "	dw_addr, " +
        	  "	lx_bm, " +
        	  "	bm_phone, " +
        	  "	lxr, " +
        	  "	lxr_phone, " +
        	  "	lj_date, " +
        	  "	yb, " +
        	  "	hy_type, " +
        	  "	dlhj, " +
        	  "	jd, " +
        	  "	wd, " +
        	  "	xzqy, " +
        	  "	jc_group, " +
        	  "	ydy_num, " +
        	  "	da_id, " +
        	  "	bg_id, " +
        	  "	year, " +
        	  "	rec_id, " +
        	  "	rec_date " +
        	  ") " +
        	  "values " +
        	  "	( " +
        	  "		?, 1, ?, ?, ?, ?, ?, ?, str_to_date(?, '%Y-%m-%d'), " +
        	  "		?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE() " +
        	  "	) ";
        batchSql.addBatch(sql, new Object[] {id, dw_name, dw_addr, lx_bm, bm_phone, lxr, lxr_phone,
        		lj_date, yb, hy_type, dlhj, jd, wd, xzqy, jc_group, ydy_num, da_id, bg_id, nowYear,
        		operator});
        
        //流程信息更新
        sql = "insert into t_lc_info  " +
        	  "values  " +
        		"(nextval('t_lc_info_sid'), ?, 1, ?, SYSDATE())";
        batchSql.addBatch(sql, new Object[]{id, operator});
        
        return db.doInTransaction(batchSql);
    }
    
    /**
     * 根据名称获取序列下一值(0001)
     * @param String
     */
    public String getNextValue(String sequenceName) {
    	String sql = "";
		sql = " select lpad(nextval(?), 4, 0) from dual ";
        return db.queryForString(sql, new Object[] {sequenceName});
    }
    
    /**
     * 根据名称获取序列下一值(00001)
     * @param String
     */
    public String getDaNextValue(String sequenceName) {
    	String sql = "";
		sql = " select lpad(nextval(?), 5, 0) from dual ";
        return db.queryForString(sql, new Object[] {sequenceName});
    }
    
    /**
     * 根据名称获取序列下一值
     * @param String
     */
    public String getNValue(String sequenceName) {
    	String sql = "";
		sql = " select nextval(?) from dual ";
        return db.queryForString(sql, new Object[] {sequenceName});
    }

    /**
     * 验证档案编号唯一
     * @param request
     * @return
     */
    public int checkDaId(HttpServletRequest request) {
    	String da_id = req.getValue(request, "da_id");
    	String id = req.getValue(request, "id");
        String sql = "";
        int count = 0;
        
        sql = " select count(1) from t_jcdw_base_info where da_id = ? and id <> ? ";
        logger.debug("checkDa : " + str.getSql(sql, new Object[] {da_id, id}));
        count = db.queryForInt(sql, new Object[] {da_id, id});
        
        return count;
    }
    
    /**
	 * 查询仪器设备列表
	 * @param request
	 * @return
	 */
	public List<?> getYqsbList() {
		String sql = " ";
		sql = " select id, yq_bh, yq_name, ggxh, dpt_name, check_qk from t_yqsb_info ";
        return db.queryForList(sql);
    }
	
	public List<?> getYqsbList1(HttpServletRequest request) {
		String id = req.getValue(request, "infoId");
		String sql = " ";
		sql = " select id, yq_bh, yq_name, ggxh, dpt_name, check_qk from t_yqsb_info where FIND_IN_SET(id,(SELECT yqsb_info FROM t_jcdw_base_info WHERE id = ?)) ";
        sql = str.getSql(sql, new Object[]{id});
		return db.queryForList(sql);
    }
	
	public int  getYqsbCount(HttpServletRequest request) {
		String id = req.getValue(request, "infoId");
		String sql = " ";
		sql = " select count(1) from t_yqsb_info where FIND_IN_SET(id,(SELECT yqsb_info FROM t_jcdw_base_info WHERE id = ?)) ";
        sql = str.getSql(sql, new Object[]{id});
        System.out.println("======================" + sql);
		return db.queryForInt(sql);
    }
    
    /**
	 * 基本信息
	 * @param request 
	 * @return
	 */
	public Map<String, Object> getBaseInfo(HttpServletRequest request) {
        String id = req.getValue(request, "base_id");
        String sql = "select " +
        			 "	id, remark3," +
        			 "	dw_name, " +
        			 "	dw_addr, " +
        			 "	lx_bm, " +
        			 "	bm_phone, " +
        			 "	lxr, " +
        			 "	lxr_phone, " +
        			 "	( " +
        			 "		case " +
        			 "		when DATE_FORMAT(lj_date, '%Y-%m-%d')= '2000-01-01' then " +
        			 "			'' " +
        			 "		else " +
        			 "			DATE_FORMAT(lj_date, '%Y-%m-%d') " +
        			 "		end " +
        			 "	)lj_date, " +
        			 "	( " +
        			 "		case " +
        			 "		when DATE_FORMAT(remark4, '%Y-%m-%d')= '2000-01-01' then " +
        			 "			'' " +
        			 "		else " +
        			 "			DATE_FORMAT(remark4, '%Y-%m-%d') " +
        			 "		end " +
        			 "	) remark4, " +
        			 "	yb, " +
        			 "	hy_type, " +
        			 "	dlhj, " +
        			 "	jd, " +
        			 "	wd, " +
        			 "	xzqy, " +
        			 "	jc_group, jc_zq, " +
        			 "	ydy_num, " +
        			 "	da_id, " +
        			 "	bg_id, " +
        			 "	year, " +
        			 "	rec_id, " +
        			 "	DATE_FORMAT(rec_date, '%Y-%m-%d')rec_date, " +
        			 "	jc_sx, " +
        			 "	(case when jc_sx = 1 then '首检' when jc_sx = 2 then '年检' else '' end ) jc_sx_name, " +
        			 "	dw_fr, " +
        			 "	jc_way, " +
	        		 "	nzddl, " +
	        		 "	npjmd, " +
	        		 "	( " +
        			 "		case " +
        			 "		when DATE_FORMAT(jc_date, '%Y-%m-%d')= '2000-01-01' then " +
        			 "			'' " +
        			 "		else " +
        			 "			DATE_FORMAT(jc_date, '%Y-%m-%d') " +
        			 "		end " +
        			 "	) jc_date, " +
	        		 "	weather, " +
	        		 "	jc_yj, " +
	        		 "	bg_gc, " +
	        		 "	remark, " +
	        		 "	(select b.name from t_user b where b.operator_id = a.jcr) jcr, " +
	        		 "	(select b.name from t_user b where b.operator_id = a.jhr) jhr, " +
	        		 "	(select b.name from t_user b where b.operator_id = a.jfr) jfr, " +
	        		 "	yqsb_info, " +
	        		 "	( " +
        			 "		case " +
        			 "		when DATE_FORMAT(yx_date, '%Y-%m-%d')= '2000-01-01' then " +
        			 "			'' " +
        			 "		else " +
        			 "			DATE_FORMAT(yx_date, '%Y-%m-%d') " +
        			 "		end " +
        			 "	) yx_date,  " +
        			 "	jyj, " +
        			 "	( " +
        			 "		case " +
        			 "		when DATE_FORMAT(zgyj_date, '%Y-%m-%d')= '2000-01-01' then " +
        			 "			'' " +
        			 "		else " +
        			 "			DATE_FORMAT(zgyj_date, '%Y-%m-%d') " +
        			 "		end " +
        			 "	) zgyj_date, " +
        			 "	zgyj, " +
        			 "	jy, remark1, remark2, DATE_FORMAT(remark_date, '%Y-%m-%d') remark_date, remark5 " +
	        		 "from " +
	        		 "	t_jcdw_base_info a " +
	        		 "where " +
	        		 "	id = ? ";
        logger.debug("=============" + str.getSql(sql, new Object[] {id}));
        Map<String, Object> map = db.queryForMap(sql, new Object[] {id});
        return map;
    }
	
	public List getInfosList(HttpServletRequest request){
		String id = req.getValue(request, "base_id");
		String sql = "	select info from t_cys_info where base_id = ? ";
		return db.queryForList(sql, new Object[]{id});
	}
	
	public List getInfosList1(HttpServletRequest request){
		String id = req.getValue(request, "infoId");
		String sql = "	select info from t_cys_info where base_id = ? ";
		return db.queryForList(sql, new Object[]{id});
	}
	
	/**
	 * 获取一年后日期
	 * @param dateNum
	 * @return
	 */
	public String getNextYearDay(String dateNum){
		String sql = " select DATE_FORMAT(DATE_ADD(str_to_date(?, '%Y-%m-%d'),INTERVAL 1 year), '%Y-%m-%d') from dual ";
		return db.queryForString(sql, new Object[]{dateNum});
	}
	
	/**
	 * 获取半年后日期
	 * @param dateNum
	 * @return
	 */
	public String getNextHalfYearDay(String dateNum){
		String sql = " select DATE_FORMAT(DATE_ADD(str_to_date(?, '%Y-%m-%d'),INTERVAL 6 month), '%Y-%m-%d') from dual ";
		return db.queryForString(sql, new Object[]{dateNum});
	}
	
	/**
     * 保存基本信息
     * @param request
     * @return
     */
    public int jcdwBaseSave(HttpServletRequest request) {
        String operator = this.getOperatorId(request);
        String dw_fr = req.getValue(request, "dw_fr"); //单位法人
        String lx_bm = req.getValue(request, "lx_bm"); //联系部门
        String bm_phone = req.getValue(request, "bm_phone"); //联系电话
        String lxr = req.getValue(request, "lxr"); //联系人or单位经办人
        String lxr_phone = req.getValue(request, "lxr_phone"); //联系电话
        String lj_date = req.getValue(request, "lj_date"); //雷击时间
        String yb = req.getValue(request, "yb"); //邮编
        String hy_type = req.getValue(request, "hy_type"); //行业类别
        String dlhj = req.getValue(request, "dlhj"); //地理环境
        String jd = req.getValue(request, "jd"); //经度
        String wd = req.getValue(request, "wd"); //纬度
        String jc_zq = req.getValue(request, "jc_zq");//检测周期
        String jc_way = req.getValue(request, "jc_way");//检测方法
        String nzddl = req.getValue(request, "nzddl");//年最大电流
        String jc_date = req.getValue(request, "jc_date");//检测日期
        String weather = req.getValue(request, "weather");//天气实况
        String npjmd = req.getValue(request, "npjmd");//年平均密度
        String jc_yj = req.getValue(request, "jc_yj");//检测意见
        String da_id = req.getValue(request, "da_id");//档案编号
       
        String[] bg_gc = req.getValues(request, "bg_gc");//报告构成
        String remark = req.getValue(request, "remark");//备注
        String[] yqsb_info = req.getValues(request, "yqsb_info");//仪器设备信息
        String id = req.getValue(request, "id");
        
        String remark3 = req.getValue(request, "remark3");
        String remark4 = req.getValue(request, "remark4");
        
        StringBuffer str = new StringBuffer();
        for (String s : bg_gc) {
            str.append(s);
            str.append(",");
        }
        String bggc = str.toString();
        str.setLength(0);
        for (String s : yqsb_info) {
            str.append(s);
            str.append(",");
        }
        String yqsbinfo = str.toString();
        
        
        //日期空值置换
        if(lj_date.equals("")){
        	lj_date = "2000-01-01";
        }
        if(jc_date.equals("")){
        	jc_date = "2000-01-01";
        }
        if("".equals(remark4)) remark4 = "2000-01-01";
        
        //有效日期判断
        String yx_date = "";
        if(jc_zq.equals("1") && !jc_date.equals("2000-01-01")){//一年
        	yx_date = this.getNextYearDay(jc_date);
        }else if(jc_zq.equals("2") && !jc_date.equals("2000-01-01")){//半年
        	yx_date = this.getNextHalfYearDay(jc_date);
        }else{
        	//日期空值置换
        	yx_date = "2000-01-01";
        }
        
        String sql ="update t_jcdw_base_info  " +
	        		"   set dw_fr = ?, " +
	        		"       jd = ?, " +
	        		"       wd = ?, " +
	        		"		lx_bm = ?, " +
	        		"		bm_phone = ?, " +
	        		"		lxr = ?, " +
	        		"		lxr_phone = ?, " +
	        		"		lj_date = ?, " +
	        		"		yb = ?,  " +
	        		"		jc_zq = ?, " +
	        		"		hy_type = ?, " +
	        		"		jc_way = ?, " +
	        		"		nzddl = ?, " +
	        		"		jc_date = ?, " +
	        		"	    weather = ?, " +
	        		"		npjmd = ?, " +
	        		"		jc_yj = ?, " +
	        		"		bg_gc = ?, " +
	        		"		remark = ?, " +
	        		"		yqsb_info = ?, " +
	        		"		da_id = ?, " +
	        		"       yx_date = ?, remark3 = ?, remark4 = ? " +
	        		" where id = ? ";
        
        BatchSql batchSql = new BatchSql();
       logger.debug("=====================" + StringHelper.getSql(sql,  new Object[] {dw_fr, jd, wd, lx_bm, bm_phone, lxr, lxr_phone, lj_date, yb, jc_zq, 
        		hy_type, jc_way, nzddl, jc_date, weather, npjmd, jc_yj, bggc, remark, yqsbinfo, da_id, yx_date, remark3, remark4, id}));
        batchSql.addBatch(sql, new Object[] {dw_fr, jd, wd, lx_bm, bm_phone, lxr, lxr_phone, lj_date, yb, jc_zq, 
        		hy_type, jc_way, nzddl, jc_date, weather, npjmd, jc_yj, bggc, remark, yqsbinfo, da_id, yx_date,  remark3, remark4, id});
        
        return db.doInTransaction(batchSql);
    }
    
    /**
	 * 查询防直击雷列表
	 * @param request
	 * @return
	 */
	public List<?> getFzjlList(HttpServletRequest request) {
        String bbhw_name = req.getValue(request, "bbhw_name");//被保护物名称
        String base_id = req.getValue(request, "base_id");
        List<String> paramsList = new ArrayList<String>();//查询参数
        
        int pageSize = req.getPageSize(request, "pageSize"); //分页
		String sql ="select * " +
					"from " +
					"	t_fzjl_info a " +
					"where " +
					"	1 = 1 ";
		
		if(!"".equals(bbhw_name)){
		    sql += " and a.bbhw_name like ? ";
            paramsList.add('%' + bbhw_name + '%');
		}
		
		sql += " and base_id = ? "
			 + " and state = 1 ";
		paramsList.add(base_id);
		
        sql += " order by a.rec_date desc ";
        sql = str.getSql(sql, paramsList);
        
        paramsList.clear();
        return db.getForList(sql, paramsList, pageSize, request);
    }
	
	/**
	 * 防直击雷信息
	 * @param request 
	 * @return
	 */
	public Map<String, Object> getFzjlInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");
        String sql = " select * from t_fzjl_info where id = ? ";
        Map<String, Object> map = db.queryForMap(sql, new Object[] {id});
        return map;
    }
	
	/**
     * 防直击雷信息保存、更新
     * @param request
     * @return
     */
    public int fzjlSave(HttpServletRequest request) {
        String operator = this.getOperatorId(request);
        String bbhw_name = req.getValue(request, "bbhw_name"); //被保护物名称
        String fl_type = req.getValue(request, "fl_type"); //防雷类别
        String ckg = req.getValue(request, "ckg"); //长宽高
        
        String sjq_xz = req.getValue(request, "sjq_xz"); //形状
        String sjq_xz_rst = req.getValue(request, "sjq_xz_rst"); 
        String sjq_gd = req.getValue(request, "sjq_gd"); //高度
        String sjq_gd_rst = req.getValue(request, "sjq_gd_rst"); 
        String sjq_fsfs = req.getValue(request, "sjq_fsfs"); //敷设方式
        String sjq_fsfs_rst = req.getValue(request, "sjq_fsfs_rst"); 
        String sjq_ggcz = req.getValue(request, "sjq_ggcz"); //规格材质
        String sjq_ggcz_rst = req.getValue(request, "sjq_ggcz_rst"); 
        String sjq_fscd = req.getValue(request, "sjq_fscd"); //腐蚀程度
        String sjq_fscd_rst = req.getValue(request, "sjq_fscd_rst"); 
        String sjq_gdxz = req.getValue(request, "sjq_gdxz"); //固定状况
        String sjq_gdxz_rst = req.getValue(request, "sjq_gdxz_rst"); 
        String sjq_hjcd = req.getValue(request, "sjq_hjcd"); //焊接长度
        String sjq_hjcd_rst = req.getValue(request, "sjq_hjcd_rst"); 
        String sjq_bhfw = req.getValue(request, "sjq_bhfw");//保护范围 
        String sjq_bhfw_rst = req.getValue(request, "sjq_bhfw_rst"); 
        String sjq_wg = req.getValue(request, "sjq_wg"); //网格
        String sjq_wg_rst = req.getValue(request, "sjq_wg_rst"); 
        String sjq_dzjjj = req.getValue(request, "sjq_dzjjj"); //带(网)支架间距
        String sjq_dzjjj_rst = req.getValue(request, "sjq_dzjjj_rst"); 
        String yxx_fsfs = req.getValue(request, "yxx_fsfs"); //敷设方式
        String yxx_fsfs_rst = req.getValue(request, "yxx_fsfs_rst");
        String yxx_sl = req.getValue(request, "yxx_sl"); //数量
        String yxx_sl_rst = req.getValue(request, "yxx_sl_rst"); 
        String yxx_jj = req.getValue(request, "yxx_jj"); //间距
        String yxx_jj_rst = req.getValue(request, "yxx_jj_rst"); 
        String yxx_fscd = req.getValue(request, "yxx_fscd"); //腐蚀程度
        String yxx_fscd_rst = req.getValue(request, "yxx_fscd_rst"); 
        String yxx_gdzk = req.getValue(request, "yxx_gdzk"); //固定状况
        String yxx_gdzk_rst = req.getValue(request, "yxx_gdzk_rst"); 
        String yxx_hjcd = req.getValue(request, "yxx_hjcd"); //焊接长度
        String yxx_hjcd_rst = req.getValue(request, "yxx_hjcd_rst"); 
        String yxx_ggcz = req.getValue(request, "yxx_ggcz"); //规格材质
        String yxx_ggcz_rst = req.getValue(request, "yxx_ggcz_rst"); 
        String yxx_mfzjjj = req.getValue(request, "yxx_mfzjjj"); //明敷支架间距
        String yxx_mfzjjj_rst = req.getValue(request, "yxx_mfzjjj_rst"); 
        String jdx_ggcz = req.getValue(request, "jdx_ggcz"); //规格材质
        String jdx_ggcz_rst = req.getValue(request, "jdx_ggcz_rst"); 
        String jdx_fscd = req.getValue(request, "jdx_fscd"); //腐蚀程度
        String jdx_fscd_rst = req.getValue(request, "jdx_fscd_rst"); 
        String pb_zdy_fsfs = req.getValue(request, "pb_zdy_fsfs"); //室外进总电源线敷设方式
        String pb_zdy_fsfs_rst = req.getValue(request, "pb_zdy_fsfs_rst"); 
        String pb_zxh_fsfs = req.getValue(request, "pb_zxh_fsfs");//室外进总信号线敷设方式 
        String pb_zxh_fsfs_rst = req.getValue(request, "pb_zxh_fsfs_rst"); 
        String pb_zdy_sx = req.getValue(request, "pb_zdy_sx"); //室外进总电源线属性
        String pb_zdy_sx_rst = req.getValue(request, "pb_zdy_sx_rst"); 
        String pb_zxh_sx = req.getValue(request, "pb_zxh_sx"); //室外进总信号线属性
        String pb_zxh_sx_rst = req.getValue(request, "pb_zxh_sx_rst");
        String dx_result = req.getValue(request, "dx_result");//单项结论
        String result = req.getValue(request, "result");//结论
        String zgyj = req.getValue(request, "zgyj");//整改意见
        String jy = req.getValue(request, "jy");//建议
        
        String method = req.getValue(request, "method");
        String sql = "";
        String base_id = req.getValue(request, "base_id");
        BatchSql batchSql = new BatchSql();
        if(method.equals("create") || method.equals("copy")){//新增
             //id
             String id = this.getNValue("t_fzjl_info_sid");
             
             sql =  "insert into t_fzjl_info(id,base_id,bbhw_name,fl_type,ckg, " +
            		" sjq_xz,sjq_xz_rst,sjq_gd,sjq_gd_rst,sjq_fsfs,sjq_fsfs_rst, " +
            		" sjq_ggcz,sjq_ggcz_rst,sjq_fscd,sjq_fscd_rst,sjq_gdxz,sjq_gdxz_rst, " +
            		" sjq_hjcd,sjq_hjcd_rst,sjq_bhfw,sjq_bhfw_rst,sjq_wg,sjq_wg_rst,sjq_dzjjj,sjq_dzjjj_rst, " +
            		" yxx_fsfs,yxx_fsfs_rst,yxx_sl,yxx_sl_rst,yxx_jj,yxx_jj_rst,yxx_fscd,yxx_fscd_rst, " +
            		" yxx_gdzk,yxx_gdzk_rst,yxx_hjcd,yxx_hjcd_rst,yxx_ggcz,yxx_ggcz_rst, " +
            		" yxx_mfzjjj,yxx_mfzjjj_rst,jdx_ggcz,jdx_ggcz_rst,jdx_fscd,jdx_fscd_rst, " +
            		" pb_zdy_fsfs,pb_zdy_fsfs_rst,pb_zxh_fsfs,pb_zxh_fsfs_rst,pb_zdy_sx,pb_zdy_sx_rst, " +
            		" pb_zxh_sx,pb_zxh_sx_rst,dx_result,result,zgyj,jy,state,rec_id,rec_date) " +
            		" values(?, ?, ?, ?, ?, " +
            		" ?, ?, ?, ?, ?, ?, " +
            		" ?, ?, ?, ?, ?, ?, " +
            		" ?, ?, ?, ?, ?, ?, ?, ?, " +
            		" ?, ?, ?, ?, ?,?, ?, ?, " +
            		" ?, ?, ?, ?, ?, ?, " +
            		" ?, ?, ?, ?, ?, ?, " +
            		" ?, ?, ?, ?, ?, ?, " +
            		" ?, ?, ?, ?, ?, ?, 1, ?, SYSDATE())";
             
             batchSql.addBatch(sql, new Object[]{id,base_id,bbhw_name,fl_type,ckg,
            		 sjq_xz,sjq_xz_rst,sjq_gd,sjq_gd_rst,sjq_fsfs,sjq_fsfs_rst,
            		 sjq_ggcz,sjq_ggcz_rst,sjq_fscd,sjq_fscd_rst,sjq_gdxz,sjq_gdxz_rst,
            		 sjq_hjcd,sjq_hjcd_rst,sjq_bhfw,sjq_bhfw_rst,sjq_wg,sjq_wg_rst,sjq_dzjjj,sjq_dzjjj_rst,
            		 yxx_fsfs,yxx_fsfs_rst,yxx_sl,yxx_sl_rst,yxx_jj,yxx_jj_rst,yxx_fscd,yxx_fscd_rst,
            		 yxx_gdzk,yxx_gdzk_rst,yxx_hjcd,yxx_hjcd_rst,yxx_ggcz,yxx_ggcz_rst,
            		 yxx_mfzjjj,yxx_mfzjjj_rst,jdx_ggcz,jdx_ggcz_rst,jdx_fscd,jdx_fscd_rst,
            		 pb_zdy_fsfs,pb_zdy_fsfs_rst,pb_zxh_fsfs,pb_zxh_fsfs_rst,pb_zdy_sx,pb_zdy_sx_rst,
            		 pb_zxh_sx,pb_zxh_sx_rst,dx_result,result,zgyj,jy,operator });
        }else{
        	 String id = req.getValue(request, "id");
        	 
        	 sql = "update t_fzjl_info set " +
        			 "	bbhw_name = ?,fl_type = ?,ckg = ?, " +
        			 "	sjq_xz = ?,sjq_xz_rst = ?,sjq_gd = ?,sjq_gd_rst = ?,sjq_fsfs = ?,sjq_fsfs_rst = ?, " +
        			 "	sjq_ggcz = ?,sjq_ggcz_rst = ?,sjq_fscd = ?,sjq_fscd_rst = ?,sjq_gdxz = ?,sjq_gdxz_rst = ?, " +
        			 "	sjq_hjcd = ?,sjq_hjcd_rst = ?,sjq_bhfw = ?,sjq_bhfw_rst = ?,sjq_wg = ?,sjq_wg_rst = ?,sjq_dzjjj = ?,sjq_dzjjj_rst = ?, " +
        			 "	yxx_fsfs = ?,yxx_fsfs_rst=?,yxx_sl = ?,yxx_sl_rst = ?,yxx_jj = ?,yxx_jj_rst = ?,yxx_fscd = ?,yxx_fscd_rst = ?, " +
        			 "	yxx_gdzk = ?,yxx_gdzk_rst = ?,yxx_hjcd = ?,yxx_hjcd_rst = ?,yxx_ggcz = ?,yxx_ggcz_rst = ?, " +
        			 "	yxx_mfzjjj = ?,yxx_mfzjjj_rst = ?,jdx_ggcz = ?,jdx_ggcz_rst = ?,jdx_fscd = ?,jdx_fscd_rst = ?, " +
        			 "	pb_zdy_fsfs = ?,pb_zdy_fsfs_rst = ?,pb_zxh_fsfs = ?,pb_zxh_fsfs_rst = ?,pb_zdy_sx = ?,pb_zdy_sx_rst = ?, " +
        			 "	pb_zxh_sx = ?,pb_zxh_sx_rst = ?,dx_result = ?,result = ?,zgyj = ?,jy = ? " +
        			 "where id = ? ";
             batchSql.addBatch(sql, new Object[] {bbhw_name,fl_type,ckg,
            		 sjq_xz,sjq_xz_rst,sjq_gd,sjq_gd_rst,sjq_fsfs,sjq_fsfs_rst,
            		 sjq_ggcz,sjq_ggcz_rst,sjq_fscd,sjq_fscd_rst,sjq_gdxz,sjq_gdxz_rst,
            		 sjq_hjcd,sjq_hjcd_rst,sjq_bhfw,sjq_bhfw_rst,sjq_wg,sjq_wg_rst,sjq_dzjjj,sjq_dzjjj_rst,
            		 yxx_fsfs,yxx_fsfs_rst,yxx_sl,yxx_sl_rst,yxx_jj,yxx_jj_rst,yxx_fscd,yxx_fscd_rst,
            		 yxx_gdzk,yxx_gdzk_rst,yxx_hjcd,yxx_hjcd_rst,yxx_ggcz,yxx_ggcz_rst,
            		 yxx_mfzjjj,yxx_mfzjjj_rst,jdx_ggcz,jdx_ggcz_rst,jdx_fscd,jdx_fscd_rst,
            		 pb_zdy_fsfs,pb_zdy_fsfs_rst,pb_zxh_fsfs,pb_zxh_fsfs_rst,pb_zdy_sx,pb_zdy_sx_rst,
            		 pb_zxh_sx,pb_zxh_sx_rst,dx_result,result,zgyj,jy, id});
        }
        
        return db.doInTransaction(batchSql);
    }
    
    /**
     * 删除防直击雷信息
     * @param request
     * @return
     */
    public int deleteFzjlInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");
        BatchSql batchSql = new BatchSql();
        String sql = " update t_fzjl_info set state = 0 where id = ? ";
        batchSql.addBatch(sql, new Object[] {id});
        return db.doInTransaction(batchSql);
    }
    
    /**
	 * 查询屏蔽等电位接地列表
	 * @param request
	 * @return
	 */
	public List<?> getPbddwList(HttpServletRequest request) {
        String jzw = req.getValue(request, "jzw");//建筑物
        String base_id = req.getValue(request, "base_id");
        List<String> paramsList = new ArrayList<String>();//查询参数
        
        int pageSize = req.getPageSize(request, "pageSize"); //分页
		String sql = "select  " +
					"	a.id, a.base_id, a.jzwly,  " +
					"	b.bbhw_name jzw,  " +
					"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10026 and b.DD_ITEM_CODE = a.dzz_bzyq) dzz_bzyq,  " +
					"	a.jcd, a.ggcz, a.dzz, a.dx_result, a.sx, a.rec_id, a.rec_date, a.state " +
					"from t_pbddw_info a, t_fzjl_info b " +
					"where a.base_id = ? " +
					"and a.jzw = b.id " +
					"and b.state = 1 " +
					"and a.state = 1 ";
		paramsList.add(base_id);
		
		if(!"".equals(jzw)){
		    sql += " and b.jzw like ? ";
            paramsList.add('%' + jzw + '%');
		}
		
        sql += " order by a.rec_date desc ";
        //sql = str.getSql(sql, paramsList);
        
        return db.getForList(sql, paramsList, pageSize, request);
    }
	
	/**
	 * 获取对应被保护建筑名称列表
	 * @param request
	 * @return
	 */
	public List<?> getBbhwNameList(HttpServletRequest request) {
        String base_id = req.getValue(request, "base_id");
        List<String> paramsList = new ArrayList<String>();//查询参数
        
		String sql = "select id, bbhw_name  " +
					"from t_fzjl_info  " +
					"where base_id = ? " +
					"and state = 1 " +
					"order by id ";
		paramsList.add(base_id);
        
		sql = str.getSql(sql, paramsList.toArray());
		logger.debug("获取被保护物名称  " + sql);
        return db.queryForList(sql);
    }
	
	/**
     * 屏蔽等电位信息保存、更新
     * @param request
     * @return
     */
    public int pbddwSave(HttpServletRequest request) {
        String operator = this.getOperatorId(request);
        String jzwly = req.getValue(request, "jzwly"); //建筑物来源
        String jzw = req.getValue(request, "jzw"); //建筑物
        String jcd = req.getValue(request, "jcd"); //检测点
        String sx = req.getValue(request, "sx"); //属性
        String ggcz = req.getValue(request, "ggcz"); //规格材质
        String dzz = req.getValue(request, "dzz"); //电阻值
        String dzz_bzyq = req.getValue(request, "dzz_bzyq"); //电阻值
        String dx_result = req.getValue(request, "dx_result"); //单项评定
        
        String method = req.getValue(request, "method");
        String sql = "";
        String base_id = req.getValue(request, "base_id");
        BatchSql batchSql = new BatchSql();
        if(method.equals("create") || method.equals("copy")){//新增or复制
             //id
             String id = this.getNValue("t_pbddw_info_sid");
             
             sql = "insert into t_pbddw_info( " +
        		   "	id, " +
        		   "	base_id, " +
        		   "	jzwly, " +
        		   "	jzw, " +
        		   "	jcd, " +
        		   "	ggcz, " +
        		   "	dzz, " +
        		   "	dzz_bzyq, " +
        		   "	dx_result, " +
        		   "	sx, " +
        		   "	rec_id, " +
        		   "	rec_date, " +
        		   "	state " +
        		   ") " +
        		   "values " +
        		   "	( " +
        		   "		?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE(),1 " +
        		   "	) ";
             
             batchSql.addBatch(sql, new Object[]{id, base_id, jzwly, jzw, jcd, ggcz, dzz, dzz_bzyq, dx_result,
            		 sx, operator});
        }else{
        	 String id = req.getValue(request, "id");
        	 
        	 sql = "update t_pbddw_info " +
        		   "set jzwly = ?, jzw = ?, jcd = ?, ggcz = ?, dzz = ?, dzz_bzyq = ?, dx_result = ?, sx = ? " +
        		   "where " +
        		   "	id = ? ";
             batchSql.addBatch(sql, new Object[] {jzwly, jzw, jcd, ggcz, dzz, dzz_bzyq, dx_result, sx, id });
        }
        
        return db.doInTransaction(batchSql);
    }
    
    /**
     * 多用户保存信息
     * @param request
     * @return
     */
    public int pbddwSaveMore(HttpServletRequest request) {
    	String operator = this.getOperatorId(request);
        String[] jzwlys = req.getValues(request, "jzwly"); //建筑物来源
        String[] jzws = req.getValues(request, "jzw"); //建筑物
        String[] jcds = req.getValues(request, "jcd"); //检测点
        String[] sxs = req.getValues(request, "sx"); //属性
        String[] ggczs = req.getValues(request, "ggcz"); //规格材质
        String[] dzzs = req.getValues(request, "dzz"); //电阻值
        String[] dzzs_bzyq = req.getValues(request, "dzz_bzyq"); //标准要求
        String[] dx_results = req.getValues(request, "dx_result"); //单项评定
        String base_id = req.getValue(request, "base_id");
        String sql = "";

        BatchSql batchSql = new BatchSql();
      
        //保存
        for(int i = 0; i < jzwlys.length; i++){
        	String id = this.getNValue("t_pbddw_info_sid");
        	//密码规则：工号后三位+手机号后三位
        	sql = "insert into t_pbddw_info( " +
         		   "	id, " +
         		   "	base_id, " +
         		   "	jzwly, " +
         		   "	jzw, " +
         		   "	jcd, " +
         		   "	ggcz, " +
         		   "	dzz, " +
         		   "	dzz_bzyq, " +
         		   "	dx_result, " +
         		   "	sx, " +
         		   "	rec_id, " +
         		   "	rec_date, " +
         		   "	state " +
         		   ") " +
         		   "values " +
         		   "	( " +
         		   "		?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?, SYSDATE(),1 " +
         		   "	) ";
        	/*logger.debug("pbddwSaveMore : " + str.getSql(sql,  new Object[]{id, base_id, jzwlys[i], jzws[i], jcds[i], ggczs[i], dzzs[i], dzzs_bzyq[i], dx_results[i],
             		 sxs[i], operator}));*/
              batchSql.addBatch(sql, new Object[]{id, base_id, jzwlys[i], jzws[i], jcds[i], ggczs[i], dzzs[i],  dzzs_bzyq[i], dx_results[i],
             		 sxs[i], operator});
        }
        return db.doInTransaction(batchSql);
    }
    
    
    /**
	 * 获取屏蔽、等电位及接地信息
	 * @param request 
	 * @return
	 */
	public Map<String, Object> getPbddwInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");
        String sql = " select * from t_pbddw_info where id = ? ";
        Map<String, Object> map = db.queryForMap(sql, new Object[] {id});
        return map;
    }
	
	/**
     * 删除屏蔽、等电位及接地信息
     * @param request
     * @return
     */
    public int deletePbddwInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");
        BatchSql batchSql = new BatchSql();
        String sql = " update t_pbddw_info set state = 0 where id = ? ";
        batchSql.addBatch(sql, new Object[] {id});
        return db.doInTransaction(batchSql);
    }
    
    /**
	 * 查询电气系统电涌保护器列表
	 * @param request
	 * @return
	 */
	public List<?> getDqdybhqList(HttpServletRequest request) {
        String bjcwwz = req.getValue(request, "bjcwwz");//被测物位置
        String base_id = req.getValue(request, "base_id");
        List<String> paramsList = new ArrayList<String>();//查询参数
        
        int pageSize = req.getPageSize(request, "pageSize"); //分页
		String sql = "select " +
					 "	* " +
					 "from " +
					 "	t_dxdybh_info a " +
					 "where " +
					 "	state = 1 " +
					 "and base_id = ? ";
		paramsList.add(base_id);
		
		if(!"".equals(bjcwwz)){
		    sql += " and a.bjcwwz like ? ";
            paramsList.add('%' + bjcwwz + '%');
		}
		
        sql += " order by a.rec_date desc ";
        //sql = str.getSql(sql, paramsList);
        
        return db.getForList(sql, paramsList, pageSize, request);
    }
	
	/**
     * 电气电涌保护器信息保存、更新
     * @param request
     * @return
     */
    public int dqdybhqSave(HttpServletRequest request) {
        String operator = this.getOperatorId(request);
        String bjcwwz = req.getValue(request, "bjcwwz"); //被检测物位置
        String xh = req.getValue(request, "xh"); //型号
        String jdzs = req.getValue(request, "jdzs"); //接地制式
        String azsl = req.getValue(request, "azsl"); //安装数量
        String azsl_rst = req.getValue(request, "azsl_rst"); 
        String szflq = req.getValue(request, "szflq"); //所在防雷区
        String szflq_rst = req.getValue(request, "szflq_rst"); 
        String yqjjl = req.getValue(request, "yqjjl"); //与前级之间距离
        String yqjjl_rst = req.getValue(request, "yqjjl_rst"); 
        String baqk = req.getValue(request, "baqk"); //备案情况
        String baqk_rst = req.getValue(request, "baqk_rst"); 
        String ztxs = req.getValue(request, "ztxs"); //状态显示
        String ztxs_rst = req.getValue(request, "ztxs_rst"); 
        String sggy = req.getValue(request, "sggy"); //施工工艺
        String sggy_rst = req.getValue(request, "sggy_rst"); 
        String dybhsp = req.getValue(request, "dybhsp"); //电压保护水平Up
        String dybhsp_rst = req.getValue(request, "dybhsp_rst"); 
        String zdcxdy = req.getValue(request, "zdcxdy"); //最大持续工作电压(V)
        String zdcxdy_rst = req.getValue(request, "zdcxdy_rst"); 
        String cjdl = req.getValue(request, "cjdl"); //冲击电流
        String cjdl_rst = req.getValue(request, "cjdl_rst"); 
        String bczdfddl = req.getValue(request, "bczdfddl"); //标称⁄最大放电电流(kA)
        String bczdfddl_rst = req.getValue(request, "bczdfddl_rst"); 
        String ldl = req.getValue(request, "ldl"); //漏电流
        String ldl_rst = req.getValue(request, "ldl_rst"); 
        String hbbhzz = req.getValue(request, "hbbhzz"); //后备保护装置规格
        String hbbhzz_rst = req.getValue(request, "hbbhzz_rst"); 
        String xlxjm = req.getValue(request, "xlxjm"); //相、零线截面(mm²)
        String xlxjm_rst = req.getValue(request, "xlxjm_rst"); 
        String jdxjm = req.getValue(request, "jdxjm"); //接地线截面
        String jdxjm_rst = req.getValue(request, "jdxjm_rst");
        String qddy = req.getValue(request, "qddy"); //启动电压
        String qddy_rst = req.getValue(request, "qddy_rst");
        String jxcd = req.getValue(request, "jxcd"); //接线长度
        String dx_result = req.getValue(request, "dx_result");
        String jxcd_rst = req.getValue(request, "jxcd_rst");
        String result = req.getValue(request, "result");
        String zgyj = req.getValue(request, "zgyj");
        String jy = req.getValue(request, "jy");
       
        
        String method = req.getValue(request, "method");
        String sql = "";
        String base_id = req.getValue(request, "base_id");
        BatchSql batchSql = new BatchSql();
        if(method.equals("create") || method.equals("copy")){//新增or复制
             //id
             String id = this.getNValue("t_pbddw_info_sid");
             
             sql = "insert into t_dxdybh_info " +
            		 "	(id,base_id,bjcwwz,xh,jdzs, " +
            		 "	azsl,azsl_rst,szflq,szflq_rst,yqjjl, " +
            		 "	yqjjl_rst,baqk,baqk_rst,ztxs,ztxs_rst, " +
            		 "	sggy,sggy_rst,dybhsp,dybhsp_rst,zdcxdy, " +
            		 "	zdcxdy_rst,cjdl,cjdl_rst,bczdfddl,bczdfddl_rst, " +
            		 "	ldl,ldl_rst,hbbhzz,hbbhzz_rst,xlxjm, " +
            		 "	xlxjm_rst,jdxjm,jdxjm_rst,qddy,qddy_rst, " +
            		 "	jxcd,jxcd_rst,dx_result,result,zgyj, " +
            		 "	jy,state,rec_id,rec_date) " +
            		 "values " +
            		 "	(?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, 1, ?, SYSDATE()) ";
             
             batchSql.addBatch(sql, new Object[]{id,base_id,bjcwwz,xh,jdzs, azsl,azsl_rst,szflq,szflq_rst,yqjjl,
            		 yqjjl_rst,baqk,baqk_rst,ztxs,ztxs_rst,sggy,sggy_rst,dybhsp,dybhsp_rst,zdcxdy,
            		 zdcxdy_rst,cjdl,cjdl_rst,bczdfddl,bczdfddl_rst,ldl,ldl_rst,hbbhzz,hbbhzz_rst,xlxjm,
            		 xlxjm_rst,jdxjm,jdxjm_rst,qddy,qddy_rst,jxcd,jxcd_rst,dx_result,result,zgyj,
            		 jy, operator});
        }else{
        	 String id = req.getValue(request, "id");
        	 
        	 sql = "update t_dxdybh_info  " +
        			 "set " +
        			 "	bjcwwz = ?,xh = ?,jdzs = ?, " +
        			 "	azsl = ?,azsl_rst = ?,szflq = ?,szflq_rst = ?,yqjjl = ?, " +
        			 "	yqjjl_rst = ?,baqk = ?,baqk_rst = ?,ztxs = ?,ztxs_rst = ?, " +
        			 "	sggy = ?,sggy_rst = ?,dybhsp = ?,dybhsp_rst = ?,zdcxdy = ?, " +
        			 "	zdcxdy_rst = ?,cjdl = ?,cjdl_rst = ?,bczdfddl = ?,bczdfddl_rst = ?, " +
        			 "	ldl = ?,ldl_rst = ?,hbbhzz = ?,hbbhzz_rst = ?,xlxjm = ?, " +
        			 "	xlxjm_rst = ?,jdxjm = ?,jdxjm_rst = ?,qddy = ?,qddy_rst = ?, " +
        			 "	jxcd = ?,jxcd_rst = ?,dx_result = ?,result = ?,zgyj = ?, " +
        			 "	jy = ?  " +
        			 "where id = ? ";
             batchSql.addBatch(sql, new Object[] {bjcwwz,xh,jdzs, azsl,azsl_rst,szflq,szflq_rst,yqjjl,
            		 yqjjl_rst,baqk,baqk_rst,ztxs,ztxs_rst,sggy,sggy_rst,dybhsp,dybhsp_rst,zdcxdy,
            		 zdcxdy_rst,cjdl,cjdl_rst,bczdfddl,bczdfddl_rst,ldl,ldl_rst,hbbhzz,hbbhzz_rst,xlxjm,
            		 xlxjm_rst,jdxjm,jdxjm_rst,qddy,qddy_rst,jxcd,jxcd_rst,dx_result,result,zgyj,
            		 jy, id });
        }
        
        return db.doInTransaction(batchSql);
    }
    
    /**
	 * 电气电涌保护器信息
	 * @param request 
	 * @return
	 */
	public Map<String, Object> getDqdybhqInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");
        String sql = " select * from t_dxdybh_info where id = ? ";
        Map<String, Object> map = db.queryForMap(sql, new Object[] {id});
        return map;
    }
	
	/**
     * 删除电气电涌保护器信息
     * @param request
     * @return
     */
    public int deleteDqdybhqInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");
        BatchSql batchSql = new BatchSql();
        String sql = " update t_dxdybh_info set state = 0 where id = ? ";
        batchSql.addBatch(sql, new Object[] {id});
        return db.doInTransaction(batchSql);
    }
    
    /**
	 * 查询信号、天馈电涌保护器列表
	 * @param request
	 * @return
	 */
	public List<?> getTkdybhqList(HttpServletRequest request) {
        String bjcwwz = req.getValue(request, "bjcwwz");//被测物位置
        String base_id = req.getValue(request, "base_id");
        List<String> paramsList = new ArrayList<String>();//查询参数
        
        int pageSize = req.getPageSize(request, "pageSize"); //分页
		String sql = "select " +
					 "	id,base_id,bjcwwz,type,xh,DATE_FORMAT(azrq,'%Y-%m-%d') azrq,baqk,baqk_rst,"
					 + "azsl,azsl_rst,bctll,bctll_rst,crsh,crsh_rst,jdjm,"
					 + "jdjm_rst,jdxcd,jdxcd_rst,sggy,sggy_rst,dyzbb,dyzbb_rst,"
					 + "edgzdy,edgzdy_rst,dybhsp,dybhsp_rst,szflq,szflq_rst,dx_result,"
					 + "result,zgyj,jy,state,rec_id,rec_date " +
					 "from " +
					 "	t_xhtkdybhq_info a " +
					 "where " +
					 "	state = 1 " +
					 "and base_id = ? ";
		paramsList.add(base_id);
		
		if(!"".equals(bjcwwz)){
		    sql += " and a.bjcwwz like ? ";
            paramsList.add('%' + bjcwwz + '%');
		}
		
        sql += " order by a.rec_date desc ";
        //sql = str.getSql(sql, paramsList);
        
        return db.getForList(sql, paramsList, pageSize, request);
    }
	
	/**
     * 电气电涌保护器信息保存、更新
     * @param request
     * @return
     */
    public int tkdybhqSave(HttpServletRequest request) {
        String operator = this.getOperatorId(request);
        String bjcwwz = req.getValue(request, "bjcwwz"); //被检测物位置
        String xh = req.getValue(request, "xh"); //型号
        String type = req.getValue(request, "type");
        String azrq = req.getValue(request, "azrq"); //安装日期
        String azsl = req.getValue(request, "azsl"); //安装数量
        String azsl_rst = req.getValue(request, "azsl_rst"); 
        String bctll = req.getValue(request, "bctll"); //标称通流量
        String bctll_rst = req.getValue(request, "bctll_rst"); 
        String crsh = req.getValue(request, "crsh"); //插入损耗
        String crsh_rst = req.getValue(request, "crsh_rst"); 
        String jdjm = req.getValue(request, "jdjm"); //接地截面
        String jdjm_rst = req.getValue(request, "jdjm_rst");
        String jdxcd = req.getValue(request, "jdxcd"); //接地线长度
        String jdxcd_rst = req.getValue(request, "jdxcd_rst");
        String dyzbb = req.getValue(request, "dyzbb"); //电压驻波比
        String dyzbb_rst = req.getValue(request, "dyzbb_rst");
        String edgzdy = req.getValue(request, "edgzdy"); //额定工作电压
        String edgzdy_rst = req.getValue(request, "edgzdy_rst");
        String dybhsp = req.getValue(request, "dybhsp"); //电压保护水平
        String dybhsp_rst = req.getValue(request, "dybhsp_rst");
        String szflq = req.getValue(request, "szflq"); //所在防雷区
        String szflq_rst = req.getValue(request, "szflq_rst"); 
        String baqk = req.getValue(request, "baqk"); //备案情况
        String baqk_rst = req.getValue(request, "baqk_rst"); 
        String sggy = req.getValue(request, "sggy"); //施工工艺
        String sggy_rst = req.getValue(request, "sggy_rst"); 
        String jxcd_rst = req.getValue(request, "jxcd_rst");
        String result = req.getValue(request, "result");
        String dx_result = req.getValue(request, "dx_result");
        String zgyj = req.getValue(request, "zgyj");
        String jy = req.getValue(request, "jy");
        
        //日期空值置换
        if(azrq.equals("")){
        	azrq = "2000-01-01";
        }
       
        
        String method = req.getValue(request, "method");
        String sql = "";
        String base_id = req.getValue(request, "base_id");
        BatchSql batchSql = new BatchSql();
        if(method.equals("create") || method.equals("copy")){//新增or复制
             //id
             String id = this.getNValue("t_xhtkdybhq_info_sid");
             
             sql = "insert into t_xhtkdybhq_info " +
            		 "	(id,base_id,bjcwwz,type,xh, " +
            		 "	azrq,baqk,baqk_rst,azsl,azsl_rst, " +
            		 "	bctll,bctll_rst,crsh,crsh_rst,jdjm, " +
            		 "	jdjm_rst,jdxcd,jdxcd_rst,sggy,sggy_rst, " +
            		 "	dyzbb,dyzbb_rst,edgzdy,edgzdy_rst,dybhsp, " +
            		 "	dybhsp_rst,szflq,szflq_rst,dx_result,result, " +
            		 "	zgyj,jy,state,rec_id,rec_date) " +
            		 "values " +
            		 "	(?, ?, ?, ?, ?, " +
            		 "	str_to_date(?, '%Y-%m-%d'), ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, 1, ?, SYSDATE())";
             
             batchSql.addBatch(sql, new Object[]{id,base_id,bjcwwz,type,xh,azrq,baqk,baqk_rst,azsl,azsl_rst,
            		 bctll,bctll_rst,crsh,crsh_rst,jdjm,jdjm_rst,jdxcd,jdxcd_rst,sggy,sggy_rst,
            		 dyzbb,dyzbb_rst,edgzdy,edgzdy_rst,dybhsp,dybhsp_rst,szflq,szflq_rst,dx_result,result,
            		 zgyj,jy,operator});
        }else{
        	 String id = req.getValue(request, "id");
        	 
        	 sql = "update t_xhtkdybhq_info  " +
        			 "set " +
        			 "  bjcwwz = ?,type = ?,xh = ?, " +
        			 "	azrq = ?,baqk = ?,baqk_rst = ?,azsl = ?,azsl_rst = ?, " +
        			 "	bctll = ?,bctll_rst = ?,crsh = ?,crsh_rst = ?,jdjm = ?, " +
        			 "	jdjm_rst = ?,jdxcd = ?,jdxcd_rst = ?,sggy = ?,sggy_rst = ?, " +
        			 "	dyzbb = ?,dyzbb_rst = ?,edgzdy = ?,edgzdy_rst = ?,dybhsp = ?, " +
        			 "	dybhsp_rst = ?,szflq = ?,szflq_rst = ?,dx_result = ?,result = ?, " +
        			 "	zgyj = ?,jy = ? " +
        			 "where id = ? ";
             batchSql.addBatch(sql, new Object[] {bjcwwz,type,xh,azrq,baqk,baqk_rst,azsl,azsl_rst,
            		 bctll,bctll_rst,crsh,crsh_rst,jdjm,jdjm_rst,jdxcd,jdxcd_rst,sggy,sggy_rst,
            		 dyzbb,dyzbb_rst,edgzdy,edgzdy_rst,dybhsp,dybhsp_rst,szflq,szflq_rst,dx_result,result,
            		 zgyj,jy, id });
        }
        
        return db.doInTransaction(batchSql);
    }
    
    /**
	 * 天馈电涌保护器信息
	 * @param request 
	 * @return
	 */
	public Map<String, Object> getTkdybhqInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");
        String sql = "select  " +
	        		"	id,base_id,bjcwwz,type,xh, " +
	        		"	(case when DATE_FORMAT(azrq, '%Y-%m-%d')= '2000-01-01' then  '' else DATE_FORMAT(azrq, '%Y-%m-%d') end )azrq, " +
	        		"	baqk,baqk_rst,azsl,azsl_rst,bctll, " +
	        		"	bctll_rst,crsh,crsh_rst,jdjm,jdjm_rst, " +
	        		"	jdxcd,jdxcd_rst,sggy,sggy_rst,dyzbb, " +
	        		"	dyzbb_rst,edgzdy,edgzdy_rst,dybhsp, " +
	        		"	dybhsp_rst,szflq,szflq_rst,dx_result, " +
	        		"	result,zgyj,jy,state,rec_id,rec_date " +
	        		"from t_xhtkdybhq_info " +
	        		"where id = ? ";
        Map<String, Object> map = db.queryForMap(sql, new Object[] {id});
        return map;
    }
    
    /**
     * 删除天馈电涌保护器信息
     * @param request
     * @return
     */
    public int deleteTkdybhqInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");
        BatchSql batchSql = new BatchSql();
        String sql = " update t_xhtkdybhq_info set state = 0 where id = ? ";
        batchSql.addBatch(sql, new Object[] {id});
        return db.doInTransaction(batchSql);
    }
    
    /**
	 * 查询电子系统列表
	 * @param request
	 * @return
	 */
	public List<?> getDzxtList(HttpServletRequest request) {
        String jf_name = req.getValue(request, "jf_name");//机房名称
        String base_id = req.getValue(request, "base_id");
        List<String> paramsList = new ArrayList<String>();//查询参数
        
        int pageSize = req.getPageSize(request, "pageSize"); //分页
		String sql = "select a.id, a.base_id, a.rec_id, " +
						"( select b.DD_ITEM_NAME  " +
						"	  from t_ddw b  " +
						"   where b.DATA_TYPE_CODE = 10007  " +
						"		 and a.dx_result = b.DD_ITEM_CODE )dx_result, " +
						"a.jf_name, a.jf_wz, a.jfmj, " +
						"( select b.DD_ITEM_NAME  " +
						"	  from t_ddw b  " +
						"   where b.DATA_TYPE_CODE = 10023  " +
						"		 and a.jf_fldj = b.DD_ITEM_CODE ) jf_fldj, " +
						"a.szdl_fldj,  " +
						"( select b.DD_ITEM_NAME  " +
						"	  from t_ddw b  " +
						"   where b.DATA_TYPE_CODE = 10013  " +
						"		 and a.szdl_fllb = b.DD_ITEM_CODE ) szdl_fllb " +
						"from t_dzxt_info a " +
						"where a.base_id = ? " +
						"and a.state = 1 ";
		paramsList.add(base_id);
		
		if(!"".equals(jf_name)){
		    sql += " and a.jf_name like ? ";
            paramsList.add('%' + jf_name + '%');
		}
		
        sql += " order by a.rec_date desc ";
        //sql = str.getSql(sql, paramsList);
        
        return db.getForList(sql, paramsList, pageSize, request);
    }
	
	/**
     * 电子系统保存、更新
     * @param request
     * @return
     */
    public int dzxtSave(HttpServletRequest request) {
        String operator = this.getOperatorId(request);
        String jf_name = req.getValue(request, "jf_name"); //机房名称
        String jf_wz = req.getValue(request, "jf_wz"); //机房位置
        String jfmj = req.getValue(request, "jfmj"); //机房面积
        String jf_fldj = req.getValue(request, "jf_fldj"); //机房防雷等级
        String szdl_fldj = req.getValue(request, "szdl_fldj"); //所在大楼名称
        String szdl_fllb = req.getValue(request, "szdl_fllb"); //所在大楼防雷类别
        String zjl_fhqk = req.getValue(request, "zjl_fhqk"); //直击雷防护情况
        
        String kjs_wd = req.getValue(request, "kjs_wd"); //开机时机房温度(°C)
        String kjs_wd_rst = req.getValue(request, "kjs_wd_rst"); 
        String kjs_sd = req.getValue(request, "kjs_sd"); //开机时机房湿度
        String kjs_sd_rst = req.getValue(request, "kjs_sd_rst"); 
        String qzcjl = req.getValue(request, "qzcjl"); //设备里外墙、柱、窗距离
        String qzcjl_rst = req.getValue(request, "qzcjl_rst"); 
        String jfdy_fsfs = req.getValue(request, "jfdy_fsfs"); //机房电源线敷设方式
        String jfdy_fsfs_rst = req.getValue(request, "jfdy_fsfs_rst");  
        String jfdy_sx = req.getValue(request, "jfdy_sx"); //机房电源线属性
        String jfdy_sx_rst = req.getValue(request, "jfdy_sx_rst");  
        String jfxh_fsfs = req.getValue(request, "jfxh_fsfs"); //机房信号线敷设方式
        String jfxh_fsfs_rst = req.getValue(request, "jfxh_fsfs_rst");  
        String jfxh_sx = req.getValue(request, "jfxh_sx"); //机房信号线属性
        String jfxh_sx_rst = req.getValue(request, "jfxh_sx_rst");  
        String ddw_ljjg = req.getValue(request, "ddw_ljjg"); //等电位连接结构
        String ddw_ljjg_rst = req.getValue(request, "ddw_ljjg_rst");  
        String ddw_czgg = req.getValue(request, "ddw_czgg"); //总接地线规格材质
        String ddw_czgg_rst = req.getValue(request, "ddw_czgg_rst"); 
        String ddw_jdx_fscd = req.getValue(request, "ddw_jdx_fscd"); //总接地线腐蚀程度
        String ddw_jdx_fscd_rst = req.getValue(request, "ddw_jdx_fscd_rst");  
        String ddw_jdx_ljqk = req.getValue(request, "ddw_jdx_ljqk"); //总接地线连接状况
        String ddw_jdx_ljqk_rst = req.getValue(request, "ddw_jdx_ljqk_rst");  
        String ddw_hlpggcz = req.getValue(request, "ddw_hlpggcz"); //汇流排规格材质
        String ddw_hlpggcz_rst = req.getValue(request, "ddw_hlpggcz_rst");  
        String ddw_hlpfscd = req.getValue(request, "ddw_hlpfscd"); //汇流排腐蚀程度
        String ddw_hlpfscd_rst = req.getValue(request, "ddw_hlpfscd_rst");  
        String ddw_hlpljzk = req.getValue(request, "ddw_hlpljzk"); //汇流排连接状况
        String ddw_hlpljzk_rst = req.getValue(request, "ddw_hlpljzk_rst");  
        String ddw_zxggcz = req.getValue(request, "ddw_zxggcz"); //走线桥架跨接线规格材质
        String ddw_zxggcz_rst = req.getValue(request, "ddw_zxggcz_rst"); 
        String ddw_zxjdggcz = req.getValue(request, "ddw_zxjdggcz"); //走线桥架接地线规格材质
        String ddw_zxjdggcz_rst = req.getValue(request, "ddw_zxjdggcz_rst");  
        String ddw_zxjdxljzk = req.getValue(request, "ddw_zxjdxljzk"); //走线桥架接地线连接状况
        String ddw_zxjdxljzk_rst = req.getValue(request, "ddw_zxjdxljzk_rst");  
        String ddw_spjdxgg = req.getValue(request, "ddw_spjdxgg"); //设备机架接地线规格材质
        String ddw_spjdxggf_rst = req.getValue(request, "ddw_spjdxggf_rst"); 
        String ddw_sbjdxlj = req.getValue(request, "ddw_sbjdxlj"); //设备机架接地线连接状况
        String ddw_sbjdxlj_rst = req.getValue(request, "ddw_sbjdxlj_rst"); 
        String ddw_gljdxgg = req.getValue(request, "ddw_gljdxgg"); //光缆加强筋接地线规格材质
        String ddw_gljdxgg_rst = req.getValue(request, "ddw_gljdxgg_rst");  
        String ddw_gljdxlj = req.getValue(request, "ddw_gljdxlj"); //光缆加强筋接地线连接状况
        String ddw_gljdxlj_rst = req.getValue(request, "ddw_gljdxlj_rst");  
        String ddw_dhxggcz = req.getValue(request, "ddw_dhxggcz"); //电话配线架接地线规格材质
        String ddw_dhxggcz_rst = req.getValue(request, "ddw_dhxggcz_rst");  
        String ddw_dhxlj = req.getValue(request, "ddw_dhxlj"); //电话配架线接地线连接状况
        String ddw_dhxlj_rst = req.getValue(request, "ddw_dhxlj_rst");  
        String ups_dyz = req.getValue(request, "ups_dyz"); //电压值
        String ups_dyz_rst = req.getValue(request, "ups_dyz_rst");  
        String ups_pl = req.getValue(request, "ups_pl"); //频率值
        String ups_pl_rst = req.getValue(request, "ups_pl_rst"); 
        String ups_bxszl = req.getValue(request, "ups_bxszl"); //电压波形失真率
        String ups_bxszl_rst = req.getValue(request, "ups_bxszl_rst");  
        String ups_lddy = req.getValue(request, "ups_lddy"); //零-地电压
        String ups_lddy_rst = req.getValue(request, "ups_lddy_rst");  
        String ups_jdfs = req.getValue(request, "ups_jdfs"); //接地方式
        String ups_jdfs_rst = req.getValue(request, "ups_jdfs_rst");  
        String ups_jdw = req.getValue(request, "ups_jdw"); //设备表面静电电位
        String ups_jdw_rst = req.getValue(request, "ups_jdw_rst"); 
        String ups_dzl = req.getValue(request, "ups_dzl"); //静电地板表面电阻率
        String ups_dzl_rst = req.getValue(request, "ups_dzl_rst");  
        String ups_jdxgg = req.getValue(request, "ups_jdxgg"); //静电地板接地线规格材质
        String ups_jdxgg_rst = req.getValue(request, "ups_jdxgg_rst");  
        String ups_ljzk = req.getValue(request, "ups_ljzk"); //静电地板接地线连接状况
        String ups_ljzk_rst = req.getValue(request, "ups_ljzk_rst");  
        String tx_xz = req.getValue(request, "tx_xz"); //接闪器形状
        String tx_xz_rst = req.getValue(request, "tx_xz_rst");  
        String tx_ggcz = req.getValue(request, "tx_ggcz"); //接闪器规格材质
        String tx_ggcz_rst = req.getValue(request, "tx_ggcz_rst");  
        String tx_fscd = req.getValue(request, "tx_fscd"); //接闪器腐蚀程度
        String tx_fscd_rst = req.getValue(request, "tx_fscd_rst");  
        String tx_bhfw = req.getValue(request, "tx_bhfw"); //接闪器保护范围
        String tx_bhfw_rst = req.getValue(request, "tx_bhfw_rst");  
        String tx_jdxggcz = req.getValue(request, "tx_jdxggcz"); //基座接地线规格材质
        String tx_jdxggcz_rst = req.getValue(request, "tx_jdxggcz_rst"); 
        String tx_jdxfscd = req.getValue(request, "tx_jdxfscd"); //基座接地线腐蚀程度
        String tx_jdxfscd_rst = req.getValue(request, "tx_jdxfscd_rst");  
        
        String dx_result = req.getValue(request, "dx_result");
        String jxcd_rst = req.getValue(request, "jxcd_rst");
        String result = req.getValue(request, "result");
        String zgyj = req.getValue(request, "zgyj");
        String jy = req.getValue(request, "jy");
       
        String method = req.getValue(request, "method");
        String sql = "";
        String base_id = req.getValue(request, "base_id");
        BatchSql batchSql = new BatchSql();
        if(method.equals("create") || method.equals("copy")){//新增or复制
             //id
             String id = this.getNValue("t_dzxt_info_sid");
             
             sql = "insert into t_dzxt_info " +
            		 "	(id,base_id,jf_name,jf_wz,jfmj, " +
            		 "	jf_fldj,szdl_fldj,szdl_fllb,zjl_fhqk,kjs_wd, " +
            		 "	kjs_wd_rst,kjs_sd,kjs_sd_rst,qzcjl,qzcjl_rst, " +
            		 "	jfdy_fsfs,jfdy_fsfs_rst,jfdy_sx,jfdy_sx_rst,jfxh_fsfs, " +
            		 "	jfxh_fsfs_rst,jfxh_sx,jfxh_sx_rst,ddw_ljjg,ddw_ljjg_rst, " +
            		 "	ddw_czgg,ddw_czgg_rst,ddw_jdx_fscd,ddw_jdx_fscd_rst,ddw_jdx_ljqk, " +
            		 "	ddw_jdx_ljqk_rst,ddw_hlpggcz,ddw_hlpggcz_rst,ddw_hlpfscd,ddw_hlpfscd_rst, " +
            		 "	ddw_hlpljzk,ddw_hlpljzk_rst,ddw_zxggcz,ddw_zxggcz_rst,ddw_zxjdggcz, " +
            		 "	ddw_zxjdggcz_rst,ddw_zxjdxljzk,ddw_zxjdxljzk_rst,ddw_spjdxgg,ddw_spjdxggf_rst, " +
            		 "	ddw_sbjdxlj,ddw_sbjdxlj_rst,ddw_gljdxgg,ddw_gljdxgg_rst,ddw_gljdxlj, " +
            		 "	ddw_gljdxlj_rst,ddw_dhxggcz,ddw_dhxggcz_rst,ddw_dhxlj,ddw_dhxlj_rst, " +
            		 "	ups_dyz,ups_dyz_rst,ups_pl,ups_pl_rst,ups_bxszl, " +
            		 "	ups_bxszl_rst,ups_lddy,ups_lddy_rst,ups_jdfs,ups_jdfs_rst, " +
            		 "	ups_jdw,ups_jdw_rst,ups_dzl,ups_dzl_rst,ups_jdxgg, " +
            		 "	ups_jdxgg_rst,ups_ljzk,ups_ljzk_rst,tx_xz,tx_xz_rst, " +
            		 "	tx_ggcz,tx_ggcz_rst,tx_fscd,tx_fscd_rst,tx_bhfw, " +
            		 "	tx_bhfw_rst,tx_jdxggcz,tx_jdxggcz_rst,tx_jdxfscd,tx_jdxfscd_rst, " +
            		 "	dx_result,result,zgyj,jy,state, " +
            		 "	rec_id,rec_date)  " +
            		 "values " +
            		 "	(?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, ?, " +
            		 "	?, ?, ?, ?, 1, " +
            		 "	?, SYSDATE()) ";
             
             batchSql.addBatch(sql, new Object[]{id,base_id,jf_name,jf_wz,jfmj,
            		 jf_fldj,szdl_fldj,szdl_fllb,zjl_fhqk,kjs_wd,kjs_wd_rst,kjs_sd,
            		 kjs_sd_rst,qzcjl,qzcjl_rst,jfdy_fsfs,jfdy_fsfs_rst,jfdy_sx,
            		 jfdy_sx_rst,jfxh_fsfs,jfxh_fsfs_rst,jfxh_sx,jfxh_sx_rst,ddw_ljjg,
            		 ddw_ljjg_rst,ddw_czgg,ddw_czgg_rst,ddw_jdx_fscd,ddw_jdx_fscd_rst,
            		 ddw_jdx_ljqk,ddw_jdx_ljqk_rst,ddw_hlpggcz,ddw_hlpggcz_rst,ddw_hlpfscd,
            		 ddw_hlpfscd_rst,ddw_hlpljzk,ddw_hlpljzk_rst,ddw_zxggcz,ddw_zxggcz_rst,
            		 ddw_zxjdggcz,ddw_zxjdggcz_rst,ddw_zxjdxljzk,ddw_zxjdxljzk_rst,ddw_spjdxgg,
            		 ddw_spjdxggf_rst,ddw_sbjdxlj,ddw_sbjdxlj_rst,ddw_gljdxgg,ddw_gljdxgg_rst,ddw_gljdxlj,
            		 ddw_gljdxlj_rst,ddw_dhxggcz,ddw_dhxggcz_rst,ddw_dhxlj,ddw_dhxlj_rst,ups_dyz,ups_dyz_rst,ups_pl,
            		 ups_pl_rst,ups_bxszl,ups_bxszl_rst,ups_lddy,ups_lddy_rst,ups_jdfs,ups_jdfs_rst,ups_jdw,ups_jdw_rst,
            		 ups_dzl,ups_dzl_rst,ups_jdxgg,ups_jdxgg_rst,ups_ljzk,ups_ljzk_rst,tx_xz,tx_xz_rst,tx_ggcz,tx_ggcz_rst,
            		 tx_fscd,tx_fscd_rst,tx_bhfw,tx_bhfw_rst,tx_jdxggcz,tx_jdxggcz_rst,tx_jdxfscd,tx_jdxfscd_rst,dx_result,
            		 result,zgyj,jy,operator });
        }else{
        	 String id = req.getValue(request, "id");
        	 
        	 sql = "update t_dzxt_info  " +
        			 "set  " +
        			 "	jf_name  = ?, jf_wz = ?, jfmj = ?,  " +
        			 "	jf_fldj = ?, szdl_fldj = ?, szdl_fllb = ?, zjl_fhqk = ?, kjs_wd = ?,  " +
        			 "	kjs_wd_rst = ?, kjs_sd = ?, kjs_sd_rst = ?, qzcjl = ?, qzcjl_rst = ?,  " +
        			 "	jfdy_fsfs = ?, jfdy_fsfs_rst = ?, jfdy_sx = ?, jfdy_sx_rst = ?, jfxh_fsfs = ?,  " +
        			 "	jfxh_fsfs_rst = ?, jfxh_sx = ?, jfxh_sx_rst = ?, ddw_ljjg = ?, ddw_ljjg_rst = ?,  " +
        			 "	ddw_czgg = ?, ddw_czgg_rst = ?, ddw_jdx_fscd = ?, ddw_jdx_fscd_rst = ?, ddw_jdx_ljqk = ?,  " +
        			 "	ddw_jdx_ljqk_rst = ?, ddw_hlpggcz = ?, ddw_hlpggcz_rst = ?, ddw_hlpfscd = ?, ddw_hlpfscd_rst = ?,  " +
        			 "	ddw_hlpljzk = ?, ddw_hlpljzk_rst = ?, ddw_zxggcz = ?, ddw_zxggcz_rst = ?, ddw_zxjdggcz = ?,  " +
        			 "	ddw_zxjdggcz_rst = ?, ddw_zxjdxljzk = ?, ddw_zxjdxljzk_rst = ?, ddw_spjdxgg = ?, ddw_spjdxggf_rst = ?,  " +
        			 "	ddw_sbjdxlj = ?, ddw_sbjdxlj_rst = ?, ddw_gljdxgg = ?, ddw_gljdxgg_rst = ?, ddw_gljdxlj = ?,  " +
        			 "	ddw_gljdxlj_rst = ?, ddw_dhxggcz = ?, ddw_dhxggcz_rst = ?, ddw_dhxlj = ?, ddw_dhxlj_rst = ?,  " +
        			 "	ups_dyz = ?, ups_dyz_rst = ?, ups_pl = ?, ups_pl_rst = ?, ups_bxszl = ?,  " +
        			 "	ups_bxszl_rst = ?, ups_lddy = ?, ups_lddy_rst = ?, ups_jdfs = ?, ups_jdfs_rst = ?,  " +
        			 "	ups_jdw = ?, ups_jdw_rst = ?, ups_dzl = ?, ups_dzl_rst = ?, ups_jdxgg = ?,  " +
        			 "	ups_jdxgg_rst = ?, ups_ljzk = ?, ups_ljzk_rst = ?, tx_xz = ?, tx_xz_rst = ?,  " +
        			 "	tx_ggcz = ?, tx_ggcz_rst = ?, tx_fscd = ?, tx_fscd_rst = ?, tx_bhfw = ?,  " +
        			 "	tx_bhfw_rst = ?, tx_jdxggcz = ?, tx_jdxggcz_rst = ?, tx_jdxfscd = ?, tx_jdxfscd_rst = ?,  " +
        			 "	dx_result = ?, result = ?, zgyj = ?, jy = ? " +
        			 "where id = ? ";
             batchSql.addBatch(sql, new Object[] {jf_name,jf_wz,jfmj,
            		 jf_fldj,szdl_fldj,szdl_fllb,zjl_fhqk,kjs_wd,kjs_wd_rst,kjs_sd,
            		 kjs_sd_rst,qzcjl,qzcjl_rst,jfdy_fsfs,jfdy_fsfs_rst,jfdy_sx,
            		 jfdy_sx_rst,jfxh_fsfs,jfxh_fsfs_rst,jfxh_sx,jfxh_sx_rst,ddw_ljjg,
            		 ddw_ljjg_rst,ddw_czgg,ddw_czgg_rst,ddw_jdx_fscd,ddw_jdx_fscd_rst,
            		 ddw_jdx_ljqk,ddw_jdx_ljqk_rst,ddw_hlpggcz,ddw_hlpggcz_rst,ddw_hlpfscd,
            		 ddw_hlpfscd_rst,ddw_hlpljzk,ddw_hlpljzk_rst,ddw_zxggcz,ddw_zxggcz_rst,
            		 ddw_zxjdggcz,ddw_zxjdggcz_rst,ddw_zxjdxljzk,ddw_zxjdxljzk_rst,ddw_spjdxgg,
            		 ddw_spjdxggf_rst,ddw_sbjdxlj,ddw_sbjdxlj_rst,ddw_gljdxgg,ddw_gljdxgg_rst,ddw_gljdxlj,
            		 ddw_gljdxlj_rst,ddw_dhxggcz,ddw_dhxggcz_rst,ddw_dhxlj,ddw_dhxlj_rst,ups_dyz,ups_dyz_rst,ups_pl,
            		 ups_pl_rst,ups_bxszl,ups_bxszl_rst,ups_lddy,ups_lddy_rst,ups_jdfs,ups_jdfs_rst,ups_jdw,ups_jdw_rst,
            		 ups_dzl,ups_dzl_rst,ups_jdxgg,ups_jdxgg_rst,ups_ljzk,ups_ljzk_rst,tx_xz,tx_xz_rst,tx_ggcz,tx_ggcz_rst,
            		 tx_fscd,tx_fscd_rst,tx_bhfw,tx_bhfw_rst,tx_jdxggcz,tx_jdxggcz_rst,tx_jdxfscd,tx_jdxfscd_rst,dx_result,
            		 result,zgyj,jy, id  });
        }
        

        return db.doInTransaction(batchSql);
    }
    
    /**
	 * 获取电子系统信息
	 * @param request 
	 * @return
	 */
	public Map<String, Object> getDzxtInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");
        String sql = "select  " +
	        		"	* " +
	        		"from t_dzxt_info " +
	        		"where id = ? ";
        Map<String, Object> map = db.queryForMap(sql, new Object[] {id});
        return map;
    }
	
	/**
     * 删除电子系统信息
     * @param request
     * @return
     */
    public int deleteDzxtInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");
        BatchSql batchSql = new BatchSql();
        String sql = " update t_dzxt_info set state = 0 where id = ? ";
        batchSql.addBatch(sql, new Object[] {id});
        return db.doInTransaction(batchSql);
    }
    
    /**
     * 保存检测依据
     * @param request
     * @return
     */
    public int jcyjSave(HttpServletRequest request) {
        String operator = this.getOperatorId(request);
       
        String[] jyj = req.getValues(request, "jyj");//检测依据
        String id = req.getValue(request, "id");
        
        StringBuffer str = new StringBuffer();
        for (String s : jyj) {
            str.append(s);
            str.append(",");
        }
        String jcyj = str.toString();
        
        String sql ="update t_jcdw_base_info  " +
	        		"   set jyj = ? " +
	        		" where id = ? ";
        
        BatchSql batchSql = new BatchSql();
       
        batchSql.addBatch(sql, new Object[] {jcyj, id});
        
        return db.doInTransaction(batchSql);
    }
    
    /**
     * 保存整改意见
     * @param request
     * @return
     */
    public int zgyjSave(HttpServletRequest request) {
        String operator = this.getOperatorId(request);
        String remark_date = req.getValue(request, "remark_date");//日期
        String remark1 = req.getValue(request, "remark1");//规范内容
        String remark2 = req.getValue(request, "remark2");
        String remark5 = req.getValue(request, "remark5");
        String id = req.getValue(request, "id");
        String [] infos = req.getValues(request, "jyinfo");//建议信息
        
        //日期空值置换
        String sql ="update t_jcdw_base_info  " +
	        		"   set remark5 = ?, " +
	        		"   remark1 = ?, remark2 = ? " +
	        		" where id = ? ";
        
        BatchSql batchSql = new BatchSql();
       logger.debug("baocun : " + str.getSql(sql, new Object[] {remark5, remark1, remark2, id}));
        batchSql.addBatch(sql, new Object[] {remark5, remark1, remark2, id});
        //建议信息保存
        sql = " delete from t_cys_info where base_id = ? ";
        batchSql.addBatch(sql, new Object[]{id});
        for(String info : infos){
        	logger.debug("info : " + info);
        	sql = " insert into t_cys_info (base_id, info) values(?, ?) ";
        	batchSql.addBatch(sql, new Object[]{id, info});
        }
        
        return db.doInTransaction(batchSql);
    }
    
    /**
	 * 查询材料上传列表
	 * @param request
	 * @return
	 */
	public List<?> getClscList(HttpServletRequest request) {
        String cl_type = req.getValue(request, "cl_type");//材料类型
        String base_id = req.getValue(request, "base_id");
        List<String> paramsList = new ArrayList<String>();//查询参数
        
        int pageSize = req.getPageSize(request, "pageSize"); //分页
		String sql = "select  " +
					"id, base_id, cl_name,  " +
					"(case  " +
					"	when cl_type = 1 then '示意图'  " +
					"	when cl_type = 2 then '照片'  " +
					"	when cl_type = 3 then '材料' end) cl_type,  " +
					"DATE_FORMAT(sc_date,'%Y-%m-%d') sc_date, cl_dx, cl_url, rec_id, cl_name_d  " +
					"from t_clsc_info a  " +
					"where base_id = ? ";
		paramsList.add(base_id);
		
		if(!"".equals(cl_type)){
		    sql += " and a.cl_type = ? ";
            paramsList.add( cl_type );
		}
		
        sql += " order by a.sc_date desc ";
        //sql = str.getSql(sql, paramsList);
        
        return db.getForList(sql, paramsList, pageSize, request);
    }
	
	/**
     * 文件上传
     * @param request
     * @return
     */
   public int impClResult(CgjcController action, HttpServletRequest request, CommonsMultipartFile file, String fileFileName) {
        String operator = this.getUser(request).getOperatorId();
        String base_id = req.getValue(request, "base_id");
        String cl_type = req.getValue(request, "cl_type");//材料类型
        String clDx = Integer.toString((int)file.getSize() / 1024) + " KB";//材料大小
        // 上传文件存档
        //String save_dir = request.getRealPath("/WEB-INF/jsp/qxfl") + "/upload/clsc/";1
        String save_dir = request.getRealPath("/showphoto/");
        FileHelper fileHelper = new FileHelper();
        String cl_name = fileHelper.getToFileName(fileFileName);//后追加时间
        String fileName = save_dir + cl_name;
        String cl_url = save_dir + cl_name;
        fileHelper.copyFile(file, fileName);
        
        BatchSql batchSql = new BatchSql();
        
        String sql = "insert into t_clsc_info " +
	        		"	(id, base_id, cl_name, cl_type, sc_date, cl_dx, cl_url, rec_id, cl_name_d) " +
	        		"values " +
	        		"	(nextval('t_clsc_info_sid'), ?, ?, ?, SYSDATE(), ?, ?, ?, ?) ";
        batchSql.addBatch(sql, new Object[]{base_id, fileFileName, cl_type, clDx, cl_url, operator, cl_name});
        
        return db.doInTransaction(batchSql);
    }
   
   /**
    * 删除材料上传信息
    * @param request
    * @return
    */
   public int deleteClscInfo(HttpServletRequest request) {
       String id = req.getValue(request, "id");
       BatchSql batchSql = new BatchSql();
       String sql = " delete from t_clsc_info where id = ? ";
       batchSql.addBatch(sql, new Object[] {id});
       return db.doInTransaction(batchSql);
   }
   
   /**
  	 * 查询发票信息列表
  	 * @param request
  	 * @return
  	 */
  	public List<?> getBillInfoList(HttpServletRequest request) {
          String bill_id = req.getValue(request, "bill_id");//发票编号
          String base_id = req.getValue(request, "base_id");
          List<String> paramsList = new ArrayList<String>();//查询参数
          
          int pageSize = req.getPageSize(request, "pageSize"); //分页
  		String sql = "select id, base_id, remark1, remark2, remark3, remark4, remark5, remark6, rec_id " +
	  				"from t_bill_info a " +
	  				"where a.state = 1 " +
	  				"and a.base_id = ? ";
  		paramsList.add(base_id);
  		
  		if(!"".equals(bill_id)){
  		    sql += " and a.bill_id = ? ";
              paramsList.add( bill_id );
  		}
  		
          sql += " order by a.rec_date desc ";
          //sql = str.getSql(sql, paramsList);
          
          return db.getForList(sql, paramsList, pageSize, request);
      }
  	
  	/**
     * 发票信息保存、更新
     * @param request
     * @return
     */
    public int billInfoSave(HttpServletRequest request) {
        String operator = this.getOperatorId(request);
        String method = req.getValue(request, "method");
        
        String remark1 = req.getValue(request, "remark1"); 
        String remark2 = req.getValue(request, "remark2"); 
        String remark3 = req.getValue(request, "remark3"); 
        String remark4 = req.getValue(request, "remark4"); 
        String remark5 = req.getValue(request, "remark5"); 
        String remark6 = req.getValue(request, "remark6"); 
        
        String bill_remark = req.getValue(request, "bill_remark");//备注
        String sql = "";
        String base_id = req.getValue(request, "base_id");
        BatchSql batchSql = new BatchSql();
        if(method.equals("create")){
             //id
             String id = this.getNValue("t_bill_info_sid");
             
             sql = "insert into t_bill_info( " +
            		 "	id, base_id, " +
            		 "	remark1, " +
            		 "	remark2, " +
            		 "	remark3, " +
            		 "	remark4, remark5, remark6, " +
            		 "	state, " +
            		 "	rec_id, " +
            		 "	rec_date, bill_remark " +
            		 ") " +
            		 "values " +
            		 "	(?, ?, ?, ?, ?, ?, ?, ?, 1, ?, SYSDATE(), ?) ";
             logger.debug("insert sql : " + str.getSql(sql,  new Object[]{id, base_id, remark1, remark2, remark3, remark4, remark5, remark6, operator,bill_remark }));
             batchSql.addBatch(sql, new Object[]{id, base_id, remark1, remark2, remark3, remark4, remark5, remark6, operator,bill_remark });
        }else{
        	 String id = req.getValue(request, "id");
        	 
        	 sql = "update t_bill_info " +
        		   "set remark1 = ?, remark2 = ?, remark3 = ?, remark4 = ?, remark5 = ?, remark6 = ?, bill_remark = ?, update_id = ?, update_date = SYSDATE() " +
        		   "where " +
        		   "	id = ? ";
        	 logger.debug("=======" + str.getSql(sql, new Object[] {remark1, remark2, remark3, remark4, remark5, remark6, bill_remark, operator, id }));
             batchSql.addBatch(sql, new Object[] {remark1, remark2, remark3, remark4, remark5, remark6, bill_remark, operator, id });
        }
        

        return db.doInTransaction(batchSql);
    }
    
    /**
	 * 获取发票信息
	 * @param request 
	 * @return
	 */
	public Map<String, Object> getBillInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");
        String sql = " select * from t_bill_info where id = ? ";
        Map<String, Object> map = db.queryForMap(sql, new Object[] {id});
        return map;
    }
	
	/**
    * 删除发票信息
    * @param request
    * @return
    */
   public int deleteBillInfo(HttpServletRequest request) {
       String id = req.getValue(request, "id");
       BatchSql batchSql = new BatchSql();
       String sql = " update t_bill_info set state = 0 where id = ? ";
       batchSql.addBatch(sql, new Object[] {id});
       return db.doInTransaction(batchSql);
   }
   
   /**
	 * 查询待提交列表
	 * @param request
	 * @return
	 */
	public List<?> getDtjList(HttpServletRequest request) {
	    String year = req.getValue(request, "year");//年度
       String bg_id = req.getValue(request, "bg_id");//报告编号
       String dw_name = req.getValue(request, "dw_name");//单位名称
       List<String> paramsList = new ArrayList<String>();//查询参数
       String operator = this.getUser(request).getOperatorId();
       
       int pageSize = req.getPageSize(request, "pageSize"); //分页
		String sql = "select " +
					 "	a.id, " +
					 "	a.dw_name, " +
					 "	a.dw_addr, " +
					 "	a.lx_bm, " +
					 "	a.bm_phone, " +
					 "	a.lxr, " +
					 "	a.lxr_phone, " +
					 "	a.lj_date, " +
					 "	a.yb, " +
					 "	a.hy_type, " +
					 "	a.dlhj, " +
					 "	a.jd, " +
					 "	a.wd, " +
					 "	a.xzqy, " +
					 "	a.jc_group, " +
					 "	a.ydy_num, " +
					 "	a.da_id, " +
					 "	a.bg_id, " +
					 "	a. year, " +
					 "	a.rec_id, " +
					 "	a.rec_date, " +
					 "	( " +
       			 "		case " +
       			 "		when DATE_FORMAT(jc_date, '%Y-%m-%d')= '2000-01-01' then " +
       			 "			'' " +
       			 "		else " +
       			 "			DATE_FORMAT(jc_date, '%Y-%m-%d') " +
       			 "		end " +
       			 "	) jc_date, ( select remark from t_th_info c where a.id = c.base_id limit 1) th_remark, " +
       			 "	( " +
       			 "		case " +
       			 "		when DATE_FORMAT(yx_date, '%Y-%m-%d')= '2000-01-01' then " +
       			 "			'' " +
       			 "		else " +
       			 "			DATE_FORMAT(yx_date, '%Y-%m-%d') " +
       			 "		end " +
       			 "	) yx_date, b.lc_id " +
					 "from " +
					 "	t_jcdw_base_info as a, t_lc_info b " +
					 "where a.id = b.info_id " +
					 " and	a.rec_id = ? ";
		 paramsList.add(operator);
		 
		 //控制流程展示
		 sql += " and b.lc_id in (1, 6) ";
		
		if(!"".equals(year)){
		    sql += " and a.year = ? ";
            paramsList.add(year);
		}
		if(!"".equals(bg_id)){
		    sql += " and a.bg_id = ? ";
           paramsList.add(bg_id);
		}
		if(!"".equals(dw_name)){
		    sql += " and a.dw_name = ? ";
           paramsList.add(dw_name);
		}
       sql += " order by a.rec_date desc ";
       //sql = str.getSql(sql, paramsList);
       
       return db.getForList(sql, paramsList, pageSize, request);
   }
	
	/**
     * 提交报告信息
     * @param request
     * @return
     */
    public int tjBgInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");//info_id
        String operator = this.getUser(request).getOperatorId();
        BatchSql batchSql = new BatchSql();
        String sql = " update t_lc_info set lc_id = 2 where info_id = ? ";
        batchSql.addBatch(sql, new Object[] {id});
        
        sql = " update t_jcdw_base_info set jcr = ? where id = ? ";
        batchSql.addBatch(sql, new Object[] {operator, id});
        
        return db.doInTransaction(batchSql);
    }
    
    /**
	 * 查询待校核列表
	 * @param request
	 * @return
	 */
	public List<?> getDjhList(HttpServletRequest request) {
	    String year = req.getValue(request, "year");//年度
       String bg_id = req.getValue(request, "bg_id");//报告编号
       String dw_name = req.getValue(request, "dw_name");//单位名称
       List<String> paramsList = new ArrayList<String>();//查询参数
       String operator = this.getUser(request).getOperatorId();
       
       int pageSize = req.getPageSize(request, "pageSize"); //分页
		String sql = "select " +
					 "	a.id, " +
					 "	a.dw_name, " +
					 "	a.dw_addr, " +
					 "	a.lx_bm, " +
					 "	a.bm_phone, " +
					 "	a.lxr, " +
					 "	a.lxr_phone, " +
					 "	a.lj_date, " +
					 "	a.yb, " +
					 "	a.hy_type, " +
					 "	a.dlhj, " +
					 "	a.jd, " +
					 "	a.wd, " +
					 "	a.xzqy, " +
					 "	a.jc_group, " +
					 "	a.ydy_num, " +
					 "	a.da_id, " +
					 "	a.bg_id, " +
					 "	a. year, " +
					 "	a.rec_id, " +
					 "	a.rec_date, ( select remark from t_th_info c where a.id = c.base_id limit 1) th_remark, " +
					 "	( " +
       			 "		case " +
       			 "		when DATE_FORMAT(jc_date, '%Y-%m-%d')= '2000-01-01' then " +
       			 "			'' " +
       			 "		else " +
       			 "			DATE_FORMAT(jc_date, '%Y-%m-%d') " +
       			 "		end " +
       			 "	) jc_date, " +
       			 "	( " +
       			 "		case " +
       			 "		when DATE_FORMAT(yx_date, '%Y-%m-%d')= '2000-01-01' then " +
       			 "			'' " +
       			 "		else " +
       			 "			DATE_FORMAT(yx_date, '%Y-%m-%d') " +
       			 "		end " +
       			 "	) yx_date, b.lc_id " +
					 "from " +
					 "	t_jcdw_base_info as a, t_lc_info b, t_user c " +
					 "where a.id = b.info_id " +
					 " and	a.rec_id = c.operator_id ";
		 
		 //控制流程
		 //部门权限控制
		 sql += " and b.lc_id in (2, 7) and c.org_id = ? ";
		 paramsList.add(this.getUser(request).getOrgId());
		
		if(!"".equals(year)){
		    sql += " and a.year = ? ";
            paramsList.add(year);
		}
		if(!"".equals(bg_id)){
		    sql += " and a.bg_id = ? ";
           paramsList.add(bg_id);
		}
		if(!"".equals(dw_name)){
		    sql += " and a.dw_name = ? ";
           paramsList.add(dw_name);
		}
       sql += " order by a.rec_date desc ";
       //sql = str.getSql(sql, paramsList);
       logger.debug("ceshi : " + str.getSql(sql, paramsList.toArray()));
       
       return db.getForList(sql, paramsList, pageSize, request);
   }
	
	/**
     * 校核报告信息
     * @param request
     * @return
     */
    public int jhBgInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");//info_id
        String operator = this.getUser(request).getOperatorId();
        BatchSql batchSql = new BatchSql();
        String sql = " update t_lc_info set lc_id = 3 where info_id = ? ";
        batchSql.addBatch(sql, new Object[] {id});
        
        sql = " update t_jcdw_base_info set jhr = ? where id = ? ";
        batchSql.addBatch(sql, new Object[] {operator, id});
        
        return db.doInTransaction(batchSql);
    }
    
    /**
     * 退回报告信息
     * @param request
     * @return
     */
    public int thBgInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");//info_id
        String operator = this.getUser(request).getOperatorId();
        BatchSql batchSql = new BatchSql();
        String sql = " update t_lc_info set lc_id = 6 where info_id = ? ";
        batchSql.addBatch(sql, new Object[] {id});
        logger.debug("thBgInfo : " + str.getSql(sql, new Object[] {id}));
        sql = " update t_jcdw_base_info set jhr = ? where id = ? ";
        batchSql.addBatch(sql, new Object[] {operator, id});
        
        return db.doInTransaction(batchSql);
    }
    
    /**
	 * 查询待签发列表
	 * @param request
	 * @return
	 */
	public List<?> getDqfList(HttpServletRequest request) {
	    String year = req.getValue(request, "year");//年度
       String bg_id = req.getValue(request, "bg_id");//报告编号
       String dw_name = req.getValue(request, "dw_name");//单位名称
       List<String> paramsList = new ArrayList<String>();//查询参数
       String operator = this.getUser(request).getOperatorId();
       
       int pageSize = req.getPageSize(request, "pageSize"); //分页
		String sql = "select " +
					 "	a.id, " +
					 "	a.dw_name, " +
					 "	a.dw_addr, " +
					 "	a.lx_bm, " +
					 "	a.bm_phone, " +
					 "	a.lxr, " +
					 "	a.lxr_phone, " +
					 "	a.lj_date, " +
					 "	a.yb, " +
					 "	a.hy_type, " +
					 "	a.dlhj, " +
					 "	a.jd, " +
					 "	a.wd, " +
					 "	a.xzqy, " +
					 "	a.jc_group, " +
					 "	a.ydy_num, " +
					 "	a.da_id, " +
					 "	a.bg_id, " +
					 "	a. year, " +
					 "	a.rec_id, " +
					 "	a.rec_date, " +
					 "	( " +
       			 "		case " +
       			 "		when DATE_FORMAT(jc_date, '%Y-%m-%d')= '2000-01-01' then " +
       			 "			'' " +
       			 "		else " +
       			 "			DATE_FORMAT(jc_date, '%Y-%m-%d') " +
       			 "		end " +
       			 "	) jc_date, ( select remark from t_th_info c where a.id = c.base_id limit 1) th_remark, " +
       			 "	( " +
       			 "		case " +
       			 "		when DATE_FORMAT(yx_date, '%Y-%m-%d')= '2000-01-01' then " +
       			 "			'' " +
       			 "		else " +
       			 "			DATE_FORMAT(yx_date, '%Y-%m-%d') " +
       			 "		end " +
       			 "	) yx_date, b.lc_id " +
					 "from " +
					 "	t_jcdw_base_info as a, t_lc_info b, t_user c " +
					 "where a.id = b.info_id and a.rec_id = c.operator_id ";
		 
		 //控制流程
		 sql += " and b.lc_id = 3 ";
		
		if(!"".equals(year)){
		    sql += " and a.year = ? ";
            paramsList.add(year);
		}
		if(!"".equals(bg_id)){
		    sql += " and a.bg_id = ? ";
           paramsList.add(bg_id);
		}
		if(!"".equals(dw_name)){
		    sql += " and a.dw_name = ? ";
           paramsList.add(dw_name);
		}
		//总经理可签发所有工单，若为可签发组织的部门长，则可签发本部门内的工单
		if(this.getUser(request).getOrgId().equals(GLOBA_KQF_ORGID)){//可签发组织
			sql += " and c.org_id = ? ";
			paramsList.add(GLOBA_KQF_ORGID);
		}
       sql += " order by a.rec_date desc ";
       //sql = str.getSql(sql, paramsList);
       
       return db.getForList(sql, paramsList, pageSize, request);
   }
	
	/**
     * 签发报告信息
     * @param request
     * @return
     */
    public int qfBgInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");//info_id
        String operator = this.getUser(request).getOperatorId();
        BatchSql batchSql = new BatchSql();
        String sql = " update t_lc_info set lc_id = 4 where info_id = ? ";
        batchSql.addBatch(sql, new Object[] {id});
        
        sql = " update t_jcdw_base_info set jfr = ? where id = ? ";
        batchSql.addBatch(sql, new Object[] {operator, id});
        
        return db.doInTransaction(batchSql);
    }
    
    /**
     * 签发退回报告信息
     * @param request
     * @return
     */
    public int qfThBgInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");//info_id
        String operator = this.getUser(request).getOperatorId();
        BatchSql batchSql = new BatchSql();
        String sql = " update t_lc_info set lc_id = 7 where info_id = ? ";
        batchSql.addBatch(sql, new Object[] {id});
        
        sql = " update t_jcdw_base_info set jfr = ? where id = ? ";
        batchSql.addBatch(sql, new Object[] {operator, id});
        
        return db.doInTransaction(batchSql);
    }
    
    
    /**
     * 保存退回说明信息
     * @param request
     * @return
     */
    public int saveThInfo(HttpServletRequest request) {
        String id = req.getValue(request, "id");//info_id
        String remark = req.getValue(request, "remark");
        String operator = this.getUser(request).getOperatorId();
        BatchSql batchSql = new BatchSql();
        String sql = " insert into t_th_info(base_id, remark, rec_date, rec_id) values(?, ?, SYSDATE(), ?) ";
        batchSql.addBatch(sql, new Object[] {id, remark, operator});
        logger.debug("saveThInfo : " + str.getSql(sql, new Object[] {id, remark, operator}));
        
        return db.doInTransaction(batchSql);
    }
    
    /**
	 * 查询待打印列表
	 * @param request
	 * @return
	 */
	public List<?> getDdyList(HttpServletRequest request) {
	    String year = req.getValue(request, "year");//年度
       String bg_id = req.getValue(request, "bg_id");//报告编号
       String dw_name = req.getValue(request, "dw_name");//单位名称
       List<String> paramsList = new ArrayList<String>();//查询参数
       String operator = this.getUser(request).getOperatorId();
       
       int pageSize = req.getPageSize(request, "pageSize"); //分页
		String sql = "select " +
					 "	a.id, " +
					 "	a.dw_name, " +
					 "	a.dw_addr, " +
					 "	a.lx_bm, " +
					 "	a.bm_phone, " +
					 "	a.lxr, " +
					 "	a.lxr_phone, " +
					 "	a.lj_date, " +
					 "	a.yb, " +
					 "	a.hy_type, " +
					 "	a.dlhj, " +
					 "	a.jd, " +
					 "	a.wd, " +
					 "	a.xzqy, " +
					 "	a.jc_group, " +
					 "	a.ydy_num, " +
					 "	a.da_id, " +
					 "	a.bg_id, " +
					 "	a. year, " +
					 "	a.rec_id, " +
					 "	a.rec_date, " +
					 "	( " +
       			 "		case " +
       			 "		when DATE_FORMAT(jc_date, '%Y-%m-%d')= '2000-01-01' then " +
       			 "			'' " +
       			 "		else " +
       			 "			DATE_FORMAT(jc_date, '%Y-%m-%d') " +
       			 "		end " +
       			 "	) jc_date, " +
       			 "	( " +
       			 "		case " +
       			 "		when DATE_FORMAT(yx_date, '%Y-%m-%d')= '2000-01-01' then " +
       			 "			'' " +
       			 "		else " +
       			 "			DATE_FORMAT(yx_date, '%Y-%m-%d') " +
       			 "		end " +
       			 "	) yx_date, b.lc_id " +
					 "from " +
					 "	t_jcdw_base_info as a, t_lc_info b " +
					 "where a.id = b.info_id ";
		 
		 //控制流程
		 sql += " and b.lc_id = 4 ";
		
		if(!"".equals(year)){
		    sql += " and a.year = ? ";
            paramsList.add(year);
		}
		if(!"".equals(bg_id)){
		    sql += " and a.bg_id = ? ";
           paramsList.add(bg_id);
		}
		if(!"".equals(dw_name)){
		    sql += " and a.dw_name = ? ";
           paramsList.add(dw_name);
		}
       sql += " order by a.rec_date desc ";
       //sql = str.getSql(sql, paramsList);
       
       return db.getForList(sql, paramsList, pageSize, request);
   }
	
	
	/**
	 * 获取退回说明信息
	 * @param request
	 * @return
	 */
	public List<?> getThList(HttpServletRequest request) {
       String baseId = req.getValue(request, "baseId");//基本信息id
       List<String> paramsList = new ArrayList<String>();//查询参数
       String sql = " select remark from t_th_info  where base_id = ? order by rec_date ";
		logger.debug("sql : " + str.getSql(sql, new Object[]{baseId}));
       return db.queryForList(str.getSql(sql, new Object[]{baseId}));
   }
	
	/**
	 * 获取基本信息
	 * @param request 
	 * @return
	 */
	public Map<String, Object> getDdyBaseInfo(HttpServletRequest request) {
        String id = req.getValue(request, "infoId");
        String sql = "select  " +
	        		"	id,dw_name,dw_addr,lx_bm,bm_phone, " +
	        		"	lxr,lxr_phone,lj_date,yb, " +
	        		"	(select b.DD_ITEM_NAME from t_ddw b where b.DATA_TYPE_CODE = 10002 and b.DD_ITEM_CODE = a.hy_type) hy_type, " +
	        		"	dlhj,jd,wd,xzqy,jc_group,ydy_num, " +
	        		"	da_id,bg_id,year,rec_id,rec_date,jc_sx, " +
	        		"	dw_fr,jc_way,nzddl,npjmd, " +
	        		"	(select b.DD_ITEM_NAME from t_ddw b where b.DATA_TYPE_CODE = 10005 and b.DD_ITEM_CODE = a.weather) weather, " +
	        		"	(case when jc_yj = 1 then '符合' when jc_yj = 2 then '不符合' when jc_yj = 3 then '/' else '' end) jc_yj, bg_gc,remark,yqsb_info, " +
	        		"	(select name from t_user b where b.operator_id = a. jcr) jcr, " +
	        		"	(select qm_name_d from t_user b where b.operator_id = a. jcr) jcr_qm, " +
	        		"	(select name from t_user b where b.operator_id = a. jhr) jhr, " +
	        		"	(select qm_name_d from t_user b where b.operator_id = a. jhr) jhr_qm, " +
	        		"	(select name from t_user b where b.operator_id = a. jfr) jfr, " +
	        		"	(select qm_name_d from t_user b where b.operator_id = a. jfr) jfr_qm, " +
	        		 "	( " +
        			 "		case " +
        			 "		when DATE_FORMAT(remark4, '%Y-%m-%d')= '2000-01-01' then " +
        			 "			'' " +
        			 "		else " +
        			 "			DATE_FORMAT(remark4, '%Y-%m-%d') " +
        			 "		end " +
        			 "	) remark4, " +
	        		"	( " +
	       			 "		case " +
	       			 "		when DATE_FORMAT(jc_date, '%Y-%m-%d')= '2000-01-01' then " +
	       			 "			'' " +
	       			 "		else " +
	       			 "			DATE_FORMAT(jc_date, '%Y-%m-%d') " +
	       			 "		end " +
	       			 "	) jc_date, (case when a.jc_sx = 1 then '首检' when a.jc_sx = 2 then '年检' else '' end) jc_sx_name, " +
	        		"	(case when a.jc_zq = 1 then '一年' when a.jc_zq = 2 then '半年' end)jc_zq, " +
	        		"	update_time,DATE_FORMAT(a.yx_date, '%Y-%m-%d') yx_date,jyj,zgyj_date,zgyj,jy, remark1, remark2, remark3, remark5, DATE_FORMAT(remark_date,'%Y-%m-%d') remark_date  " +
	        		"from t_jcdw_base_info a " +
	        		"where id = ? ";
        Map<String, Object> map = db.queryForMap(sql, new Object[] {id});
        return map;
    }
	
	public Map<String, Object> getDdyBaseInfo2(HttpServletRequest request) {
        String id = req.getValue(request, "infoId");
        String sql = "select  " +
	        		"	id,dw_name,dw_addr,lx_bm,bm_phone, " +
	        		"	lxr,lxr_phone,lj_date,yb, " +
	        		"	(select b.DD_ITEM_NAME from t_ddw b where b.DATA_TYPE_CODE = 10002 and b.DD_ITEM_CODE = a.hy_type) hy_type, " +
	        		"	dlhj,jd,wd,xzqy,jc_group,ydy_num, " +
	        		"	da_id,bg_id,year,rec_id,rec_date,jc_sx, " +
	        		"	dw_fr,jc_way,nzddl,npjmd, " +
	        		"	(select b.DD_ITEM_NAME from t_ddw b where b.DATA_TYPE_CODE = 10005 and b.DD_ITEM_CODE = a.weather) weather, " +
	        		"	(case when jc_yj = 1 then '符合' when jc_yj = 2 then '不符合' when jc_yj = 3 then '/' else '' end) jc_yj, bg_gc,remark,yqsb_info, " +
	        		"	(select name from t_user b where b.operator_id = a. jcr) jcr, " +
	        		"	(select qm_name_d from t_user b where b.operator_id = a. jcr) jcr_qm, " +
	        		"	(select name from t_user b where b.operator_id = a. jhr) jhr, " +
	        		"	(select qm_name_d from t_user b where b.operator_id = a. jhr) jhr_qm, " +
	        		"	(select name from t_user b where b.operator_id = a. jfr) jfr, " +
	        		"	(select qm_name_d from t_user b where b.operator_id = a. jfr) jfr_qm, " +
	        		 "	( " +
        			 "		case " +
        			 "		when DATE_FORMAT(remark4, '%Y-%m-%d')= '2000-01-01' then " +
        			 "			'' " +
        			 "		else " +
        			 "			DATE_FORMAT(remark4, '%Y年%m月%d日') " +
        			 "		end " +
        			 "	) remark4, " +
	        		"	( " +
	       			 "		case " +
	       			 "		when DATE_FORMAT(jc_date, '%Y-%m-%d')= '2000-01-01' then " +
	       			 "			'' " +
	       			 "		else " +
	       			 "			DATE_FORMAT(jc_date, '%Y年%m月%d日') " +
	       			 "		end " +
	       			 "	) jc_date, (case when a.jc_sx = 1 then '首检' when a.jc_sx = 2 then '年检' else '' end) jc_sx_name, " +
	        		"	(case when a.jc_zq = 1 then '一年' when a.jc_zq = 2 then '半年' end)jc_zq, " +
	        		"	update_time,DATE_FORMAT(a.yx_date, '%Y年%m月%d日') yx_date,jyj,zgyj_date,zgyj,jy, remark1, remark2, remark3, remark5, DATE_FORMAT(remark_date,'%Y-%m-%d') remark_date  " +
	        		"from t_jcdw_base_info a " +
	        		"where id = ? ";
        Map<String, Object> map = db.queryForMap(sql, new Object[] {id});
        return map;
    }
	
	public Map getOrgJcdwInfo(HttpServletRequest request){
		String id = req.getValue(request, "infoId");
		String sql = "SELECT " +
					"   a.id, " +
					"	t.sl_phone, " +
					"	t.org_jcdw, " +
					"	t.org_addr, " +
					"	t.org_postal, " +
					"	t.org_phone " +
					"FROM " +
					"	t_jcdw_base_info a " +
					"LEFT JOIN ( " +
					"	SELECT " +
					"		c.sl_phone, " +
					"		c.org_jcdw, " +
					"		c.org_addr, " +
					"		c.org_postal, " +
					"		c.org_phone, " +
					"	  b.operator_id " +
					"	FROM " +
					"		t_user b, " +
					"		t_organization c " +
					"	WHERE " +
					"		b.org_id = c.org_id " +
					") t ON a.rec_id = t.operator_id " +
					"where id = ? ";
		return db.queryForMap(sql, new Object[] {id});
	}
	
	/**
	 * 获取防直击雷 屏蔽、等电位及接地信息
	 * 单条防直接雷信息（A）对应多条等电位信息（B）
	 * 前台展示需求：A1 B11 B12 ...  A2  B21 B22...
	 * @param request 
	 * @return
	 */
	public List<Map<String, Object>> getFzjlPbddwInfo(HttpServletRequest request) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        String baseId = req.getValue(request, "infoId");
        String sql = "select GROUP_CONCAT(id) from t_fzjl_info where base_id = ? and state = 1 ";
        
        String fzjlIds = db.queryForString(str.getSql(sql, new Object[] {baseId}));
        String[] ids = fzjlIds.split(",");
        for(String id : ids){
        	Map<String, Object> map = new HashMap<String, Object>();
        	sql = "select id,base_id,bbhw_name, " +
        			"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10013 and b.DD_ITEM_CODE = a.fl_type) fl_type,ckg,sjq_xz, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.sjq_xz_rst) sjq_xz_rst,sjq_gd, " +
        			"	case when a.sjq_xz_rst = 1 then '√' when a.sjq_xz_rst = 2 then '×' else '/' end  sjq_xz_rst,sjq_gd, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.sjq_gd_rst) sjq_gd_rst, " +
        			"	case when a.sjq_gd_rst = 1 then '√' when a.sjq_gd_rst = 2 then '×'  else '/' end  sjq_gd_rst, " +
        			"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10008 and b.DD_ITEM_CODE = a.sjq_fsfs) sjq_fsfs, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.sjq_fsfs_rst) sjq_fsfs_rst, " +
        			"	case when a.sjq_fsfs_rst = 1 then '√' when a.sjq_fsfs_rst = 2 then '×'  else '/' end  sjq_fsfs_rst, " +
        			"	sjq_ggcz, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.sjq_ggcz_rst) sjq_ggcz_rst, " +
        			"	case when a.sjq_ggcz_rst = 1 then '√' when a.sjq_ggcz_rst = 2 then '×' else '/'  end  sjq_ggcz_rst, " +
        			"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10009 and b.DD_ITEM_CODE = a.sjq_fscd) sjq_fscd, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.sjq_fscd_rst) sjq_fscd_rst, " +
        			"	case when a.sjq_fscd_rst = 1 then '√' when a.sjq_fscd_rst = 2 then '×'else '/' end    sjq_fscd_rst, " +
        			"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10014 and b.DD_ITEM_CODE = a.sjq_gdxz) sjq_gdxz, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.sjq_gdxz_rst) sjq_gdxz_rst,sjq_hjcd, " +
        			"	case when a.sjq_gdxz_rst = 1 then '√' when a.sjq_gdxz_rst = 2 then '×'else '/' end    sjq_gdxz_rst,sjq_hjcd, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.sjq_hjcd_rst) sjq_hjcd_rst,  " +
        			"	case when a.sjq_hjcd_rst = 1 then '√' when a.sjq_hjcd_rst = 2 then '×'  else '/'  end  sjq_hjcd_rst, " +
        			"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10015 and b.DD_ITEM_CODE = a.sjq_bhfw) sjq_bhfw, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.sjq_bhfw_rst) sjq_bhfw_rst,sjq_wg, " +
        			"	case when a.sjq_bhfw_rst = 1 then '√' when a.sjq_bhfw_rst = 2 then '×'  else '/'  end  sjq_bhfw_rst,sjq_wg, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.sjq_wg_rst) sjq_wg_rst,sjq_dzjjj, " +
        			"	case when a.sjq_wg_rst = 1 then '√' when a.sjq_wg_rst = 2 then '×' else '/'  end  sjq_wg_rst,sjq_dzjjj, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.sjq_dzjjj_rst) sjq_dzjjj_rst, " +
        			"	case when a.sjq_dzjjj_rst = 1 then '√' when a.sjq_dzjjj_rst = 2 then '×'  else '/'  end  sjq_dzjjj_rst, " +
        			"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10008 and b.DD_ITEM_CODE = a.yxx_fsfs) yxx_fsfs,yxx_sl, " +
        			"	case when a.yxx_fsfs_rst = 1 then '√' when a.yxx_fsfs_rst = 2 then '×'  else '/'  end  yxx_fsfs_rst, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.yxx_sl_rst) yxx_sl_rst,yxx_jj, " +
        			"	case when a.yxx_sl_rst = 1 then '√' when a.yxx_sl_rst = 2 then '×'  else '/' end  yxx_sl_rst,yxx_jj, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.yxx_jj_rst) yxx_jj_rst, " +
        			"	case when a.yxx_jj_rst = 1 then '√' when a.yxx_jj_rst = 2 then '×' else '/'  end  yxx_jj_rst, " +
        			"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10009 and b.DD_ITEM_CODE = a.yxx_fscd) yxx_fscd, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.yxx_fscd_rst) yxx_fscd_rst, " +
        			"	case when a.yxx_fscd_rst = 1 then '√' when a.yxx_fscd_rst = 2 then '×' else '/'  end  yxx_fscd_rst, " +
        			"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10014 and b.DD_ITEM_CODE = a.yxx_gdzk) yxx_gdzk, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.yxx_gdzk_rst) yxx_gdzk_rst,yxx_hjcd, " +
        			"	case when a.yxx_gdzk_rst = 1 then '√' when a.yxx_gdzk_rst = 2 then '×' else '/'  end  yxx_gdzk_rst,yxx_hjcd, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.yxx_hjcd_rst) yxx_hjcd_rst, " +
        			"	case when a.yxx_hjcd_rst = 1 then '√' when a.yxx_hjcd_rst = 2 then '×' else '/'  end  yxx_hjcd_rst, " +
        			"	yxx_ggcz, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.yxx_ggcz_rst) yxx_ggcz_rst, " +
        			"	case when a.yxx_ggcz_rst = 1 then '√' when a.yxx_ggcz_rst = 2 then '×' else '/'  end  yxx_ggcz_rst, " +
        			"	yxx_mfzjjj, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.yxx_mfzjjj_rst) yxx_mfzjjj_rst,jdx_ggcz, " +
        			"	case when a.yxx_mfzjjj_rst = 1 then '√' when a.yxx_mfzjjj_rst = 2 then '×' else '/'  end  yxx_mfzjjj_rst,jdx_ggcz, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.jdx_ggcz_rst) jdx_ggcz_rst, " +
        			"	case when a.jdx_ggcz_rst = 1 then '√' when a.jdx_ggcz_rst = 2 then '×' else '/'  end  jdx_ggcz_rst, " +
        			"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10009 and b.DD_ITEM_CODE = a.jdx_fscd) jdx_fscd, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.jdx_fscd_rst) jdx_fscd_rst, " +
        			"	case when a.jdx_fscd_rst = 1 then '√' when a.jdx_fscd_rst = 2 then '×' else '/'  end  jdx_fscd_rst, " +
        			"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10008 and b.DD_ITEM_CODE = a.pb_zdy_fsfs) pb_zdy_fsfs, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.pb_zdy_fsfs_rst) pb_zdy_fsfs_rst, " +
        			"	case when a.pb_zdy_fsfs_rst = 1 then '√' when a.pb_zdy_fsfs_rst = 2 then '×' else '/'  end  pb_zdy_fsfs_rst, " +
        			"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10008 and b.DD_ITEM_CODE = a.pb_zxh_fsfs) pb_zxh_fsfs, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.pb_zxh_fsfs_rst) pb_zxh_fsfs_rst, " +
        			"	case when a.pb_zxh_fsfs_rst = 1 then '√' when a.pb_zxh_fsfs_rst = 2 then '×' else '/'  end  pb_zxh_fsfs_rst, " +
        			"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10011 and b.DD_ITEM_CODE = a.pb_zdy_sx) pb_zdy_sx, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.pb_zdy_sx_rst) pb_zdy_sx_rst, " +
        			"	case when a.pb_zdy_sx_rst = 1 then '√' when a.pb_zdy_sx_rst = 2 then '×' else '/'  end  pb_zdy_sx_rst, " +
        			"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10011 and b.DD_ITEM_CODE = a.pb_zxh_sx) pb_zxh_sx, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.pb_zxh_sx_rst) pb_zxh_sx_rst,dx_result, " +
        			"	case when a.pb_zxh_sx_rst = 1 then '√' when a.pb_zxh_sx_rst = 2 then '×' else '/'  end  pb_zxh_sx_rst,dx_result, " +
        			"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10001 and b.DD_ITEM_CODE = a.result) result, " +
        			"	CONCAT(zgyj, '。', jy)remark, zgyj,jy,state,rec_id,rec_date  " +
        			"from t_fzjl_info a " +
        			"where id = ? " +
        			"and state = 1 ";
        	map.put("fzjlInfo", db.queryForMap(sql, new Object[] {id}));
        	
        	sql = "select id,base_id,jzwly,jzw,jcd,ggcz, " +
        			"	dzz, (select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10026 and b.DD_ITEM_CODE = a.dzz_bzyq) dzz_bzyq, " +
        			//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.dx_result) dx_result, " +
        			"	case when a.dx_result = 1 then '√' when a.dx_result = 2 then '×' else '/' end  dx_result, " +
        			"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10016 and b.DD_ITEM_CODE = a.sx) sx,rec_id,rec_date,state  " +
        			"from t_pbddw_info a " +
        			"where state = 1 " +
        			"and jzwly = 1 " +
        			"and jzw = ? ";
        	logger.debug("B表 ： " + str.getSql(sql, new Object[] {id}));
        	 List<Map<String, Object>> res = db.queryForList(sql, new Object[]{id});
             int size = res.size();
             int buchong = 23 - size % 23;//补齐,不足23倍数，补充
             if(buchong < 23){
             	for (int i = 0; i < buchong; i++) {
             		Map tmp = new HashMap();
             		if(i == 0){
             			tmp.put("jcd", "以下空白");
             		}
         			res.add(tmp);
         		}
             }
             
        	map.put("PbList", res);
        	list.add(map);
        }
        return list;
    }
	
	/**
	 * 获取电气系统电涌保护器信息
	 * @param request 
	 * @return
	 */
	public List getDqdybhqInfos(HttpServletRequest request) {
        String baseId = req.getValue(request, "infoId");
        String sql = "select id,base_id,bjcwwz,xh, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10020 and b.DD_ITEM_CODE = a.jdzs) jdzs, " +
	        		"	azsl, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.azsl_rst) azsl_rst, " +
	        		"	case when a.azsl_rst = 1 then '√' when a.azsl_rst = 2 then '×' else '/' end  azsl_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10017 and b.DD_ITEM_CODE = a.szflq) szflq, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.szflq_rst) szflq_rst,yqjjl, " +
	        		"	case when a.szflq_rst = 1 then '√' when a.szflq_rst = 2 then '×' else '/' end   szflq_rst,yqjjl, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.yqjjl_rst) yqjjl_rst, " +
	        		"	case when a.yqjjl_rst = 1 then '√' when a.yqjjl_rst = 2 then '×' else '/' end  yqjjl_rst, " +
	        		"	a.baqk, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.baqk_rst) baqk_rst, " +
	        		"	case when a.baqk_rst = 1 then '√' when a.baqk_rst = 2 then '×' else '/' end  baqk_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10019 and b.DD_ITEM_CODE = a.ztxs) ztxs, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ztxs_rst) ztxs_rst, " +
	        		"	case when a.ztxs_rst = 1 then '√' when a.ztxs_rst = 2 then '×' else '/' end  ztxs_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10012 and b.DD_ITEM_CODE = a.sggy) sggy, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.sggy_rst) sggy_rst,dybhsp, " +
	        		"	case when a.sggy_rst = 1 then '√' when a.sggy_rst = 2 then '×' else '/' end   sggy_rst,dybhsp, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.dybhsp_rst) dybhsp_rst,zdcxdy, " +
	        		"	case when a.dybhsp_rst = 1 then '√' when a.dybhsp_rst = 2 then '×' else '/' end   dybhsp_rst,zdcxdy, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.zdcxdy_rst) zdcxdy_rst,cjdl, " +
	        		"	case when a.zdcxdy_rst = 1 then '√' when a.zdcxdy_rst = 2 then '×' else '/' end   zdcxdy_rst,cjdl, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.cjdl_rst) cjdl_rst,bczdfddl, " +
	        		"	case when a.cjdl_rst = 1 then '√' when a.cjdl_rst = 2 then '×' else '/' end   cjdl_rst,bczdfddl, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.bczdfddl_rst) bczdfddl_rst, " +
	        		"	case when a.bczdfddl_rst = 1 then '√' when a.bczdfddl_rst = 2 then '×' else '/' end  bczdfddl_rst, " +
	        		"	ldl, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ldl_rst) ldl_rst,hbbhzz, " +
	        		"	case when a.ldl_rst = 1 then '√' when a.ldl_rst = 2 then '×' else '/' end  ldl_rst,hbbhzz, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.hbbhzz_rst) hbbhzz_rst,xlxjm, " +
	        		"	case when a.hbbhzz_rst = 1 then '√' when a.hbbhzz_rst = 2 then '×' else '/' end  hbbhzz_rst,xlxjm, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.xlxjm_rst) xlxjm_rst, " +
	        		"	case when a.xlxjm_rst = 1 then '√' when a.xlxjm_rst = 2 then '×' else '/' end  xlxjm_rst, " +
	        		"	jdxjm, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.jdxjm_rst) jdxjm_rst,qddy, " +
	        		"	case when a.jdxjm_rst = 1 then '√' when a.jdxjm_rst = 2 then '×' else '/' end  jdxjm_rst,qddy, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.qddy_rst) qddy_rst,jxcd, " +
	        		"	case when a.qddy_rst = 1 then '√' when a.qddy_rst = 2 then '×' else '/' end  qddy_rst,jxcd, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.jxcd_rst) jxcd_rst, " +
	        		"	case when a.jxcd_rst = 1 then '√' when a.jxcd_rst = 2 then '×' else '/' end  jxcd_rst, " +
	        		"	dx_result, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10001 and b.DD_ITEM_CODE = a.result) result,zgyj,jy,CONCAT(zgyj, '。', jy)remark,state,rec_id,rec_date  " +
	        		"from t_dxdybh_info a " +
	        		"where a.state = 1 " +
	        		"and a.base_id = ? ";
        return db.queryForList(sql, new Object[]{baseId});
    }
	
	/**
	 * 获取信号天馈电涌保护器信息
	 * @param request 
	 * @return
	 */
	public List getXhtkInfoList(HttpServletRequest request) {
        String baseId = req.getValue(request, "infoId");
        String sql = "select id,base_id,bjcwwz, " +
	        		"	( case when type = 1 then '天馈电涌保护器' when type= 2 then '信号电涌保护器' end )type,xh," +
	        		"	( " +
	       			 "		case " +
	       			 "		when DATE_FORMAT(azrq, '%Y-%m-%d')= '2000-01-01' then " +
	       			 "			'' " +
	       			 "		else " +
	       			 "			DATE_FORMAT(azrq, '%Y-%m-%d') " +
	       			 "		end " +
	       			 "	) azrq, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10018 and b.DD_ITEM_CODE = a.baqk) baqk, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.baqk_rst) baqk_rst,azsl, " +
	        		"	case when a.baqk_rst = 1 then '√' when a.baqk_rst = 2 then '×' else '/' end  baqk_rst,azsl, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.azsl_rst) azsl_rst,bctll, " +
	        		"	case when a.azsl_rst = 1 then '√' when a.azsl_rst = 2 then '×' else '/' end  azsl_rst,bctll, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.bctll_rst) bctll_rst,crsh, " +
	        		"	case when a.bctll_rst = 1 then '√' when a.bctll_rst = 2 then '×' else '/' end  bctll_rst,crsh, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.crsh_rst) crsh_rst,jdjm, " +
	        		"	case when a.crsh_rst = 1 then '√' when a.crsh_rst = 2 then '×' else '/' end  crsh_rst,jdjm, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.jdjm_rst) jdjm_rst, " +
	        		"	case when a.jdjm_rst = 1 then '√' when a.jdjm_rst = 2 then '×' else '/' end  jdjm_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10021 and b.DD_ITEM_CODE = a.jdxcd) jdxcd, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.jdxcd_rst) jdxcd_rst, " +
	        		"	case when a.jdxcd_rst = 1 then '√' when a.jdxcd_rst = 2 then '×' else '/' end  jdxcd_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10012 and b.DD_ITEM_CODE = a.sggy) sggy, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.sggy_rst) sggy_rst,dyzbb, " +
	        		"	case when a.sggy_rst = 1 then '√' when a.sggy_rst = 2 then '×' else '/' end  sggy_rst,dyzbb, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.dyzbb_rst) dyzbb_rst, " +
	        		"	case when a.dyzbb_rst = 1 then '√' when a.dyzbb_rst = 2 then '×' else '/' end  dyzbb_rst, " +
	        		"	edgzdy, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.edgzdy_rst) edgzdy_rst,dybhsp, " +
	        		"	case when a.edgzdy_rst = 1 then '√' when a.edgzdy_rst = 2 then '×' else '/' end  edgzdy_rst, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.dybhsp_rst) dybhsp_rst, " +
	        		"	case when a.dybhsp_rst = 1 then '√' when a.dybhsp_rst = 2 then '×' else '/' end  dybhsp_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10017 and b.DD_ITEM_CODE = a.szflq) szflq, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.szflq_rst) szflq_rst,dx_result, " +
	        		"	case when a.szflq_rst = 1 then '√' when a.szflq_rst = 2 then '×' else '/' end  szflq_rst,dx_result, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10001 and b.DD_ITEM_CODE = a.result) result, " +
	        		"	zgyj,jy,CONCAT(zgyj, '。', jy)remark,state,rec_id,rec_date  " +
	        		"from t_xhtkdybhq_info a " +
	        		"where state = 1 " +
	        		"and base_id = ? ";
        return db.queryForList(sql, new Object[]{baseId});
    }
	
	/**
	 * 获取电子系统信息
	 * @param request 
	 * @return
	 */
	public List getDzxtInfoList(HttpServletRequest request) {
        String baseId = req.getValue(request, "infoId");
        String sql = "select id,base_id,jf_name,jf_wz,jfmj, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10023 and b.DD_ITEM_CODE = a.jf_fldj) jf_fldj, " +
	        		"	szdl_fldj, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10013 and b.DD_ITEM_CODE = a.szdl_fllb) szdl_fllb,zjl_fhqk,kjs_wd, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.kjs_wd_rst) kjs_wd_rst, " +
	        		"	kjs_sd, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.kjs_sd_rst) kjs_sd_rst,qzcjl, " +
	        		"	case when a.kjs_sd_rst = 1 then '√' when a.kjs_sd_rst = 2 then '×' else '/' end  kjs_sd_rst,qzcjl, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.qzcjl_rst) qzcjl_rst, " +
	        		"	case when a.qzcjl_rst = 1 then '√' when a.qzcjl_rst = 2 then '×' else '/' end  qzcjl_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10010 and b.DD_ITEM_CODE = a.jfdy_fsfs) jfdy_fsfs, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.jfdy_fsfs_rst) jfdy_fsfs_rst, " +
	        		"	case when a.jfdy_fsfs_rst = 1 then '√' when a.jfdy_fsfs_rst = 2 then '×' else '/' end  jfdy_fsfs_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10011 and b.DD_ITEM_CODE = a.jfdy_sx) jfdy_sx, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.jfdy_sx_rst) jfdy_sx_rst, " +
	        		"	case when a.jfdy_sx_rst = 1 then '√' when a.jfdy_sx_rst = 2 then '×' else '/' end  jfdy_sx_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10010 and b.DD_ITEM_CODE = a.jfxh_fsfs) jfxh_fsfs, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.jfxh_fsfs_rst) jfxh_fsfs_rst, " +
	        		"	case when a.jfxh_fsfs_rst = 1 then '√' when a.jfxh_fsfs_rst = 2 then '×' else '/' end  jfxh_fsfs_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10011 and b.DD_ITEM_CODE = a.jfxh_sx) jfxh_sx, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.jfxh_sx_rst) jfxh_sx_rst, " +
	        		"	case when a.jfxh_sx_rst = 1 then '√' when a.jfxh_sx_rst = 2 then '×' else '/' end  jfxh_sx_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10024 and b.DD_ITEM_CODE = a.ddw_ljjg) ddw_ljjg, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ddw_ljjg_rst) ddw_ljjg_rst,ddw_czgg, " +
	        		"	case when a.ddw_ljjg_rst = 1 then '√' when a.ddw_ljjg_rst = 2 then '×' else '/' end  ddw_ljjg_rst,ddw_czgg, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ddw_czgg_rst) ddw_czgg_rst, " +
	        		"	case when a.ddw_czgg_rst = 1 then '√' when a.ddw_czgg_rst = 2 then '×' else '/' end ddw_czgg_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10009 and b.DD_ITEM_CODE = a.ddw_jdx_fscd) ddw_jdx_fscd, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ddw_jdx_fscd_rst) ddw_jdx_fscd_rst, " +
	        		"	case when a.ddw_jdx_fscd_rst = 1 then '√' when a.ddw_jdx_fscd_rst = 2 then '×' else '/' end ddw_jdx_fscd_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10012 and b.DD_ITEM_CODE = a.ddw_jdx_ljqk) ddw_jdx_ljqk, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ddw_jdx_ljqk_rst) ddw_jdx_ljqk_rst, " +
	        		"	case when a.ddw_jdx_ljqk_rst = 1 then '√' when a.ddw_jdx_ljqk_rst = 2 then '×' else '/' end ddw_jdx_ljqk_rst, " +
	        		"	ddw_hlpggcz, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ddw_hlpggcz_rst) ddw_hlpggcz_rst, " +
	        		"	case when a.ddw_hlpggcz_rst = 1 then '√' when a.ddw_hlpggcz_rst = 2 then '×' else '/' end ddw_hlpggcz_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10009 and b.DD_ITEM_CODE = a.ddw_hlpfscd) ddw_hlpfscd, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ddw_hlpfscd_rst) ddw_hlpfscd_rst, " +
	        		"	case when a.ddw_hlpfscd_rst = 1 then '√' when a.ddw_hlpfscd_rst = 2 then '×' else '/' end ddw_hlpfscd_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10012 and b.DD_ITEM_CODE = a.ddw_hlpljzk) ddw_hlpljzk, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ddw_hlpfscd_rst) ddw_hlpljzk_rst,ddw_zxggcz, " +
	        		"	case when a.ddw_hlpljzk_rst = 1 then '√' when a.ddw_hlpljzk_rst = 2 then '×' else '/' end ddw_hlpljzk_rst,ddw_zxggcz, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ddw_zxggcz_rst) ddw_zxggcz_rst, " +
	        		"	case when a.ddw_zxggcz_rst = 1 then '√' when a.ddw_zxggcz_rst = 2 then '×' else '/' end ddw_zxggcz_rst, " +
	        		"	ddw_zxjdggcz, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ddw_zxjdggcz_rst)  ddw_zxjdggcz_rst, " +
	        		"	case when a.ddw_zxjdggcz_rst = 1 then '√' when a.ddw_zxjdggcz_rst = 2 then '×' else '/' end ddw_zxjdggcz_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10012 and b.DD_ITEM_CODE = a.ddw_zxjdxljzk) ddw_zxjdxljzk, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ddw_zxjdxljzk_rst)  ddw_zxjdxljzk_rst, " +
	        		"	case when a.ddw_zxjdxljzk_rst = 1 then '√' when a.ddw_zxjdxljzk_rst = 2 then '×' end ddw_zxjdxljzk_rst, " +
	        		"	ddw_spjdxgg, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ddw_spjdxggf_rst) ddw_spjdxggf_rst,ddw_sbjdxlj, " +
	        		"	case when a.ddw_spjdxggf_rst = 1 then '√' when a.ddw_spjdxggf_rst = 2 then '×' else '/' end ddw_spjdxggf_rst,ddw_sbjdxlj, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ddw_sbjdxlj_rst) ddw_sbjdxlj_rst, " +
	        		"	case when a.ddw_sbjdxlj_rst = 1 then '√' when a.ddw_sbjdxlj_rst = 2 then '×' else '/' end ddw_sbjdxlj_rst, " +
	        		"	ddw_gljdxgg, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ddw_gljdxgg_rst) ddw_gljdxgg_rst,ddw_gljdxlj, " +
	        		"	case when a.ddw_gljdxgg_rst = 1 then '√' when a.ddw_gljdxgg_rst = 2 then '×' else '/' end ddw_gljdxgg_rst,ddw_gljdxlj, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ddw_gljdxlj_rst) ddw_gljdxlj_rst, " +
	        		"	case when a.ddw_gljdxlj_rst = 1 then '√' when a.ddw_gljdxlj_rst = 2 then '×' else '/' end ddw_gljdxlj_rst, " +
	        		"	ddw_dhxggcz, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ddw_dhxggcz_rst) ddw_dhxggcz_rst,ddw_dhxlj, " +
	        		"	case when a.ddw_dhxggcz_rst = 1 then '√' when a.ddw_dhxggcz_rst = 2 then '×' else '/' end ddw_dhxggcz_rst,ddw_dhxlj, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ddw_dhxlj_rst) ddw_dhxlj_rst,ups_dyz, " +
	        		"	case when a.ddw_dhxlj_rst = 1 then '√' when a.ddw_dhxlj_rst = 2 then '×' else '/' end ddw_dhxlj_rst,ups_dyz, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ups_dyz_rst) ups_dyz_rst,ups_pl, " +
	        		"	case when a.ups_dyz_rst = 1 then '√' when a.ups_dyz_rst = 2 then '×' else '/' end ups_dyz_rst,ups_pl, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ups_pl_rst) ups_pl_rst,ups_bxszl, " +
	        		"	case when a.ups_pl_rst = 1 then '√' when a.ups_pl_rst = 2 then '×' else '/' end ups_pl_rst,ups_bxszl, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ups_bxszl_rst) ups_bxszl_rst,ups_lddy, " +
	        		"	case when a.ups_bxszl_rst = 1 then '√' when a.ups_bxszl_rst = 2 then '×' else '/' end ups_bxszl_rst,ups_lddy, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ups_lddy_rst) ups_lddy_rst, " +
	        		"	case when a.ups_lddy_rst = 1 then '√' when a.ups_lddy_rst = 2 then '×' else '/' end ups_lddy_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10020 and b.DD_ITEM_CODE = a.ups_jdfs)  ups_jdfs, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ups_jdfs_rst) ups_jdfs_rst,ups_jdw, " +
	        		"	case when a.ups_jdfs_rst = 1 then '√' when a.ups_jdfs_rst = 2 then '×' else '/' end ups_jdfs_rst,ups_jdw, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ups_jdw_rst) ups_jdw_rst, " +
	        		"	case when a.ups_jdw_rst = 1 then '√' when a.ups_jdw_rst = 2 then '×' else '/' end ups_jdw_rst, " +
	        		"	ups_dzl, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ups_dzl_rst) ups_dzl_rst,ups_jdxgg, " +
	        		"	case when a.ups_dzl_rst = 1 then '√' when a.ups_dzl_rst = 2 then '×' else '/' end ups_dzl_rst,ups_jdxgg, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ups_jdxgg_rst) ups_jdxgg_rst, " +
	        		"	case when a.ups_jdxgg_rst = 1 then '√' when a.ups_jdxgg_rst = 2 then '×' else '/' end ups_jdxgg_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10012 and b.DD_ITEM_CODE = a.ups_ljzk) ups_ljzk, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.ups_ljzk_rst) ups_ljzk_rst,tx_xz, " +
	        		"	case when a.ups_ljzk_rst = 1 then '√' when a.ups_ljzk_rst = 2 then '×' else '/' end ups_ljzk_rst,tx_xz, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.tx_xz_rst) tx_xz_rst,tx_ggcz, " +
	        		"	case when a.tx_xz_rst = 1 then '√' when a.tx_xz_rst = 2 then '×' else '/' end tx_xz_rst,tx_ggcz, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.tx_ggcz_rst) tx_ggcz_rst, " +
	        		"	case when a.tx_ggcz_rst = 1 then '√' when a.tx_ggcz_rst = 2 then '×' else '/' end tx_ggcz_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10009 and b.DD_ITEM_CODE = a.tx_fscd) tx_fscd, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.tx_fscd_rst) tx_fscd_rst, " +
	        		"	case when a.tx_fscd_rst = 1 then '√' when a.tx_fscd_rst = 2 then '×' else '/' end tx_fscd_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10015 and b.DD_ITEM_CODE = a.tx_bhfw) tx_bhfw, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.tx_bhfw_rst) tx_bhfw_rst,tx_jdxggcz, " +
	        		"	case when a.tx_bhfw_rst = 1 then '√' when a.tx_bhfw_rst = 2 then '×' else '/' end tx_bhfw_rst,tx_jdxggcz, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.tx_jdxggcz_rst) tx_jdxggcz_rst, " +
	        		"	case when a.tx_jdxggcz_rst = 1 then '√' when a.tx_jdxggcz_rst = 2 then '×' else '/' end tx_jdxggcz_rst, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10009 and b.DD_ITEM_CODE = a.tx_jdxfscd) tx_jdxfscd, " +
	        		//"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10007 and b.DD_ITEM_CODE = a.tx_jdxfscd_rst) tx_jdxfscd_rst,dx_result, " +
	        		"	case when a.tx_jdxfscd_rst = 1 then '√' when a.tx_jdxfscd_rst = 2 then '×' else '/' end tx_jdxfscd_rst,dx_result, " +
	        		"	(select dd_item_name from t_ddw b where DATA_TYPE_CODE = 10001 and b.DD_ITEM_CODE = a.result) result,zgyj,jy,state,rec_id,rec_date  " +
	        		"from t_dzxt_info a  " +
	        		"where a.state = 1  " +
	        		"and base_id = ? ";
        return db.queryForList(sql, new Object[]{baseId});
    }
	
	/**
	 * 获取示意图、照片等信息
	 * @param request 
	 * @return
	 */
	public List getPhotos(HttpServletRequest request) {
        String baseId = req.getValue(request, "infoId");
        String sql = " select cl_type, cl_name_d from t_clsc_info where base_id = ? and cl_type in (1, 2) ";
        return db.queryForList(sql, new Object[]{baseId});
    }
	
	/**
	    *流程状态更新为已打印
	    *流程状态 5
	    * @param request
	    * @return
	    */
	   public int UpLcydyNum(HttpServletRequest request) {
	       String id = req.getValue(request, "id");
	       BatchSql batchSql = new BatchSql();
	       String sql = " select ydy_num from t_jcdw_base_info where id = ? ";
	       String dyNum = db.queryForString(sql, new Object[]{id});
	       dyNum = dyNum.equals("") ? "0" : dyNum;
	       int Num = Integer.valueOf(dyNum) + 1;
	       sql = " update t_jcdw_base_info set ydy_num = ? where id = ? ";
	       batchSql.addBatch(sql, new Object[]{Num, id});
	       int rst = db.doInTransaction(batchSql);
	       return rst;
	   }

}
