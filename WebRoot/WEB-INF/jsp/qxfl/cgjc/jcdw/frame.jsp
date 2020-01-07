<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>检测单位</title>
		<%@ include file="/inc/includeBase.jsp"%>
	</head>
	<body>
		<form id="form1" name="form1" method="post" action="${app}/cgjc/cgjc/cgjcList.do" target="listQuery">
			<input type="hidden" id="flag" name="flag" value="${flag }" />
			<input type="hidden" id="cflag" name="cflag" value="${cflag }" />
			<div id="queryPanel" class="queryPanel">
				<div id="queryPanel_title" class="queryPanel_title">
					<div class="queryPanel_title_collapse"></div>
					&nbsp;查询条件
				</div>
				<div id="queryPanel_content" class="queryPanel_content" name="queryPanel_content"
					style="position: relative;">
					<table class="search" cellspacing="0" cellpadding="0">
						<tr>
							<td class="outDetail">
								年度：
							</td>
							<td class="outDetail2">
								<zcc:select list="yearsList" name="year" id="year"
									headLabel="请选择..." headValue=""
									optionLabel="year" optionValue="year" />
							</td>
							<td class="outDetail" style="width: 70px;">
								报告编号：
							</td>
							<td class="outDetail2" style="width: 100px;">
								<input type="text" id="bg_id" name="bg_id" />
				
							<td class="outDetail" style="width: 70px;">
								单位名称：
							</td>
							<td class="outDetail2" style="width: 100px;">
								<input type="text" id="dw_name" name="dw_name" />
							</td>
						</tr>
					</table>
					<div id="queryPanel_footer" class="queryPanel_footer"
						style="position: absolute; bottom: 1px; right: 10px;">
						<input type="hidden" id="pageSize" name="pageSize" value="" />
						<zcc:button id="schbtn" cssClass="ovalbutton" onclick="sch('${app}/cgjc/cgjc/cgjcList.do');return false;">查 询</zcc:button>
						&nbsp;&nbsp;
						<zcc:button id="schbtn" cssClass="ovalbutton" onclick="add();return false;">新 增</zcc:button>
						&nbsp;&nbsp;
						<zcc:button id="schbtn" cssClass="ovalbutton" onclick="changType(0);return false;">年 检</zcc:button>
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
		sch('${app}/cgjc/cgjc/cgjcList.do');
  		function sch(url)
  		{
  			disable(document.getElementById("schbtn"));
  			$('#listQuery').attr('src','${app}/inc/baseLoading.jsp');
  			form1.action = url;
			setTimeout('form1.submit();',500);
  		}
  		
  		function njInfo()
  		{
  			disable(document.getElementById("schbtn"));
  			$('#listQuery').attr('src','${app}/inc/baseLoading.jsp');
  			form1.action = "${app}/cgjc/cgjc/njInfoList.do";
			setTimeout('form1.submit();',500);
  		}
  		
  		function add() {
			MyWindow.OpenCenterWindowScroll('${app}/cgjc/cgjc/Jcdwedit.do?method=create','editJcdw',608,800);
		}
  	
  		function changType(flag){
			var url = '${app}/cgjc/cgjc/ajaxChange.do?flag='+flag;
	 		var result = new MyJqueryAjax(url).request().trim();
	  		$('#queryPanel_content').html(result);
  			
		}
	</script>
</html>

