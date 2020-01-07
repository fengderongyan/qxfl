<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>基本信息</title>
		<%@ include file="/inc/includeBase.jsp"%>
	</head>
	<body style="width: 70%;">
		<form id="form1" name="form1" method="post" action="${app}/cgjc/cgjc/jcyjSave.do" >
			<input type="hidden" value="${id }" id="id" name="id" />
			<div id="queryPanel" class="queryPanel">
				<div id="queryPanel_title" class="queryPanel_title">
					<div class="queryPanel_title_collapse"></div>
					&nbsp;检测依据
				</div>
				<div id="queryPanel_content" class="queryPanel_content"
					style="position: relative;">
					<input type="checkbox" id="selectAll"/>全选
					<zcc:checkboxlist name="jyj" id="jyj" list="jcyjList"
						checkboxLabel="dd_item_name" checkboxValue="dd_item_code"
						value="${baseInfo.jyj}" delims="," columns="1"/>
				</div>
			</div>
		<c:if test="${baseInfo.rec_id == user.operatorId &&  empty cflag }">
			<div align="center">
				<zcc:button id="schbtn" cssClass="ovalbutton" 
	         		onclick="savaInfo(this);return false;">保 存</zcc:button>
			</div>
		</c:if>
		</form>
	</body>
	<script type="text/javascript">
		function savaInfo(src){
			src.disabled=true;
		 	if(!Validator.Validate("form1")){
				src.disabled = false ;
				return false;
			}
			form1.submit();
		}
		
		$('#selectAll').click(function(){
			var is=document.getElementById('selectAll');//获取全选的复选框
			var em=is.checked;//判断复选框的选中状态  
			var iss=document.getElementsByName('jyj');//下面所有的复选框
			if(em){//如果全选复选框是false 则执行下面代码
				for(var i=0;i<iss.length;i++){ //循环下面所有复选框,将所有复选框都选中
					iss[i].checked=true;  
				}
			}else{
				for(var i=0;i<iss.length;i++){
					iss[i].checked=false;
				}
			}
		});
	</script>
</html>

