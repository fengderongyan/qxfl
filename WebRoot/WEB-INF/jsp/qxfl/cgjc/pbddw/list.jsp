<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="/inc/includeBase.jsp"%>
	</head>
	<body>
		<display:table name="list" requestURI="${app}/cgjc/cgjc/pbddwList.do"
			class="list" id="row" cellspacing="0" style="width:100%"
			cellpadding="0" pagesize="18" export="false" sort="external"  partialList="true" size="size">
			<display:column title="序号" style="width:60px;" media="html">
				<c:out value="${row_rowNum + beginIndex}" />
			</display:column>
			<display:column title="建筑物" property="jzw" />
			<display:column title="检测点" property="jcd" />
			<display:column title="规格材质" property="ggcz" />
			<display:column title="电阻值（Ω）" property="dzz"  />
			<display:column title="标准要求（Ω）" property="dzz_bzyq"  />
			<display:column title="单项评定" style="width:60px;" media="html">
				<c:choose>
					<c:when test="${row.dx_result == 1 }">合格</c:when>
					<c:when test="${row.dx_result == 2 }">不合格</c:when>
					<c:when test="${row.dx_result == 3 }">/</c:when>
				</c:choose>
			</display:column>
			<display:column title="操作" media="html" style="width:180px;">
				<zcc:button cssClass="smallBtn_gray"
						onclick="pbddwInfoEdit('${row.id}', 'show');return false;">详细</zcc:button>&nbsp; 
				<c:if test="${row.rec_id eq user.operatorId &&  empty cflag }">
					<zcc:button cssClass="smallBtn_gray"
						onclick="pbddwInfoEdit('${row.id}', 'edit');return false;">修改</zcc:button>&nbsp; 
					<zcc:button cssClass="smallBtn_gray"
						onclick="del('${row.id}');return false;">删除</zcc:button>&nbsp;
					<zcc:button cssClass="smallBtn_gray"
						onclick="copyPbddwInfo('${row.base_id}', '${row.id }');return false;">复制</zcc:button>&nbsp; 
				</c:if> 
			</display:column>
		</display:table>
	</body>
	<script type="text/javascript">
		$(document).ready(function(){
			//启用frame查询按钮
			window.parent.enable($('#schbtn', parent.document));  
		});
		
		function pbddwInfoEdit(id, method){
			var baseId = '${base_id}';
			MyWindow.OpenCenterWindowScroll('${app}/cgjc/cgjc/pbddwEdit.do?method='+method+'&id='+id+'&base_id='+baseId,'editFzjl',600,600);
		}
		
		function copyPbddwInfo(base_id, id){
			MyWindow.OpenCenterWindowScroll('${app}/cgjc/cgjc/pbddwEdit.do?method=copy&base_id='+base_id+'&id='+id+'&base_id'+'${base_id}','editFzjl',600,600);
		}
		
		function del(id){//删除
			if(window.confirm('确定要删除吗？')){
				var res = new MyJqueryAjax('${app}/cgjc/cgjc/delPbddw.do','id='+id).request();
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