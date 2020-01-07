<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>电子系统</title>
		<%@ include file="/inc/includeBase.jsp"%>
	</head>
	<body >
		<form id="form1" name="form1" method="post" action="${app}/cgjc/cgjc/dzxtSave.do" >
			<input type="hidden" value="${dzxtInfo.id }" id="id" name="id" />
			<input type="hidden" value="${base_id }" id="base_id" name="base_id" />
			
			<div id="queryPanel" class="queryPanel">
				<div id="queryPanel_title" class="queryPanel_title">
					<div class="queryPanel_title_collapse"></div>
					&nbsp;机房信息
				</div>
				<div id="queryPanel_content" class="queryPanel_content"
					style="position: relative;">
					<table class="form_table" width="98%" align="center" >
						<tr height="26px">
		               		<td class="outDetail" style="width: 20%;">
								机房名称:<label style="color:red">*</label>
		                	</td>
		                	<td class="outDetail2" style="width: 30%;">
		                		<input type="text" id="jf_name" name="jf_name" size="35"
		                			value="${dzxtInfo.jf_name }" dataType="Require" msg="请输入机房名称!" />
		                	</td>
		                	<td class="outDetail" style="width: 20%;">
								机房位置:
		                	</td>
		                	<td class="outDetail2" style="width: 30%;">
		                		<input type="text" id="jf_wz" name="jf_wz" size="35"
		                			value="${dzxtInfo.jf_wz }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								机房面积: 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="jfmj" name="jfmj" 
		                			value="${dzxtInfo.jfmj }"  /> 
		                	</td>
		                	<td class="outDetail"  >
								机房防雷等级:
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="jf_fldj" id="jf_fldj" list="jfflList" style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.jf_fldj }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								所在大楼名称:  
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="szdl_fldj" name="szdl_fldj" 
		                			value="${dzxtInfo.szdl_fldj }"  /> 
		                	</td>
		                	<td class="outDetail"  >
								所在大楼防雷类别:
		                	</td>
		                	<td class="outDetail2"  >
		                		
								<zcc:select name="szdl_fllb" id="szdl_fllb" list="fllbList" style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.szdl_fllb }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								直击雷防护情况:  
		                	</td>
		                	<td class="outDetail2" colspan="3" >
		                		<textarea rows="4" cols="68" id="zjl_fhqk" name="zjl_fhqk">${dzxtInfo.zjl_fhqk }</textarea>
		                	</td>
		                </tr>
	                 </table>
				</div>
			</div>
		    <div id="queryPanel" class="queryPanel">
				<div id="queryPanel_title" class="queryPanel_title">
					<div class="queryPanel_title_collapse"></div>
					&nbsp;机房环境及线缆屏蔽 
				</div>
				<div id="queryPanel_content" class="queryPanel_content"
					style="position: relative;">
					<table class="form_table" width="98%" align="center" >            
		                
		                <tr height="26px">
		               		<td class="outDetail"  >
								开机时机房温度(°C): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="kjs_wd" name="kjs_wd" value="${dzxtInfo.kjs_wd }" />
		                		&nbsp;
								<zcc:select name="kjs_wd_rst" id="kjs_wd_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.kjs_wd_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								开机时机房湿度: 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="kjs_sd" name="kjs_sd" value="${dzxtInfo.kjs_sd }" />
		                		&nbsp;
								<zcc:select name="kjs_sd_rst" id="kjs_sd_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.kjs_sd_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								设备里外墙、柱、窗距离: 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="qzcjl" name="qzcjl" value="${dzxtInfo.qzcjl }" />
		                		&nbsp;
								<zcc:select name="qzcjl_rst" id="qzcjl_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.qzcjl_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								机房电源线敷设方式: 
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="jfdy_fsfs" id="jfdy_fsfs" list="xfsfsList" style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.jfdy_fsfs }" />
		                		&nbsp;
								<zcc:select name="jfdy_fsfs_rst" id="jfdy_fsfs_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.jfdy_fsfs_rst }" />
		                	</td>
		                </tr>
		                
		                <tr height="26px">
		               		<td class="outDetail"  >
								机房电源线属性:  
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="jfdy_sx" id="jfdy_sx" list="xsxList"
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.jfdy_sx }" />
								&nbsp;
								<zcc:select name="jfdy_sx_rst" id="jfdy_sx_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.jfdy_sx_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								机房信号线敷设方式: 
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="jfxh_fsfs" id="jfxh_fsfs" list="xfsfsList"
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.jfxh_fsfs }" />
		                		&nbsp;
								<zcc:select name="jfxh_fsfs_rst" id="jfxh_fsfs_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.jfxh_fsfs_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								机房信号线属性: 
		                	</td>
		                	<td class="outDetail2" colspan="3" >
		                		<zcc:select name="jfxh_sx" id="jfxh_sx" list="xsxList"
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.jfxh_sx }" />
								&nbsp;
								<zcc:select name="jfxh_sx_rst" id="jfxh_sx_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.jfxh_sx_rst }" />
		                	</td> 
		                </tr> 
		            </table>
				</div>
			</div>
			<div id="queryPanel" class="queryPanel">
				<div id="queryPanel_title" class="queryPanel_title">
					<div class="queryPanel_title_collapse"></div>
					&nbsp;等电位连接 
				</div>
				<div id="queryPanel_content" class="queryPanel_content"
					style="position: relative;">
					<table class="form_table" width="98%" align="center" >            
		                
		                <tr height="26px">
		               		<td class="outDetail"  >
								等电位连接结构: 
		                	</td>
		                	<td class="outDetail2" style="width: 30%;" >
		                		<zcc:select name="ddw_ljjg" id="ddw_ljjg" list="ddwllList" style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_ljjg }" />
		                		&nbsp;
								<zcc:select name="ddw_ljjg_rst" id="ddw_ljjg_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_ljjg_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								总接地线规格材质(mm⁄mm²):
		                	</td>
		                	<td class="outDetail2" style="width: 30%;" >
		                		<input type="text" id="ddw_czgg" name="ddw_czgg" value="${dzxtInfo.ddw_czgg }" />
		                		&nbsp;
								<zcc:select name="ddw_czgg_rst" id="ddw_czgg_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_czgg_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								总接地线腐蚀程度: 
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="ddw_jdx_fscd" id="ddw_jdx_fscd" list="fscdList" style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_jdx_fscd }" />
		                		&nbsp;
								<zcc:select name="ddw_jdx_fscd_rst" id="ddw_jdx_fscd_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_jdx_fscd_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								总接地线连接状况: 
		                	</td>
		                	<td class="outDetail2"  > 
		                		<zcc:select name="ddw_jdx_ljqk" id="ddw_jdx_ljqk" list="yxzcList" style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_jdx_ljqk }" />
		                		&nbsp;
								<zcc:select name="ddw_jdx_ljqk_rst" id="ddw_jdx_ljqk_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_jdx_ljqk_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								汇流排规格材质(mm⁄mm²):
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="ddw_hlpggcz" name="ddw_hlpggcz" value="${dzxtInfo.ddw_hlpggcz }" />
		                		&nbsp;
								<zcc:select name="ddw_hlpggcz_rst" id="ddw_hlpggcz_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_hlpggcz_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								汇流排腐蚀程度: 
		                	</td>
		                	<td class="outDetail2"  > 
		                		<zcc:select name="ddw_hlpfscd" id="ddw_hlpfscd" list="fscdList" style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_hlpfscd }" />
		                		&nbsp;
								<zcc:select name="ddw_hlpfscd_rst" id="ddw_hlpfscd_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_hlpfscd_rst }" />
		                	</td>
		                </tr>
		                
		                
		                <tr height="26px">
		               		<td class="outDetail"  >
								汇流排连接状况: 
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="ddw_hlpljzk" id="ddw_hlpljzk" list="yxzcList"
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_hlpljzk }" />
								&nbsp;
								<zcc:select name="ddw_hlpljzk_rst" id="ddw_hlpljzk_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_hlpljzk_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								走线桥架跨接线规格材质(mm⁄mm²):
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="ddw_zxggcz" name="ddw_zxggcz" value="${dzxtInfo.ddw_zxggcz }" />
		                		&nbsp;
								<zcc:select name="ddw_zxggcz_rst" id="ddw_zxggcz_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_zxggcz_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								走线桥架接地线规格材质(mm⁄mm²): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="ddw_zxjdggcz" name="ddw_zxjdggcz" value="${dzxtInfo.ddw_zxjdggcz }" />
								&nbsp;
								<zcc:select name="ddw_zxjdggcz_rst" id="ddw_zxjdggcz_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_zxjdggcz_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								走线桥架接地线连接状况:
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="ddw_zxjdxljzk" id="ddw_zxjdxljzk" list="yxzcList"
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_zxjdxljzk }" />
		                		&nbsp;
								<zcc:select name="ddw_zxjdxljzk_rst" id="ddw_zxjdxljzk_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_zxjdxljzk_rst }" />
		                	</td>
		                </tr> 
		                <tr height="26px">
		               		<td class="outDetail"  >
								设备机架接地线规格材质(mm⁄mm²): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="ddw_spjdxgg" name="ddw_spjdxgg" value="${dzxtInfo.ddw_spjdxgg }" />
								&nbsp;
								<zcc:select name="ddw_spjdxggf_rst" id="ddw_spjdxggf_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_spjdxggf_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								设备机架接地线连接状况: 
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="ddw_sbjdxlj" id="ddw_sbjdxlj" list="yxzcList"
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_sbjdxlj }" />
		                		&nbsp;
								<zcc:select name="ddw_sbjdxlj_rst" id="ddw_sbjdxlj_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_sbjdxlj_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								光缆加强筋接地线规格材质(mm⁄mm²):
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="ddw_gljdxgg" name="ddw_gljdxgg" value="${dzxtInfo.ddw_gljdxgg }" />
								&nbsp;
								<zcc:select name="ddw_gljdxgg_rst" id="ddw_gljdxgg_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_gljdxgg_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								光缆加强筋接地线连接状况:
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="ddw_gljdxlj" id="ddw_gljdxlj" list="yxzcList"
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_gljdxlj }" />
		                		&nbsp;
								<zcc:select name="ddw_gljdxlj_rst" id="ddw_gljdxlj_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_gljdxlj_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								电话配线架接地线规格材质(mm⁄mm²):
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="ddw_dhxggcz" name="ddw_dhxggcz" value="${dzxtInfo.ddw_dhxggcz }" />
								&nbsp;
								<zcc:select name="ddw_dhxggcz_rst" id="ddw_dhxggcz_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_dhxggcz_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								电话配架线接地线连接状况:
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="ddw_dhxlj" id="ddw_dhxlj" list="yxzcList"
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_dhxlj }" />
		                		&nbsp;
								<zcc:select name="ddw_dhxlj_rst" id="ddw_dhxlj_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ddw_dhxlj_rst }" />
		                	</td>
		                </tr>
		                
		            </table>
				</div>
			</div>
			<div id="queryPanel" class="queryPanel">
				<div id="queryPanel_title" class="queryPanel_title">
					<div class="queryPanel_title_collapse"></div>
					&nbsp;UPS后备电源及防静电 
				</div>
				<div id="queryPanel_content" class="queryPanel_content"
					style="position: relative;">
					<table class="form_table" width="98%" align="center" >            
		                
		                <tr height="26px">
		               		<td class="outDetail"  >
								电压值(V): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="ups_dyz" name="ups_dyz" value="${dzxtInfo.ups_dyz }" />
		                		&nbsp;
								<zcc:select name="ups_dyz_rst" id="ups_dyz_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ups_dyz_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								频率值(Hz): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="ups_pl" name="ups_pl" value="${dzxtInfo.ups_pl }" />
		                		&nbsp;
								<zcc:select name="ups_pl_rst" id="ups_pl_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ups_pl_rst }" />
		                	</td>
		                </tr>
						<tr height="26px">
		               		<td class="outDetail"  >
								电压波形失真率: 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="ups_bxszl" name="ups_bxszl" value="${dzxtInfo.ups_bxszl }" />
		                		&nbsp;
								<zcc:select name="ups_bxszl_rst" id="ups_bxszl_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ups_bxszl_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								零-地电压(V): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="ups_lddy" name="ups_lddy" value="${dzxtInfo.ups_lddy }" />
		                		&nbsp;
								<zcc:select name="ups_lddy_rst" id="ups_lddy_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ups_lddy_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								接地方式: 
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="ups_jdfs" id="ups_jdfs" list="jdList" style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ups_jdfs }" />
		                		&nbsp;
								<zcc:select name="ups_jdfs_rst" id="ups_jdfs_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ups_jdfs_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								设备表面静电电位(kV): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="ups_jdw" name="ups_jdw" value="${dzxtInfo.ups_jdw }" />
		                		&nbsp;
								<zcc:select name="ups_jdw_rst" id="ups_jdw_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ups_jdw_rst }" />
		                	</td>
		                </tr>		
		                <tr height="26px">
		               		<td class="outDetail"  >
								静电地板表面电阻率(Ω⁄cm²): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="ups_dzl" name="ups_dzl" value="${dzxtInfo.ups_dzl }" />
		                		&nbsp;
								<zcc:select name="ups_dzl_rst" id="ups_dzl_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ups_dzl_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								静电地板接地线规格材质(mm⁄mm²):
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="ups_jdxgg" name="ups_jdxgg" value="${dzxtInfo.ups_jdxgg }" />
		                		&nbsp;
								<zcc:select name="ups_jdxgg_rst" id="ups_jdxgg_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ups_jdxgg_rst }" />
		                	</td>
		                </tr>                
		                <tr height="26px">
		               		<td class="outDetail"  >
								静电地板接地线连接状况:
		                	</td>
		                	<td class="outDetail2" colspan="3" >
		                		<zcc:select name="ups_ljzk" id="ups_ljzk" list="yxzcList" style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ups_ljzk }" />
		                		&nbsp;
								<zcc:select name="ups_ljzk_rst" id="ups_ljzk_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.ups_ljzk_rst }" />
		                	</td>
		               </tr>
		                
		            </table>
				</div>
			</div>
			<div id="queryPanel" class="queryPanel">
				<div id="queryPanel_title" class="queryPanel_title">
					<div class="queryPanel_title_collapse"></div>
					&nbsp;室外天线 
				</div>
				<div id="queryPanel_content" class="queryPanel_content"
					style="position: relative;">
					<table class="form_table" width="98%" align="center" >            
		                
		                <tr height="26px">
		               		<td class="outDetail"  >
								接闪器形状: 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="tx_xz" name="tx_xz" value="${dzxtInfo.tx_xz }" />
		                		&nbsp;
								<zcc:select name="tx_xz_rst" id="tx_xz_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.tx_xz_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								接闪器规格材质(mm⁄mm²): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="tx_ggcz" name="tx_ggcz" value="${dzxtInfo.tx_ggcz }" />
		                		&nbsp;
								<zcc:select name="tx_ggcz_rst" id="tx_ggcz_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.tx_ggcz_rst }" />
		                	</td>
		                </tr>
						<tr height="26px">
		               		<td class="outDetail"  >
								接闪器腐蚀程度:
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="tx_fscd" id="tx_fscd" list="fscdList" style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.tx_fscd }" />
		                		&nbsp;
								<zcc:select name="tx_fscd_rst" id="tx_fscd_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.tx_fscd_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								接闪器保护范围:  
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="tx_bhfw" id="tx_bhfw" list="dbList" style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.tx_bhfw }" />
		                		&nbsp;
								<zcc:select name="tx_bhfw_rst" id="tx_bhfw_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.tx_bhfw_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								基座接地线规格材质(mm⁄mm²): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="tx_jdxggcz" name="tx_jdxggcz" value="${dzxtInfo.tx_jdxggcz }" />
		                		&nbsp;
								<zcc:select name="tx_jdxggcz_rst" id="tx_jdxggcz_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.tx_jdxggcz_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								基座接地线腐蚀程度:
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="tx_jdxfscd" id="tx_jdxfscd" list="fscdList" style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.tx_jdxfscd }" />
		                		&nbsp;
								<zcc:select name="tx_jdxfscd_rst" id="tx_jdxfscd_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.tx_jdxfscd_rst }" />
		                	</td>
		                </tr>		
		            </table>
				</div>
			</div>
			<div id="queryPanel" class="queryPanel">
				<div id="queryPanel_title" class="queryPanel_title">
					<div class="queryPanel_title_collapse"></div>
					&nbsp;结论及建议信息 
				</div>
				<div id="queryPanel_content" class="queryPanel_content"
					style="position: relative;">
					<table class="form_table" width="98%" align="center" >            
		                <tr height="26px">
							<td class="outDetail"  >
								单项结论
		                	</td>
		                	<td class="outDetail2" colspan="3">
		                		<zcc:select name="dx_result" id="dx_result" list="hgList" 
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.dx_result }" />
		                	</td>
						</tr>
						<tr height="26px">
							<td class="outDetail"  >
								结论
		                	</td>
		                	<td class="outDetail2" colspan="3">
		                		<zcc:select name="result" id="result" list="rstList" 
		                			style="width: 435px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dzxtInfo.result }" />
		                	</td>
						</tr>
						<tr height="26px">
							<td class="outDetail"  >
								备注
		                	</td>
		                	<td class="outDetail2" colspan="3">
		                		<textarea rows="3" cols="60" id="zgyj" name="zgyj" >${dzxtInfo.zgyj }</textarea>
		                	</td>
						</tr>
						<!-- <tr height="26px">
							<td class="outDetail"  >
								建议
		                	</td>
		                	<td class="outDetail2" colspan="3">
		                		<textarea rows="3" cols="60" id="jy" name="jy" >${dzxtInfo.jy }</textarea>
		                	</td>
						</tr>  -->
		            </table>
				</div>
			</div>
			
		<c:if test="${method != 'show' }">
		<div align="center">
			<zcc:button id="schbtn" cssClass="ovalbutton" 
         		onclick="savaInfo(this);return false;">保 存</zcc:button>
         		<br/>
         		<br/>
		</div>
		</c:if>
		</form>
	</body>
	<script type="text/javascript">
		var method = '${method}';
		var value = '${dzxtInfo.jf_name }' + '（复制）';
		if(method == 'copy'){
			$('#jf_name').val(value);
		}
		
		//全选
		$("#check_all").click(function() {
			if (this.checked) {
				$("[name=yqsb_info]").prop('checked', true)
			} else {
				$("[name=yqsb_info]").prop('checked', false)
			}
		})
		
		function savaInfo(src){
			src.disabled=true;
		 	if(!Validator.Validate("form1")){
				src.disabled = false ;
				return false;
			}
			form1.action = "${app}/cgjc/cgjc/dzxtSave.do?method="+'${method}';
			form1.submit();
		}
		
	</script>
</html>

