package qxfl.action.cgjc;


import qxfl.service.cgjc.CgjcService;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import web.action.BaseController;

import com.zcc.util.common.DateHelper;
import com.zcc.util.common.StringHelper;


/**
 * 常规检测
 * @date 2018-12-10
 */
@Controller
@RequestMapping(value = "/cgjc/cgjc/")
public class CgjcController extends BaseController {
    /**
     * spring 类型注入
     */
    @Autowired
    public CgjcService cgjcService;
    
    private String file;
    public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	private String fileFileName;

    /**
     * 查询frame界面
     * @return
     */
    @RequestMapping(value = "cgjcFrame.do")
    public String cgjcFrame() {
        request.setAttribute("yearsList", cgjcService.getNdList(request));
        request.setAttribute("flag", req.getValue(request, "flag"));
        return COM_PATH +"qxfl/cgjc/jcdw/frame";
    }

    /**
     * 查询列表
     * @return
     */
    @RequestMapping(value = "cgjcList.do")
    public String cgjcList() {
    	request.setAttribute("flag", req.getValue(request, "flag"));
        request.setAttribute("list", cgjcService.getJcdwList(request));
        return COM_PATH +"qxfl/cgjc/jcdw/list";
    }
    
    /**
     * 年检复制列表
     * @return
     */
    @RequestMapping(value = "njInfoList.do")
    public String njInfoList() {
    	request.setAttribute("flag", req.getValue(request, "flag"));
        request.setAttribute("list", cgjcService.getJcdwList(request));
        return COM_PATH +"qxfl/cgjc/jcdw/njlist";
    }
    
    /**
     * 复制信息为年检
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "copyJcdwInfo.do")
    public void copyJcdwInfo(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        this.writeText(cgjcService.copyJcdwInfo(request), response);
    }
    
    /** 
     * 年检、首检
     * @return
     */ 
    @RequestMapping(value = "ajaxChange.do")
    public String ajaxChange(){
    	String flag = req.getValue(request, "flag");
    	 request.setAttribute("yearsList", cgjcService.getNdList(request));
    	if(flag.equals("0")){//跳转年检
    		return COM_PATH + "qxfl/cgjc/jcdw/ajaxspan";
    	}else {//跳转首检
    		return COM_PATH + "qxfl/cgjc/jcdw/ajaxspan2";
    	}
    }
    
    /**
     * 删除检测单位信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "delJcdw.do")
    public void delJcdw(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        this.writeText(cgjcService.deleteJcdwInfo(request), response);
    }
    

    /**
     * 修改检测单位信息
     * @return
     */
    @RequestMapping(value = "Jcdwedit.do")
    public String Jcdwedit() {
        String method = req.getValue(request, "method");
        //request.setAttribute("jcdwInfo", cgjcService.getUserInfo(request));
        Calendar now = Calendar.getInstance();  
        String nowYear = Integer.toString(now.get(Calendar.YEAR));
        //报告编码
        request.setAttribute("bg_id", "BG" + "011000" + nowYear + cgjcService.getNextValue("t_jcdw_base_bg_sid"));
        //档案编码
        request.setAttribute("da_id", "DA" + "011002" + nowYear + cgjcService.getDaNextValue("t_jcdw_base_da_sid"));
        //年度
        request.setAttribute("nowYear", nowYear);
        request.setAttribute("hyTypeList", cgjcService.getHyTypeList(request, "10002"));//行业类别
        request.setAttribute("dlhjList", cgjcService.getHyTypeList(request, "10003"));//地理环境
        request.setAttribute("jczbList", cgjcService.getHyTypeList(request, "10004"));//检测组别
        return COM_PATH +"qxfl/cgjc/jcdw/edit";
    }

    /**
     * 新增检测单位信息
     * @return
     */
    @RequestMapping(value = "jcdwSave.do")
    public String jcdwSave() {
        request.setAttribute("result", cgjcService.jcdwSave(request));
        return COM_PATH +"qxfl/global/saveResult";
    }
    
    /**
     * 验证档案编号是否存在
     * @param response
     */
    @RequestMapping(value = "checkDaId.do")
    public void checkDaId(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        this.writeText(cgjcService.checkDaId(request), response);
    }
    
