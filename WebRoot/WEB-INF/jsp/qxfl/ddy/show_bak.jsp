<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/inc/includeBase.jsp" %>
<head>
	<title> 
		连云港市长虹防雷工程中心
	</title>
</head>
	<body scroll="yes" style="background-color: white;">
	<br/>
	<div id="btn" name="btn" style="width: 100%;">
		<center>
			<zcc:button cssClass="ovalbutton" onclick="waitPrint();">打印</zcc:button>
		</center>
	</div>
	<div style="width: 100%;" id="printDiv" name="printDiv">
	<center>
		<form id="form1" name="form1" action=""  style="background-color: white;">
			<div style="width: 100%; text-align: center; padding-top: 20px; padding-bottom: 15px;">
				<font size="4"> <b>防 雷 装 置 综 合 检 测 报 告</b></font>
			</div>
			<div style="width: 100%; text-align: center; padding-bottom: 5px;">
				<font size="3">基本信息汇总表</font>
			</div>
			<div style="width: 100%; text-align: left; padding-bottom: 3px; margin-left: 10px;" >
				报告编号：${baseInfo.bg_id }
			</div>
			   <table  width="100%" align="center" border="1" style="text-align: center;">
					<tr height="40px">
	               		<td style="width: 15%;">
							单位名称
	                	</td>
	                	<td style="width: 45%;">
	                		${baseInfo.dw_name }
	                	</td>
	                	<td style="width: 15%;" >
							行政区域
	                	</td>
	                	<td style="width: 25%;">
	                		${baseInfo.xzqy }
	                	</td>
	                </tr>
					<tr height="40px">
	               		<td  >
							行业类别
	                	</td>
	                	<td >
	                		${baseInfo.hy_type }
	                	</td>
	                	<td  >
							单位法人
	                	</td>
	                	<td >
	                		${baseInfo.dw_fr }
	                	</td>
	                </tr>
	                <tr height="40px">
	               		<td  >
							经度E
	                	</td>
	                	<td >
	                		${baseInfo.jd }
	                	</td>
	                	<td  >
							纬度N
	                	</td>
	                	<td >
	                		${baseInfo.wd }
	                	</td>
	                </tr>
	                <tr height="40px">
	               		<td  >
							联系部门
	                	</td>
	                	<td >
	                		${baseInfo.lx_bm }
	                	</td>
	                	<td  >
							联系人
	                	</td>
	                	<td >
	                		${baseInfo.lxr }
	                	</td>
	                </tr>
	                <tr height="40px">
	               		<td  >
							联系电话
	                	</td>
	                	<td >
	                		${baseInfo.lxr_phone }
	                	</td>
	                	<td  >
							检测周期
	                	</td>
	                	<td >
	                		${baseInfo.jc_zq }
	                	</td>
	                </tr>
	                <tr height="40px">
	               		<td  >
							检测方法
	                	</td>
	                	<td >
	                		${baseInfo.jc_way }
	                	</td>
	                	<td  >
							年最大雷电流（KA）
	                	</td>
	                	<td >
	                		${baseInfo.nzddl }
	                	</td>
	                </tr>
	                <tr height="40px">
	               		<td  >
							检测属性
	                	</td>
	                	<td >
	                		${baseInfo.jc_sx_name }
	                	</td>
	                	<td  >
							检测意见
	                	</td>
	                	<td >
	                		是否符合国家现行规范：${baseInfo.jc_yj }
	                	</td>
	                </tr>
	                <tr height="40px">
	                	<td  >
							雷击大地的年平均密度（次/公里².年）
	                	</td>
	                	<td colspan="3">
	                		${baseInfo.npjmd }
	                	</td>
	                </tr>
	                <tr height="40px">
	               		<td  >
							报告构成
	                	</td>
	                	<td colspan="3">
	                		<zcc:checkboxlist name="bg_gc" id="bg_gc" list="bggcList" disabled="true"
								checkboxLabel="dd_item_name" checkboxValue="dd_item_code"
								value="${baseInfo.bg_gc}" delims="," columns="2"/>
	                	</td>
	                </tr>
	                <tr height="200px">
	               		<td  >
							整改或改进意见
	                	</td>
	                	<td  colspan="3" style="text-align: left;">
	                		${baseInfo.remark }
	                	</td>
	                </tr>
	                <tr height="40px">
	               		<td  >
							整改期限
	                	</td>
	                	<td colspan="3" style="text-align: left;">
	                		&nbsp;&nbsp;以上问题请在_____________________前予以整改，整改后即报复检。
	                	</td>
	                </tr>
	                <tr height="200px">
	               		<td  >
							复检情况
	                	</td>
	                	<td colspan="3" style="text-align: left;">
	                		
	                	</td>
	                </tr>
	                <tr height="40px">
	               		<td  >
							复检人
	                	</td>
	                	<td >
	                		
	                	</td>
	                	<td  >
							复核人
	                	</td>
	                	<td >
	                		
	                	</td>
	                </tr>
	                <tr height="40px">
	               		<td  >
							复检日期
	                	</td>
	                	<td >
	                		
	                	</td>
	                	<td  >
							天气实况
	                	</td>
	                	<td >
	                		${baseInfo.weather }
	                	</td>
	                </tr>
	                
			</table>
			<br>
	  </form>
	  <!-- 强制换页 -->
	  <div style="page-break-after: always;"></div>
	  
	  <c:forEach var="row" items="${showFDInfos }">
		  <form id="form2" name="form2" action=""  style="background-color: white;">
		  	<div style="width: 100%; text-align: center; padding-top: 20px; padding-bottom: 15px;">
				<font size="4"> <b>防 雷 装 置 综 合 检 测 报 告</b></font>
			</div>
			<div style="width: 100%; text-align: center; padding-bottom: 5px;">
				<font size="3">（A）防直击雷</font>
			</div>
			<div style="width: 100%; text-align: left; padding-bottom: 3px; margin-left: 10px;" >
				报告编号：${baseInfo.bg_id }
			</div>
		    
		  	<table  width="100%" align="center" border="1" style="text-align: center;">
		  		<tr height="35px">
		  			<td colspan="2">
		  				被保护物名称
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.bbhw_name }
		  			</td>
		  			<td>
		  				长/宽/高（m）
		  			</td>
		  			<td>
		  				${row.fzjlInfo.ckg }
		  			</td>
		  			<td>
		  				防雷类别
		  			</td>
		  			<td>
		  				${row.fzjlInfo.fl_type }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td colspan="2">
		  				检测项目
		  			</td>
		  			<td colspan="2">
		  				标准
		  			</td>
		  			<td colspan="2">
		  				检测结果
		  			</td>
		  			<td colspan="2">
		  				单项评定
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td rowspan="9">接闪器</td>
		  			<td colspan="1">
		  				形状
		  			</td>
		  			<td colspan="2">
		  				针/带/网/线/金属构件/金属屋面
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.sjq_xz }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.sjq_xz_rst  }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td colspan="1">
		  				高度（m）
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.sjq_gd }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.sjq_gd_rst }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td colspan="1">
		  				敷设方式
		  			</td>
		  			<td colspan="2">
		  				明敷、暗敷
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.sjq_fsfs }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.sjq_fsfs_rst }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td colspan="1">
		  				规格材质
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.sjq_ggcz }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.sjq_ggcz_rst }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td colspan="1">
		  				网格（m）
		  			</td>
		  			<td colspan="2">
		  				一类：≤5m X 5m 或 6m X 4m<br/>
		  				二类：≤10m X 10m 或 12m X 8m <br/>
		  				三类 ：≤20m X 20m 或 24m X 16m
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.sjq_wg }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.sjq_wg_rst }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td colspan="1">
		  				腐蚀状况
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.sjq_fscd }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.sjq_fscd_rst }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td colspan="1">
		  				固定状况
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.sjq_gdxz }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.sjq_gdxz_rst }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td colspan="1">
		  				连接状况
		  			</td>
		  			<td colspan="2">
		  				圆Fe与圆Fe长度L≥Fe 6Ф（双面）<br/>
		  				圆Fe与圆Fe长度L≥Fe 2w（三面）
		  			</td>
		  			<td colspan="2">
		  				缺省
		  			</td>
		  			<td colspan="2">
		  				缺省
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td colspan="1">
		  				保护范围
		  			</td>
		  			<td colspan="2">
		  				按滚球法或避雷网确定
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.sjq_bhfw }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.sjq_bhfw_rst }
		  			</td>
		  		</tr>
		  		
		  		<tr height="35px">
		  			<td rowspan="7">引下线</td>
		  			<td colspan="1">
		  				敷设方式
		  			</td>
		  			<td colspan="2">
		  				---
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.yxx_fsfs }
		  			</td>
		  			<td colspan="2">
		  				---
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td colspan="1">
		  				数量（根）
		  			</td>
		  			<td colspan="2">
		  				≥2根（一类、二类）
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.yxx_sl }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.yxx_sl_rst }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td colspan="1">
		  				间距（m）
		  			</td>
		  			<td colspan="2">
		  				一类≤12m;二类：≤18m;三类：≤25m
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.yxx_jj }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.yxx_jj_rst }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td colspan="1">
		  				规格材质（mm/mm²）
		  			</td>
		  			<td colspan="2">
		  				明敷：（圆Fe）Ф ≥ 8mm;(扁Fe)S≥48mm²<br/>
		  				暗敷： （圆Fe）Ф ≥ 10mm;(扁Fe)S≥80mm²<br/>
		  				烟囱：（圆Fe）Ф ≥ 12mm;(扁Fe)S≥100mm²
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.yxx_ggcz }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.yxx_ggcz_rst }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td colspan="1">
		  				腐蚀程度
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.yxx_fscd }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.yxx_fscd_rst }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td colspan="1">
		  				固定状况
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.yxx_gdzk }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.yxx_gdzk_rst }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td colspan="1">
		  				连接情况
		  			</td>
		  			<td colspan="2">
		  				同闪接器连接状况
		  			</td>
		  			<td colspan="2">
		  				缺省
		  			</td>
		  			<td colspan="2">
		  				缺省
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td rowspan="2">接地装置</td>
		  			<td colspan="1">
		  				规格材质（mm/mm²）
		  			</td>
		  			<td colspan="2">
		  				（圆Fe）Ф ≥ 10mm;(扁Fe)S≥100mm²
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.jdx_ggcz }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.jdx_ggcz_rst }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td colspan="1">
		  				腐蚀程度
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.jdx_fscd }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.jdx_fscd_rst }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td rowspan="4">
		  				屏蔽措施
		  			</td>
		  			<td>
		  				室外进总配电源线敷设方式
		  			</td>
		  			<td colspan="2">
		  				架空、埋地
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.pb_zdy_fsfs }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.pb_zdy_fsfs_rst }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td >
		  				室外进总配电源线属性
		  			</td>
		  			<td colspan="2">
		  				铠装/非铠装/穿金属管
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.pb_zdy_sx }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.pb_zdy_sx_rst }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td >
		  				室外进户信号线敷设方式
		  			</td>
		  			<td colspan="2">
		  				架空、埋地
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.pb_zxh_fsfs }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.pb_zxh_fsfs_rst }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td >
		  				室外进户信号线属性
		  			</td>
		  			<td colspan="2">
		  				铠装/非铠装/穿金属管
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.pb_zxh_sx }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.pb_zxh_sx_rst }
		  			</td>
		  		</tr>
		  		
		  		<tr height="70px">
		  			<td colspan="4" style="text-align: left;" >
		  				结论：<br/>${row.fzjlInfo.result }
		  			</td>
		  			<td colspan="4" style="text-align: left;">
		  				备注：<br/>
		  				${row.fzjlInfo.remark }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td width="10%">
		  				检测人
		  			</td>
		  			<td width="20%">
		  				${baseInfo.jcr }
		  			</td>
		  			<td width="15%">
		  				校核人
		  			</td>
		  			<td width="15%">
		  				${baseInfo.jhr }
		  			</td>
		  			<td width="10%">
		  				天气实况
		  			</td>
		  			<td width="10%">
		  				${baseInfo.weather }
		  			</td>
		  			<td width="10%">
		  				检测日期
		  			</td>
		  			<td width="10%">
		  				${baseInfo.jc_date }
		  			</td>
		  		</tr>
		  	</table>
		  </form>
		  
		  <div style="page-break-after: always;"></div>
		  
		  <!-- **************************************************************************************** -->
		  
		  <form id="form3" name="form3" action=""  style="background-color: white;">
		  	<div style="width: 100%; text-align: center; padding-top: 20px; padding-bottom: 15px;">
				<font size="4"> <b>防 雷 装 置 综 合 检 测 报 告</b></font>
			</div>
			<div style="width: 100%; text-align: center; padding-bottom: 5px;">
				<font size="3">（B）屏蔽、等电位及接地等</font>
			</div>
			<div style="width: 100%; text-align: left; padding-bottom: 3px; margin-left: 10px;" >
				报告编号：${baseInfo.bg_id }
			</div>
		    
		  	<table  width="100%" align="center" border="1" style="text-align: center;">
		  		<tr style="height: 40px;">
		  			<td width="10%">
		  				序号
		  			</td>
		  			<td width="25%">
		  				检测点
		  			</td>
		  			<td width="15%">
		  				属性
		  			</td>
		  			<td width="20%">
		  				规格/材质（mm/mm²）
		  			</td>
		  			<td width="15%">
		  				电阻值（Ω）
		  			</td>
		  			<td width="10%">
		  				单项评定
		  			</td>
		  			<c:forEach items="${row.PbList }" var="pb" varStatus="status">
		  				<tr style="height: 40px;">
		  					<td>
		  						${status.index + 1 }
		  					</td>
		  					<td>
		  						${pb.jcd }
		  					</td>
		  					<td>
		  						${pb.sx }
		  					</td>
		  					<td>
		  						${pb.ggcz }
		  					</td>
		  					<td>
		  						${pb.dzz }
		  					</td>
		  					<td>
		  						${pb.dx_result }
		  					</td>
		  				</tr>
		  			</c:forEach>
		  			
		  		</tr>
		  	</table>
		  </form>
		  <div style="page-break-after: always;"></div>
		  
	  </c:forEach>
	  
	  <!-- C表 -->
	  <c:forEach items="${dqxtList }" var="dqxt" >
	  	<form id="formC" name="formC"  style="background-color: white; width: 100%;">
	  		<div style="width: 100%; text-align: center; padding-top: 20px; padding-bottom: 15px;">
				<font size="4"> <b>防 雷 装 置 综 合 检 测 报 告</b></font>
			</div>
			<div style="width: 100%; text-align: center; padding-bottom: 5px;">
				<font size="3">（C）电气系统电涌保护器</font>
			</div>
			<div style="width: 100%; text-align: left; padding-bottom: 3px; margin-left: 10px;" >
				报告编号：${baseInfo.bg_id }
			</div>
			<table  width="100%" align="center" border="1" style="text-align: center;">
		  		<tr height="40px">
		  			<td colspan="2">
		  				被检测物位置
		  			</td>
		  			<td colspan="2">
		  				${dqxt.bjcwwz }
		  			</td>
		  			<td>
		  				型号
		  			</td>
		  			<td>
		  				${dqxt.xh }
		  			</td>
		  			<td>
		  				接地制式
		  			</td>
		  			<td>
		  				${dqxt.jdzs }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				检测项目
		  			</td>
		  			<td colspan="2">
		  				标准
		  			</td>
		  			<td colspan="2">
		  				检测结果
		  			</td>
		  			<td colspan="2">
		  				单项评定
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				安装数量(套)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dqxt.azsl }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.azsl_rst  }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				所在防雷区(LPZ)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dqxt.szflq }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.szflq_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				与前级之间距离(m)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dqxt.yqjjl }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.yqjjl_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				绝缘电阻
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dqxt.baqk }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.baqk_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				状态显示
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dqxt.ztxs }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.ztxs_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				施工工艺
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dqxt.sggy }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.sggy_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				电压保护水平Up(kV)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dqxt.dybhsp }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.dybhsp_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				最大持续工作电压(V)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dqxt.zdcxdy }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.zdcxdy_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				冲击电流limp(kA)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dqxt.cjdl }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.cjdl_rst }
		  			</td>
		  		</tr>
		  		
		  		<tr height="40px">
		  			<td colspan="2">
		  				标称⁄最大放电电流(kA)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dqxt.bczdfddl }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.bczdfddl_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				泄漏电流lie(A)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dqxt.ldl }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.ldl_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				后备保护装置规格(A)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dqxt.hbbhzz }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.hbbhzz_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				相、零线截面(mm²)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dqxt.xlxjm }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.xlxjm }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				接地线截面(mm²)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dqxt.jdxjm }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.jdxjm_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				压敏电压（U1mA）
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dqxt.qddy }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.qddy_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				接线长度(m)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dqxt.jxcd }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.jxcd_rst }
		  			</td>
		  		</tr>
		  		
		  		<tr height="70px">
		  			<td colspan="4" style="text-align: left;" >
		  				结论：<br/>${dqxt.result }
		  			</td>
		  			<td colspan="4" style="text-align: left;">
		  				备注：<br/>
		  				${dqxt.remark }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td width="10%">
		  				检测人
		  			</td>
		  			<td width="20%">
		  				${baseInfo.jcr }
		  			</td>
		  			<td width="15%">
		  				校核人
		  			</td>
		  			<td width="15%">
		  				${baseInfo.jhr }
		  			</td>
		  			<td width="10%">
		  				天气实况
		  			</td>
		  			<td width="10%">
		  				${baseInfo.weather }
		  			</td>
		  			<td width="10%">
		  				检测日期
		  			</td>
		  			<td width="10%">
		  				${baseInfo.jc_date }
		  			</td>
		  		</tr>
		  	</table>
		  	
	  	</form>
	  	<div style="page-break-after: always;"></div>
	  </c:forEach>	  
	  
	  <!-- D表 -->
	  <c:forEach items="${xhtkList }" var="xhtk" >
	  	<form id="formD" name="formD"  style="background-color: white; width: 100%;">
	  		<div style="width: 100%; text-align: center; padding-top: 20px; padding-bottom: 15px;">
				<font size="4"> <b>防 雷 装 置 综 合 检 测 报 告</b></font>
			</div>
			<div style="width: 100%; text-align: center; padding-bottom: 5px;">
				<font size="3">（D）信号天馈电涌保护器</font>
			</div>
			<div style="width: 100%; text-align: left; padding-bottom: 3px; margin-left: 10px;" >
				报告编号：${baseInfo.bg_id }
			</div>
			<table  width="100%" align="center" border="1" style="text-align: center;">
		  		<tr height="40px">
		  			<td colspan="">
		  				被检测物位置
		  			</td>
		  			<td colspan="">
		  				${xhtk.bjcwwz }
		  			</td>
		  			<td>
		  				类型
		  			</td>
		  			<td>
		  				${xhtk.type }
		  			</td>
		  			<td>
		  				型号
		  			</td>
		  			<td>
		  				${xhtk.xh }
		  			</td>
		  			<td colspan="">
		  				安装日期
		  			</td>
		  			<td colspan="">
		  				${xhtk.azrq }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				检测项目
		  			</td>
		  			<td colspan="2">
		  				标准
		  			</td>
		  			<td colspan="2">
		  				检测结果
		  			</td>
		  			<td colspan="2">
		  				单项评定
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				绝缘电阻
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${xhtk.baqk }
		  			</td>
		  			<td colspan="2">
		  				${xhtk.baqk_rst  }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				安装数量
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${xhtk.azsl }
		  			</td>
		  			<td colspan="2">
		  				${xhtk.azsl_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				标称通流量In⁄(kA)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${xhtk.bctll }
		  			</td>
		  			<td colspan="2">
		  				${xhtk.bctll_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				插入损耗
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${xhtk.crsh }
		  			</td>
		  			<td colspan="2">
		  				${xhtk.crsh_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				接地截面(mm²)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${xhtk.jdjm }
		  			</td>
		  			<td colspan="2">
		  				${xhtk.jdjm_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				接地线长度(m)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${xhtk.jdxcd }
		  			</td>
		  			<td colspan="2">
		  				${xhtk.jdxcd_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				施工工艺
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${xhtk.sggy }
		  			</td>
		  			<td colspan="2">
		  				${xhtk.sggy_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				电压驻波比
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${xhtk.dyzbb }
		  			</td>
		  			<td colspan="2">
		  				${xhtk.dyzbb_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				额定工作电压
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${xhtk.edgzdy }
		  			</td>
		  			<td colspan="2">
		  				${xhtk.edgzdy_rst }
		  			</td>
		  		</tr>
		  		
		  		<tr height="40px">
		  			<td colspan="2">
		  				电压保护水平
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${xhtk.dybhsp }
		  			</td>
		  			<td colspan="2">
		  				${xhtk.dybhsp_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td colspan="2">
		  				所在防雷区(LPZ)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${xhtk.szflq }
		  			</td>
		  			<td colspan="2">
		  				${xhtk.szflq_rst }
		  			</td>
		  		</tr>
		  		
		  		<tr height="70px">
		  			<td colspan="4" style="text-align: left;" >
		  				结论：<br/>${xhtk.result }
		  			</td>
		  			<td colspan="4" style="text-align: left;">
		  				备注：<br/>
		  				${xhtk.remark }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td width="10%">
		  				检测人
		  			</td>
		  			<td width="20%">
		  				${baseInfo.jcr }
		  			</td>
		  			<td width="15%">
		  				校核人
		  			</td>
		  			<td width="15%">
		  				${baseInfo.jhr }
		  			</td>
		  			<td width="10%">
		  				天气实况
		  			</td>
		  			<td width="10%">
		  				${baseInfo.weather }
		  			</td>
		  			<td width="10%">
		  				检测日期
		  			</td>
		  			<td width="10%">
		  				${baseInfo.jc_date }
		  			</td>
		  		</tr>
		  	</table>
		  	
	  	</form>
	  	<div style="page-break-after: always;"></div>
	  </c:forEach>
	  
	  <!-- E表 -->
	  <c:forEach items="${dzxtList }" var="dzxt" >
	  	<form id="formD" name="formD"  style="background-color: white; width: 100%;">
	  		<div style="width: 100%; text-align: center; padding-top: 20px; padding-bottom: 15px;">
				<font size="4"> <b>防 雷 装 置 综 合 检 测 报 告</b></font>
			</div>
			<div style="width: 100%; text-align: center; padding-bottom: 5px;">
				<font size="3">（E）电子系统</font>
			</div>
			<div style="width: 100%; text-align: left; padding-bottom: 3px; margin-left: 10px;" >
				报告编号：${baseInfo.bg_id }
			</div>
			<table  width="100%" align="center" border="1" style="text-align: center;">
		  		<tr height="26px">
		  			<td colspan="2">
		  				机房名称
		  			</td>
		  			<td colspan="2">
		  				${dzxt.jf_name }
		  			</td>
		  			<td colspan="2">
		  				机房位置
		  			</td>
		  			<td colspan="2">
		  				${dzxt.jf_wz }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td colspan="2">
		  				机房面积
		  			</td>
		  			<td colspan="2">
		  				${dzxt.jfmj }
		  			</td>
		  			<td colspan="2">
		  				机房防雷等级
		  			</td>
		  			<td colspan="2">
		  				${dzxt.jf_fldj }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td colspan="2">
		  				所在大楼名称
		  			</td>
		  			<td colspan="2">
		  				${dzxt.szdl_fldj }
		  			</td>
		  			<td colspan="2">
		  				所在大楼防雷类别
		  			</td>
		  			<td colspan="2">
		  				${dzxt.szdl_fllb }
		  			</td>
		  		</tr>
		  		<tr height="70px">
		  			<td colspan="2">
		  				直击雷防护情况
		  			</td>
		  			<td colspan="6">
		  				${dzxt.zjl_fhqk }
		  			</td>
		  			
		  		</tr>
		  		<tr style="height: 35px;">
		  			<td  colspan="2">
		  				检测项目
		  			</td>
		  			<td colspan="2">
		  				标准
		  			</td>
		  			<td colspan="2">
		  				检测结果
		  			</td>
		  			<td colspan="2">
		  				单项评定
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td rowspan="7">
		  				机房环境及线缆屏蔽
		  			</td>
		  			<td >
		  				开机时机房温度(°C)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.kjs_wd }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.kjs_wd_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				开机时机房湿度
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.kjs_sd }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.kjs_sd_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				设备里外墙、柱、窗距离
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.qzcjl }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.qzcjl_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				机房电源线敷设方式
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.jfdy_fsfs }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.jfdy_fsfs_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				机房电源线属性
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.jfdy_sx }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.jfdy_sx_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				机房信号线敷设方式
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.jfxh_fsfs }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.jfxh_fsfs_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				机房信号线属性
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.jfxh_sx }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.jfxh_sx_rst  }
		  			</td>
		  		</tr>
		  		
		  		<tr height="26px">
		  			<td rowspan="16">
		  				等电位连接
		  			</td>
		  			<td >
		  				等电位连接结构
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_ljjg }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_ljjg_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				 总接地线规格材质(mm⁄mm²)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_czgg }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_czgg_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				总接地线腐蚀程度
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_jdx_fscd }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_jdx_fscd_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				总接地线连接状况
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_jdx_ljqk }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_jdx_ljqk_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				汇流排规格材质(mm⁄mm²)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_hlpggcz }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_hlpggcz_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				汇流排腐蚀程度
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_hlpfscd }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_hlpfscd_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				汇流排连接状况
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_hlpljzk }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_hlpljzk_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				 走线桥架跨接线规格材质(mm⁄mm²)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_zxggcz }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_zxggcz_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				走线桥架接地线规格材质(mm⁄mm²)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_zxjdggcz }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_zxjdggcz_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				走线桥架接地线连接状况
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_zxjdxljzk }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_zxjdxljzk_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				设备机架接地线规格材质(mm⁄mm²)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_spjdxgg }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_spjdxggf_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				设备机架接地线连接状况
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_sbjdxlj }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_sbjdxlj_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				光缆加强筋接地线规格材质(mm⁄mm²)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_gljdxgg }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_gljdxgg_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				 光缆加强筋接地线连接状况
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_gljdxlj }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_gljdxlj_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				电话配线架接地线规格材质(mm⁄mm²
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_dhxggcz }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_dhxggcz_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				 电话配架线接地线连接状况
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_dhxlj }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ddw_dhxlj_rst  }
		  			</td>
		  		</tr>
		  		<!-- ***************************************************** -->
		  		<tr height="26px">
		  			<td rowspan="9">
		  				  UPS后备电源及防静电 
		  			</td>
		  			<td >
		  				电压值(V)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ups_dyz }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ups_dyz_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				频率值(Hz)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ups_pl }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ups_pl_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				电压波形失真率
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ups_bxszl }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ups_bxszl_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				零-地电压(V)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ups_lddy }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ups_lddy_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				接地方式
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ups_jdfs }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ups_jdfs_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				设备表面静电电位(kV)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ups_jdw }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ups_jdw_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				静电地板表面电阻率(Ω⁄cm²)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ups_dzl }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ups_dzl_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				 静电地板接地线规格材质(mm⁄mm²)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ups_jdxgg }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ups_jdxgg_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px">
		  			<td >
		  				静电地板接地线连接状况
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ups_ljzk }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.ups_ljzk_rst  }
		  			</td>
		  		</tr>
		  		<tr height="26px" style="border: 0px;">
		  			<td width="10%" style="border: 0px;">
		  			</td>
		  			<td width="20%" style="border: 0px;">
		  			</td>
		  			<td width="15%" style="border: 0px;">
		  			</td>
		  			<td width="15%" style="border: 0px;">
		  			</td>
		  			<td width="10%" style="border: 0px;">
		  			</td>
		  			<td width="10%" style="border: 0px;">
		  			</td>
		  			<td width="10%" style="border: 0px;">
		  			</td>
		  			<td width="10%" style="border: 0px;">
		  			</td>
		  		</tr>
	  		</table>
	  	</form>
	  	<div style="page-break-after: always;"></div>
	  	
	  	<form id="formD" name="formD"  style="background-color: white; width: 100%;">
	  		<div style="width: 100%; text-align: center; padding-top: 20px; padding-bottom: 15px;">
				<font size="4"> <b>防 雷 装 置 综 合 检 测 报 告</b></font>
			</div>
			<div style="width: 100%; text-align: center; padding-bottom: 5px;">
				<font size="3">（E）电子系统（二）</font>
			</div>
			<div style="width: 100%; text-align: left; padding-bottom: 3px; margin-left: 10px;" >
				报告编号：${baseInfo.bg_id }
			</div>
			<table  width="100%" align="center" border="1" style="text-align: center;">
		  		<tr height="35px">
		  			<td rowspan="6">
		  				    室外天线 
		  			</td>
		  			<td >
		  				 接闪器形状
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.tx_xz }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.tx_xz_rst }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td >
		  				接闪器规格材质(mm⁄mm²)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.tx_ggcz }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.tx_ggcz_rst  }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td >
		  				接闪器腐蚀程度
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.tx_fscd }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.tx_fscd_rst  }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td >
		  				接闪器保护范围
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.tx_bhfw }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.tx_bhfw_rst  }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td >
		  				基座接地线规格材质(mm⁄mm²)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.tx_jdxggcz }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.tx_jdxggcz_rst  }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td >
		  				基座接地线腐蚀程度
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dzxt.tx_jdxfscd }
		  			</td>
		  			<td colspan="2">
		  				${dzxt.tx_jdxfscd_rst  }
		  			</td>
		  		</tr>
		  		<tr height="70px">
		  			<td colspan="4" style="text-align: left;" >
		  				结论：<br/>${dzxt.result }
		  			</td>
		  			<td colspan="4" style="text-align: left;">
		  				备注：<br/>
		  				${dzxt.remark }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td width="10%">
		  				检测人
		  			</td>
		  			<td width="20%">
		  				${baseInfo.jcr }
		  			</td>
		  			<td width="15%">
		  				校核人
		  			</td>
		  			<td width="15%">
		  				${baseInfo.jhr }
		  			</td>
		  			<td width="10%">
		  				天气实况
		  			</td>
		  			<td width="10%">
		  				${baseInfo.weather }
		  			</td>
		  			<td width="10%">
		  				检测日期
		  			</td>
		  			<td width="10%">
		  				${baseInfo.jc_date }
		  			</td>
		  		</tr>
		  	</table>
		  	
	  	</form>
	  	<div style="page-break-after: always;"></div>
	  </c:forEach>
	  
	  <!-- 末页 -->
	  <form id="form4" name="form4" action=""  style="background-color: white; width: 100%;" >
	  	<div style="width: 100px; padding-top: 30px; padding-bottom: 7px; padding-left: 15px; ">
	  		<nobr><font size="3">主要检测仪器设备</font></nobr>
	  	</div>
	  	<div id="queryPanel_content" class="queryPanel_content"
			style="position: relative;">
		  	<zcc:checkboxlist name="yqsb" id="yqsb" list="yqsbList" disabled="true"
				checkboxLabel="yq_name" checkboxValue="id"
				value="${baseInfo.yqsb_info}" delims="," columns="1"/>
		</div>
		</table> 
		<div style="width: 100px; padding-top: 30px; padding-bottom: 7px; padding-left: 15px; ">
	  		<nobr><font size="3">主要检测依据规范</font></nobr>
	  	</div>
	  	<div id="queryPanel_content" class="queryPanel_content"
			style="position: relative;">
		  	<zcc:checkboxlist name="jyj" id="jyj" list="jcyjList" disabled="true"
				checkboxLabel="dd_item_name" checkboxValue="dd_item_code"
				value="${baseInfo.jyj}" delims="," columns="1"/>
		</div>
	  </form>
  </center>
  <form id="form5" name="form5" action="">
	  <div id="queryPanel_content" class="queryPanel_content"
			style="position: relative; background-color: white; padding-top: 25px; margin-top: 5px;">
			检测方法： ${baseInfo.jc_way }<br/>
			天气实况：  ${baseInfo.weather }<br/><br/>
			<div>
				主检人：<img src="<%=request.getContextPath()%>/pic/${baseInfo.jcr_qm}"  width="100px" height="50px" />
			</div>
			<div>
				校核人：<img src="<%=request.getContextPath()%>/pic/${baseInfo.jhr_qm}"  width="100px" height="50px" /> 
			</div>
			<div>
				签发人：<img src="<%=request.getContextPath()%>/pic/${baseInfo.jfr_qm}"  width="100px" height="50px" /> 
			</div>
		</div>
		<div style="padding-top: 50px; background-color: white; padding-left: 450px;">
			检测单位<br/>&nbsp;<br/>
			${baseInfo.jc_date }
		</div>
	</form>
	<div style="page-break-after: always;"></div>
	
	<c:forEach items="${photosList }" var="pho" >
		<form id="form6" name="form6" action=""  style="background-color: white; width: 100%;" >
			<div style="width: 100%; text-align: center; padding-top: 20px; padding-bottom: 15px;">
				<font size="4"> <b>防 雷 装 置 综 合 检 测 报 告</b></font>
			</div>
			<div style="width: 100%; text-align: center; padding-bottom: 5px;">
				<font size="3"> ${pho.cl_type == 1 ? "示意图 " : "照片" }  </font>
			</div>
			<div style="width: 100%; text-align: left; padding-bottom: 3px; margin-left: 10px;" >
				报告编号：${baseInfo.bg_id }
			</div>
			<div style="width: 800px; height: 900px;">
				<img src="<%=request.getContextPath()%>/showphoto/${pho.cl_name_d}" width="100%" height="100%" />
			</div>
		</form>
		
		<div style="page-break-after: always;"></div>
	</c:forEach>
	
  </div>
