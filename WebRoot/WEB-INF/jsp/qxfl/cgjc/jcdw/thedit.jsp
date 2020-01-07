<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/inc/includeBase.jsp" %>
<head>
	<title>
		退回情况说明
	</title>
	<style>
		table.form_table td, table.form_table th {
			border: 1px solid #D3D3D3;
			font-size: 13px;
		}
		
		table.form_table td.outDetail {
			text-align: center;
			font-size: 13px;
		}
		table.form_table tr.outHeader td {
			background-position:left -1px;
			text-valign: middle;
			text-align: center;
			font-weight: bold;
			font-size: 15px;
			height: 25px;
			color:#15428B;
			border-collapse:collapse;
		}
	</style>
</head>
	<body scroll="yes">
	<form id="form1" name="form1" action="#"  
		method="post">
		<center>
			<c:forEach items="${smList }" var="row">
				<table class="form_table"  width="98%">
					<tr class="outHeader">
						<td  >
							历史退回原因
						</td>
					</tr>
					<tr>
						<td>
						<textarea rows="6" cols="70">${row.remark }</textarea>
						</td>
					</tr>
				</table>
			</c:forEach>
			<c:if test="${flag == 0 }">
				<table class="form_table"  width="98%">
					<tr class="outHeader">
						<td  >
							退回原因说明
						</td>
					</tr>
					<tr>
						<td>
							<textarea id="remark" name="remark" rows="7" cols="70"></textarea>
						</td>
					</tr>
				</table>
		        	
				<center>
					<zcc:button cssClass="ovalbutton" onclick="sav();return false;">退回</zcc:button>&nbsp;
					<zcc:button cssClass="ovalbutton" onclick="window.close();">关闭</zcc:button>
				</center>
			</c:if>
		</center>
  </form>
</body>
<script type="text/javascript">

	function sav(){
		var infoId = '${baseId}';
		var url = '${url}';
		var remark = $('#remark').val();
		alert(infoId);
		alert(url);
		alert(remark);
		var res = new MyJqueryAjax('${app}/cgjc/cgjc/saveThInfo.do','id='+infoId+'&remark='+remark).request();
		alert(res);
		if(res==1){
			var r = new MyJqueryAjax(url,'id='+infoId).request();
			if(r==1){
				alert('退回成功！');
				window.close();
			}
		}else{
			alert('退回失败！');
		} 
	}
	
</script>
</html>