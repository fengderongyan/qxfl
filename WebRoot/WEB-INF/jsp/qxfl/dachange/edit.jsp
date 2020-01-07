<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/inc/includeBase.jsp" %>
	<%@ include file="/inc/includeEasyUi.jsp" %>
	<link rel="stylesheet" href="${app}/css/ztree/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="${app}/js/ztree/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="${app}/js/ztree/jquery.ztree.excheck-3.5.js"></script>
	<title>修改档案编码</title>
	<style type="">
	.hintInfo{padding:8px 35px 8px 10px;text-shadow:none;-webkit-box-shadow:0 2px 4px rgba(0,0,0,0.2);-moz-box-shadow:0 2px 4px rgba(0,0,0,0.2);box-shadow:0 2px 4px rgba(0,0,0,0.2);background-color:#f9edbe;border:1px solid #f0c36d;-webkit-border-radius:2px;-moz-border-radius:2px;border-radius:2px;color:#333}
	
	</style>
</head>
<body>
	<form id="form2" name="form2" action="${app}/daCfg/saveOrUpdateDaId.do" method="post"  >
		<zcc:csrfToken />
		<div id="queryPanel" class="queryPanel">
			<div id="queryPanel_title" class="queryPanel_title">
				<div class="queryPanel_title_collapse"></div>&nbsp;修改档案编码
			</div>
		    <div id="queryPanel_content" class="queryPanel_content">
				<table class="form_table" cellspacing="0" cellpadding="0" style="width: 100%;">
					<tr height="20">
						<td class="outDetail">
							<font color="red">*</font>&nbsp;档案编号：
						</td>
						<td class="outDetail2">
							<input type="text" id="da_id" name="da_id" value="${daInfo.da_id}" />	
							<input type="hidden" id="id" name="id" value="${daInfo.id}" />	
						</td>
					</tr>
				</table>
		    </div>
		</div>
		<br />
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
	//验证方法
	function errorCheck() { 
		//判断新档案编号是否存在
		var isDaIdExist=false;
		var url2 = '${app}/daCfg/checkDaIdOnly.do';
		var params2 = 'id='+$('#id').val()+'&da_id='+$('#da_id').val();
		var ajaxRes2 = new MyJqueryAjax(url2, params2).request();
		if(ajaxRes2 > 0) {
			isDaIdExist=true; 
		}
		if(isDaIdExist==true) {
			alert('该档案编号已经在使用，请换用其他档案编号！');
			$('#da_id').focus();
			return false; 
		}
		return true;
	}
	//保存方法
	function sav(src) {
		//防止重复提交
		disable(document.getElementById("saveBtn"));
		if(!errorCheck()) {
			enable(document.getElementById("saveBtn"));
			return false;
		}
		form2.submit();
	}
</script>
</html>
