<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/inc/includeBase.jsp" %>
<head>
	<title> 
		新增检测单位
	</title>
	<style>
		table.form_table td, table.form_table th {
			border: 1px solid #D3D3D3;
			font-size: 13px;
		}
		
		table.form_table td.outDetail {
			text-align: center;
			font-size: 13px;
		}
		table.form_table tr.outHeader td {
			background-position:left -1px;
			text-valign: middle;
			text-align: center;
			font-weight: bold;
			font-size: 15px;
			height: 25px;
			color:#15428B;
			border-collapse:collapse;
		}
	</style>
</head>
	<body scroll="yes">
	<form id="form1" name="form1" action="${app}/cgjc/cgjc/jcdwSave.do"  
		method="post">
		   <input type="hidden" id="nowYear" name="nowYear" value="${nowYear }" />
		   <table class="form_table" width="98%" align="center" >
				<tr class="outHeader">
					<td colspan="4">
						新增检测单位
					</td>
				</tr>
				<tr height="26px">
               		<td class="outDetail" >
						报告编码:
                	</td>
                	<td class="outDetail2">
                		<input type="text" id="bg_id" name="bg_id" style="background-color: #DDDDDD;"
                			value="${bg_id }" readonly="readonly" />
                	</td>
                	<td class="outDetail" >
						档案编码:
                	</td>
                	<td class="outDetail2">
                		<input type="text" id="da_id" name="da_id" style="background-color: #DDDDDD;"
                			value="${da_id }" readonly="readonly" />
                	</td>
                </tr>
				<tr height="26px">
               		<td class="outDetail" >
						单位名称:<label style="color:red">*</label>
                	</td>
                	<td class="outDetail2">
                		<input type="text" id="dw_name" name="dw_name"
                			dataType="Require" msg="请输入单位名称!"/>
                	</td>
                	<td class="outDetail" >
						单位地址:
                	</td>
                	<td class="outDetail2">
                		<input type="text" id="dw_addr" name="dw_addr" dataType="Require" msg="请输入单位地址!"/>
                	</td>
                </tr>
                <tr height="26px">
               		<td class="outDetail" >
						联系部门:
                	</td>
                	<td class="outDetail2">
                		<input type="text" id="lx_bm" name="lx_bm" />
                	</td>
                	<td class="outDetail" >
						部门电话:
                	</td>
                	<td class="outDetail2">
                		<input type="text" id="bm_phone" name="bm_phone"  />
                	</td>
                </tr>
                <tr height="26px">
               		<td class="outDetail" >
						联系人:
                	</td>
                	<td class="outDetail2">
                		<input type="text" id="lxr" name="lxr" />
                	</td>
                	<td class="outDetail" >
						联系电话:
                	</td>
                	<td class="outDetail2">
                		<input type="text" id="lxr_phone" name="lxr_phone"  />
                	</td>
                </tr>
                <tr height="26px">
               		<td class="outDetail" >
						雷击时间:
                	</td>
                	<td class="outDetail2">
                		<input type="text" id="lj_date" name="lj_date" size="11"
							onclick="WdatePicker();" readonly="readonly" />
                	</td>
                	<td class="outDetail" >
						邮编:
                	</td>
                	<td class="outDetail2">
                		<input type="text" id="yb" name="yb"  />
                	</td>
                </tr>
                <tr height="26px">
               		<td class="outDetail" >
						行业类别:<label style="color:red">*</label>
                	</td>
                	<td class="outDetail2">
                		<zcc:select name="hy_type" id="hy_type" list="hyTypeList"
							optionLabel="dd_item_name" optionValue="dd_item_code"
							headLabel="请选择..." headValue="" dataType="Require"
							msg="请选择行业类别!" />
                	</td>
                	<td class="outDetail" >
						地理环境:<label style="color:red">*</label>
                	</td>
                	<td class="outDetail2">
                		<zcc:select name="dlhj" id="dlhj" list="dlhjList"
							optionLabel="dd_item_name" optionValue="dd_item_code" dataType="Require"
							msg="请选择地理环境!" headLabel="请选择..." headValue="" />
                	</td>
                </tr>
                <tr height="26px">
               		<td class="outDetail" >
						经度:
                	</td>
                	<td class="outDetail2">
                		<input type="text" id="jd" name="jd"  />
                	</td>
                	<td class="outDetail" >
						纬度:
                	</td>
                	<td class="outDetail2">
                		<input type="text" id="wd" name="wd"  />
                	</td>
                </tr>
                <tr height="26px">
               		<td class="outDetail" >
						行政区域:<label style="color:red">*</label>
                	</td>
                	<td class="outDetail2">
                		<input type="text" id="xzqy" name="xzqy" dataType="Require"
							msg="请输入行政区域!"  />
                	</td>
                	<td class="outDetail" >
						检测组别:<label style="color:red">*</label>
                	</td>
                	<td class="outDetail2">
                		<zcc:select name="jc_group" id="jc_group" list="jczbList"
							optionLabel="dd_item_name" optionValue="dd_item_code"
							headLabel="请选择..." headValue="" dataType="Require"
							msg="请选择检测组别!"/>
                	</td>
                </tr>
               <!--  <tr height="26px">
               		<td class="outDetail" >
						雷击损失情况:
                	</td>
                	<td class="outDetail2" colspan="3">
                		<textarea rows="3" cols="60" id="lj_ss_info" name="lj_ss_info" 
							style="width: 100%;" ></textarea>
                	</td>
                </tr> -->
                
		</table>
		<br>
		<center>
			<zcc:button cssClass="ovalbutton" onclick="sav(this);">保存</zcc:button>&nbsp;
			<zcc:button cssClass="ovalbutton" onclick="window.close();">关闭</zcc:button>
		</center>
  </form>
</body>
<script type="text/javascript">
	//保存
	function sav(src){
	 	src.disabled=true;
	 	if(!Validator.Validate("form1")){
			src.disabled = false ;
			return false;
		}
		
		//验证档案编码是否存在
		var isDaExist=false;
		var url = '${app}/cgjc/cgjc/checkDaId.do';
		var param = 'da_id='+$('#da_id').val();
		var ajaxRes = new MyJqueryAjax(url, param).request();
		if(ajaxRes != 0) {
			isDaExist=true; 
		}
		if(isDaExist==true) {
			alert('系统生成档案编号已被占用，请关闭当前窗口重新添加！');
			return false; 
		}
		
		form1.submit();
	}
	
   </script>
</html>