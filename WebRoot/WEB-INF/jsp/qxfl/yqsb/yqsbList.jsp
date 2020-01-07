<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="/inc/includeBase.jsp"%>
	</head>
	<body>
		<display:table name="list" requestURI="${app}/yqsb/yqsbList.do"
			class="list" id="row" cellspacing="0" style="width:100%"
			cellpadding="0" pagesize="${param.pageSize}" export="false" sort="external"  partialList="true" size="size">
			<display:column title="序号" style="width:32px;" media="html">
				<c:out value="${row_rowNum + beginIndex}" />
			</display:column>
			<display:column title="仪器编号" property="yq_bh" />
			<display:column title="仪器名称" property="yq_name" />
			<display:column title="规格型号" property="ggxh"  />
			<display:column title="部门名称" property="dpt_name" />
			<display:column title="检定情况" property="check_qk" />
			
			<display:column title="操作" media="html" style="width:150px;">
				<zcc:button cssClass="smallBtn_gray"
					onclick="edit('${row.id}','edit');return false;">修改</zcc:button>&nbsp;
				<zcc:button cssClass="smallBtn_gray"
					onclick="deleteInfo('${row.id}');return false;">删除</zcc:button>&nbsp;
			</display:column>
		</display:table>
	</body>
	<script type="text/javascript">
		$(document).ready(function(){
			//启用frame查询按钮
			window.parent.enable($('#schbtn', parent.document));  
		});
		
    	function edit(id, method) {	
      　　		MyWindow.OpenCenterWindowScroll('${app}/yqsb/yqsbEdit.do?id=' + id +'&method=' + method,'yqsbEdit',400,700);
    	}
    
    	function deleteInfo(id){
		 	if(!confirm('确定要删除该设备吗？')) {
				return false;
			}
			var url = '${app}/yqsb/deleteYqsb.do';
			var params="id="+id;
			var res = new MyJqueryAjax(url,params).request();
			if(res==1) {
				alert('数据操作成功！');
		  	} else {
				alert('数据操作失败！');
		  	}
		  	window.parent.$('#form1').submit();
		}
	</script>
</html>