<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="/inc/includeBase.jsp"%>
	</head>
	<body>
		<display:table name="list" requestURI="${app}/cgjc/cgjc/cgjcList.do"
			class="list" id="row" cellspacing="0" style="width:120%"
			cellpadding="0" pagesize="18" export="false" sort="external"  partialList="true" size="size">
			<display:column title="序号" style="width:60px;" media="html">
				<c:out value="${row_rowNum + beginIndex}" />
			</display:column>
			<display:column title="档案编号" property="da_id" />
			<display:column title="报告编号" property="bg_id" />
			<display:column title="年度" property="year" />
			<display:column title="检测属性" property="jc_sx_name" />
			<display:column title="报告状态" style="width:60px;" media="html">
				<c:choose>
					<c:when test="${row.lc_id == 1 }">待提交</c:when>
					<c:when test="${row.lc_id == 2 }">待校核</c:when>
					<c:when test="${row.lc_id == 3 }">待签发</c:when>
					<c:when test="${row.lc_id == 4 }">待打印</c:when>
					<c:when test="${row.lc_id == 5 }">已打印</c:when>
					<c:when test="${row.lc_id == 6 }"><font color="red">待提交</font></c:when>
					<c:when test="${row.lc_id == 7 }"><font color="red">待校核</font></c:when>
				</c:choose>
			</display:column>
			<display:column title="单位名称" property="dw_name"  />
			<display:column title="单位地址" property="dw_addr"  />
			<display:column title="联系人" property="lxr" />
			<display:column title="联系电话" property="lxr_phone"  />
			<display:column title="行政区域" property="xzqy"  />
			<display:column title="检测日期" property="jc_date"  />
			<display:column title="有效日期" property="yx_date"  />
			<display:column title="操作" media="html" style="width:120px;">
				<%-- <zcc:button cssClass="smallBtn_gray"
					onclick="showJcInfo('${row.id}');return false;">检测信息</zcc:button>&nbsp;  --%>
				<c:if test="${row.rec_id eq user.operatorId && row.lc_id == 1}">
					<zcc:button cssClass="smallBtn_gray"
						onclick="delJcInfo('${row.id}');return false;">删除</zcc:button>&nbsp;
				</c:if>
			</display:column>
		</display:table>
	</body>
	<script type="text/javascript">
		$(document).ready(function(){
			//启用frame查询按钮
			window.parent.enable($('#schbtn', parent.document));  
		});
		
		function showJcInfo(baseId){
			var flag = '${flag}';
			MyWindow.OpenCenterWindowScroll('${app}/cgjc/cgjc/jcdwMain.do?base_id='+baseId+'&flag='+flag,'editJcdw',900,1300);
		}
		
		function delJcInfo(id){//删除
			if(window.confirm('确定要删除吗？')){
				var res = new MyJqueryAjax('${app}/cgjc/cgjc/delJcdw.do?id='+id).request();
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