<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="/inc/includeBase.jsp"%>
	</head>
	<body>
		<display:table name="list" requestURI="${app}/cgjc/cgjc/dzxtList.do"
			class="list" id="row" cellspacing="0" style="width:100%"
			cellpadding="0" pagesize="18" export="false" sort="external"  partialList="true" size="size">
			<display:column title="序号" style="width:60px;" media="html">
				<c:out value="${row_rowNum + beginIndex}" />
			</display:column>
			<display:column title="合格状态" property="dx_result" />
			<display:column title="机房名称" property="jf_name" />
			<display:column title="机房位置" property="jf_wz" />
			<display:column title="机房面积(m²)" property="jfmj" />
			<display:column title="机房防雷等级" property="jf_fldj"  />
			<display:column title="所在大楼名称" property="szdl_fldj" />
			<display:column title="所在大楼防雷类别" property="szdl_fllb"  />
			<display:column title="操作" media="html" style="width:180px;">
				<zcc:button cssClass="smallBtn_gray"
						onclick="dzxtInfoEdit('${row.id}', 'show');return false;">详细</zcc:button>&nbsp;
				<c:if test="${row.rec_id eq user.operatorId &&  empty cflag }">
					<zcc:button cssClass="smallBtn_gray"
						onclick="dzxtInfoEdit('${row.id}', 'edit');return false;">修改</zcc:button>&nbsp; 
					<zcc:button cssClass="smallBtn_gray"
						onclick="del('${row.id}');return false;">删除</zcc:button>&nbsp;
					<zcc:button cssClass="smallBtn_gray"
						onclick="copyDzxtInfo('${row.base_id}', '${row.id }');return false;">复制</zcc:button>&nbsp;
				</c:if> 
			</display:column>
		</display:table>
	</body>
	<script type="text/javascript">
		$(document).ready(function(){
			//启用frame查询按钮
			window.parent.enable($('#schbtn', parent.document));  
		});
		
		function dzxtInfoEdit(id, method){
			MyWindow.OpenCenterWindowScroll('${app}/cgjc/cgjc/dzxtEdit.do?method='+method+'&id='+id,'editDzxt',800,900);
		}
		
		function copyDzxtInfo(base_id, id){
			MyWindow.OpenCenterWindowScroll('${app}/cgjc/cgjc/dzxtEdit.do?method=copy&base_id='+base_id+'&id='+id,'copyDzxt',800,900);
		}
		
		function del(id){//删除
			if(window.confirm('确定要删除吗？')){
				var res = new MyJqueryAjax('${app}/cgjc/cgjc/delDzxt.do','id='+id).request();
				if(res==1){
					alert('删除成功！');
					window.parent.form1.submit();
				}else{
					alert('删除失败！');
					window.parent.form1.submit();
				}
			}
		}
		
		
	</script>
</html>