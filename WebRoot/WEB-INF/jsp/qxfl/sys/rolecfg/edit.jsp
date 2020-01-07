<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/inc/includeBase.jsp" %>
	<%@ include file="/inc/includeEasyUi.jsp" %>
	<link rel="stylesheet" href="${app}/css/ztree/zTreeStyle/zTreeStyle.css" type="text/css" />
	<script type="text/javascript" src="${app}/js/ztree/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="${app}/js/ztree/jquery.ztree.excheck-3.5.js"></script>
	<link rel="stylesheet" type="text/css" href="${app}/js/jquery/jquery.ui/css/jquery.ui.all.css"/>
	<script type="text/javascript" src="${app}/js/jquery/jquery.ui/jquery.ui.core.js"></script>
	<script type="text/javascript" src="${app}/js/jquery/jquery.ui/jquery.ui.widget.js"></script>
	<script type="text/javascript" src="${app}/js/jquery/jquery.ui/jquery.ui.button.js"></script>
	<script type="text/javascript" src="${app}/js/jquery/jquery.ui/jquery.ui.position.js"></script>
	<script type="text/javascript" src="${app}/js/jquery/jquery.ui/jquery.ui.menu.js"></script>
	<script type="text/javascript" src="${app}/js/jquery/jquery.ui/jquery.ui.autocomplete.js"></script>
	<script type="text/javascript" src="${app}/js/jquery/jquery.ui/jquery.ui.tooltip.js"></script>
	<script type="text/javascript" src="${app}/js/jquery/jquery.ui/jquery.combobox.js"></script>
	<c:choose>
		<c:when test="${param.method=='edit'}">
			<c:set var="title" value="修改角色信息"></c:set>
		</c:when>
		<c:when test="${param.method=='create'}">
			<c:set var="title" value="新建角色"></c:set>
		</c:when>
		<c:when test="${param.method=='show'}">
			<c:set var="title" value="角色详细信息"></c:set>
		</c:when>
	</c:choose>
	<title>${title}</title>
	<style type="">
	.hintInfo{padding:8px 35px 8px 10px;text-shadow:none;-webkit-box-shadow:0 2px 4px rgba(0,0,0,0.2);-moz-box-shadow:0 2px 4px rgba(0,0,0,0.2);box-shadow:0 2px 4px rgba(0,0,0,0.2);background-color:#f9edbe;border:1px solid #f0c36d;-webkit-border-radius:2px;-moz-border-radius:2px;border-radius:2px;color:#333}
	
	
	</style>
</head>
<body>
	<form id="form1" name="form1" action="${app}/sys/rolecfg/saveOrUpdateRole.do" method="post">
		<div id="queryPanel" class="queryPanel">
				<div id="queryPanel_title" class="queryPanel_title">
					<div class="queryPanel_title_collapse"></div>
					&nbsp;角色基本信息
				</div>
				<div id="queryPanel_content" class="queryPanel_content"
					style="position: relative;">
					<table class="search" cellspacing="0" cellpadding="0">
						<tr>
							<td class="outDetail" style="width: 70px;">
								角色名称：
								<input type="hidden" id="roleid" name="roleid" value="${param.role_id}" />
							</td>
							
							<c:choose>
								<c:when test="${param.method=='create'}">
									<td class="outDetail2" style="width: 100px;">
										<input type="text" id="role_name" name="role_name" />
									</td>
								</c:when>
								<c:otherwise>
									<td class="outDetail2" style="width: 100px;">
										<input type="text" id="role_name" name="role_name" value="${roleInfo.role_name }"/>
									</td>
								</c:otherwise>
							</c:choose>
							
							<td class="outDetail" style="width: 70px;">
								状态：
							</td>
							
							<c:choose>
								<c:when test="${param.method=='create'}">
									<td class="outDetail2" style="width: 100px;">
										 <select id="status" name="status">
										 	<option value="1">有效</option>
										 	<option value="0">无效</option>
										 </select>
									</td>
								</c:when>
								<c:otherwise>
									<td class="outDetail2" style="width: 100px;">
										<zcc:select id="status" name="status" value="${roleInfo.status}">
											<zcc:option value="1">有效</zcc:option>
											<zcc:option value="0">无效</zcc:option>
										</zcc:select>
									</td>
								</c:otherwise>
							</c:choose>
							
						</tr>
						<tr>
							<td class="outDetail" style="width: 70px;">
								角色排序：
							</td>
							
							<c:choose>
								<c:when test="${param.method=='create'}">
									<td class="outDetail2" style="width: 100px;">
										<input type="text" id="role_order" name="role_order" 
											required="true" dataType="Number" msg="角色排序必须是数字"/>
									</td>
								</c:when>
								<c:otherwise>
									<td class="outDetail2" style="width: 100px;">
										<input type="text" id="role_order" name="role_order"  value="${roleInfo.role_order }"
											required="true" dataType="Number" msg="角色排序必须是数字"/>
									</td>
								</c:otherwise>
							</c:choose>
							
							
							<td class="outDetail" style="width: 70px;">
								角色层级
							</td>
							
							<c:choose>
								<c:when test="${param.method=='create'}">
									<td class="outDetail2" style="width: 100px;">
										 <select id="role_level" name="role_level">
										 	<option value="1">1</option>
										 	<option value="2">2</option>
										 	<option value="3">3</option>
										 	<option value="4">4</option>
										 </select>
									</td>
								</c:when>
								<c:otherwise>
									<td class="outDetail2" style="width: 100px;">
										 <zcc:select id="role_level" name="role_level" value="${roleInfo.role_level}">
											<zcc:option value="1">1</zcc:option>
											<zcc:option value="2">2</zcc:option>
											<zcc:option value="3">3</zcc:option>
											<zcc:option value="4">4</zcc:option>
										</zcc:select>
									</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</table>
					
					<div id="queryPanel_footer" class="queryPanel_footer"
						style="position: absolute; bottom: 1px; right: 10px;">
						<c:if test="${param.method=='create' }">
							<zcc:button id="saveBtn" cssClass="ovalbutton" onclick="save1(this);">保 存</zcc:button></label>
						</c:if>
						<c:if test="${param.method=='edit'}">
							<zcc:button id="saveBtn" cssClass="ovalbutton" onclick="save2(this);">保 存</zcc:button></label>
						</c:if>
					</div>
					
				</div>
			</div>
	</form>
</body>
<script type="text/javascript" defer="defer">

	if('${param.method == 'create'}'){
		/**保存角色模块配置**/
		function save1(src) {
			src.disabled=true;
		 	if(!Validator.Validate("form1")){
				src.disabled = false ;
				return false;
			}
			var roleId = $('#roleid').val();
			var roleName = $('#role_name').val();
			var roleStatus = $('#status').val();
			var roleOrder = $('#role_order').val();
			var roleLevel = document.getElementById('role_level').value;
			
			var baseUrl =  '${app}/sys/rolecfg/roleSave.do';
			var params="role_id="+roleId+"&role_name="+roleName+"&status="+roleStatus+"&role_order="+roleOrder
				      +"&role_level="+roleLevel+"&method="+'${param.method}';
			var res = new MyJqueryAjax(baseUrl,params).request().trim();
			
			if(res==1 ) {
				alert('操作成功！');
				window.close();
			} else{
		  		alert('操作失败！');
		  	}
		}
			
	}
	
	if('${param.method != 'create'}'){
		/**保存角色模块配置**/
		function save2(src) {
			disable(document.getElementById("saveBtn"));
			
			var roleId = $('#roleid').val();
			var roleName = $('#role_name').val();
			var roleStatus = document.getElementById('status').value;
			var roleOrder = $('#role_order').val();
			var roleLevel = document.getElementById('role_level').value;
			
			var baseUrl =  '${app}/sys/rolecfg/roleSave.do';
			var params="role_id="+roleId+"&role_name="+roleName+"&status="+roleStatus+"&role_order="+roleOrder
					   +"&role_level="+roleLevel+"&method="+'${param.method}';
			var res = new MyJqueryAjax(baseUrl,params).request();
			if(res==1 ) {
				
				var role_id = $('#role_id').val();
				if(''==role_id || null==role_id){
					alert("请选择角色视野！");
					enable(src);
					return ;
				}
				var treeObj = $.fn.zTree.getZTreeObj("roleModuleTree");
				var sNodes = treeObj.getCheckedNodes();
				var moduleIds = '';
				if(sNodes.length !=0){
					var moduleids = '';
					for(var k=0; k<sNodes.length; k++){
						moduleIds += ''+sNodes[k].id+',';
					}
					moduleIds = moduleIds.substr(0,moduleIds.length-1);
				}else{
					if(!confirm('未选着任何模块，确认提交吗？')){
						enable(src);
						return false;
					}
				}
				$('#moduleIds').val(moduleIds);
				
				var url = '${app}/adminpermit/roleSave.do';
				var params="moduleIds="+moduleIds+"&role_id="+role_id;
				var res = new MyJqueryAjax(url,params).request();
				if(res==1) {
					alert('操作成功！');
					window.close();
			  	} else {
					alert('操作失败！');
			  	}
			  	enable(src);
		  	} else{
		  		alert('操作失败！');
		  	}
		}
		
		//角色下拉列表框模糊查询
		$("#role_id" ).combobox();
		
		//下拉列表框onchange事件
		$('#role_id').combobox({
			select:function(){
				chanageRole();
			}
		});
		function chanageRole(){
			var role_id = $('#role_id').val();
			if(''==role_id || null==role_id){
				return ;
			}
			window.location.href="${app}/adminpermit/roleQuery.do?role_id="+role_id+'&csrfToken='+$('#csrfToken').val();
		}
	}
</script>
</html>
