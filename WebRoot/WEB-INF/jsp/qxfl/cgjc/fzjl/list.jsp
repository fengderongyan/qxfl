<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="/inc/includeBase.jsp"%>
	</head>
	<body>
		<display:table name="list" requestURI="${app}/cgjc/cgjc/fzjlList.do"
			class="list" id="row" cellspacing="0" style="width:100%"
			cellpadding="0" pagesize="18" export="false" sort="external"  partialList="true" size="size">
			<display:column title="序号" style="width:60px;" media="html">
				<c:out value="${row_rowNum + beginIndex}" />
			</display:column>
			<display:column title="合格状态" style="width:60px;" media="html">
				<c:choose>
					<c:when test="${row.dx_result == 1 }">合格</c:when>
					<c:when test="${row.dx_result == 2 }">不合格</c:when>
					<c:when test="${row.dx_result == 3 }">/</c:when>
				</c:choose>
			</display:column>
			<display:column title="被保护物名称" property="bbhw_name" />
			<display:column title="被保护物长/宽/高" property="ckg" />
			<display:column title="接闪杆形状" property="sjq_xz" />
			<display:column title="接闪杆高度" property="sjq_gd"  />
			<display:column title="引下线数量" property="yxx_sl"  />
			<display:column title="引下线间距" property="yxx_jj"  />
			<display:column title="操作" media="html" style="width:180px;">
				<zcc:button cssClass="smallBtn_gray"
						onclick="fzjlInfoEdit('${row.id}', 'show');return false;">详细</zcc:button>&nbsp; 
				<c:if test="${row.rec_id eq user.operatorId  &&  empty cflag }">
					<zcc:button cssClass="smallBtn_gray"
						onclick="fzjlInfoEdit('${row.id}', 'edit');return false;">修改</zcc:button>&nbsp; 
					<zcc:button cssClass="smallBtn_gray"
						onclick="del('${row.id}');return false;">删除</zcc:button>&nbsp;
					<zcc:button cssClass="smallBtn_gray"
						onclick="copyFzjlInfo('${row.base_id}', '${row.id }');return false;">复制</zcc:button>&nbsp;
				</c:if> 
			</display:column>
		</display:table>
	</body>
	<script type="text/javascript">
		$(document).ready(function(){
			//启用frame查询按钮
			window.parent.enable($('#schbtn', parent.document));  
		});
		
		function fzjlInfoEdit(id, method){
			MyWindow.OpenCenterWindowScroll('${app}/cgjc/cgjc/fzjlEdit.do?method='+method+'&id='+id,'editFzjl',900,800);
		}
		
		function copyFzjlInfo(base_id, id){
			MyWindow.OpenCenterWindowScroll('${app}/cgjc/cgjc/fzjlEdit.do?method=copy&base_id='+base_id+'&id='+id,'editFzjl',900,800);
		}
		
		function del(id){//删除
			if(window.confirm('确定要删除吗？')){
				var res = new MyJqueryAjax('${app}/cgjc/cgjc/delFzjl.do','id='+id).request();
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