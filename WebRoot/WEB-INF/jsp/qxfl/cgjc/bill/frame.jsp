<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>材料上传</title>
		<%@ include file="/inc/includeBase.jsp"%>
	</head>
	<body>
		<form id="form1" name="form1" method="post" action="${app}/cgjc/cgjc/billList.do" target="listQuery">
			<input type="hidden" id="base_id" name="base_id" value="${base_id }" />
			<input type="hidden" id="cflag" name="cflag" value="${cflag }" />
			<div id="queryPanel" class="queryPanel">
				<div id="queryPanel_title" class="queryPanel_title">
					<div class="queryPanel_title_collapse"></div>
					&nbsp;查询条件
				</div>
				<div id="queryPanel_content" class="queryPanel_content"
					style="position: relative;">
					<table class="search" cellspacing="0" cellpadding="0">
						<tr>
							<td class="outDetail" style="width: 70px;">
								发票编号：
							</td>
							<td class="outDetail2" style="width: 100px;">
								<input type="text" id="bill_id" name="bill_id" />
							</td>
						</tr>
					</table>
					<div id="queryPanel_footer" class="queryPanel_footer"
						style="position: absolute; bottom: 1px; right: 10px;">
						<input type="hidden" id="pageSize" name="pageSize" value="" />
						<zcc:button id="schbtn" cssClass="ovalbutton" onclick="sch();return false;">查 询</zcc:button>
						&nbsp;&nbsp;
						<c:if test="${flag == 1 &&  empty cflag }">
							<zcc:button id="schbtn" cssClass="ovalbutton" onclick="add();return false;">新增</zcc:button>
						</c:if>
					</div>
				</div>
			</div>
		</form>
		<div id="listPanel" class="queryPanel">
			<div id="queryPanel_title" class="queryPanel_title">
				<div class="queryPanel_title_collapse"></div>
				&nbsp;查询列表
			</div>
			<div id="queryPanel_content" class="queryPanel_content">
				<iframe id="listQuery" allowtransparency="true" name="listQuery"
					frameborder="0" width="100%" scrolling="auto"></iframe>
			</div>
		</div>
	</body>
	<script type="text/javascript">
	 	//先调用设置行数的函数，再调用默认查询函数
		setPageSize('listQuery');
		sch();
  		function sch()
  		{
  			disable(document.getElementById("schbtn"));
  			$('#listQuery').attr('src','${app}/inc/baseLoading.jsp');
			setTimeout('form1.submit();',500);
  		}
  		
  		function add() {
			MyWindow.OpenCenterWindowScroll('${app}/cgjc/cgjc/billEdit.do?base_id='+'${base_id}'+'&method=create','editBillInof',350,650);
		}
  	
	</script>
</html>