    /* main分页
    * @return
    */
   @RequestMapping(value = "jcdwMain.do")
   public String jcdwMain() {
	   String baseId = req.getValue(request, "base_id");
       request.setAttribute("baseId", baseId);
       request.setAttribute("flag", req.getValue(request, "flag"));
       request.setAttribute("cflag", req.getValue(request, "cflag"));//年检传入0
       return COM_PATH +"qxfl/cgjc/jcdw/main";
   }
    
    /**
     * 检测信息-基本信息
     * @return
     */
    @RequestMapping(value = "baseInfoEdit.do")
    public String baseInfoEdit() {
    	request.setAttribute("hyTypeList", cgjcService.getHyTypeList(request, "10002"));//行业类别
    	request.setAttribute("weatherList", cgjcService.getHyTypeList(request, "10005"));//天气实况
    	request.setAttribute("bggcList", cgjcService.getHyTypeList(request, "10006"));//报告构成
    	request.setAttribute("yqsbList", cgjcService.getYqsbList());//仪器设备信息
    	
    	request.setAttribute("id", req.getValue(request, "base_id"));
    	request.setAttribute("baseInfo", cgjcService.getBaseInfo(request));
    	request.setAttribute("cflag", req.getValue(request, "cflag"));//年检标记
        return COM_PATH +"qxfl/cgjc/jcdw/baseInfoEdit";
    }
    
    /**
     * 新增基本信息
     * @return
     */
    @RequestMapping(value = "jcdwBaseSave.do")
    public String jcdwBaseSave() {
        request.setAttribute("result", cgjcService.jcdwBaseSave(request));
        return COM_PATH +"qxfl/cgjc/jcdw/saveResult";
    }
    
    /**
     * 防直击雷frame界面
     * @return
     */
    @RequestMapping(value = "fzjlFrame.do")
    public String fzjlFrame() {
    	request.setAttribute("base_id", req.getValue(request, "base_id"));
    	request.setAttribute("flag", req.getValue(request, "flag"));
    	request.setAttribute("cflag", req.getValue(request, "cflag"));//年检标记
        return COM_PATH +"qxfl/cgjc/fzjl/frame";
    }
    
    /**
     * 防直击雷查询列表
     * @return
     */
    @RequestMapping(value = "fzjlList.do")
    public String fzjlList() {
        request.setAttribute("list", cgjcService.getFzjlList(request));
        request.setAttribute("cflag", req.getValue(request, "cflag"));//年检标记
        return COM_PATH +"qxfl/cgjc/fzjl/list";
    }
    
    /**
     * 防直击雷信息新增修改
     * @return
     */
    @RequestMapping(value = "fzjlEdit.do")
    public String fzjlEdit() {
        String method = req.getValue(request, "method");
        request.setAttribute("method", method);
        //request.setAttribute("jcdwInfo", cgjcService.getUserInfo(request));
        request.setAttribute("base_id", req.getValue(request, "base_id"));
        request.setAttribute("flTypeList", cgjcService.getHyTypeList(request, "10013"));//防雷类别
        request.setAttribute("heList", cgjcService.getHyTypeList(request, "10007"));//合格状态
        request.setAttribute("fsfsList", cgjcService.getHyTypeList(request, "10008"));//敷设方式
        request.setAttribute("fscdList", cgjcService.getHyTypeList(request, "10009"));//腐蚀程度
        request.setAttribute("dbList", cgjcService.getHyTypeList(request, "10015"));//达标情况
        request.setAttribute("xfsList", cgjcService.getHyTypeList(request, "10010"));//线敷设方式
        request.setAttribute("xsxList", cgjcService.getHyTypeList(request, "10011"));//线属性
        request.setAttribute("gdqkList", cgjcService.getHyTypeList(request, "10014"));//固定情况
        request.setAttribute("rstList", cgjcService.getHyTypeList(request, "10001"));//结论
        if(method.equals("edit") || method.equals("copy") || method.equals("show")){
        	request.setAttribute("fzjlInfo", cgjcService.getFzjlInfo(request));
        }
        return COM_PATH +"qxfl/cgjc/fzjl/edit";
    }
    
