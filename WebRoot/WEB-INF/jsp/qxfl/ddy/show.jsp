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
		<div style='width:100%; display: flex; flex-direction:column;align-items:center;'>
		<div style="margin-left: 60%">
			<img src="${app}/images/ma.png"/>
		</div>
		<form id="form1" name="form1" action=""  style="background-color: white;width:100%; display: flex; justify-content:space-between;">
			<div style="width: 30%; text-align: left; margin-top: 25px;   margin-left: 10px;font-size: 14px" >
				报告编号：${baseInfo.bg_id }</br>
				档案编号：${baseInfo.da_id }
			</div>
			<div style="width: 30%; text-align: left; margin-top: 25px;   margin-right: 10px;font-size: 14px" >
				资质认证编号：171019130569</br>
				检测资质证号：1102017011
			</div>
	  	</form>
	  	<div style=' width:80%;margin:20px 10%;display:flex;flex-direction:column;align-items:center; height: 300px;'>
	  		<br/><br/><br/><br/><br/><br/>
	  		<!-- <input id="t4" style="font-size:18px;letter-spacing:1px;width:40%; border: 0; border-bottom: 1px solid #000;" />
	  		<span id="t44"  style="font-size:35px;font-weight:bold;line-height:2;width:40%;border-bottom:1px solid #000;"></span><br/> -->
	  		<span  style="font-size:38px;font-weight:bold;letter-spacing:2px;">防&nbsp;&nbsp;雷&nbsp;&nbsp;装&nbsp;&nbsp;置&nbsp;&nbsp;综&nbsp;&nbsp;合&nbsp;&nbsp;检&nbsp;&nbsp;测&nbsp;&nbsp;报&nbsp;&nbsp;告</span><br/>
	  	</div>
	  	<br/><br/><br/><br/><br/><br/><br/><br/><br/>
	  	<div style='width:80%;margin:40px 10%;display:flex;flex-direction:column;'>
	  		<div style='width:100%;margin:10px 0;display:flex;justify-content:flex-start'>
	  			<div style="font-size:22px;letter-spacing:1px;width:30%;">受检单位名称:</div>
	  			<!-- <input id="t1" style="font-size:22px;letter-spacing:1px;width:70%; border: 0; border-bottom: 1px solid #000;" /> -->
	  			 <div id="t11" style="font-size:22px;letter-spacing:1px;width:70%;border-bottom:1px solid #000">${baseInfo.dw_name }</div> 
	  		</div>
	  		<div style='width:100%;margin:10px 0;display:flex;justify-content:flex-start'>
	  			<div style="font-size:22px;letter-spacing:1px;width:30%;">受检单位地址:</div>
	  			<!-- <input id="t2" style="font-size:22px;letter-spacing:1px;width:70%; border: 0; border-bottom: 1px solid #000;" /> -->
	  			<div id="t22" style="font-size:22px;letter-spacing:1px;width:70%;border-bottom:1px solid #000">${baseInfo.dw_addr }</div>
	  		</div>
	  		<div style='width:100%;margin:10px 0;display:flex;justify-content:flex-start'>
	  			<div style="font-size:22px;letter-spacing:1px;width:30%;">检测有效期至:</div>
	  			<%-- <input id="t3" style="font-size:22px;letter-spacing:1px;width:70%; border: 0; border-bottom: 1px solid #000;" value="${baseInfo.yx_date }"/> --%>
	  			<div id="t33" style="font-size:22px;letter-spacing:1px;width:70%;border-bottom:1px solid #000;">${baseInfo.yx_date }</div>
	  		</div>
	  	</div>
	  	<br/><br/><br/><br/><br/><br/><br/><br/><br/>
	  	<div style='display:flex;flex-direction:column;'>
	  		<span  style="font-size:28px;font-weight:bold;line-height:2">连&nbsp;云&nbsp;港&nbsp;市&nbsp;长&nbsp;虹&nbsp;防&nbsp;雷</span>
	  		<span  style="font-size:28px;font-weight:bold;letter-spacing:2px;">工&nbsp;程&nbsp;中&nbsp;心</span>
	  	</div>
	  </div>
	   <div style="page-break-after: always;"></div>
	   <br/><br/>
	   <div style="margin-left: 50px;margin-right: 50px">
  	   <div style="font-size:29px;font-weight:bold">说明事项</div>
  	   <br/>
	   <div style="font-size:14px;text-align: left;text-indent: 50px;line-height: 40px">
	   	一、有下列行为之一者，本报告无效：
	   </div>
	   <div style="font-size:14px;text-align: left;text-indent: 50px;line-height: 40px">
	   	1、无本公司“检测检验专用章”、侧翼无骑缝章；
	   </div>
	   <div style="font-size:14px;text-align: left;text-indent: 50px;line-height: 40px">
	   	2、无“检测人、校核人、签发人”签名；
	   </div>
	   <div style="font-size:14px;text-align: left;text-indent: 50px;line-height:40px">
	   	3、部分复印本报告未重新加盖“检测检验专用章”；
	   </div>
	   <div style="font-size:14px;text-align: left;text-indent: 50px;line-height: 40px">
	   	4、涂改或缺页。
	   </div>
	   <div style="font-size:14px;text-align: left;text-indent: 50px;line-height: 40px">
	   	二、本报告只对被检测点有效。
	   </div>
	   <div style="font-size:14px;text-align: left;text-indent: 50px;line-height: 40px">
	   	三、本报告内页中“/”表示无此项目；“-”表示应该有此项目，但无技术指标要求。同时，“Fe”表示铁（钢）材质；“Cu”表示铜材质；“AL”表示铝材质；“S”表示截面；“φ”表示直径；“D”表示厚度；“w”表示宽度；“L”表示长度；“H”表示高度。
	   </div>
	   <div style="font-size:14px;text-align: left;text-indent: 50px;line-height: 40px">
		四、受检单位若对本报告有异议，须在收到本报告15天内提出，逾期即为认可，受理电话
		<!-- <input type="text" id="i_1" style="border: 0; border-bottom: 1px solid #000;font-size: 22px;"/> -->
		<span id="span_1" style="font-size:14px;text-align: left;line-height: 40px">${orgJcdwInfo.sl_phone }</span>。	  
	   </div>
	   <div style="font-size:14px;text-align: left;text-indent: 50px;line-height: 40px">
		五、防雷装置应每年检测一次，易燃易爆场所的防雷装置应每半年检测一次。
	   </div>
	   <div style="font-size:14px;text-align: left;text-indent: 50px;line-height: 40px">
		六、受检单位应贯彻“安全第一，预防为主，防治结合”的方针，应主动及时申报检测，加强对防雷装置的日常维护管理，指定专人负责，建立专门档案，以备查验。
	   </div>
	   <div style="font-size:14px;text-align: left;text-indent: 50px;line-height: 40px">
		七、检测单位：<!-- <input type="text" id="i_2" style="border: 0; border-bottom: 1px solid #000;font-size: 22px;"/> -->
		<span id="span_2" style="font-size:14px;text-align: left;line-height: 28px">${orgJcdwInfo.org_jcdw }</span>
	   </div>
	   <div style="font-size:14px;text-align: left;text-indent: 50px;line-height: 40px">
		地    址：<!-- <input type="text" id="i_3" style="border: 0; border-bottom: 1px solid #000;font-size: 22px;"/> -->
		<span id="span_3" style="font-size:14px;text-align: left;line-height: 40px">${orgJcdwInfo.org_addr }</span>
	   </div>
	   <div style="font-size:14px;text-align: left;text-indent: 50px;line-height: 40px">
		邮    编：<!-- <input type="text" id="i_4" style="border: 0; border-bottom: 1px solid #000;font-size: 22px;"/> -->
		<span id="span_4" style="font-size:14px;text-align: left;line-height: 40px">${orgJcdwInfo.org_postal }</span>
	   </div>
	   <div style="font-size:14px;text-align: left;text-indent: 50px;line-height: 40px">
		电    话：<!-- <input type="text" id="i_5" style="border: 0; border-bottom: 1px solid #000;font-size: 22px;"/> -->
		<span id="span_5" style="font-size:14px;text-align: left;line-height: 40px">${orgJcdwInfo.org_phone }</span>
	   </div>
	   </div>
	    <div style="page-break-after: always;"></div>
		<form id="form1" name="form1" action=""  style="background-color: white;margin-left: 50px;margin-right: 50px">
			<div style="width: 100%; text-align: center; padding-top: 20px; padding-bottom: 15px;">
				<font size="5"> <b>防 雷 装 置 综 合 检 测 报 告</b></font>
			</div>
			<div style="width: 100%; text-align: center; padding-bottom: 5px;">
				<font size="4">基本信息汇总表</font>
			</div>
			<div style="width: 100%; text-align: left; padding-bottom: 3px; margin-left: 10px;font-size: 14px" >
				报告编号：${baseInfo.bg_id }
			</div>
			   <table  width="100%" align="center" border="1" style="text-align: center;font-size: 14px">
					<tr height="40px">
	               		<td style="width: 15%;">
							单位名称
	                	</td>
	                	<td style="width: 45%;" colspan="2" >
	                		${baseInfo.dw_name }
	                	</td>
	                	<td style="width: 15%;" >
							行政区域
	                	</td>
	                	<td style="width: 25%;" colspan="2">
	                		${baseInfo.xzqy }
	                	</td>
	                </tr>
					<tr height="40px">
	               		<td  >
							行业类别
	                	</td>
	                	<td colspan="2">
	                		${baseInfo.hy_type }
	                	</td>
	                	<td  >
							单位法人
	                	</td>
	                	<td colspan="2">
	                		${baseInfo.dw_fr }
	                	</td>
	                </tr>
	                <tr height="40px">
	               		<td  >
							经度E
	                	</td>
	                	<td colspan="2">
	                		${baseInfo.jd }
	                	</td>
	                	<td  >
							纬度N
	                	</td>
	                	<td colspan="2">
	                		${baseInfo.wd }
	                	</td>
	                </tr>
	                <tr height="40px">
	               		<td  >
							联系部门
	                	</td>
	                	<td colspan="2">
	                		${baseInfo.lx_bm }
	                	</td>
	                	<td  >
							联系人
	                	</td>
	                	<td colspan="2">
	                		${baseInfo.lxr }
	                	</td>
	                </tr>
	                <tr height="40px">
	               		<td  >
							联系电话
	                	</td>
	                	<td colspan="2">
	                		${baseInfo.lxr_phone }
	                	</td>
	                	<td  >
							检测周期
	                	</td>
	                	<td colspan="2">
	                		${baseInfo.jc_zq }
	                	</td>
	                </tr>
	                <%-- <tr height="50px">
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
	                <tr height="50px">
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
	                <tr height="50px">
	                	<td  >
							雷击大地的年平均密度（次/公里².年）
	                	</td>
	                	<td colspan="3">
	                		${baseInfo.npjmd }
	                	</td>
	                </tr> --%>
	                <tr height="100px">
	               		<td  >
							报告构成
	                	</td>
	                	<td colspan="5">
	                		<zcc:checkboxlist name="bg_gc" id="bg_gc" list="bggcList" disabled="true"
								checkboxLabel="dd_item_name" checkboxValue="dd_item_code"
								value="${baseInfo.bg_gc}" delims="," columns="2" />
	                	</td>
	                </tr>
	                <tr height="100px">
	               		<td  >
							检测依据
	                	</td>
	                	<td colspan="5">
	                		<zcc:checkboxlist name="jyj" id="jyj" list="jcyjList" disabled="true"
								checkboxLabel="dd_item_name" checkboxValue="dd_item_code"
								value="${baseInfo.jyj}" delims="," columns="1"/>
	                	</td>
	                </tr>
	                <tr height="40px" >
	               		<td  rowspan="${yqsbCount + 1 }">
							检测仪器
	                	</td>
	                	<td>
	                		名称
	                	</td>
	                	<td>
	                		规格型号
	                	</td>
	                	<td>
	                		编号
	                	</td>
	                	<td colspan="2">
	                		检测情况
	                	</td>
	                </tr>
	                <c:forEach var="row" items="${yqsbList }" >
	                	<tr height="40px">
	                	<td>
	                		 ${row.yq_name }
	                	</td>
	                	<td>
	                		 ${row.ggxh }
	                	</td>
	                	<td>
	                		 ${row.yq_bh }
	                	</td>
	                	<td colspan="2">
	                		 ${row.check_qk }
	                	</td>
	                </tr>
	                </c:forEach>
	                
	                 <tr height="40px">
	                	<td>
	                		检测项目
	                	</td>
	                	<td colspan="5" style="text-align: left;">
	                		${baseInfo.remark3 }
	                	</td>
	                </tr>
	                <tr height="40px">
	                	<td>
	                		环境状况
	                	</td>
	                	<td colspan="5" style="text-align: left;">
	                		天气：${ baseInfo.weather }
	                	</td>
	                </tr>
	                <tr height="40px">
	                	<td>
	                		检测日期
	                	</td>
	                	<td colspan="2" style="text-align: left;">
	                		 ${ baseInfo.jc_date }
	                	</td>
	                	<td>
	                		隐患建议书
	                	</td>
	                	<td colspan="2" style="text-align: left;">
	                		&nbsp;&nbsp; ${baseInfo.remark1 == null ? '无' : '有' }
	                	</td>
	                </tr>
	                <%-- <tr height="200px">
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
	                </tr> --%>
	                <tr height="200px">
	               		<td  >
							检测结论
	                	</td>
	                	<td colspan="5" style="text-align: left;">
	                		${baseInfo.remark }
	                		<br/><br/>
	                		<div style='width:90%;margin: 20px auto;text-align: right'>检测单位（盖章）</div>
	                		<div style='width:90%;margin: 10px auto;text-align: right'>签发日期：${baseInfo.remark4 }</div>
	                	</td>
	                </tr>
	                <tr height="40px">
	                	<td>
	                		检测报告<br/>有效期至
	                	</td>
	                	<td colspan="5" style="text-align: left;">
	                		${baseInfo.yx_date }
	                	</td>
	                </tr>
	                <tr height="40px">
	               		<td  >
							检测人
	                	</td>
	                	<td >
	                		&nbsp;&nbsp;${baseInfo.jcr }
	                	</td>
	                	<td  >
							审核人
	                	</td>
	                	<td >
	                		&nbsp;&nbsp;${baseInfo.jhr }
	                	</td>
	                	<td  >
							批准人
	                	</td>
	                	<td width="30px;">
	                		&nbsp;&nbsp;${baseInfo.jfr }
	                	</td>
	                </tr>
	                
			</table>
			<br>
	  </form>
	  <!-- 强制换页 -->
	  <div style="page-break-after: always;"></div>
	  
	  <c:forEach var="row" items="${showFDInfos }">
		  <form id="form2" name="form2" action=""  style="background-color: white;margin-left: 50px;margin-right: 50px">
		  	<div style="width: 100%; text-align: center; padding-top: 20px; padding-bottom: 15px;">
				<font size="5"> <b>防 雷 装 置 综 合 检 测 报 告</b></font>
			</div>
			<div style="width: 100%; text-align: center; padding-bottom: 5px;">
				<font size="4">（A）防直击雷</font>
			</div>
			<div style="width: 100%; text-align: left; padding-bottom: 3px; margin-left: 10px;font-size: 14px" >
				报告编号：${baseInfo.bg_id }
			</div>
		    
		  	<table  width="100%" align="center" border="1" style="text-align: center;font-size: 14px">
		  		<tr height="35px">
		  			<td>
		  				被保护物名称
		  			</td>
		  			<td >
		  				${row.fzjlInfo.bbhw_name }
		  			</td>
		  			<td>
		  				长/宽/高（m）
		  			</td>
		  			<td width="120px">
		  				${row.fzjlInfo.ckg }
		  			</td>
		  			<td colspan="2">
		  				防雷类别
		  			</td>
		  			<td >
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
		  				接闪杆/带/网/线/金属构件/金属屋面
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
		  				${row.fzjlInfo.sjq_hjcd }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.sjq_hjcd_rst }
		  			</td>
		  		</tr>
		  		<tr height="35px">
		  			<td colspan="1">
		  				保护范围
		  			</td>
		  			<td colspan="2">
		  				按滚球法或接闪网确定
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
		  				明敷、暗敷
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.yxx_fsfs }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.yxx_fsfs_rst }
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
		  				同接闪杆连接状况
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.yxx_hjcd }
		  			</td>
		  			<td colspan="2">
		  				${row.fzjlInfo.yxx_hjcd_rst }
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
		  			<td colspan="3" style="text-align: left;" >
		  				结论：<br/>${row.fzjlInfo.result }
		  			</td>
		  			<td colspan="5" style="text-align: left;">
		  				${row.fzjlInfo.zgyj }
		  			</td>
		  		</tr>
		  		
		  	</table>
		  	<div style="text-align:left;">注：单项判定符合要求的划“√”，不符合要求的划“×”</div>
		  </form>
		  
		  <div style="page-break-after: always;"></div>
		  
		  <!-- **************************************************************************************** -->
		  
		<%--   <c:forEach var="row" items="${showFDInfos }" >
		  
		  </c:forEach> --%>
		  
		  <form id="form3" name="form3" action=""  style="background-color: white;margin-left: 50px;margin-right: 50px">
		  	<div style="width: 100%; text-align: center; padding-top: 20px; padding-bottom: 15px;">
				<font size="5"> <b>防 雷 装 置 综 合 检 测 报 告</b></font>
			</div>
			<div style="width: 100%; text-align: center; padding-bottom: 5px;">
				<font size="4">（B）屏蔽、等电位及接地等</font>
			</div>
			<div style="width: 100%; text-align: left; padding-bottom: 3px; margin-left: 10px;font-size: 14px" >
				报告编号：${baseInfo.bg_id }
			</div>
		    
		  	<table  width="100%" align="center" border="1" style="text-align: center;font-size: 14px">
		  		<tr style="height: 40px;">
		  			<td width="5%">
		  				序号
		  			</td>
		  			<td width="33%">
		  				检测点
		  			</td>
		  			<td width="12%">
		  				属性
		  			</td>
		  			<td width="15%">
		  				规格/材质（mm/mm²）
		  			</td>
		  			<td width="12%">
		  				电阻值（Ω）
		  			</td>
		  			<td width="13%">
		  				标准要求（Ω）
		  			</td>
		  			<td width="10%">
		  				单项评定
		  			</td>
		  		</tr>
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
		  						${pb.dzz_bzyq }
		  					</td>
		  					<td>
		  						${pb.dx_result }
		  					</td>
		  				</tr>
		  			<c:if test="${(status.index+1) % 23 == 0}">
		  				</table>
		  				<div style="text-align:left;">注：单项判定符合要求的划“√”，不符合要求的划“×”</div>
		  				<div style="page-break-after: always;"></div>
		  				<c:if test="${!status.last}">
			  				<table  width="100%" align="center" border="1" style="text-align: center;">
			  					<tr style="height: 40px;">
						  			<td width="5%">
						  				序号
						  			</td>
						  			<td width="20%">
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
						  			<td width="15%">
						  				标准要求（Ω）
						  			</td>
						  			<td width="10%">
						  				单项评定
						  			</td>
						  		</tr>
					  	</c:if>
		  			</c:if>	
		  			
		  			</c:forEach>
		  	</table>
		  	
		  </form>
		  <div style="page-break-after: always;"></div>
		  
	  </c:forEach>
	  
	  <!-- C表 -->
	  <c:forEach items="${dqxtList }" var="dqxt" >
	  	<form id="formC" name="formC"  style="background-color: white;margin-left: 50px;margin-right: 50px">
	  		<div style="width: 100%; text-align: center; padding-top: 20px; padding-bottom: 15px;">
				<font size="5"> <b>防 雷 装 置 综 合 检 测 报 告</b></font>
			</div>
			<div style="width: 100%; text-align: center; padding-bottom: 5px;">
				<font size="4">（C）电气系统电涌保护器</font>
			</div>
			<div style="width: 100%; text-align: left; padding-bottom: 3px; margin-left: 10px;font-size: 14px" >
				报告编号：${baseInfo.bg_id }
			</div>
			<table  width="100%" align="center" border="1" style="text-align: center;font-size: 14px">
		  		<tr height="40px">
		  			<td colspan="2">
		  				被检测物位置
		  			</td>
		  			<td colspan="6">
		  				${dqxt.bjcwwz }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td width="7%">
		  				序号
		  			</td>
		  			<td width="35%">
		  				检测项目
		  			</td>
		  			<td colspan="2" width="25%">
		  				标准
		  			</td>
		  			<td colspan="2" >
		  				检测结果
		  			</td>
		  			<td colspan="2" width="10%">
		  				单项评定
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td >
		  				1
		  			</td>
		  			<td >
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
		  			<td >
		  				2
		  			</td>
		  			<td >
		  				型号
		  			</td>
		  			<td colspan="2">
		  				----
		  			</td>
		  			<td colspan="2">
		  				${dqxt.xh }
		  			</td>
		  			<td colspan="2">
		  				/
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td >
		  				3
		  			</td>
		  			<td >
		  				接地系统
		  			</td>
		  			<td colspan="2">
		  				TN/TT/IT
		  			</td>
		  			<td colspan="2">
		  				${dqxt.jdzs }
		  			</td>
		  			<td colspan="2">
		  				/
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td >
		  				4
		  			</td>
		  			<td >
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
		  			<td >
		  				5
		  			</td>
		  			<td >
		  				与前级之间距离(m)
		  			</td>
		  			<td colspan="2">
		  				限压型与限压型≥5m
						开关型与限压型≥10m
		  			</td>
		  			<td colspan="2">
		  				${dqxt.yqjjl }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.yqjjl_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td >
		  				6
		  			</td>
		  			<td >
		  				状态显示
		  			</td>
		  			<td colspan="2">
		  				正常/损坏
		  			</td>
		  			<td colspan="2">
		  				${dqxt.ztxs }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.ztxs_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td >
		  				7
		  			</td>
		  			<td >
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
		  			<td >
		  				8
		  			</td>
		  			<td >
		  				电压保护水平Up(kV)
		  			</td>
		  			<td colspan="2">
		  				≤2.5KV
		  			</td>
		  			<td colspan="2">
		  				${dqxt.dybhsp }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.dybhsp_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td >
		  				9
		  			</td>
		  			<td >
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
		  			<td >
		  				10
		  			</td>
		  			<td >
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
		  			<td >
		  				11
		  			</td>
		  			<td >
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
		  			<td >
		  				12
		  			</td>
		  			<td >
		  				绝缘电阻
		  			</td>
		  			<td colspan="2">
		  				≥50MΩ
		  			</td>
		  			<td colspan="2">
		  				${dqxt.baqk }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.baqk_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td >
		  				13
		  			</td>
		  			<td >
		  				泄漏电流lie(A)
		  			</td>
		  			<td colspan="2">
		  				≤20 uA
		  			</td>
		  			<td colspan="2">
		  				${dqxt.ldl }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.ldl_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td >
		  				14
		  			</td>
		  			<td >
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
		  			<td >
		  				15
		  			</td>
		  			<td >
		  				相、零线截面(mm²)
		  			</td>
		  			<td colspan="2">
		  				规范
		  			</td>
		  			<td colspan="2">
		  				${dqxt.xlxjm }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.xlxjm_rst }
		  			</td>
		  		</tr>
		  		<tr height="40px">
		  			<td >
		  				16
		  			</td>
		  			<td >
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
		  			<td >
		  				17
		  			</td>
		  			<td >
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
		  			<td >
		  				18
		  			</td>
		  			<td >
		  				接线长度(m)
		  			</td>
		  			<td colspan="2">
		  				宜≤0.5m
		  			</td>
		  			<td colspan="2">
		  				${dqxt.jxcd }
		  			</td>
		  			<td colspan="2">
		  				${dqxt.jxcd_rst }
		  			</td>
		  		</tr>
		  		
		  		<tr height="70px">
		  			<td colspan="3" style="text-align: left;" >
		  				结论：<br/>${dqxt.result }
		  			</td>
		  			<td colspan="5" style="text-align: left;">
		  				备注：<br/>
		  				${dqxt.zgyj }
		  			</td>
		  		</tr>
		  	</table>
		  	<div style="text-align:left;">注：单项判定符合要求的划“√”，不符合要求的划“×”</div>
	  	</form>
	  	<div style="page-break-after: always;"></div>
	  </c:forEach>	  
	  
	  <!-- D表 -->
	  <c:forEach items="${xhtkList }" var="xhtk" >
	  	<form id="formD" name="formD"  style="background-color: white;margin-left: 50px;margin-right: 50px">
	  		<div style="width: 100%; text-align: center; padding-top: 20px; padding-bottom: 15px;">
				<font size="5"> <b>防 雷 装 置 综 合 检 测 报 告</b></font>
			</div>
			<div style="width: 100%; text-align: center; padding-bottom: 5px;">
				<font size="4">（D）信号天馈电涌保护器</font>
			</div>
			<div style="width: 100%; text-align: left; padding-bottom: 3px; margin-left: 10px;font-size: 14px" >
				报告编号：${baseInfo.bg_id }
			</div>
			<table  width="100%" align="center" border="1" style="text-align: center;font-size: 14px">
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
		  				备案情况
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
		  				${xhtk.zgyj }
		  			</td>
		  		</tr>
		  	</table>
		  	<div style="text-align:left;">注：单项判定符合要求的划“√”，不符合要求的划“×”</div>
	  	</form>
	  	<div style="page-break-after: always;"></div>
	  </c:forEach>
	  
	  <!-- E表 -->
	  <c:forEach items="${dzxtList }" var="dzxt" >
	  	<form id="formD" name="formD"  style="background-color: white;margin-left: 50px;margin-right: 50px">
	  		<div style="width: 100%; text-align: center; padding-top: 20px; padding-bottom: 15px;">
				<font size="5"> <b>防 雷 装 置 综 合 检 测 报 告</b></font>
			</div>
			<div style="width: 100%; text-align: center; padding-bottom: 5px;">
				<font size="4">（E）电子系统</font>
			</div>
			<div style="width: 100%; text-align: left; padding-bottom: 3px; margin-left: 10px;font-size: 14px" >
				报告编号：${baseInfo.bg_id }
			</div>
			<table  width="100%" align="center" border="1" style="text-align: center;font-size: 14px">
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
	  		<div style="text-align:left;">注：单项判定符合要求的划“√”，不符合要求的划“×”</div>
	  	</form>
	  	<div style="page-break-after: always;"></div>
	  	
	  	<form id="formD" name="formD"  style="background-color: white;margin-left: 50px;margin-right: 50px">
	  		<div style="width: 100%; text-align: center; padding-top: 20px; padding-bottom: 15px;">
				<font size="5"> <b>防 雷 装 置 综 合 检 测 报 告</b></font>
			</div>
			<div style="width: 100%; text-align: center; padding-bottom: 5px;">
				<font size="4">（E）电子系统（二）</font>
			</div>
			<div style="width: 100%; text-align: left; padding-bottom: 3px; margin-left: 10px;font-size: 14px" >
				报告编号：${baseInfo.bg_id }
			</div>
			<table  width="100%" align="center" border="1" style="text-align: center;font-size: 14px">
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
		  				${dzxt.zgyj }
		  			</td>
		  		</tr>
		  	</table>
		  	<div style="text-align:left;">注：单项判定符合要求的划“√”，不符合要求的划“×”</div>
	  	</form>
	  	<div style="page-break-after: always;"></div>
	  </c:forEach>
	  
	  <!-- 末页 -->
	  <%-- <form id="form4" name="form4" action=""  style="background-color: white; width: 100%;" >
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
	  </form> --%>
  </center>
  <%-- <form id="form5" name="form5" action="">
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
	</form> --%>
	<div style="page-break-after: always;"></div>
	
	<c:forEach items="${photosList }" var="pho" >
		<form id="form6" name="form6" action=""  style="background-color: white; margin-left: 50px;margin-right: 50px" >
			<div style="width: 100%; text-align: center; padding-top: 20px; padding-bottom: 15px;">
				<font size="5"> <b>防 雷 装 置 综 合 检 测 报 告</b></font>
			</div>
			<div style="width: 100%; text-align: center; padding-bottom: 5px;">
				<font size="4"> ${pho.cl_type == 1 ? "示意图 " : "照片" }  </font>
			</div>
			<div style="width: 100%; text-align: left; padding-bottom: 3px; margin-left: 10px;font-size: 14px" >
				报告编号：${baseInfo.bg_id }
			</div>
			<div style="width: 800px; height: 900px;">
				<img src="<%=request.getContextPath()%>/showphoto/${pho.cl_name_d}" width="100%" height="100%" />
			</div>
		</form>
		
		<div style="page-break-after: always;"></div>
	</c:forEach>
	<c:if test="${baseInfo.remark1 != null || baseInfo.remark1 != null != ''  }">
		
		<form id="form7" name="form7" action="" style="margin-left: 50px;margin-right: 50px">
			<br/><br/><br/><br/><br/>
		    <div style="width: 100%; text-align: center; padding-top: 20px; padding-bottom: 15px;">
				<font style="font-size: 29px"> <b>防雷装置安全隐患建议书</b></font>
		    </div> 
			<div style="width: 100%; text-align: left; padding-bottom: 3px; font-size: 14px" >
				报告编号：${baseInfo.bg_id }
			</div>
			<div style="width: 100%; text-align: left; padding-bottom: 3px; font-size: 14px;line-height:40px" >
				${baseInfo.remark5 }：
			</div>
			<div style='width:100%;display:flex;justify-content:flex-start'>
				<span style="text-align: left; font-size: 14px;text-indent: 40px;line-height:40px!important" >我单位按照国家现行规范  &nbsp;&nbsp; 
				${baseInfo.remark1 == null ? '______________________________________________' : baseInfo.remark1 }   &nbsp;&nbsp;&nbsp;
				的要求对你单位的${baseInfo.remark2 == null ? '_________' : baseInfo.remark2 } 
				防雷装置进行了检测。经检测，你单位以下防雷装置不符合规范要求，存在安全隐患： </span>
			</div>
			<c:forEach var="row" items="${infoList }">
			<div style="font-size: 14px;text-indent: 40px!important;line-height:40px!important">
				${row.info }
			</div>
				<%-- <span style="font-size: 20px;text-indent: 40px!important;">${row.info }</span>  <br/> --%>
			</c:forEach>
			<div style="vertical-align: bottom;height: 800px;">
				<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
				<span style="padding-left: 500px;font-size: 14px">检测单位（公章）</span><br /><br />
				<span style="padding-left: 500px;font-size: 14px">${baseInfo.remark4 }</span>
			</div>
		</form>
		
	</c:if>
	<form id="form8" name="form8" action=""  style="background-color: white;margin-left: 50px;margin-right: 50px" >
			<div >
				<img src="${app}/images/zizhi/zizhi1.jpg" width="98%" height="98%" />
			</div>
	</form>
	<div style="page-break-after: always;"></div>
	<form id="form9" name="form9" action=""  style="background-color: white;margin-left: 50px;margin-right: 50px" >
		<div >
			<img src="${app}/images/zizhi/zizhi2.jpg" width="98%" height="98%" />
		</div>
	</form>
  </div>
