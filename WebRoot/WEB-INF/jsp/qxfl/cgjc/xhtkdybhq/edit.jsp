<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>信号、天馈电涌保护器</title>
		<%@ include file="/inc/includeBase.jsp"%>
	</head>
	<body >
		<form id="form1" name="form1" method="post" action="${app}/cgjc/cgjc/dqdybhqSave.do" >
			<input type="hidden" value="${tkdybhqInfo.id }" id="id" name="id" />
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
		               		<td class="outDetail" style="width: 15%;">
								被检测物位置:<label style="color:red">*</label>
		                	</td>
		                	<td class="outDetail2" style="width: 35%;">
		                		<input type="text" id="bjcwwz" name="bjcwwz" 
		                			value="${tkdybhqInfo.bjcwwz }" dataType="Require" msg="请输入被检测物位置!" />
		                	</td>
		                	<td class="outDetail" style="width: 15%;">
								类型:
		                	</td>
		                	<td class="outDetail2" style="width: 35%;">
		                		<select id="type" name="type">
		                			<option value="1" ${tkdybhqInfo.type == 1 ? 'selected' : '' } >天馈电涌保护器</option>
		                			<option value="2" ${tkdybhqInfo.type == 2 ? 'selected' : '' } >信号电涌保护器</option>
		                		</select>
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								型号: 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="xh" name="xh" 
		                			value="${tkdybhqInfo.xh }"  /> 
		                	</td>
		                	<td class="outDetail"  >
								安装日期:
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="azrq" name="azrq" size="11" value="${tkdybhqInfo.azrq }"
									onclick="WdatePicker();" readonly="readonly" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								绝缘电阻:  
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="baqk" id="baqk" list="baqkList"
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${tkdybhqInfo.baqk }" />
								&nbsp;
								<zcc:select name="baqk_rst" id="baqk_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${tkdybhqInfo.baqk_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								安装数量:
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="azsl" name="azsl" value="${tkdybhqInfo.azsl }" />
		                		&nbsp;
								<zcc:select name="azsl_rst" id="azsl_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${tkdybhqInfo.azsl_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								标称通流量In⁄(kA): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="bctll" name="bctll" value="${tkdybhqInfo.bctll }" />
		                		&nbsp;
								<zcc:select name="bctll_rst" id="bctll_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${tkdybhqInfo.bctll_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								插入损耗:
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="crsh" name="crsh" value="${tkdybhqInfo.crsh }" />
		                		&nbsp;
								<zcc:select name="crsh_rst" id="crsh_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${tkdybhqInfo.crsh_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								接地截面(mm²): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="jdjm" name="jdjm" value="${tkdybhqInfo.jdjm }" />
		                		&nbsp;
								<zcc:select name="jdjm_rst" id="jdjm_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${tkdybhqInfo.jdjm_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								接地线长度(m): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="jdxcd" id="jdxcd" list="xcdList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${tkdybhqInfo.jdxcd }" />
		                		&nbsp;
								<zcc:select name="jdxcd_rst" id="jdxcd_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${tkdybhqInfo.jdxcd_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								施工工艺:
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="sggy" id="sggy" list="sggyList"
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${tkdybhqInfo.sggy }" />
								&nbsp;
								<zcc:select name="sggy_rst" id="sggy_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${tkdybhqInfo.sggy_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								电压驻波比: 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="dyzbb" name="dyzbb" value="${tkdybhqInfo.dyzbb }" />
		                		&nbsp;
								<zcc:select name="dyzbb_rst" id="dyzbb_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${tkdybhqInfo.dyzbb_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								额定工作电压: 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="edgzdy" name="edgzdy" value="${tkdybhqInfo.edgzdy }" />
		                		&nbsp;
								<zcc:select name="edgzdy_rst" id="edgzdy_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${tkdybhqInfo.edgzdy_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								电压保护水平: 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="dybhsp" name="dybhsp" value="${tkdybhqInfo.dybhsp }" />
		                		&nbsp;
								<zcc:select name="dybhsp_rst" id="dybhsp_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${tkdybhqInfo.dybhsp_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" style="width: 20%;">
								所在防雷区(LPZ): 
		                	</td>
		                	<td class="outDetail2" colspan="3" >
		                		<zcc:select name="szflq" id="szflq" list="flqList"
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${tkdybhqInfo.szflq }" />
								&nbsp;
								<zcc:select name="szflq_rst" id="szflq_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${tkdybhqInfo.szflq_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px"> 
							<td class="outDetail"  > 
								单项结论
		                	</td>
		                	<td class="outDetail2" colspan="3">
		                		<zcc:select name="dx_result" id="dx_result" list="hgList" 
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${tkdybhqInfo.dx_result }" />
		                	</td>
						</tr>
						<tr height="26px">
							<td class="outDetail"  >
								结论
		                	</td>
		                	<td class="outDetail2" colspan="3">
		                		<zcc:select name="result" id="result" list="rstList" 
		                			style="width: 435px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${tkdybhqInfo.result }" />
		                	</td>
						</tr>
						<tr height="26px">
							<td class="outDetail"  >
								备注
		                	</td>
		                	<td class="outDetail2" colspan="3">
		                		<textarea rows="3" cols="60" id="zgyj" name="zgyj" >${tkdybhqInfo.zgyj }</textarea>
		                	</td>
						</tr>
						<!-- <tr height="26px">
							<td class="outDetail"  >
								建议
		                	</td>
		                	<td class="outDetail2" colspan="3">
		                		<textarea rows="3" cols="60" id="jy" name="jy" >${tkdybhqInfo.jy }</textarea>
		                	</td>
						</tr>  -->
		                
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
		var value = '${tkdybhqInfo.bjcwwz }' + '（复制）';
		if(method == 'copy'){
			$('#bjcwwz').val(value);
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
			form1.action = "${app}/cgjc/cgjc/tkdybhqSave.do?method="+'${method}';
			form1.submit();
		}
		
	</script>
</html>

