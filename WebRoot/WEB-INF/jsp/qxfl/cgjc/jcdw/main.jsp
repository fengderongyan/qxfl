<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/inc/includeBase.jsp" %>
<%@ include file="/inc/includeEasyUi.jsp"%>
<html>
	<head>
		<title>检测信息录入</title>
	</head>
	<body >
		<zcc:csrfToken />
		<div id="tabsModuleRole" class="easyui-tabs" data-options="fit:true,border:false">
			<div id="easytab1" title="基本信息">
				<iframe id="baseInfo" frameborder="0" height="99.5%" width="100%" scrolling="yes"
					src=""></iframe>
			</div>
			<div id="easytab2" title="防直击雷" data-options="closable:false" style="overflow: auto;">
				<iframe id="fzjl" frameborder="0" height="99.5%" width="100%" scrolling="no"
					src=""></iframe>
			</div>
			<div id="easytab3" title="屏蔽、等电位及接地" data-options="closable:false" style="overflow: auto;">
				<iframe id="pbInfo" frameborder="0" height="99.5%" width="100%" scrolling="no"
					src=""></iframe>
			</div>
			<div id="easytab4" title="电气系统电涌保护器" data-options="closable:false" style="overflow: auto;">
				<iframe id="dqdybhq" frameborder="0" height="99.5%" width="100%" scrolling="no"
					src=""></iframe>
			</div>
			<div id="easytab5" title="信号、天馈电涌保护器" data-options="closable:false" style="overflow: auto;">
				<iframe id="tkdybhq" frameborder="0" height="99.5%" width="100%" scrolling="no"
					src=""></iframe>
			</div>
			<div id="easytab6" title="电子系统" data-options="closable:false" style="overflow: auto;">
				<iframe id="dzxt" frameborder="0" height="99.5%" width="100%" scrolling="no"
					src=""></iframe>
			</div>
			<div id="easytab7" title="检测依据" data-options="closable:false" style="overflow: auto;">
				<iframe id="jcyj" frameborder="0" height="99.5%" width="100%" scrolling="no"
					src=""></iframe>
			</div>
			<div id="easytab8" title="隐患建议书" data-options="closable:false" style="overflow: auto;">
				<iframe id="zgyj" frameborder="0" height="99.5%" width="100%" scrolling="no"
					src=""></iframe>
			</div>
			<div id="easytab9" title="材料上传" data-options="closable:false" style="overflow: auto;">
				<iframe id="clsc" frameborder="0" height="99.5%" width="100%" scrolling="no"
					src=""></iframe>
			</div>
			<div id="easytab10" title="发票信息" data-options="closable:false" style="overflow: auto;">
				<iframe id="bill" frameborder="0" height="99.5%" width="100%" scrolling="no"
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
						$('#baseInfo').attr('src', '${app}/cgjc/cgjc/baseInfoEdit.do?base_id='+'${baseId}'+'&flag='+'${flag}'+'&cflag='+'${cflag}');
						$('#tabsId').val('easytab1');
					}
				}else if('easytab2'==tbid){
					if($('#tabsId').val() != 'easytab2'){
						$('#fzjl').attr('src', '${app}/cgjc/cgjc/fzjlFrame.do?base_id='+'${baseId}'+'&flag='+'${flag}'+'&cflag='+'${cflag}');
						$('#tabsId').val('easytab2');
					}
				}else if('easytab3'==tbid){
					if($('#tabsId').val() != 'easytab3'){
						$('#pbInfo').attr('src', '${app}/cgjc/cgjc/pbddwFrame.do?base_id='+'${baseId}'+'&flag='+'${flag}'+'&cflag='+'${cflag}');
						$('#tabsId').val('easytab3');
					}
				}else if('easytab4'==tbid){
					if($('#tabsId').val() != 'easytab4'){
						$('#dqdybhq').attr('src', '${app}/cgjc/cgjc/dqdybhqFrame.do?base_id='+'${baseId}'+'&flag='+'${flag}'+'&cflag='+'${cflag}');
						$('#tabsId').val('easytab4');
					}
				}else if('easytab5'==tbid){
					if($('#tabsId').val() != 'easytab5'){
						$('#tkdybhq').attr('src', '${app}/cgjc/cgjc/tkdybhqFrame.do?base_id='+'${baseId}'+'&flag='+'${flag}'+'&cflag='+'${cflag}');
						$('#tabsId').val('easytab5');
					}
				}else if('easytab6'==tbid){
					if($('#tabsId').val() != 'easytab6'){
						$('#dzxt').attr('src', '${app}/cgjc/cgjc/dzxtFrame.do?base_id='+'${baseId}'+'&flag='+'${flag}'+'&cflag='+'${cflag}');
						$('#tabsId').val('easytab6');
					}
				}else if('easytab7'==tbid){
					if($('#tabsId').val() != 'easytab7'){
						$('#jcyj').attr('src', '${app}/cgjc/cgjc/jcyjEdit.do?base_id='+'${baseId}'+'&flag='+'${flag}'+'&cflag='+'${cflag}');
						$('#tabsId').val('easytab7');
					}
				}else if('easytab8'==tbid){
					if($('#tabsId').val() != 'easytab8'){
						$('#zgyj').attr('src', '${app}/cgjc/cgjc/zgyjEdit.do?base_id='+'${baseId}'+'&flag='+'${flag}'+'&cflag='+'${cflag}');
						$('#tabsId').val('easytab8');
					}
				}else if('easytab9'==tbid){
					if($('#tabsId').val() != 'easytab9'){
						$('#clsc').attr('src', '${app}/cgjc/cgjc/clscFrame.do?base_id='+'${baseId}'+'&flag='+'${flag}'+'&cflag='+'${cflag}');
						$('#tabsId').val('easytab9');
					}
				}else if('easytab10'==tbid){
					if($('#tabsId').val() != 'easytab10'){
						$('#bill').attr('src', '${app}/cgjc/cgjc/billFrame.do?base_id='+'${baseId}'+'&flag='+'${flag}'+'&cflag='+'${cflag}');
						$('#tabsId').val('easytab10');
					}
				}
			}
		});
	</script>
</html>

