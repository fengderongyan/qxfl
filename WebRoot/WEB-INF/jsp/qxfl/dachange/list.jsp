<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="/inc/includeBase.jsp"%>
	</head>
	<body>
		<display:table name="jcInfoList" requestURI="${app}/daCfg/list.do"
			class="list" id="row" cellspacing="0" style="width:100%"
			cellpadding="0" pagesize="${param.pageSize}" export="false" sort="external"  partialList="true" size="size">
			<display:column title="序号" style="width:60px;" media="html">
				<c:out value="${row_rowNum + beginIndex}" />
			</display:column>
			<display:column title="单位名称"  property="dw_name"/>
			<display:column title="单位地址"  property="dw_addr" />
			<display:column title="报告编号" property="bg_id" />
			<display:column title="档案编号" property="da_id" />
			<display:column title="操作" media="html" style="width:100px;">
				<zcc:button cssClass="smallBtn_gray"
					onclick="changeId('${row.id}');return false;">档案编码修改</zcc:button>&nbsp;
			</display:column>
		</display:table>
	</body>
	<script type="text/javascript">
		
		
		$(document).ready(function(){
			//启用frame查询按钮
			window.parent.enable($('#schbtn', parent.document));  
		});
		
    	function changeId(id) {	
      　　		MyWindow.OpenCenterWindowScroll('${app}/daCfg/changeDaId.do?id='+id,'changeDaId', 300, 400);
    	}
	</script>
</html>