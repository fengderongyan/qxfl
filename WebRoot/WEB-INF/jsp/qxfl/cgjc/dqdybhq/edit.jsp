<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>电气系统电涌保护器</title>
		<%@ include file="/inc/includeBase.jsp"%>
	</head>
	<body >
		<form id="form1" name="form1" method="post" action="${app}/cgjc/cgjc/dqdybhqSave.do" >
			<input type="hidden" value="${dqdybhqInfo.id }" id="id" name="id" />
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
		                		<input type="text" id="bjcwwz" name="bjcwwz" size="35"
		                			value="${dqdybhqInfo.bjcwwz }" dataType="Require" msg="请输入被检测物位置!" />
		                	</td>
		                	<td class="outDetail" style="width: 15%;">
								型号:
		                	</td>
		                	<td class="outDetail2" style="width: 35%;">
		                		<input type="text" id="xh" name="xh" value="${dqdybhqInfo.xh }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								接地制式:
		                	</td>
		                	<td class="outDetail2" colspan="3">
		                		<zcc:select name="jdzs" id="jdzs" list="jdffList" style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.jdzs }" />
		                	</td> 
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								安装数量(套): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="azsl" name="azsl" 
		                			value="${dqdybhqInfo.azsl }"  /> 
		                		&nbsp;
		                		<zcc:select name="azsl_rst" id="azsl_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.azsl_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								所在防雷区(LPZ):
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="szflq" id="szflq" list="flqList"
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.szflq }" />
								&nbsp;
								<zcc:select name="szflq_rst" id="szflq_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.szflq_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								与前级之间距离(m): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="yqjjl" name="yqjjl" 
		                			value="${dqdybhqInfo.yqjjl }"  /> 
		                		&nbsp;
		                		<zcc:select name="yqjjl_rst" id="yqjjl_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.yqjjl_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								绝缘电阻:  
		                	</td>
		                	<td class="outDetail2"  >
		                		<%-- <zcc:select name="baqk" id="baqk" list="baqkList"
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.baqk }" /> --%>
								<input type="text" id="baqk" name="baqk" 
		                			value="${dqdybhqInfo.baqk }"  /> 
								&nbsp;
								<zcc:select name="baqk_rst" id="baqk_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.baqk_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								状态显示:
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="ztxs" id="ztxs" list="ztxsList" style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.ztxs }" />
		                		&nbsp;
		                		<zcc:select name="ztxs_rst" id="ztxs_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.ztxs_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								施工工艺:
		                	</td>
		                	<td class="outDetail2"  >
		                		<zcc:select name="sggy" id="sggy" list="sggyList"
		                			style="width: 135px;"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.sggy }" />
								&nbsp;
								<zcc:select name="sggy_rst" id="sggy_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.sggy_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								电压保护水平Up(kV): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="dybhsp" name="dybhsp" 
		                			value="${dqdybhqInfo.dybhsp }"  />
		                		&nbsp;
		                		<zcc:select name="dybhsp_rst" id="dybhsp_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.dybhsp_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								最大持续工作电压(V): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="zdcxdy" name="zdcxdy" 
		                			value="${dqdybhqInfo.zdcxdy }"  />
								&nbsp;
								<zcc:select name="zdcxdy_rst" id="zdcxdy_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.zdcxdy_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								冲击电流limp(kA):
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="cjdl" name="cjdl" 
		                			value="${dqdybhqInfo.cjdl }"  />
		                		&nbsp;
		                		<zcc:select name="cjdl_rst" id="cjdl_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.cjdl_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								标称⁄最大放电电流(kA):
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="bczdfddl" name="bczdfddl" 
		                			value="${dqdybhqInfo.bczdfddl }"  />
								&nbsp;
								<zcc:select name="bczdfddl_rst" id="bczdfddl_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.bczdfddl_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								泄漏电流lie(A): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="ldl" name="ldl" 
		                			value="${dqdybhqInfo.ldl }"  />
		                		&nbsp;
		                		<zcc:select name="ldl_rst" id="ldl_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.ldl_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								后备保护装置规格(A):
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="hbbhzz" name="hbbhzz" 
		                			value="${dqdybhqInfo.hbbhzz }"  />
								&nbsp;
								<zcc:select name="hbbhzz_rst" id="hbbhzz_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.hbbhzz_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								相、零线截面(mm²): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="xlxjm" name="xlxjm" 
		                			value="${dqdybhqInfo.xlxjm }"  />
		                		&nbsp;
		                		<zcc:select name="xlxjm_rst" id="xlxjm_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.xlxjm_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								接地线截面(mm²):
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="jdxjm" name="jdxjm" 
		                			value="${dqdybhqInfo.jdxjm }"  />
								&nbsp;
								<zcc:select name="jdxjm_rst" id="jdxjm_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.jdxjm_rst }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail"  >
								压敏电压（U1mA）: 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="qddy" name="qddy" 
		                			value="${dqdybhqInfo.qddy }"  />
		                		&nbsp;
		                		<zcc:select name="qddy_rst" id="qddy_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.qddy_rst }" />
		                	</td>
		                	<td class="outDetail"  >
								接线长度(m): 
		                	</td>
		                	<td class="outDetail2"  >
		                		<input type="text" id="jxcd" name="jxcd" 
		                			value="${dqdybhqInfo.jxcd }"  />
								&nbsp;
								<zcc:select name="jxcd_rst" id="jxcd_rst" list="hgList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									value="${dqdybhqInfo.jxcd_rst }" />
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
									value="${dqdybhqInfo.dx_result }" />
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
									value="${dqdybhqInfo.result }" />
		                	</td>
						</tr>
						<tr height="26px">
							<td class="outDetail"  >
								备注
		                	</td>
		                	<td class="outDetail2" colspan="3">
		                		<textarea rows="3" cols="60" id="zgyj" name="zgyj" >${dqdybhqInfo.zgyj }</textarea>
		                	</td>
						</tr>
						<!-- <tr height="26px">
							<td class="outDetail"  >
								建议
		                	</td>
		                	<td class="outDetail2" colspan="3">
		                		<textarea rows="3" cols="60" id="jy" name="jy" >${dqdybhqInfo.jy }</textarea>
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
		var value = '${dqdybhqInfo.bjcwwz }' + '（复制）';
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
			form1.action = "${app}/cgjc/cgjc/dqdybhqSave.do?method="+'${method}';
			form1.submit();
		}
		
	</script>
</html>

