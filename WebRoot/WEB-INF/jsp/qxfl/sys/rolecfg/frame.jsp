<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>角色管理</title>
		<%@ include file="/inc/includeBase.jsp"%>
	</head>
	<body>
		<form id="form1" name="form1" method="post" action="${app}/sys/rolecfg/roleList.do" target="listQuery">
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
								角色名称：
							</td>
							<td class="outDetail2" style="width: 100px;">
								<input type="text" id="role_name" name="role_name" />
							</td>
							<td class="outDetail" style="width: 70px;">
								状态：
							</td>
							<td class="outDetail2" style="width: 100px;">
								 <select id="status" name="status">
								 	<option value="1">有效</option>
								 	<option value="0">无效</option>
								 </select>
							</td>
							
						</tr>
						
					</table>
					<div id="queryPanel_footer" class="queryPanel_footer"
						style="position: absolute; bottom: 1px; right: 10px;">
						<input type="hidden" id="pageSize" name="pageSize" value="" />
						<zcc:button id="schbtn" cssClass="ovalbutton" onclick="sch();return false;">查 询</zcc:button>
						&nbsp;&nbsp;
						<zcc:button id="schbtn" cssClass="ovalbutton" onclick="add();return false;">新 增</zcc:button>
					</div>
				</div>
			</div>
		</form>
		<div id="listPanel" class="queryPanel">
			<div id="queryPanel_title" class="queryPanel_title">
				<div class="queryPanel_title_collapse"></div>
				&nbsp;角色列表
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
			MyWindow.OpenCenterWindowScroll('${app}/sys/rolecfg/roleEdit.do?method=create','editRole',608,800);
		}
  	
	</script>
</html>

