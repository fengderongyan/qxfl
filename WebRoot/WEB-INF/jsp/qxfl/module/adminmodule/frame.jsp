<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/inc/includeBase.jsp" %>
<%@ include file="/inc/includeEasyUi.jsp"%>
<html>
	<head>
		<title>权限管理</title>
	</head>
	<body>
		<zcc:csrfToken />
		<div id="tabsModuleRole" class="easyui-tabs" data-options="fit:true,border:false">
			<div id="easytab1" title="模块管理">
				<iframe id="queryModule" frameborder="0" height="99.5%" width="100%" scrolling="no"
					src=""></iframe>
			</div>
			<div id="easytab3" title="模块权限管理" data-options="closable:false" style="overflow: auto;">
				<iframe id="queryPermit" frameborder="0" height="99.5%" width="100%" scrolling="no"
					src=""></iframe>
			</div>
		</div>
		<input type="hidden" id="tabsId" name="tabsId" />
	</body>
	<script type="text/javascript">
		$('#tabsModuleRole').tabs({
			onSelect:function(title){
				var tab = $('#tabsModuleRole').tabs('getSelected');
				var tbid = tab.attr('id');
				if('easytab1'==tbid){
					if($('#tabsId').val() != 'easytab1'){
						$('#queryModule').attr('src', '${app}/adminmodule/queryModule.do');
						$('#tabsId').val('easytab1');
					}
				}else if('easytab3'==tbid){
					if($('#tabsId').val() != 'easytab3'){
						$('#queryPermit').attr('src', '${app}/adminpermit/queryModulePermit.do');
						$('#tabsId').val('easytab3');
					}
				}
			}
		});
	</script>
</html>