    /**
     * 防直击雷保存、更新
     * @return
     */
    @RequestMapping(value = "fzjlSave.do")
    public String fzjlSave() {
        request.setAttribute("result", cgjcService.fzjlSave(request));
        return COM_PATH +"qxfl/global/saveResult";
    }
    
    /**
     * 删除防直击雷信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "delFzjl.do")
    public void delFzjl(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        this.writeText(cgjcService.deleteFzjlInfo(request), response);
    }
    
    /**
     * 屏蔽等电位接地frame界面
     * @return
     */
    @RequestMapping(value = "pbddwFrame.do")
    public String pbddwFrame() {
    	request.setAttribute("base_id", req.getValue(request, "base_id"));
    	request.setAttribute("flag", req.getValue(request, "flag"));
    	request.setAttribute("cflag", req.getValue(request, "cflag"));//年检标记
        return COM_PATH +"qxfl/cgjc/pbddw/frame";
    }
    
    /**
     * 屏蔽等电位接地查询列表
     * @return
     */
    @RequestMapping(value = "pbddwList.do")
    public String pbddwList() {
        request.setAttribute("list", cgjcService.getPbddwList(request));
        request.setAttribute("base_id", req.getValue(request, "base_id"));
        request.setAttribute("cflag", req.getValue(request, "cflag"));//年检标记
        return COM_PATH +"qxfl/cgjc/pbddw/list";
    }
    
    /**
     * 屏蔽等电位接地信息新增修改
     * @return
     */
    @RequestMapping(value = "pbddwEdit.do")
    public String pbddwEdit() {
        String method = req.getValue(request, "method");
        request.setAttribute("method", method);
        //request.setAttribute("jcdwInfo", cgjcService.getUserInfo(request));
        request.setAttribute("base_id", req.getValue(request, "base_id"));
        request.setAttribute("heList", cgjcService.getHyTypeList(request, "10007"));//合格状态
        request.setAttribute("sxList", cgjcService.getHyTypeList(request, "10016"));//属性
        request.setAttribute("bzyqList", cgjcService.getHyTypeList(request, "10026"));//标准要求
        request.setAttribute("bbhNamelist", cgjcService.getBbhwNameList(request));//被保护物名称
        if(method.equals("edit") || method.equals("copy") || method.equals("show")){
        	request.setAttribute("pbddwInfo", cgjcService.getPbddwInfo(request));
        }
        return COM_PATH +"qxfl/cgjc/pbddw/edit";
    }
    
    /**
     * 屏蔽等电位接地信息新增修改(more)
     * @return
     */
    @RequestMapping(value = "pbddwMoreEdit.do")
    public String pbddwMoreEdit() {
        String method = req.getValue(request, "method");
        request.setAttribute("method", method);
        //request.setAttribute("jcdwInfo", cgjcService.getUserInfo(request));
        request.setAttribute("base_id", req.getValue(request, "base_id"));
        request.setAttribute("heList", cgjcService.getHyTypeList(request, "10007"));//合格状态
        request.setAttribute("sxList", cgjcService.getHyTypeList(request, "10016"));//属性
        request.setAttribute("bzyqList", cgjcService.getHyTypeList(request, "10026"));//标准要求
        request.setAttribute("bbhNamelist", cgjcService.getBbhwNameList(request));//被保护物名称
        if(method.equals("edit") || method.equals("copy") || method.equals("show")){
        	request.setAttribute("pbddwInfo", cgjcService.getPbddwInfo(request));
        }
        return COM_PATH +"qxfl/cgjc/pbddw/editMore";
    }
    
    /**
     * 屏蔽等电位保存、更新
     * @return
     */
    @RequestMapping(value = "pbddwSave.do")
    public String pbddwSave() {
        request.setAttribute("result", cgjcService.pbddwSave(request));
        return COM_PATH +"qxfl/global/saveResult";
    }
    
    
    /**
     * 多个用户信息保存（多个）
     * @return
     */
    @RequestMapping(value = "pbddwSaveMore.do")
    public String pbddwSaveMore() {
        request.setAttribute("result", cgjcService.pbddwSaveMore(request));
        return COM_PATH +"qxfl/global/saveResult";
    }
    
