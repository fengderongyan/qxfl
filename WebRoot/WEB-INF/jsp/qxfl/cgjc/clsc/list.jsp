<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="/inc/includeBase.jsp"%>
		<script type="text/javascript" src="${app}/js/My97DatePicker/WdatePicker.js"></script>
	</head>
	<body>
		<display:table name="list" requestURI="${app}/cgjc/cgjc/clscList.do"
			class="list" id="row" cellspacing="0" style="width:100%"
			cellpadding="0" pagesize="18" export="false" sort="external"  partialList="true" size="size">
			<display:column title="序号" style="width:60px;" media="html">
				<c:out value="${row_rowNum + beginIndex}" />
			</display:column>
			<display:column title="文件名称" property="cl_name" />
			<display:column title="文件类型" property="cl_type" />
			<display:column title="上传时间" property="sc_date" />
			<display:column title="材料大小" property="cl_dx" />
			<display:column title="操作" media="html" style="width:130px;">
				<zcc:button cssClass="smallBtn_gray"
					onclick="downloadFile('/showphoto/${row.cl_name_d }', '${row.cl_name }');">下载</zcc:button>&nbsp;
				<c:if test="${row.rec_id eq user.operatorId &&  empty cflag }">
					<zcc:button cssClass="smallBtn_gray"
						onclick="del('${row.id}');return false;">删除</zcc:button>&nbsp;
				</c:if> 
			</display:column>
		</display:table>
	</body>
	<script type="text/javascript">
		$(document).ready(function(){
			//启用frame查询按钮
			window.parent.enable($('#schbtn', parent.document));  
		});
		
		function dqdybhqInfoEdit(id){
			MyWindow.OpenCenterWindowScroll('${app}/cgjc/cgjc/dqdybhqEdit.do?method=edit&id='+id,'editDqdybhq',800,800);
		}
		
		function copyDqdybhqInfo(base_id, id){
			MyWindow.OpenCenterWindowScroll('${app}/cgjc/cgjc/dqdybhqEdit.do?method=copy&base_id='+base_id+'&id='+id,'copyDqdybhq',800,800);
		}
		
		function del(id){//删除
			if(window.confirm('确定要删除吗？')){
				var res = new MyJqueryAjax('${app}/cgjc/cgjc/delClsc.do','id='+id).request();
				if(res==1){
					alert('删除成功！');
					window.parent.form1.submit();
				}else{
					alert('删除失败！');
					window.parent.form1.submit();
				}
			}
		}
		
		//下载文件 
	    function downloadFile(url,name) {
	    	var log_id = exportBtn.customExportLog2('exptbtn','${app}','材料信息下载，材料名称：'+name,
				'${param.module_id}',url, '');
	    	window.location.href="<%=Constants.DOWNLOAD%>?file_name="+encodeURI(encodeURI(url))+
	    			"&filename="+encodeURI(encodeURI(name));
	    	<%--IE 和 360 可用，火狐不可用，原因是：火狐缓存优先机制 
	    		window.location.reload('<%=Constants.DOWNLOAD%>?file_name='+encodeURI(encodeURI(url))+
	    			'&filename='+encodeURI(encodeURI(name))); --%>
	    }
		
	</script>
</html>