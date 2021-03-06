<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/inc/includeBase.jsp" %>
</head>
	<body>
		<zcc:csrfToken />
		<display:table name="list" requestURI="${app}/sys/log/loginHisList.do"
			class="list" id="row" cellspacing="0" style="width:100%" partialList="true" size="size"
			cellpadding="0" pagesize="${param.pageSize}" export="false" sort="external" >
			<display:column title="序号" media="html" style="width: 50px;">
				<c:out value="${row_rowNum+beginIndex}" />
			</display:column>
			<display:column title="归属组织" property="ORG_NAME"/>
			<display:column title="人员工号" property="OPERATOR_ID" style="width: 120px;"/>
			<display:column title="姓名" property="NAME" style="width: 120px;"/>
			<display:column title="手机号码" property="MOBILE" style="width: 120px;"/>
			<display:column title="登录时间" property="OPERATE_TIME" style="width: 140px;"/>
			<display:column title="登录IP" property="CLIENT_ADDRESS"/>
			<display:column title="登录类型" property="OP_TYPE_NAME" style="width: 100px;"/>
		</display:table>
	</body>
	<script type="text/javascript">
		$(document).ready(function(){
			//启用frame查询按钮
			window.parent.enable($('#schbtn', parent.document));  
		});
	</script>
</html>