</body>
<script type="text/javascript">
	
	/* chek();
	function chek(){
		$('#t11').hide();
		$('#t22').hide();
		$('#t33').hide();
		$('#t44').hide();
	} */
	
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
     
     /* var t1V =  $('#t1').val();
     var t2V =  $('#t2').val();
     var t3V =  $('#t3').val();
     var t4V =  $('#t4').val();
     $('#t11').show();
     $('#t1').hide();
     $('#t11').html(t1V);
     
     $('#t22').show();
     $('#t2').hide();
     $('#t22').html(t2V);
     
     $('#t33').show();
     $('#t3').hide();
     $('#t33').html(t3V);
     
     $('#t44').show();
     $('#t4').hide();
     $('#t44').html(t4V); */
     
    /*  var i_1 = $('#i_1').val();
     var i_2 = $('#i_2').val();
     var i_3 = $('#i_3').val();
     var i_4 = $('#i_4').val();
     var i_5 = $('#i_5').val();
     $('#span_1').html(i_1);
     $('#span_1').show();
     $('#i_1').hide();
     
     $('#span_2').html(i_2);
     $('#span_2').show();
     $('#i_2').hide();
     
     $('#span_3').html(i_3);
     $('#span_3').show();
     $('#i_3').hide();
     
     $('#span_4').html(i_4);
     $('#span_4').show();
     $('#i_4').hide();
     
     $('#span_5').html(i_5);
     $('#span_5').show();
     $('#i_5').hide(); */
     
     var bodystr = document.all.item("printDiv").innerHTML;                     
     var oldstr = document.body.innerHTML; 
     
     document.body.innerHTML = headstr + bodystr + footstr;  
     //pagesetup_null();     
     window.print();          
     //pagesetup_default();
     document.body.innerHTML = oldstr;
     return false;   
   }       
   
   //设置网页打印的页眉页脚为空
    function pagesetup_null(){
		try{
			var RegWsh
			if(window.ActiveXObject){
			//支持-通过ActiveXObject的一个新实例来创建XMLHttpRequest对象
				RegWsh = new ActiveXObject("Microsoft.XMLHTTP");
			}
			//不支持
			else if(window.XMLHttpRequest){
				RegWsh = new XMLHttpRequest()
			}
			 
			//var RegWsh = new ActiveXObject("WScript.Shell")
			hkey_key="header" 
			RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"")
			hkey_key="footer"
			RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"")
		}catch(e){
			alert(e);
		}
	}
     
    //设置网页打印的页眉页脚为默认值
    function pagesetup_default() {
        try {
        	var RegWsh
			if(window.ActiveXObject){
			//支持-通过ActiveXObject的一个新实例来创建XMLHttpRequest对象
				RegWsh = new ActiveXObject("Microsoft.XMLHTTP");
			}
			//不支持
			else if(window.XMLHttpRequest){
				RegWsh = new XMLHttpRequest()
			}
            //var RegWsh = new ActiveXObject("WScript.Shell")
            hkey_key = "header";
            RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "&w&b页码，&p/&P")
            hkey_key = "footer";
            RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "&u&b&d")
        } catch (e) {
        	alert(e);
        }
    }
   
   var hkey_root,hkey_path,hkey_key
   hkey_root="HKEY_CURRENT_USER"
   hkey_path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\"
   
   //水印
	watermark({watermark_txt: "<p style='text-align: center;'>连云港市长虹防雷<br>工程中心", watermark_objName: "printDiv"})//传入动态水印内容
	//watermark({watermark_txt: "<p style='text-align: center;'>${operName}<br>${orgName}<br>${nowDate}</p>"})//传入动态水印内容
	function watermark(settings) {
    //默认设置
    var defaultSettings={
    	watermark_objName:"id",//容器
        watermark_txt:"text",
        watermark_x:150,//水印起始位置x轴坐标
        watermark_y:150,//水印起始位置Y轴坐标
        watermark_rows:10000,//水印行数
        watermark_cols:10000,//水印列数
        watermark_x_space:80,//水印x轴间隔
        watermark_y_space:400,//水印y轴间隔
        watermark_color:'#000000',//水印字体颜色
        watermark_alpha:0.2,//水印透明度
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