    /**
     * 删除屏蔽等电位信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "delPbddw.do")
    public void delPbddw(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        this.writeText(cgjcService.deletePbddwInfo(request), response);
    }
    
    /**
     * 电气系统电涌保护器frame界面
     * @return
     */
    @RequestMapping(value = "dqdybhqFrame.do")
    public String dqdybhqFrame() {
    	request.setAttribute("base_id", req.getValue(request, "base_id"));
    	request.setAttribute("flag", req.getValue(request, "flag"));
    	request.setAttribute("cflag", req.getValue(request, "cflag"));//年检标记
        return COM_PATH +"qxfl/cgjc/dqdybhq/frame";
    }
    
    /**
     * 电气系统电涌保护器查询列表
     * @return
     */
    @RequestMapping(value = "dqdybhqList.do")
    public String dqdybhqList() {
        request.setAttribute("list", cgjcService.getDqdybhqList(request));
        request.setAttribute("cflag", req.getValue(request, "cflag"));//年检标记
        return COM_PATH +"qxfl/cgjc/dqdybhq/list";
    }
    
    /**
     * 电气电涌保护器信息新增修改
     * @return
     */
    @RequestMapping(value = "dqdybhqEdit.do")
    public String dqdybhqEdit() {
        String method = req.getValue(request, "method");
        request.setAttribute("method", method);
        //request.setAttribute("jcdwInfo", cgjcService.getUserInfo(request));
        request.setAttribute("base_id", req.getValue(request, "base_id"));
        request.setAttribute("jdffList", cgjcService.getHyTypeList(request, "10020"));//接地方法
        request.setAttribute("flqList", cgjcService.getHyTypeList(request, "10017"));//所在防雷区
        request.setAttribute("baqkList", cgjcService.getHyTypeList(request, "10018"));//备案情况
        request.setAttribute("ztxsList", cgjcService.getHyTypeList(request, "10019"));//状态显示
        request.setAttribute("sggyList", cgjcService.getHyTypeList(request, "10012"));//施工工艺
        request.setAttribute("hgList", cgjcService.getHyTypeList(request, "10007"));//合格状态
        request.setAttribute("rstList", cgjcService.getHyTypeList(request, "10001"));//结论
        if(method.equals("edit") || method.equals("copy") || method.equals("show")){
        	request.setAttribute("dqdybhqInfo", cgjcService.getDqdybhqInfo(request));
        }
        return COM_PATH + "qxfl/cgjc/dqdybhq/edit";
    }
    
    /**
     * 电气电涌保护器保存、更新
     * @return
     */
    @RequestMapping(value = "dqdybhqSave.do")
    public String dqdybhqSave() {
        request.setAttribute("result", cgjcService.dqdybhqSave(request));
        return COM_PATH +"qxfl/global/saveResult";
    }
    
    /**
     * 删除电气电涌保护器信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "delDqdybhq.do")
    public void delDqdybhq(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        this.writeText(cgjcService.deleteDqdybhqInfo(request), response);
    }
    
    /**
     * 信号、天馈电涌保护器frame界面
     * @return
     */
    @RequestMapping(value = "tkdybhqFrame.do")
    public String tkdybhqFrame() {
    	request.setAttribute("base_id", req.getValue(request, "base_id"));
    	request.setAttribute("flag", req.getValue(request, "flag"));
    	request.setAttribute("cflag", req.getValue(request, "cflag"));//年检标记
        return COM_PATH +"qxfl/cgjc/xhtkdybhq/frame";
    }
    
    /**
     * 信号、天馈电涌保护器查询列表
     * @return
     */
    @RequestMapping(value = "tkdybhqList.do")
    public String tkdybhqList() {
        request.setAttribute("list", cgjcService.getTkdybhqList(request));
        request.setAttribute("cflag", req.getValue(request, "cflag"));//年检标记
        return COM_PATH +"qxfl/cgjc/xhtkdybhq/list";
    }
    