</body>
<script type="text/javascript">
	
  //延时打印
  //waitPrint();
  function waitPrint(){
  	setTimeout(function() {
  		if(window.confirm("确认打印该报告？")){
  			var res = '0';
			res = new MyJqueryAjax('${app}/cgjc/cgjc/ydyNum.do','id='+'${baseInfo.id}').request();
  			if(res == 0){
  				res = 1;
  			}
  			if(res == 1){
  				//wb.ExecWB(7,1);
  				UserPrint();
  			}else{
  				alert('打印机调用失败！');
  				return false;
  			}
	  	}
  	}, 100)
  }
  
  //打印方法
  function UserPrint(){
     bdhtml=window.document.body.innerHtml; 
     var headstr = "<html><head></head><body>";
     var footstr = "</body>"; 
     var bodystr = document.all.item("printDiv").innerHTML;                     
     var oldstr = document.body.innerHTML; 
     
     document.body.innerHTML = headstr + bodystr + footstr;  
     //pagesetup_null();     
     window.print();          
     //pagesetup_default();
     document.body.innerHTML = oldstr;
     return false;   
   }       
   
   var hkey_root,hkey_path,hkey_key
   hkey_root="HKEY_CURRENT_USER"
   hkey_path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\"
   
   //水印
	watermark({watermark_txt: "<p style='text-align: center;'>连云港市长虹防雷<br>工程中心<br>${nowDate}</p>", watermark_objName: "printDiv"})//传入动态水印内容
	//watermark({watermark_txt: "<p style='text-align: center;'>${operName}<br>${orgName}<br>${nowDate}</p>"})//传入动态水印内容
	function watermark(settings) {
    //默认设置
    var defaultSettings={
    	watermark_objName:"id",//容器
        watermark_txt:"text",
        watermark_x:70,//水印起始位置x轴坐标
        watermark_y:80,//水印起始位置Y轴坐标
        watermark_rows:10000,//水印行数
        watermark_cols:10000,//水印列数
        watermark_x_space:80,//水印x轴间隔
        watermark_y_space:400,//水印y轴间隔
        watermark_color:'#000000',//水印字体颜色
        watermark_alpha:0.1,//水印透明度
        watermark_fontsize:'18px',//水印字体大小
        watermark_font:'微软雅黑',//水印字体
        watermark_width:200,//水印宽度
        watermark_height:80,//水印长度
        watermark_angle:30//水印倾斜度数
    };
    //采用配置项替换默认值，作用类似jquery.extend
    if(arguments.length===1&&typeof arguments[0] ==="object" )
    {
        var src=arguments[0]||{};
        for(key in src)
        {
            if(src[key]&&defaultSettings[key]&&src[key]===defaultSettings[key])
                continue;
            else if(src[key])
                defaultSettings[key]=src[key];
        }
    }
    //页面
    var oTemp = document.createDocumentFragment();
    //获取页面最大宽度
    //var page_width = Math.max(document.body.scrollWidth,document.body.clientWidth);
    //获取页面最大长度
    //var page_height = Math.max(document.body.scrollHeight,document.body.clientHeight);
    
    //id
    var obj=document.getElementById(defaultSettings.watermark_objName);
    //获取页面最大宽度
    var page_width = obj.offsetWidth; //Math.max(document.body.scrollWidth,document.body.clientWidth);
    //获取页面最大长度
    var page_height = obj.offsetHeight ;//Math.max(document.body.scrollHeight,document.body.clientHeight);
    
    
    //如果将水印列数设置为0，或水印列数设置过大，超过页面最大宽度，则重新计算水印列数和水印x轴间隔
    if (defaultSettings.watermark_cols == 0 ||
   　　　　(parseInt(defaultSettings.watermark_x 
　　　　+ defaultSettings.watermark_width *defaultSettings.watermark_cols 
　　　　+ defaultSettings.watermark_x_space * (defaultSettings.watermark_cols - 1)) 
　　　　> page_width)) {
        defaultSettings.watermark_cols = 
　　　　　　parseInt((page_width-defaultSettings.watermark_x
　　　　　　　　　　+defaultSettings.watermark_x_space) 
　　　　　　　　　　/ (defaultSettings.watermark_width 
　　　　　　　　　　+ defaultSettings.watermark_x_space));
        defaultSettings.watermark_x_space = 
　　　　　　parseInt((page_width 
　　　　　　　　　　- defaultSettings.watermark_x 
　　　　　　　　　　- defaultSettings.watermark_width 
　　　　　　　　　　* defaultSettings.watermark_cols) 
　　　　　　　　　　/ (defaultSettings.watermark_cols - 1));
    }

    //如果将水印行数设置为0，或水印行数设置过大，超过页面最大长度，则重新计算水印行数和水印y轴间隔
    if (defaultSettings.watermark_rows == 0 ||
   　　　　(parseInt(defaultSettings.watermark_y 
　　　　+ defaultSettings.watermark_height * defaultSettings.watermark_rows 
　　　　+ defaultSettings.watermark_y_space * (defaultSettings.watermark_rows - 1)) 
　　　　> page_height)) {
        defaultSettings.watermark_rows = 
　　　　　　parseInt((defaultSettings.watermark_y_space 
　　　　　　　　　　　+ page_height - defaultSettings.watermark_y) 
　　　　　　　　　　　/ (defaultSettings.watermark_height + defaultSettings.watermark_y_space));
        defaultSettings.watermark_y_space = 
　　　　　　parseInt((page_height 
　　　　　　　　　　- defaultSettings.watermark_y 
　　　　　　　　　　- defaultSettings.watermark_height 
　　　　　　　　　　* defaultSettings.watermark_rows) 
　　　　　　　　　/ (defaultSettings.watermark_rows - 1));
    }
    var x;
    var y;
    for (var i = 0; i < defaultSettings.watermark_rows; i++) {
        y = defaultSettings.watermark_y + (defaultSettings.watermark_y_space + defaultSettings.watermark_height) * i;
        for (var j = 0; j < defaultSettings.watermark_cols; j++) {
            x = defaultSettings.watermark_x + (defaultSettings.watermark_width + defaultSettings.watermark_x_space) * j;
            var mask_div = document.createElement('div');
            mask_div.id = 'mask_div' + i + j;
            var _text = document.createElement("span");
            _text.innerHTML = defaultSettings.watermark_txt;
            mask_div.appendChild(_text);
            //mask_div.appendChild(document.createTextNode(defaultSettings.watermark_txt));
            //设置水印div倾斜显示
            
            mask_div.style.webkitTransform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
            mask_div.style.MozTransform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
            mask_div.style.msTransform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
            mask_div.style.OTransform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
            mask_div.style.transform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
            mask_div.style.visibility = "";
            mask_div.style.position = "absolute";
            mask_div.style.left = x + 'px';
            mask_div.style.top = y + 'px';
            mask_div.style.overflow = "hidden";
            mask_div.style.zIndex = "9999";
            //mask_div.style.border="solid #eee 1px";
            mask_div.style.opacity = defaultSettings.watermark_alpha;
            mask_div.style.filter = 'alpha(opacity=30)';
            mask_div.style.fontSize = defaultSettings.watermark_fontsize;
            mask_div.style.fontFamily = defaultSettings.watermark_font;
            mask_div.style.color = defaultSettings.watermark_color;
            mask_div.style.textAlign = "center";
            mask_div.style.width = defaultSettings.watermark_width + 'px';
            mask_div.style.height = defaultSettings.watermark_height + 'px';
            mask_div.style.display = "block";
            oTemp.appendChild(mask_div);
        };
    };
    //document.body.appendChild(oTemp);
    obj.appendChild(oTemp);
}
	
	
</script>
</html>