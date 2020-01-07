<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/inc/includeBase.jsp" %>
	<c:choose>
		<c:when test="${param.method=='edit'}">
			<c:set var="title" value="修改设备信息"></c:set>
		</c:when>
		<c:when test="${param.method=='add'}">
			<c:set var="title" value="新增设备信息"></c:set>
		</c:when>
		<c:when test="${param.method=='show'}">
			<c:set var="title" value="设备详细信息"></c:set>
		</c:when>
	</c:choose>
	<title>${title}</title>
</head>
<body>
	<form id="form1" name="form1" action="${app}/yqsb/saveOrUpdate.do" method="post">
		<div id="queryPanel" class="queryPanel">
			<div id="queryPanel_title" class="queryPanel_title">
				<div class="queryPanel_title_collapse"></div>&nbsp;${title}
			</div>
		    <div id="queryPanel_content" class="queryPanel_content">
				<table class="detail_table" cellspacing="0" cellpadding="0" style="width: 100%;">
					<tr>
						<td class="outDetail">
							<font color="red">*</font>&nbsp;仪器编号：
						</td>
						<td class="outDetail2" colspan="3">
							<input id="yq_bh" name="yq_bh" value="${map.yq_bh }" required="true" dataType="Require" msg="请填写仪器编号"/>
						</td>
					</tr>
					<tr>
						<td class="outDetail">
							<font color="red">*</font>&nbsp;仪器名称：
						</td>
						<td class="outDetail2" colspan="3">
							<input id="yq_name" name="yq_name" value="${map.yq_name }" required="true" dataType="Require" msg="请填写仪器名称"/>
						</td>
					</tr>
					<tr>
						<td class="outDetail">
							<font color="red">*</font>&nbsp;规格型号：
						</td>
						<td class="outDetail2" colspan="3">
							<input id="ggxh" name="ggxh" value="${map.ggxh }" required="true" dataType="Require" msg="请填写规格型号"/>
						</td>
					</tr>
					<tr>
						<td class="outDetail">
							<font color="red">*</font>&nbsp;部门名称：
						</td>
						<td class="outDetail2" colspan="3">
							<input id="dpt_name" name="dpt_name" value="${map.dpt_name }" required="true" dataType="Require" msg="请填写部门名称"/>
						</td>
					</tr>
					<tr>
						<td class="outDetail">
							<font color="red">*</font>&nbsp;检定情况：
						</td>
						<td class="outDetail2" colspan="3">
							<input id="check_qk" name="check_qk" value="${map.check_qk }" required="true" dataType="Require" msg="请填写检定情况"/>
						</td>
					</tr>
				</table>
		    </div>
		</div>
		<br />
		<p align="center">
			<input type="hidden" id="id" name="id" value="${map.id}"  />
			<input type="hidden" name="method" id="method" value="${param.method}" />
			<c:if test="${param.method!='show'}">
				<zcc:button cssClass="ovalbutton" onclick="sav(this);return false;">保 存</zcc:button>
			</c:if>&nbsp;
			<zcc:button cssClass="ovalbutton" onclick="window.close();">关 闭</zcc:button>
		</p>
	</form>
</body>
<script type="text/javascript" defer="defer">
	$(document).ready(function(){
		if(${param.method != 'create'}){
			if(${map.is_branch_root == 1}){
				$('#location').show();
			}else {
				$('#location').hide();
			}
		}
	});

	
	//保存
	function sav(src) {
		disable(src);
		if(!Validator.Validate('form1')) {
			enable(src);
			return false;
		}
		$('#form1').submit();
	}
	
	
</script>
</html>
