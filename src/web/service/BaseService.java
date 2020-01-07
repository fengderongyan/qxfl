package web.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;

import web.bean.SystemInfo;
import web.model.User;
import web.service.systemlog.SystemLogService;

import com.zcc.util.common.DateHelper;
import com.zcc.util.common.FileHelper;
import com.zcc.util.common.StringHelper;
import com.zcc.util.db.BatchSql;
import com.zcc.util.db.DBHelperSpring;
import com.zcc.util.spring.RequestHelper;

/**
 * 控制组件基类
 * @date 2016-2-22
 */
public class BaseService
{
	public DBHelperSpring db;// 数据操作
	public final Logger logger = Logger.getLogger(this.getClass());
	public RequestHelper req = new RequestHelper();
	public SystemInfo systemInfo;
	public final int PAGE_SIZE = 18;
	
	/******************** 组织 ******************/
    public static String GLOBA_KQF_ORGID = "10028"; 	//可签发分部
	
	public User getUser(HttpServletRequest request) {
		return (User) request.getSession().getAttribute("user");
	}
	
	@Resource(name="dbHelper")
	public void setDb(DBHelperSpring db) {
		this.db = db;
	}
	public DBHelperSpring getDb() {
		return db;
	}
	
	public SystemInfo getSystemInfo() {
		return systemInfo;
	}
	
	@Resource(name="systemInfo")
	public void setSystemInfo(SystemInfo systemInfo) {
		this.systemInfo = systemInfo;
	}
	
	public SystemLogService systemLogService;

    @Resource(name = "systemLogService")
    public void setSystemLogService(SystemLogService systemLogService) {
        this.systemLogService = systemLogService;
    }

	public StringHelper str = new StringHelper();

	/**
	 * 获取当前用户工号
	 * @param request
	 * @return
	 */
	public String getOperatorId(HttpServletRequest request) {
		return this.getUser(request).getOperatorId();
	}
	
	/**
     * 获取当前用户地市
     * @param request
     * @return
     */
    public String getRegionId(HttpServletRequest request) {
        return this.getUser(request).getCountyId();
    }
	
	/**
	 * 获取角色列表
	 * @return
	 */
	public List<Map<String, Object>> getRoleList(){
		return this.systemInfo.getRoleList();
	}
	
	/**
	 * 获取数据字典配置
	 * @param 字典组编号
	 * @return
	 */
	public List<?> getDictItemList(String group_id){
		return this.getDictItemList(group_id, "");
	}
	
	/**
	 * 获取数据字典配置
	 * @param 字典组编号
	 * @param special 特殊条件 如：and item_id not in(99)
	 * @return
	 */
	public List<?> getDictItemList(String group_id,String special){
		String sql = "select a.item_id,a.item_name,a.item_value,a.item_order,a.group_id," +
				" 	a.item_order,a.remark from t_dictionary_item a " +
				" where a.status =1 and upper(a.group_id)=upper(?) ";
		if(!"".equals(special)){
			sql += special;
		}
		sql += "order by a.item_order,a.item_id " ;
		return db.queryForList(sql, new Object[]{group_id});
	}
	
	/**
     * 获取数据字典名称
     * @return
     */
    public String getDictItemName (String group_id,String item_id ) {
        String sql  ="select a.item_name " +
                    "  from t_dictionary_item a " + 
                    " where a.status = 1 " + 
                    "   and upper(a.group_id) = upper(?) " + 
                    "   and a.item_id = ?";
        return db.queryForString(sql, new Object[]{group_id,item_id});
    }
    
    /**
     * 操作历史记录，使用占位符
     * @param request
     * @param batch
     * @param table_name 表名称
     * @param hisTableName 历史表名
     * @param condition 条件
     * @param oper_type 操作类型
     * @param paramList 条件中的占位符参数
     */
    public void addHis(HttpServletRequest request, BatchSql batch, String table_name, String hisTableName,
            String condition, String oper_type, List<String> paramList) {
        String sql = " insert into " + hisTableName + " select '" + this.getOperatorId(request) + "', sysdate, '" +
                oper_type + "', a.* " + "   from " + table_name + " a where 1 = 1 " + condition;
        //logger.debug("获取插入历史表的记录"+StringHelper.getSql(sql, paramList.toArray()));
        batch.addBatch(sql, paramList.toArray());
    }
    
