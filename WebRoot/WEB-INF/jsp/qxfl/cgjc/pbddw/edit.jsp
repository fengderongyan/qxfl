<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>屏蔽、等电位及接地</title>
		<%@ include file="/inc/includeBase.jsp"%>
	</head>
	<body >
		<form id="form1" name="form1" method="post" action="${app}/cgjc/cgjc/pbddwSave.do" >
			<input type="hidden" value="${pbddwInfo.id }" id="id" name="id" />
			<input type="hidden" value="${base_id }" id="base_id" name="base_id" />
			
			<div id="queryPanel" class="queryPanel">
				<div id="queryPanel_title" class="queryPanel_title">
					<div class="queryPanel_title_collapse"></div>
					&nbsp;基本信息
				</div>
				<div id="queryPanel_content" class="queryPanel_content"
					style="position: relative;">
					<table class="form_table" width="98%" align="center" >
						<tr height="26px">
		               		<td class="outDetail" style="width: 30%;">
								建筑物来源:
		                	</td>
		                	<td class="outDetail2" style="width: 70%;">
		                		<input type="radio" id="jzwly" name="jzwly" value="1" ${pbddwInfo.jzwly == 1 ? 'checked' : '' } >防直击雷</input>&nbsp;&nbsp;
		                		<%-- <input type="radio" id="jzwly" name="jzwly" value="2" ${pbddwInfo.jzwly == 2 ? 'checked' : '' } >电子系统</input>&nbsp;&nbsp;
		                		<input type="radio" id="jzwly" name="jzwly" value="3" ${pbddwInfo.jzwly == 3 ? 'checked' : '' } >其他 </input> 
		                		应该有级联操作--%>
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								建筑物:<label style="color: red;">*</label>
		                	</td>
		                	<td class="outDetail2" >
		                		<zcc:select name="jzw" id="jzw" list="bbhNamelist" 
		                			optionLabel="bbhw_name" optionValue="id" value="${pbddwInfo.jzw }" 
		                			dataType="Require" msg="请选择建筑物！" headLabel="请选择..." headValue="" />
		                	</td> 
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								检测点:<label style="color: red;">*</label>
		                	</td>
		                	<td class="outDetail2" >
		                		<input type="text" id="jcd" name="jcd"  value="${pbddwInfo.jcd }" 
		                			dataType="Require" msg="请输入检测点!" />
		                	</td> 
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								属性:
		                	</td>
		                	<td class="outDetail2" >
		                		<zcc:select name="sx" id="sx" list="sxList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${pbddwInfo.sx }" />
		                	</td> 
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								规格材质(mm⁄mm²): 
		                	</td>
		                	<td class="outDetail2" >
		                		<input type="text" id="ggcz" name="ggcz"  value="${pbddwInfo.ggcz }"  />
		                	</td> 
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								电阻值(Ω): 
		                	</td>
		                	<td class="outDetail2" >
		                		<input type="text" id="dzz" name="dzz"  value="${pbddwInfo.dzz }"  />
		                	</td> 
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								标准要求(Ω): 
		                	</td>
		                	<td class="outDetail2" >
		                		<zcc:select name="dzz_bzyq" id="dzz_bzyq" list="bzyqList"
									optionLabel="dd_item_name" optionValue="dd_item_code" headLabel="请选择..." headValue=""
									value="${pbddwInfo.dzz_bzyq }" />
		                	</td> 
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								单项评定:
		                	</td>
		                	<td class="outDetail2" >
		                		<zcc:select name="dx_result" id="dx_result" list="heList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${pbddwInfo.dx_result }" />
		                	</td> 
		                </tr>
		            </table>
				</div>
			</div>
			<c:if test="${method != 'show' }">
				<div align="center">
					<zcc:button id="schbtn" cssClass="ovalbutton" 
		         		onclick="savaInfo(this);return false;">保 存</zcc:button>
		         		<br/>
		         		<br/>
				</div>
			</c:if>
		</form>
	</body>
	<script type="text/javascript">
		var method = '${method}';
		var value = '${pbddwInfo.jzw }' + '（复制）';
		if(method == 'copy'){
			$('#jzw').val(value);
		}
		
		//新增时radio默认选中第一个
		if(method == 'create'){
			$("input[type=radio][name=jzwly]").each(function() { 
	            if ($(this).val() == '1') { 
	                $(this).attr("checked", "checked"); 
	            } 
	        }); 
		}
		
		//全选
		$("#check_all").click(function() {
			if (this.checked) {
				$("[name=yqsb_info]").prop('checked', true)
			} else {
				$("[name=yqsb_info]").prop('checked', false)
			}
		})
		
		function savaInfo(src){
			src.disabled=true;
		 	if(!Validator.Validate("form1")){
				src.disabled = false ;
				return false;
			}
			form1.action = "${app}/cgjc/cgjc/pbddwSave.do?method="+'${method}';
			form1.submit();
		}
		
	</script>
</html>