    /**
     * 信号、天馈电涌保护器信息新增修改
     * @return
     */
    @RequestMapping(value = "tkdybhqEdit.do")
    public String tkdybhqEdit() {
        String method = req.getValue(request, "method");
        request.setAttribute("method", method);
        //request.setAttribute("jcdwInfo", cgjcService.getUserInfo(request));
        request.setAttribute("base_id", req.getValue(request, "base_id"));
        request.setAttribute("flqList", cgjcService.getHyTypeList(request, "10017"));//所在防雷区
        request.setAttribute("baqkList", cgjcService.getHyTypeList(request, "10018"));//备案情况
        request.setAttribute("sggyList", cgjcService.getHyTypeList(request, "10012"));//施工工艺
        request.setAttribute("xcdList", cgjcService.getHyTypeList(request, "10021"));//线长度
        request.setAttribute("hgList", cgjcService.getHyTypeList(request, "10007"));//合格状态
        request.setAttribute("rstList", cgjcService.getHyTypeList(request, "10001"));//结论
        if(method.equals("edit") || method.equals("copy") || method.equals("show")){
        	request.setAttribute("tkdybhqInfo", cgjcService.getTkdybhqInfo(request));
        }
        return COM_PATH + "qxfl/cgjc/xhtkdybhq/edit";
    }
    
    /**
     * 信号、天馈电涌保护器保存、更新
     * @return
     */
    @RequestMapping(value = "tkdybhqSave.do")
    public String tkdybhqSave() {
        request.setAttribute("result", cgjcService.tkdybhqSave(request));
        return COM_PATH +"qxfl/global/saveResult";
    }
    
    /**
     * 删除信号、天馈电涌保护器信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "delTkdybhq.do")
    public void delTkdybhq(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        this.writeText(cgjcService.deleteTkdybhqInfo(request), response);
    }
    
    /**
     * 电子系统frame界面
     * @return
     */
    @RequestMapping(value = "dzxtFrame.do")
    public String dzxtFrame() {
    	request.setAttribute("base_id", req.getValue(request, "base_id"));
    	request.setAttribute("flag", req.getValue(request, "flag"));
    	request.setAttribute("cflag", req.getValue(request, "cflag"));//年检标记
        return COM_PATH +"qxfl/cgjc/dzxt/frame";
    }
    
    /**
     * 电子系统查询列表
     * @return
     */
    @RequestMapping(value = "dzxtList.do")
    public String dzxtList() {
        request.setAttribute("list", cgjcService.getDzxtList(request));
        request.setAttribute("cflag", req.getValue(request, "cflag"));//年检标记
        return COM_PATH +"qxfl/cgjc/dzxt/list";
    }
    
    /**
     * 信号、天馈电涌保护器信息新增修改
     * @return
     */
    @RequestMapping(value = "dzxtEdit.do")
    public String dzxtEdit() {
        String method = req.getValue(request, "method");
        request.setAttribute("method", method);
        //request.setAttribute("jcdwInfo", cgjcService.getUserInfo(request));
        request.setAttribute("base_id", req.getValue(request, "base_id"));
        request.setAttribute("xsxList", cgjcService.getHyTypeList(request, "10011"));//线属性
        request.setAttribute("jfflList", cgjcService.getHyTypeList(request, "10023"));//机房防雷等级
        request.setAttribute("jdList", cgjcService.getHyTypeList(request, "10020"));//接地方式
        request.setAttribute("fllbList", cgjcService.getHyTypeList(request, "10013"));//防雷类别
        request.setAttribute("xfsfsList", cgjcService.getHyTypeList(request, "10010"));//线敷设方式
        request.setAttribute("ddwllList", cgjcService.getHyTypeList(request, "10024"));//等电位连接结构
        request.setAttribute("fscdList", cgjcService.getHyTypeList(request, "10009"));//腐蚀程度
        request.setAttribute("yxzcList", cgjcService.getHyTypeList(request, "10012"));//优良中差
        request.setAttribute("dbList", cgjcService.getHyTypeList(request, "10015"));//达标
        request.setAttribute("hgList", cgjcService.getHyTypeList(request, "10007"));//合格状态
        request.setAttribute("rstList", cgjcService.getHyTypeList(request, "10001"));//结论
        if(method.equals("edit") || method.equals("copy") || method.equals("show")){
        	request.setAttribute("dzxtInfo", cgjcService.getDzxtInfo(request));
        }
        return COM_PATH + "qxfl/cgjc/dzxt/edit";
    }
    