    /**
     * 操作历史记录，使用占位符
     * @param request
     * @param batch
     * @param table_name 表名称
     * @param hisTableName 历史表名
     * @param condition 条件
     * @param oper_type 操作类型
     * @param paramValues 条件中的占位符参数值(用','号分割)
     */
   public void addHis(HttpServletRequest request, BatchSql batch, String table_name, String hisTableName,
            String condition, String oper_type, String paramValues) {
        String sql = " insert into " + hisTableName + " select '" + this.getOperatorId(request) + "', sysdate, '" +
                oper_type + "', a.* " + "   from " + table_name + " a where 1 = 1 " + condition;
        //logger.debug("获取插入历史表的记录"+StringHelper.getSql(sql, paramList.toArray()));
        batch.addBatch(sql, new Object[] {paramValues});
    }
   
   /**
    * 获取序列值
    * @param sequenceName 序列名称
    */
   public String getNextSequenceValue(String sequenceName) {
	   return db.getNextSequenceValue(sequenceName);
   }
	
	/**
     * 文件上传
     * @param user_name
     * @param file1
     * @param file1FileName
     * @param toDir
     * @return
     */
	public String uploadFile(MultipartFile file, String fileFileName, String toDir) {
		String fileName = "";
		String nowTime = DateHelper.getToday("yyyyMMddhhmmss");
		int idx = fileFileName.lastIndexOf(".");
		fileName = fileFileName.substring(0, idx) + "" + nowTime
				+ "" + "." + fileFileName.substring(idx + 1);
		FileHelper fileHelper = new FileHelper();
		fileHelper.copyFile(file, toDir + fileName);
		return fileName;
	}

	/**
     * 菜单点击流水
     * @param request
     * @param mainAccountName
     * @param operatorId
     */
    public void addNodeLog(HttpServletRequest request, String operatorId,String orgId,String countyId) 
    {
    	String moduleId = req.getValue(request, "module_id");		// 模块编号
        String moduleName = req.getValue(request, "module_name");	// 模块名称
        String operatingTypeId = req.getValue(request, "op_type_id");	// 操作类型编号
        String operatingTypeName = req.getValue(request, "op_type_name");// 操作类型名称
        String operateContent = systemLogService.getRequestCommonInfo(request);
        
        // 记录系统日志
        this.recordSystemLog(request,operatorId, operatingTypeId, operatingTypeName, "2", 
        		operateContent, moduleId, moduleName,orgId,countyId);
    }
    
    /** 
     * @description 记录系统登录日志
     * @param operatorId  系统工号
     * @param operatingTypeId   操作类型编号
     * @param operatingTypeName 操作类型名称
     * @param operatingLevel    操作级别编号
     * @param operateContent  操作内容
     * @param orgId      组织编号
     * @param moduleId   模块编码
     * @param moduleName 模块名称
     * @return
     */ 
    public void recordSystemLog(HttpServletRequest request, String operatorId, 
    		String operatingTypeId, String operatingTypeName, String operatingLevel, String operateContent, 
    		String moduleId, String moduleName,String orgId,String countyId) 
    {
    	Map<String, Object> map = new HashMap<String, Object>();
        map.put("operator_id", operatorId);
        map.put("op_type_id", operatingTypeId);
        map.put("op_type_name", operatingTypeName);
        map.put("op_level_id", operatingLevel);
        map.put("operate_content", operateContent);
        map.put("operate_result", "0"); // 操作结果【0：成功 1：失败】 
        map.put("module_id", moduleId);
        map.put("module_name", moduleName);
        map.put("org_id", orgId);
        
        systemLogService.createSystemLog(request, map);
    }
    
    /**
     * 更新导出状态
     * @param request
     * @return
     */
    public int updateExportLogStatus(DBHelperSpring db,HttpServletRequest request){
        String log_id = req.getValue(request, "log_id");
        String sql = "update t_info_export_log a set a.status=1 ,end_date = sysdate() where a.log_id =?";
        return db.update(sql, new Object[]{log_id});
    }
    
    /**
     * 记录登陆、退出日志
     * @param request 
     * 
     */
    public void recordLoginLog(HttpServletRequest request,String operatorId,
            String operateTypeId, String operateTypeName, String opLevelId, String operateContent, 
            String orgId,String countyId) {
        this.recordSystemLog(request,operatorId, operateTypeId, operateTypeName, 
                opLevelId, operateContent, "", "",orgId,countyId);
    }
    
    
    public String getRegionIdByCountyId(String county_id){
        String sql = "select a.org_id from t_county a where a.region_id = ? ";
        return db.queryForString(sql,new Object[]{county_id});
    }
}
