<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/inc/includeBase.jsp" %>
	<%@ include file="/inc/includeEasyUi.jsp" %>
	<link rel="stylesheet" href="${app}/css/ztree/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="${app}/js/ztree/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="${app}/js/ztree/jquery.ztree.excheck-3.5.js"></script>
	
	<title>多屏蔽等电位信息新增</title>
	<style type="">
	.hintInfo{padding:8px 35px 8px 10px;text-shadow:none;-webkit-box-shadow:0 2px 4px rgba(0,0,0,0.2);-moz-box-shadow:0 2px 4px rgba(0,0,0,0.2);box-shadow:0 2px 4px rgba(0,0,0,0.2);background-color:#f9edbe;border:1px solid #f0c36d;-webkit-border-radius:2px;-moz-border-radius:2px;border-radius:2px;color:#333}
	
	</style>
</head>
<body>
	<form id="form2" name="form2" action="${app}/cgjc/cgjc/pbddwSaveMore.do" method="post"  >
		<zcc:csrfToken />
		<div id="queryPanel" class="queryPanel">
			<div id="queryPanel_title" class="queryPanel_title">
				<div class="queryPanel_title_collapse"></div>&nbsp;${title}
			</div>
		    <div id="queryPanel_content" class="queryPanel_content">
		    	<center>
		    	<div>
		    		<input type="hidden" value="${base_id }" id="base_id" name="base_id" />
					<input type="hidden" id="pageSize" name="pageSize" value="" />
					<zcc:button id="schbtn" cssClass="ovalbutton" onclick="addInfo();return false;">新增一条</zcc:button>
					<br/>&nbsp;
				</div>
				</center>
				<table class="form_table" style="width: 99%;"
					align="center"  >
					<tr height="25">
						<td class="outDetail"  >
							<font color="red">*</font>&nbsp;建筑物来源
						</td>
						<td class="outDetail"  >
							<font color="red">*</font>&nbsp;建筑物
						</td>
						<td class="outDetail"  >
							<font color="red">*</font>&nbsp;检测点
						</td>
						<td class="outDetail"  >
							<font color="red">*</font>&nbsp;属性
						</td>
						<td class="outDetail"  >
							<font color="red">*</font>&nbsp;规格材质(mm⁄mm²)
						</td>
						<td class="outDetail"  >
							<font color="red">*</font>&nbsp;电阻值(Ω)
						</td>
						<td class="outDetail"  >
							<font color="red">*</font>&nbsp;标准要求(Ω)
						</td>
						<td class="outDetail"  >
							<font color="red">*</font>&nbsp;单项评定
						</td>
						<td class="outDetail"  >
							操作
						</td>
					</tr>
					<tr id="dcTabs" name="dcTabs">
						<td class="outDetail2"  >
							防直击雷
							<input type="hidden" id="jzwly" name="jzwly" value="1"/>
						</td>
						<td class="outDetail"  >
							<zcc:select name="jzw" id="jzw" list="bbhNamelist" 
	                			optionLabel="bbhw_name" optionValue="id" value="${pbddwInfo.jzw }" 
	                			dataType="Require" msg="请选择建筑物！" headLabel="请选择..." headValue="" />
						</td>
						<td class="outDetail" >
							<input type="text" id="jcd" name="jcd"  value="${pbddwInfo.jcd }" 
	                			dataType="Require" msg="请输入检测点!" />
						</td>
						<td class="outDetail" >
							<zcc:select name="sx" id="sx" list="sxList"
								optionLabel="dd_item_name" optionValue="dd_item_code"
								value="${pbddwInfo.sx }" />
						</td>
						<td class="outDetail"  >
							<input type="text" id="ggcz" name="ggcz"  value="${pbddwInfo.ggcz }"  />
						</td>
						<td class="outDetail" >
							<input type="text" id="dzz" name="dzz"  value="${pbddwInfo.dzz }"  />
						</td>
						<td class="outDetail" >
							<zcc:select name="dzz_bzyq" id="dzz_bzyq" list="bzyqList"
									optionLabel="dd_item_name" optionValue="dd_item_code" headLabel="请选择..." headValue=""
									value="${pbddwInfo.dzz_bzyq }" />
						</td>
						<td class="outDetail"  >
							<zcc:select name="dx_result" id="dx_result" list="heList"
								optionLabel="dd_item_name" optionValue="dd_item_code"
								value="${pbddwInfo.dx_result }" />
						</td>
						<td class="outDetail"  >
							<a style="color: red; cursor: hand; text-decoration: none; text-decoration: underline;"
								onclick="delRow('dcTabs');return false;"> 
								<b style="font-size: 12px; font-weight: bold;">删 除</b> 
							</a>
						</td>
					</tr>
				</table>
		    </div>
		</div>
		<br />
		<p align="center">
			<c:if test="${param.method!='show'}">
				<zcc:button cssClass="ovalbutton" id="saveBtn" onclick="sav(this);return false;">保 存</zcc:button>
			</c:if>&nbsp;
			<zcc:button cssClass="ovalbutton" onclick="window.close();">关 闭</zcc:button>
		</p>
		<br />
		<br />
	</form>
</body>
<script type="text/javascript" defer="defer">
	//保存方法
	function sav(src){
		src.disabled=true;
		if(!Validator.Validate("form2")){
			src.disabled=false;
			return false;
		}
		form2.submit();
	}
	
	//动态添加
	function addInfo(){
		$("tr[id='dcTabs']:last").after($("tr[id='dcTabs']:first").clone());
		$("tr[id='dcTabs']:last").show();
		
	}
	
	//动态删除
	function delRow(tableId){
		var tab = document.getElementsByName(tableId);
		if(tab.length == 1){
			alert('最后一条不能删除！');
			return false;
		}
		var tb = document.getElementById(tableId);
		//火狐不兼容 event.srcElementevent 处理，且FF不支持event直接使用
		var event = window.event || arguments.callee.caller.arguments[0];
		var src = event.srcElement || event.target;;
		var row = getRow(src);
		//var tab = $(row).parent().parent();
		$(row).remove();
	}
	
</script>
</html>