    /**
     * 信号、天馈电涌保护器保存、更新
     * @return
     */
    @RequestMapping(value = "dzxtSave.do")
    public String dzxtSave() {
        request.setAttribute("result", cgjcService.dzxtSave(request));
        return COM_PATH +"qxfl/global/saveResult";
    }
    
    /**
     * 删除电子系统信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "delDzxt.do")
    public void delDzxt(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        this.writeText(cgjcService.deleteDzxtInfo(request), response);
    }
    
    /**
     * 检测依据
     * @return
     */
    @RequestMapping(value = "jcyjEdit.do")
    public String jcyjEdit() {
    	request.setAttribute("jcyjList", cgjcService.getHyTypeList(request, "10025"));//检测依据
    	request.setAttribute("id", req.getValue(request, "base_id"));
    	request.setAttribute("baseInfo", cgjcService.getBaseInfo(request));
    	request.setAttribute("cflag", req.getValue(request, "cflag"));//年检标记
        return COM_PATH +"qxfl/cgjc/jcdw/jcyj";
    }
    
    /**
     * 检测依据信息保存
     * @return
     */
    @RequestMapping(value = "jcyjSave.do")
    public String jcyjSave() {
        request.setAttribute("result", cgjcService.jcyjSave(request));
        return COM_PATH +"qxfl/cgjc/jcdw/saveResult";
    }
    
    /**
     * 整改意见
     * @return
     */
    @RequestMapping(value = "zgyjEdit.do")
    public String zgyjEdit() {
    	request.setAttribute("id", req.getValue(request, "base_id"));
    	request.setAttribute("baseInfo", cgjcService.getBaseInfo(request));
    	request.setAttribute("cflag", req.getValue(request, "cflag"));//年检标记
    	request.setAttribute("infoList", cgjcService.getInfosList(request));//循环列表
        return COM_PATH +"qxfl/cgjc/jcdw/zgyj";
    }
    
    /**
     * 整改意见信息保存
     * @return
     */
    @RequestMapping(value = "zgyjSave.do")
    public String zgyjSave() {
        request.setAttribute("result", cgjcService.zgyjSave(request));
        return COM_PATH +"qxfl/cgjc/jcdw/saveResult";
    }
    
    /**
     * 材料上传frame界面
     * @return
     */
    @RequestMapping(value = "clscFrame.do")
    public String clscFrame() {
    	request.setAttribute("base_id", req.getValue(request, "base_id"));
    	request.setAttribute("flag", req.getValue(request, "flag"));
    	request.setAttribute("cflag", req.getValue(request, "cflag"));//年检标记
        return COM_PATH +"qxfl/cgjc/clsc/frame";
    }
    
    /**
     * 材料上传查询列表
     * @return
     */
    @RequestMapping(value = "clscList.do")
    public String clscList() {
        request.setAttribute("list", cgjcService.getClscList(request));
        request.setAttribute("cflag", req.getValue(request, "cflag"));//年检标记
        return COM_PATH +"qxfl/cgjc/clsc/list";
    }
    
    /**
     * 材料上传界面
     * @return
     */
    @RequestMapping(value = "clscEdit.do")
    public String clscEdit() {
    	request.setAttribute("base_id", req.getValue(request, "base_id"));
        return COM_PATH +"qxfl/cgjc/clsc/edit";
    }
    
    /**
     * 上传文件
     * @return
     */
    @RequestMapping(value="impFile.do")
    public String impFile(@RequestParam(value="file") CommonsMultipartFile file) {
        fileFileName = file.getOriginalFilename();
        request.setAttribute("result", cgjcService.impClResult(this, request, file, fileFileName));
        //return COM_PATH +"qxfl/cgjc/clsc/saveResult";
        return COM_PATH + "qxfl/global/saveResult";
    }
    
