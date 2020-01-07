<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>防直击雷</title>
		<%@ include file="/inc/includeBase.jsp"%>
		<style>
			.keyboard_Box,.keyboard_Box li {
				list-style:none;
				margin:0;
				padding:0;
				-webkit-user-select:none;
				-moz-user-select:none;
				-ms-user-select:none;
				user-select:none;
			}
			.keyboard_Box {
				width:285px;
				height:auto;
				border-radius:0.05em;
				display:none;
				box-sizing:border-box;
				background:#bed8d1;
				padding:12px;
				box-sizing:border-box;
			}
			.keyboard_Box li {
				position:relative;
				font-family:arial,"Vrinda";
				width:20px;
				height:20px;
				line-height:20px;
				background-color:rgba(255,255,255,.8);
				border-radius:0.2em;
				font-weight:600;
				display:inline-block;
				text-align:center;
				font-size:15px;
				vertical-align:text-top;
				margin-right:0.4em;
				margin-bottom:10px;
				color:#266ada;
				box-shadow:0 0.2em 0.4em rgba(0,0,0,.5);
				cursor:pointer;
				position:relative;
				overflow:visible;
				text-shadow:-1px 1px 4px rgb(111,102,102);
			}
			.keyboard_Box li:active {
				box-shadow:inset 1px 1px 0 rgba(0,0,0,.5);
				top:0.08em;
				color:#da4026;
				background-color:rgba(8,148,243,0.63);
			}
			.keyboard_Box  .com {
				width:130px;
			}
		</style>
	</head>
	
	<body >
		<form id="form1" name="form1" method="post" action="${app}/cgjc/cgjc/fzjlSave.do" >
			<input type="hidden" value="${fzjlInfo.id }" id="id" name="id" />
			<input type="hidden" value="${base_id }" id="base_id" name="base_id" />
			
			<div id="queryPanel" class="queryPanel">
				<div id="queryPanel_title" class="queryPanel_title">
					<div class="queryPanel_title_collapse"></div>
					&nbsp;基本信息
				</div>
				<div id="queryPanel_content" class="queryPanel_content"
					style="position: relative;">
					<table class="form_table" width="98%" align="center" >
						<tr height="26px">
		               		<td class="outDetail" style="width: 15%;">
								被保护物名称:<label style="color:red">*</label>
		                	</td>
		                	<td class="outDetail2" style="width: 35%;">
		                		<input type="text" id="bbhw_name" name="bbhw_name" 
		                			value="${fzjlInfo.bbhw_name }" dataType="Require" msg="请输入被保护物名称!" />
		                	</td>
		                	<td class="outDetail" style="width: 15%;">
								防雷类别:
		                	</td>
		                	<td class="outDetail2" style="width: 35%;">
		                		<zcc:select name="fl_type" id="fl_type" list="flTypeList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.fl_type }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								长/宽/高:
		                	</td>
		                	<td class="outDetail2" colspan="3">
		                		<input type="text" id="ckg" name="ckg"  value="${fzjlInfo.ckg }"  />
		                	</td> 
		                </tr>
		            </table>
				</div>
			</div>
			
			<div id="listPanel" class="queryPanel">
				<div id="queryPanel_title" class="queryPanel_title">
					<div class="queryPanel_title_collapse"></div>
					&nbsp;接闪杆信息
				</div>
				<div id="queryPanel_content" class="queryPanel_content">
					<table class="form_table" width="98%" align="center" >
						<tr height="26px">
							<td class="outDetail" style="width: 15%;">
								形状:
		                	</td>
		                	<td class="outDetail2" style="width: 35%;">
		                		<input type="text" id="sjq_xz" name="sjq_xz"  value="${fzjlInfo.sjq_xz }"  />
		                		&nbsp;
		                		<zcc:select name="sjq_xz_rst" id="sjq_xz_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.sjq_xz_rst }" />
		                	</td>
		                	<td class="outDetail" style="width: 15%;">
								高度:
		                	</td>
		                	<td class="outDetail2" style="width: 35%;">
		                		<input type="text" id="sjq_gd" name="sjq_gd"  value="${fzjlInfo.sjq_gd }"  />
		                		&nbsp;
		                		<zcc:select name="sjq_gd_rst" id="sjq_gd_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.sjq_gd_rst }" />
		                	</td>
						</tr>
						<tr height="26px">
							<td class="outDetail" >
								敷设方式:
		                	</td>
		                	<td class="outDetail2" >
		                		<zcc:select name="sjq_fsfs" id="sjq_fsfs" list="fsfsList"
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.sjq_fsfs }" />
		                		&nbsp;
		                		<zcc:select name="sjq_fsfs_rst" id="sjq_fsfs_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.sjq_fsfs_rst }" />
		                	</td>
		                	<td class="outDetail" >
								规格材质(mm⁄mm²): 
		                	</td>
		                	<td class="outDetail2" id="outDetail21" style="position:relative" >
		                		<input type="text"  id="sjq_ggcz" name="sjq_ggcz"  value="${fzjlInfo.sjq_ggcz }"  />
		                		<!-- <ul id="keyboard_Box" class="keyboard_Box" style=" display: none;position:absolute;top:28px"></ul> -->
		                		&nbsp;
		                		<zcc:select name="sjq_ggcz_rst" id="sjq_ggcz_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.sjq_ggcz_rst }" />
		                	</td>
						</tr>
						<tr height="26px">
							<td class="outDetail" >
								腐蚀程度:
		                	</td>
		                	<td class="outDetail2" >
		                		<zcc:select name="sjq_fscd" id="sjq_fscd" list="fscdList" 
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.sjq_fscd }" />
		                		&nbsp;
		                		<zcc:select name="sjq_fscd_rst" id="sjq_fscd_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.sjq_fscd_rst }" />
		                	</td>
		                	<td class="outDetail" >
								固定状况: 
		                	</td>
		                	<td class="outDetail2" >
		                		<zcc:select name="sjq_gdxz" id="sjq_gdxz" list="gdqkList"
		                			 style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.sjq_gdxz }" />
		                		&nbsp;
		                		<zcc:select name="sjq_gdxz_rst" id="sjq_gdxz_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.sjq_gdxz_rst }" />
		                	</td>
						</tr>
						<tr height="26px">
							<td class="outDetail" >
								焊接长度:
		                	</td>
		                	<td class="outDetail2" >
		                		<input type="text" id="sjq_hjcd" name="sjq_hjcd"  value="${fzjlInfo.sjq_hjcd }"  />
		                		&nbsp;
		                		<zcc:select name="sjq_hjcd_rst" id="sjq_hjcd_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.sjq_hjcd_rst }" />
		                	</td>
		                	<td class="outDetail" >
								保护范围: 
		                	</td>
		                	<td class="outDetail2" >
		                		<zcc:select name="sjq_bhfw" id="sjq_bhfw" list="dbList"
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.sjq_bhfw }" />
		                		&nbsp;
		                		<zcc:select name="sjq_bhfw_rst" id="sjq_bhfw_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.sjq_bhfw_rst }" />
		                	</td>
						</tr>
						<tr height="26px">
							<td class="outDetail" >
								网格:
		                	</td>
		                	<td class="outDetail2" >
		                		<input type="text" id="sjq_wg" name="sjq_wg"  value="${fzjlInfo.sjq_wg }"  />
		                		&nbsp;
		                		<zcc:select name="sjq_wg_rst" id="sjq_wg_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.sjq_wg_rst }" />
		                	</td>
		                	<td class="outDetail" >
								带(网)支架间距:
		                	</td>
		                	<td class="outDetail2" >
		                		<input type="text" id="sjq_dzjjj" name="sjq_dzjjj"  value="${fzjlInfo.sjq_dzjjj }"  />
		                		&nbsp;
		                		<zcc:select name="sjq_dzjjj_rst" id="sjq_dzjjj_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.sjq_dzjjj_rst }" />
		                	</td>
						</tr>
						
					</table> 
				</div>
			</div>
			<div id="listPanel" class="queryPanel">
				<div id="queryPanel_title" class="queryPanel_title">
					<div class="queryPanel_title_collapse"></div>
					&nbsp;引下线信息
				</div>
				<div id="queryPanel_content" class="queryPanel_content">
					<table class="form_table" width="98%" align="center" >
						<tr height="26px">
							<td class="outDetail" style="width: 15%;">
								敷设方式:
		                	</td>
		                	<td class="outDetail2" style="width: 35%;">
		                		<zcc:select name="yxx_fsfs" id="yxx_fsfs" list="fsfsList"
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.yxx_fsfs }" />
		                		&nbsp;
		                		<zcc:select name="yxx_fsfs_rst" id="yxx_fsfs_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.yxx_fsfs_rst }" />
		                	</td>
		                	<td class="outDetail" style="width: 15%;">
								数量:
		                	</td>
		                	<td class="outDetail2" style="width: 35%;">
		                		<input type="text" id="yxx_sl" name="yxx_sl"  value="${fzjlInfo.yxx_sl }"  />
		                		&nbsp;
		                		<zcc:select name="yxx_sl_rst" id="yxx_sl_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.yxx_sl_rst }" />
		                	</td>
						</tr>
						<tr height="26px">
							<td class="outDetail" >
								间距(m): 
		                	</td>
		                	<td class="outDetail2" >
		                		<input type="text" id="yxx_jj" name="yxx_jj"  value="${fzjlInfo.yxx_jj }"  />
		                		&nbsp;
		                		<zcc:select name="yxx_jj_rst" id="yxx_jj_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.yxx_jj_rst }" />
		                	</td>
		                	<td class="outDetail" >
								腐蚀程度: 
		                	</td>
		                	<td class="outDetail2" >
		                		<zcc:select name="yxx_fscd" id="yxx_fscd" list="fscdList"
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.yxx_fscd }" />
		                		&nbsp;
		                		<zcc:select name="yxx_fscd_rst" id="yxx_fscd_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.yxx_fscd_rst }" />
		                	</td>
						</tr>
						<tr height="26px">
							<td class="outDetail" >
								固定状况:
		                	</td>
		                	<td class="outDetail2" >
		                		<zcc:select name="yxx_gdzk" id="yxx_gdzk" list="gdqkList" 
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.yxx_gdzk }" />
		                		&nbsp;
		                		<zcc:select name="yxx_gdzk_rst" id="yxx_gdzk_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.yxx_gdzk_rst }" />
		                	</td>
		                	<td class="outDetail" >
								焊接长度: 
		                	</td>
		                	<td class="outDetail2" >
		                		<input type="text" id="yxx_hjcd" name="yxx_hjcd"  value="${fzjlInfo.yxx_hjcd }"  />
		                		&nbsp;
		                		<zcc:select name="yxx_hjcd_rst" id="yxx_hjcd_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.yxx_hjcd_rst }" />
		                	</td>
						</tr>
						<tr height="26px">
							<td class="outDetail" >
								规格材质(mm⁄mm²): 
		                	</td>
		                	<td class="outDetail2" style="position:relative">
		                		<input type="text" id="yxx_ggcz" name="yxx_ggcz" value="${fzjlInfo.yxx_ggcz }"   />
		                		<!-- <ul id="keyboard_Box1" class="keyboard_Box" style=" display: none;position:absolute;top:28px"></ul> -->
		                		&nbsp;
		                		<zcc:select name="yxx_ggcz_rst" id="yxx_ggcz_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.yxx_ggcz_rst }" />
		                	</td>
		                	<td class="outDetail" >
								明敷支架间距(m): 
		                	</td>
		                	<td class="outDetail2" >
		                		<input type="text" id="yxx_mfzjjj" name="yxx_mfzjjj"  value="${fzjlInfo.yxx_mfzjjj }"  />
		                		&nbsp;
		                		<zcc:select name="yxx_mfzjjj_rst" id="yxx_mfzjjj_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.yxx_mfzjjj_rst }" />
		                	</td>
						</tr>
					</table> 
				</div>
			</div>
			<div id="listPanel" class="queryPanel">
				<div id="queryPanel_title" class="queryPanel_title">
					<div class="queryPanel_title_collapse"></div>
					&nbsp;接地线信息
				</div>
				<div id="queryPanel_content" class="queryPanel_content">
					<table class="form_table" width="98%" align="center" >
						<tr height="26px">
		                	<td class="outDetail" style="width: 15%;">
								腐蚀程度:
		                	</td>
		                	<td class="outDetail2" style="width: 35%;">
		                		<zcc:select name="jdx_fscd" id="jdx_fscd" list="fscdList" 
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.jdx_fscd }" />
		                		&nbsp;
		                		<zcc:select name="jdx_fscd_rst" id="jdx_fscd_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.jdx_fscd_rst }" />
		                	</td>
		                	<td class="outDetail" style="width: 15%;" >
								规格材质(mm⁄mm²):
		                	</td>
		                	<td class="outDetail2" style="width: 35%;position:relative">
		                		<input type="text" id="jdx_ggcz" name="jdx_ggcz" value="${fzjlInfo.jdx_ggcz }"  />
		                		<!-- <ul id="keyboard_Box2" class="keyboard_Box" style=" display: none;position:absolute;top:28px"></ul> -->
		                		&nbsp;
		                		<zcc:select name="jdx_ggcz_rst" id="jdx_ggcz_rst" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${fzjlInfo.jdx_ggcz_rst }" />
		                	</td>
						</tr>
					</table> 
				</div>
			</div>
			<div id="listPanel" class="queryPanel">
				<div id="queryPanel_title" class="queryPanel_title">
					<div class="queryPanel_title_collapse"></div>
					&nbsp;屏蔽信息 
				</div>
			<div id="queryPanel_content" class="queryPanel_content">
				<table class="form_table" width="98%" align="center" >
					<tr height="26px">
						<td class="outDetail" style="width: 15%;">
							室外进总电源线敷设方式:
	                	</td>
	                	<td class="outDetail2" style="width: 35%;">
	                		<zcc:select name="pb_zdy_fsfs" id="pb_zdy_fsfs" list="xfsList" 
	                			style="width: 135px;"
								optionLabel="dd_item_name" optionValue="dd_item_code"
								value="${fzjlInfo.pb_zdy_fsfs }" />
	                		&nbsp;
	                		<zcc:select name="pb_zdy_fsfs_rst" id="pb_zdy_fsfs_rst" list="heList"
								optionLabel="dd_item_name" optionValue="dd_item_code"
								value="${fzjlInfo.pb_zdy_fsfs_rst }" />
	                	</td>
	                	<td class="outDetail" style="width: 15%;">
							室外进总信号线敷设方式：
	                	</td>
	                	<td class="outDetail2" style="width: 35%;">
	                		<zcc:select name="pb_zxh_fsfs" id="pb_zxh_fsfs" list="xfsList" 
	                			style="width: 135px;"
								optionLabel="dd_item_name" optionValue="dd_item_code"
								value="${fzjlInfo.pb_zxh_fsfs }" />
	                		&nbsp;
	                		<zcc:select name="pb_zxh_fsfs_rst" id="pb_zxh_fsfs_rst" list="heList"
								optionLabel="dd_item_name" optionValue="dd_item_code"
								value="${fzjlInfo.pb_zxh_fsfs_rst }" />
	                	</td>
					</tr>
					<tr height="26px">
						<td class="outDetail" style="width: 15%;">
							室外进总电源线属性:  
	                	</td>
	                	<td class="outDetail2" style="width: 35%;">
	                		<zcc:select name="pb_zdy_sx" id="pb_zdy_sx" list="xsxList" 
	                			style="width: 135px;"
								optionLabel="dd_item_name" optionValue="dd_item_code"
								value="${fzjlInfo.pb_zdy_sx }" />
	                		&nbsp;
	                		<zcc:select name="pb_zdy_sx_rst" id="pb_zdy_sx_rst" list="heList"
								optionLabel="dd_item_name" optionValue="dd_item_code"
								value="${fzjlInfo.pb_zdy_sx_rst }" />
	                	</td>
	                	<td class="outDetail" style="width: 15%;">
							室外进总信号线属性：
	                	</td>
	                	<td class="outDetail2" style="width: 35%;">
	                		<zcc:select name="pb_zxh_sx" id="pb_zxh_sx" list="xsxList" 
	                			style="width: 135px;"
								optionLabel="dd_item_name" optionValue="dd_item_code"
								value="${fzjlInfo.pb_zxh_sx }" />
	                		&nbsp;
	                		<zcc:select name="pb_zxh_sx_rst" id="pb_zxh_sx_rst" list="heList"
								optionLabel="dd_item_name" optionValue="dd_item_code"
								value="${fzjlInfo.pb_zxh_sx_rst }" />
	                	</td>
					</tr>
				</table> 
			</div>
		</div>
		<div id="listPanel" class="queryPanel">
				<div id="queryPanel_title" class="queryPanel_title">
					<div class="queryPanel_title_collapse"></div>
					&nbsp;结论及建议信息 
				</div>
			<div id="queryPanel_content" class="queryPanel_content">
				<table class="form_table" width="98%" align="center" >
					<tr height="26px">
						<td class="outDetail" style="width: 15%;">
							单项结论
	                	</td>
	                	<td class="outDetail2" colspan="3">
	                		<zcc:select name="dx_result" id="dx_result" list="heList" 
	                			style="width: 135px;"
								optionLabel="dd_item_name" optionValue="dd_item_code"
								value="${fzjlInfo.dx_result }" />
	                	</td>
					</tr>
					<tr height="26px">
						<td class="outDetail" style="width: 15%;">
							结论
	                	</td>
	                	<td class="outDetail2" colspan="3">
	                		<zcc:select name="result" id="result" list="rstList" 
	                			style="width: 435px;"
								optionLabel="dd_item_name" optionValue="dd_item_code"
								value="${fzjlInfo.result }" />
	                	</td>
					</tr>
					<tr height="26px">
						<td class="outDetail" style="width: 15%;">
							备注
	                	</td>
	                	<td class="outDetail2" colspan="3">
	                		<textarea rows="3" cols="60" id="zgyj" name="zgyj" >${fzjlInfo.zgyj }</textarea>
	                	</td>
					</tr>
					<!-- <tr height="26px">
						<td class="outDetail" style="width: 15%;">
							建议
	                	</td>
	                	<td class="outDetail2" colspan="3">
	                		<textarea rows="3" cols="60" id="jy" name="jy" >${fzjlInfo.jy }</textarea>
	                	</td>
					</tr> --> 
					
				</table> 
			</div>
		</div>
		<c:if test="${ method != 'show' }">
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
		var value = '${fzjlInfo.bbhw_name }' + '（复制）';
		if(method == 'copy'){
			$('#bbhw_name').val(value);
		}
		
		/****虚拟键盘*****/
		$("#keyboard_Box").html('<li class="list">1</li>' +
		    '<li class="list">2</li>' +
		    '<li class="list">3</li>' +
		    '<li class="list">4</li>' +
		    '<li class="list">5</li>' +
		    '<li class="list">6</li>' +
		    '<li class="list">7</li>' +
		    '<li class="list">8</li>' +
		    '<li class="list">9</li>' +
		    '<li class="list">0</li>' +
		    '<li class="list toLowerCase">∠</li>' +
		    '<li class="list toLowerCase">.</li>' +
		    '<li class="list toLowerCase">Φ</li>' +
		    '<li class="list toLowerCase">◎</li>' +
		    '<li class="list toLowerCase">≥</li>' +
		    '<li class="list toLowerCase">≤</li>' +
		    '<li class="list toLowerCase">/</li>' +
		    '<li class="list toLowerCase">-</li>' +
		    '<li class="list toLowerCase">×</li>' +
		    '<li class="list toLowerCase">W</li>' +
		    '<li class="list toLowerCase">D</li>' +
		    '<li class="list toLowerCase">S</li>' +
		    '<li class="list toLowerCase">Fe</li>' +
		    '<li class="list toLowerCase">Cu</li>' +
		    '<li class="list toLowerCase">Al</li>' +
		    '<li class="list toLowerCase2" style="width:60px;">本身</li>' +
		    '<li class="list toLowerCase2" style="width:60px;">暗敷</li>' +
		    '<li class="list toLowerCase1" style="width:100px;">金属构件</li>' +
		    '<li class="list toLowerCase1" style="width:100px;">金属屋面</li>' +
		    '<li class="com" id="clear">清空</li>' +
		    '<li class="" style="visibility: hidden;"></li>' +
		    '<li class="" style="visibility: hidden;"></li>' +
		    '<li class="" style="visibility: hidden;margin:0;"></li>' +
		    '</ul>');
		    
		var attr = []
		$("#keyboard_Box .list").on('click', function() {
		    if ($("#sjq_ggcz").val() == "") {
		        $("#sjq_ggcz").val("")
		        attr = []
		    }
		    var val = $(this).html()
		    attr.push(val)
		    for (var i = 0; i < attr.length; i++) {
		    	attvalu = attr.join('');
		        $("#sjq_ggcz").val(attvalu)
		        var s = $("#sjq_ggcz").val()
		        s = s.replace(',', '');
		        $("#sjq_ggcz").val(s)
		    }
		})
		$("#clear").on("click", function() {
		    attr = []
		    $("#sjq_ggcz").val("");
		})
		$("#").on("click", function() {
		    var longnum = $("#sjq_ggcz").val().length;
		    var num;
		    num = $("#sjq_ggcz").val().substr(0, longnum - 1);
		    num = num.replace(',', '');
		    $("#sjq_ggcz").val(num);
		})
		$("#shift").on("click", function() {
		    setCapsLock("#shift")
		})
		
		$('.outDetail2').click(function(){
			$('#keyboard_Box').hide();
			$(this).find('#keyboard_Box').show();
		})
		
		$("#keyboard_Box1").html('<li class="list">1</li>' +
		    '<li class="list">2</li>' +
		    '<li class="list">3</li>' +
		    '<li class="list">4</li>' +
		    '<li class="list">5</li>' +
		    '<li class="list">6</li>' +
		    '<li class="list">7</li>' +
		    '<li class="list">8</li>' +
		    '<li class="list">9</li>' +
		    '<li class="list">0</li>' +
		    '<li class="list toLowerCase">∠</li>' +
		    '<li class="list toLowerCase">.</li>' +
		    '<li class="list toLowerCase">Φ</li>' +
		    '<li class="list toLowerCase">◎</li>' +
		    '<li class="list toLowerCase">≥</li>' +
		    '<li class="list toLowerCase">≤</li>' +
		    '<li class="list toLowerCase">/</li>' +
		    '<li class="list toLowerCase">-</li>' +
		    '<li class="list toLowerCase">×</li>' +
		    '<li class="list toLowerCase">W</li>' +
		    '<li class="list toLowerCase">D</li>' +
		    '<li class="list toLowerCase">S</li>' +
		    '<li class="list toLowerCase">Fe</li>' +
		    '<li class="list toLowerCase">Cu</li>' +
		    '<li class="list toLowerCase">Al</li>' +
		    '<li class="list toLowerCase2" style="width:60px;">本身</li>' +
		    '<li class="list toLowerCase2" style="width:60px;">暗敷</li>' +
		    '<li class="list toLowerCase1" style="width:100px;">金属构件</li>' +
		    '<li class="list toLowerCase1" style="width:100px;">金属屋面</li>' +
		    '<li class="com" id="clear1">清空</li>' +
		    '<li class="" style="visibility: hidden;"></li>' +
		    '<li class="" style="visibility: hidden;"></li>' +
		    '<li class="" style="visibility: hidden;margin:0;"></li>' +
		    '</ul>');
		    
		var attr1 = []
		$("#keyboard_Box1 .list").on('click', function() {
		    if ($("#yxx_ggcz").val() == "") {
		        $("#yxx_ggcz").val("")
		        attr1 = []
		    }
		    var val = $(this).html()
		    attr1.push(val)
		    for (var i = 0; i < attr1.length; i++) {
		    	attvalu = attr1.join('');
		        $("#yxx_ggcz").val(attvalu)
		        var s = $("#yxx_ggcz").val()
		        s = s.replace(',', '');
		        $("#yxx_ggcz").val(s)
		    }
		})
		$("#clear1").on("click", function() {
		    attr1 = []
		    $("#yxx_ggcz").val("");
		})
		$("#").on("click", function() {
		    var longnum = $("#yxx_ggcz").val().length;
		    var num;
		    num = $("#yxx_ggcz").val().substr(0, longnum - 1);
		    num = num.replace(',', '');
		    $("#yxx_ggcz").val(num);
		})
		$("#shift").on("click", function() {
		    setCapsLock("#shift")
		})
		
		$('.outDetail2').click(function(){
			$('#keyboard_Box1').hide();
			$(this).find('#keyboard_Box1').show();
		})
		
		
		$("#keyboard_Box2").html('<li class="list">1</li>' +
		    '<li class="list">2</li>' +
		    '<li class="list">3</li>' +
		    '<li class="list">4</li>' +
		    '<li class="list">5</li>' +
		    '<li class="list">6</li>' +
		    '<li class="list">7</li>' +
		    '<li class="list">8</li>' +
		    '<li class="list">9</li>' +
		    '<li class="list">0</li>' +
		    '<li class="list toLowerCase">∠</li>' +
		    '<li class="list toLowerCase">.</li>' +
		    '<li class="list toLowerCase">Φ</li>' +
		    '<li class="list toLowerCase">◎</li>' +
		    '<li class="list toLowerCase">≥</li>' +
		    '<li class="list toLowerCase">≤</li>' +
		    '<li class="list toLowerCase">/</li>' +
		    '<li class="list toLowerCase">-</li>' +
		    '<li class="list toLowerCase">×</li>' +
		    '<li class="list toLowerCase">W</li>' +
		    '<li class="list toLowerCase">D</li>' +
		    '<li class="list toLowerCase">S</li>' +
		    '<li class="list toLowerCase">Fe</li>' +
		    '<li class="list toLowerCase">Cu</li>' +
		    '<li class="list toLowerCase">Al</li>' +
		    '<li class="list toLowerCase2" style="width:60px;">本身</li>' +
		    '<li class="list toLowerCase2" style="width:60px;">暗敷</li>' +
		    '<li class="list toLowerCase1" style="width:100px;">金属构件</li>' +
		    '<li class="list toLowerCase1" style="width:100px;">金属屋面</li>' +
		    '<li class="com" id="clear2">清空</li>' +
		    '<li class="" style="visibility: hidden;"></li>' +
		    '<li class="" style="visibility: hidden;"></li>' +
		    '<li class="" style="visibility: hidden;margin:0;"></li>' +
		    '</ul>');
		    
		var attr2 = []
		$("#keyboard_Box2 .list").on('click', function() {
		    if ($("#jdx_ggcz").val() == "") {
		        $("#jdx_ggcz").val("")
		        attr2 = []
		    }
		    var val = $(this).html()
		    attr2.push(val)
		    for (var i = 0; i < attr2.length; i++) {
		    	attvalu = attr2.join('');
		        $("#jdx_ggcz").val(attvalu)
		        var s = $("#jdx_ggcz").val()
		        s = s.replace(',', '');
		        $("#jdx_ggcz").val(s)
		    }
		})
		$("#clear2").on("click", function() {
		    attr2 = []
		    $("#jdx_ggcz").val("");
		})
		$("#").on("click", function() {
		    var longnum = $("#jdx_ggcz").val().length;
		    var num;
		    num = $("#jdx_ggcz").val().substr(0, longnum - 1);
		    num = num.replace(',', '');
		    $("#jdx_ggcz").val(num);
		})
		$("#shift").on("click", function() {
		    setCapsLock("#shift")
		})
		
		$('.outDetail2').click(function(){
			$('#keyboard_Box2').hide();
			$(this).find('#keyboard_Box2').show();
		})
		
		
  		//checkbox 回显
		var checkboxValues = '${fzjlInfo.yqsb_info }';
		checkboxValues = ',' + checkboxValues + ',';
		var yqInfo = document.getElementsByName('yqsb_info');
		for (var i = 0; i < yqInfo.length; i++){
			if (checkboxValues.indexOf(',' + yqInfo[i].value + ',') != -1) {
				yqInfo[i].checked = true;
			}
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
			form1.action = "${app}/cgjc/cgjc/fzjlSave.do?method="+'${method}';
			form1.submit();
		}
		
	</script>
</html>