    /**
     * 删除材料上传信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "delClsc.do")
    public void delClsc(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        this.writeText(cgjcService.deleteClscInfo(request), response);
    }
    
    /**
     * 发票信息frame界面
     * @return
     */
    @RequestMapping(value = "billFrame.do")
    public String billFrame() {
    	request.setAttribute("base_id", req.getValue(request, "base_id"));
    	request.setAttribute("flag", req.getValue(request, "flag"));
    	request.setAttribute("cflag", req.getValue(request, "cflag"));//年检标记
        return COM_PATH +"qxfl/cgjc/bill/frame";
    }
    
    /**
     * 发票信息查询列表
     * @return
     */
    @RequestMapping(value = "billList.do")
    public String billList() {
        request.setAttribute("list", cgjcService.getBillInfoList(request));
        request.setAttribute("cflag", req.getValue(request, "cflag"));//年检标记
        return COM_PATH +"qxfl/cgjc/bill/list";
    }
    
    /**
     * 发票信息新增/编辑页面
     * @return
     */
    @RequestMapping(value = "billEdit.do")
    public String billEdit() {
    	request.setAttribute("base_id", req.getValue(request, "base_id"));
    	request.setAttribute("method", req.getValue(request, "method"));
    	if(req.getValue(request, "method").equals("edit")){//修改
    		request.setAttribute("billInfo", cgjcService.getBillInfo(request));
    	}
        return COM_PATH +"qxfl/cgjc/bill/edit";
    }
    
    /**
     * 发票信息保存、更新
     * @return
     */
    @RequestMapping(value = "billInfoSave.do")
    public String billInfoSave() {
        request.setAttribute("result", cgjcService.billInfoSave(request));
        return COM_PATH +"qxfl/global/saveResult";
    }
    
    /**
     * 删除发票信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "delBill.do")
    public void delBill(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        this.writeText(cgjcService.deleteBillInfo(request), response);
    }
    
    /**
     * 待提交报告
     * 报告录入人可视、操作
     * 
     */
    
    /**
     * 待提交frame界面
     * @return
     */
    @RequestMapping(value = "dtjFrame.do")
    public String dtjFrame() {
        request.setAttribute("yearsList", cgjcService.getNdList(request));
        request.setAttribute("flag", req.getValue(request, "flag"));
        return COM_PATH +"qxfl/dtj/frame";
    }
    
    /**
     * 待提交查询列表
     * @return
     */
    @RequestMapping(value = "dtjList.do")
    public String dtjList() {
    	request.setAttribute("flag", req.getValue(request, "flag"));
        request.setAttribute("list", cgjcService.getDtjList(request));//本人可见
        return COM_PATH +"qxfl/dtj/list";
    }
    
    /**
     * 提交报告信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "tjBg.do")
    public void tjBg(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        this.writeText(cgjcService.tjBgInfo(request), response);
    }
    
    /**
     * 待校核报告
     * 部门内人员可见，自己不可校核
     * 部门内人员相互校核
     * 
     */
    /**
     * 待校核frame界面
     * @return
     */
    @RequestMapping(value = "djhFrame.do")
    public String djhFrame() {
        request.setAttribute("yearsList", cgjcService.getNdList(request));
        request.setAttribute("flag", req.getValue(request, "flag"));
        return COM_PATH +"qxfl/djh/frame";
    }

    /**
     * 待校核查询列表
     * @return
     */
    @RequestMapping(value = "djhList.do")
    public String djhList() {
    	request.setAttribute("flag", req.getValue(request, "flag"));
        request.setAttribute("list", cgjcService.getDjhList(request));//部门内人员可见
        return COM_PATH +"qxfl/djh/list";
    }
    
    /**
     * 校核报告信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "jhBg.do")
    public void jhBg(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        this.writeText(cgjcService.jhBgInfo(request), response);
    }
    
    /**
     * 退回报告信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "thBg.do")
    public void thBg(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        this.writeText(cgjcService.thBgInfo(request), response);
    }
    
    /**
     * 待签发报告
     * 总经理可视、操作
     * 
     */
    /**
     * 待签发frame界面
     * @return
     */
    @RequestMapping(value = "dqfFrame.do")
    public String dqfFrame() {
        request.setAttribute("yearsList", cgjcService.getNdList(request));
        request.setAttribute("flag", req.getValue(request, "flag"));
        return COM_PATH +"qxfl/dqf/frame";
    }
    
    /**
     * 待签发查询列表
     * @return
     */
    @RequestMapping(value = "dqfList.do")
    public String dqfList() {
    	request.setAttribute("flag", req.getValue(request, "flag"));
        request.setAttribute("list", cgjcService.getDqfList(request));//部门内人员可见
        return COM_PATH +"qxfl/dqf/list";
    }
    
    /**
     * 签发报告信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "qfBg.do")
    public void qfBg(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        this.writeText(cgjcService.qfBgInfo(request), response);
    }
    
    /**
     * 签发退回报告信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "qfThBg.do")
    public void qfThBg(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        this.writeText(cgjcService.qfThBgInfo(request), response);
    }
    
    /**
     * 签发退回报告信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveThInfo.do")
    public void saveThInfo(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        this.writeText(cgjcService.saveThInfo(request), response);
    }
    
    /* 退回页面
     * @return
     */
    @RequestMapping(value = "thEdit.do")
    public String thEdit() {
 	   String baseId = req.getValue(request, "id");
        request.setAttribute("baseId", baseId);//基本信息id
        request.setAttribute("url", req.getValue(request, "url"));
        request.setAttribute("flag", req.getValue(request, "flag"));
        request.setAttribute("smList", cgjcService.getThList(request));
        return COM_PATH +"qxfl/cgjc/jcdw/thedit";
    }
    
    /**
     * 待打印
     * 全视野
     */
    /**
     * 待打印frame界面
     * @return
     */
    @RequestMapping(value = "ddyFrame.do")
    public String ddyFrame() {
        request.setAttribute("yearsList", cgjcService.getNdList(request));
        return COM_PATH +"qxfl/ddy/frame";
    }
    
    /**
     * 待打印查询列表
     * @return
     */
    @RequestMapping(value = "ddyList.do")
    public String ddyList() {
        request.setAttribute("list", cgjcService.getDdyList(request));
        return COM_PATH +"qxfl/ddy/list";
    }
    
    /**
     * 打印信息预览
     * @return
     */
    @RequestMapping(value = "ddyShowInfo.do")
    public String ddyShowInfo() {
        //request.setAttribute("jcdwInfo", cgjcService.getUserInfo(request));
    	request.setAttribute("bggcList", cgjcService.getHyTypeList2(request, "10006"));//报告构成
    	
        request.setAttribute("baseInfo", cgjcService.getDdyBaseInfo2(request));//基本信息
        request.setAttribute("orgJcdwInfo", cgjcService.getOrgJcdwInfo(request));//说明事项的组织检测部信息
        
        request.setAttribute("yqsbList", cgjcService.getYqsbList1(request));//仪器设备信息
        request.setAttribute("yqsbCount", cgjcService.getYqsbCount(request));//仪器设备信息计数
        request.setAttribute("jcyjList", cgjcService.getHyTypeList1(request, "10025"));//检测依据
        request.setAttribute("showFDInfos", cgjcService.getFzjlPbddwInfo(request));//防直接雷、屏蔽等电位及接地信息
        request.setAttribute("dqxtList", cgjcService.getDqdybhqInfos(request));//电气系统电涌保护器
        request.setAttribute("xhtkList", cgjcService.getXhtkInfoList(request));//信号天馈电涌保护器
        request.setAttribute("dzxtList", cgjcService.getDzxtInfoList(request));//电子系统
        
        request.setAttribute("infoList", cgjcService.getInfosList1(request));//循环列表
        
        request.setAttribute("photosList", cgjcService.getPhotos(request));//示意图or照片
        
        
        
        
        Calendar now = Calendar.getInstance();  
        
        String today = DateHelper.getToday("YYYYMMdd");
        request.setAttribute("nowDate", today);//示意图or照片
        
        
        return COM_PATH +"qxfl/ddy/show";
    }
    
    /**
     * 流程状态更新为已打印
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "ydyNum.do")
    public void ydyNum(HttpServletResponse response) {
    	//xml解析错误
    	//response 追加字节编码格式解决
    	response.setContentType("text/text;charset=utf-8");
    	response.setCharacterEncoding("UTF-8");
        this.writeText(cgjcService.UpLcydyNum(request), response);
    }
    
}
