<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>基本信息</title>
		<%@ include file="/inc/includeBase.jsp"%>
	</head>
	<body style="width: 70%;">
		<form id="form1" name="form1" method="post" action="${app}/cgjc/cgjc/jcdwBaseSave.do" >
			<input type="hidden" value="${id }" id="id" name="id" />
			<div id="queryPanel" class="queryPanel">
				<div id="queryPanel_title" class="queryPanel_title">
					<div class="queryPanel_title_collapse"></div>
					&nbsp;基本信息
				</div>
				<div id="queryPanel_content" class="queryPanel_content"
					style="position: relative;">
					<table class="form_table" width="98%" align="center" >
						<tr height="26px">
		               		<td class="outDetail" style="width: 10%;">
								报告编号:
		                	</td>
		                	<td class="outDetail2" style="width: 40%;">
		                		<input type="text" id="bg_id" name="bg_id" style="background-color: #DDDDDD;"
		                			value="${baseInfo.bg_id }" readonly="readonly" />
		                	</td>
		                	<td class="outDetail" style="width: 10%;">
								档案编号:
		                	</td>
		                	<td class="outDetail2" style="width: 40%;">
		                		<input type="text" id="da_id" name="da_id" 
		                			value="${baseInfo.da_id }"  />
		                	</td>
		                </tr>
						<tr height="26px">
		               		<td class="outDetail" style="width: 10%;">
								单位名称:
		                	</td>
		                	<td class="outDetail2" style="width: 40%;">
		                		<input type="text" id="dw_name" name="dw_name" style="background-color: #DDDDDD;"
		                			value="${baseInfo.dw_name }" readonly="readonly" />
		                	</td>
		                	<td class="outDetail" style="width: 10%;">
								单位地址:
		                	</td>
		                	<td class="outDetail2" style="width: 40%;">
		                		<input type="text" id="dw_addr" name="dw_addr" style="background-color: #DDDDDD;"
		                			value="${baseInfo.dw_addr }" readonly="readonly" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								行政区域:
		                	</td>
		                	<td class="outDetail2">
		                		<input type="text" id="xzqy" name="xzqy" style="background-color: #DDDDDD;"
		                			value="${baseInfo.xzqy }" readonly="readonly" />
		                	</td>
		                	<td class="outDetail" >
								检测属性:
		                	</td>
		                	<td class="outDetail2">
		                		<input type="hidden" id="jc_sx" name="jc_sx" value="${baseInfo.jc_sx }"  />
		                		<input type="text" id="jc_sx_name" name="jc_sx_name" style="background-color: #DDDDDD;"
		                			value="${baseInfo.jc_sx_name }" readonly="readonly" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								单位法人:
		                	</td>
		                	<td class="outDetail2">
		                		<input type="text" id="dw_fr" name="dw_fr" 
		                			value="${baseInfo.dw_fr }"  />
		                	</td>
		                	<td class="outDetail" >
								单位经办人:
		                	</td>
		                	<td class="outDetail2">
		                		<input type="text" id="dwjbr" name="dwjbr" style="background-color: #DDDDDD;"
		                			value="${baseInfo.lxr }" readonly="readonly" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								经度:
		                	</td>
		                	<td class="outDetail2">
		                		<input type="text" id="jd" name="jd" value="${baseInfo.jd }" />
		                	</td>
		                	<td class="outDetail" >
								纬度:
		                	</td>
		                	<td class="outDetail2">
		                		<input type="text" id="wd" name="wd" value="${baseInfo.wd }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								联系部门:
		                	</td>
		                	<td class="outDetail2">
		                		<input type="text" id="lx_bm" name="lx_bm" value="${baseInfo.lx_bm }" />
		                	</td>
		                	<td class="outDetail" >
								部门电话:
		                	</td>
		                	<td class="outDetail2">
		                		<input type="text" id="bm_phone" name="bm_phone" value="${baseInfo.bm_phone }"  />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								联系人:
		                	</td>
		                	<td class="outDetail2">
		                		<input type="text" id="lxr" name="lxr" value="${baseInfo.lxr }" />
		                	</td>
		                	<td class="outDetail" >
								联系电话:
		                	</td>
		                	<td class="outDetail2">
		                		<input type="text" id="lxr_phone" name="lxr_phone" value="${baseInfo.lxr_phone }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								雷击时间:
		                	</td>
		                	<td class="outDetail2">
		                		<input type="text" id="lj_date" name="lj_date" size="11" value="${baseInfo.lj_date }"
									onclick="WdatePicker();" readonly="readonly" />
		                	</td>
		                	<td class="outDetail" >
								邮编:
		                	</td>
		                	<td class="outDetail2">
		                		<input type="text" id="yb" name="yb"  value="${baseInfo.yb }" />
		                	</td>
		                </tr>
		                <tr height="26px">
		                	<td class="outDetail" >
								检测周期:
		                	</td>
		                	<td class="outDetail2">
		                		<select id="jc_zq" name="jc_zq" >
		                			<option value="1" ${baseInfo.jc_zq == '1' ? 'selected' : '' }  >一年</option>
		                			<option value="2" ${baseInfo.jc_zq == '2' ? 'selected' : '' }>半年</option>
		                		</select>
		                	</td>
		               		<td class="outDetail" >
								行业类别:<label style="color:red">*</label>
		                	</td>
		                	<td class="outDetail2">
		                		<zcc:select name="hy_type" id="hy_type" list="hyTypeList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									headLabel="请选择..." headValue="" dataType="Require" value="${baseInfo.hy_type }"
									msg="请选择行业类别!" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								检测方法:
		                	</td>
		                	<td class="outDetail2">
		                		<input type="text" id="jc_way" name="jc_way" value="${baseInfo.jc_way }" size="55" />
		                	</td>
		                	<td class="outDetail" >
								年最大电流(kA):
		                	</td>
		                	<td class="outDetail2">
		                		<input type="text" id="nzddl" name="nzddl" value="${baseInfo.nzddl }"  />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								检测日期:
		                	</td>
		                	<td class="outDetail2">
		                		<input type="text" id="jc_date" name="jc_date" size="11" value="${baseInfo.jc_date }" 
									onclick="WdatePicker();" readonly="readonly" />
		                	</td>
		                	<td class="outDetail" >
								天气实况:
		                	</td>
		                	<td class="outDetail2">
		                		<zcc:select name="weather" id="weather" list="weatherList"
									optionLabel="dd_item_name" optionValue="dd_item_code"
									dataType="Require" msg="请选择天气实况!" />
		                	</td>
		                </tr>
		                
		                <tr height="26px">
		               		<td class="outDetail" >
								年平均密度(次/a•km²): 
		                	</td>
		                	<td class="outDetail2">
		                		<input type="text" id="npjmd" name="npjmd" value="${baseInfo.npjmd }"  />
		                	</td>
		                	<td class="outDetail" >
								检测意见:
		                	</td>
		                	<td class="outDetail2">
		                		<select id="jc_yj" name="jc_yj" >
		                			<option value="1" ${baseInfo.jc_yj == 1 ? selected : '' } >符合</option>
		                			<option value="2" ${baseInfo.jc_yj == 2 ? selected : '' }>不符合</option>
		                			<option value="3" ${baseInfo.jc_yj == 3 ? selected : '' }>/</option>
		                		</select>
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								报告构成:
		                	</td>
		                	<td class="outDetail2" colspan="3">
		                		<zcc:checkboxlist name="bg_gc" id="bg_gc" list="bggcList"
									checkboxLabel="dd_item_name" checkboxValue="dd_item_code"
									value="${baseInfo.bg_gc}" delims="," columns="2"/>
		                	</td>
		                </tr>
		                
		                <tr height="26px">
		               		<td class="outDetail" >
								检测结论:
		                	</td>
		                	<td class="outDetail2" colspan="3">
		                		<textarea rows="4" cols="60" id="remark" name="remark" 
									style="width: 100%;" >${baseInfo.remark == '' ? '依据 ****** 规范要求，对 *** 的防雷装置进行了检测，检测结果详见第2-3页。不合格项目详见第4页。' : baseInfo.remark }</textarea>
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								签发日期:
		                	</td>
		                	<td class="outDetail2">
		                		<input type="text" id="remark4" name="remark4" size="11" value="${baseInfo.remark4 }"
									onclick="WdatePicker();" readonly="readonly"  />
		                	</td>
		                	<td class="outDetail" >
								检测项目:
		                	</td>
		                	<td class="outDetail2">
		                		<input name='remark3' id='remark3' size='35' value="${baseInfo.remark3 }"  />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								检测人:
		                	</td>
		                	<td class="outDetail2" >
		                		<input type="text" id="jcr" name="jcr" value="${baseInfo.jcr }" 
		                			style="background-color: #DDDDDD;" readonly="readonly" />
		                	</td>
		                	<td class="outDetail" >
								校核人:
		                	</td>
		                	<td class="outDetail2" >
		                		<input type="text" id="jhr" name="jhr" value="${baseInfo.jhr }" 
		                			style="background-color: #DDDDDD;" readonly="readonly" />
		                	</td>
		                </tr>
		                <tr height="26px">
		               		<td class="outDetail" >
								签发人:
		                	</td>
		                	<td class="outDetail2" colspan="3">
		                		<input type="text" id="jfr" name="jfr" value="${baseInfo.jfr }" 
		                			style="background-color: #DDDDDD;" readonly="readonly" />
		                	</td>
		                </tr> 
				</table>
				</div>
			</div>
			<div id="listPanel" class="queryPanel">
			<div id="queryPanel_title" class="queryPanel_title">
				<div class="queryPanel_title_collapse"></div>
				&nbsp;仪器设备信息
			</div>
			<div id="queryPanel_content" class="queryPanel_content">
				<table class="form_table" width="98%" align="center" >
					<tr>
						<td class="outDetail" style="text-align: center;">
							<input type="checkbox" name="check_all" id="check_all" />
	                	</td>
	                	<td class="outDetail" >
							仪器编号
	                	</td>
	                	<td class="outDetail" >
							仪器名称
	                	</td>
	                	<td class="outDetail" >
							规格型号
	                	</td>
	                	<td class="outDetail" >
							部门名称
	                	</td>
	                	<td class="outDetail" >
							检定情况
	                	</td>
					</tr>
					<c:forEach var="row" items="${yqsbList }">
						<tr>
							<td class="outDetail" style="text-align: center;" >
								<input type="checkbox" value="${row.id }" name="yqsb_info" id="yqsb_info" />
							</td>
							<td class="outDetail2" style="text-align: center;"  >
								${row.yq_bh }
							</td>
							<td class="outDetail2" style="text-align: center;" >
								${row.yq_name }
							</td>
							<td class="outDetail2" style="text-align: center;" >
								${row.ggxh }
							</td>
							<td class="outDetail2" style="text-align: center;" >
								${row.dpt_name }
							</td>
							<td class="outDetail2" style="text-align: center;" >
								${row.check_qk }
							</td>
						</tr>
					</c:forEach> 
				</table> 
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
  		//checkbox 回显
		var checkboxValues = '${baseInfo.yqsb_info }';
		checkboxValues = ',' + checkboxValues + ',';
		var yqInfo = document.getElementsByName('yqsb_info');
		for (var i = 0; i < yqInfo.length; i++){
			if (checkboxValues.indexOf(',' + yqInfo[i].value + ',') != -1) {
				yqInfo[i].checked = true;
			}
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
			//判断修改档案编码与系统内档案编码是否重复
			var daId = $('#da_id').val();
			var id = $('#id').val();
			var res = new MyJqueryAjax('${app}/cgjc/cgjc/checkDaId.do?id='+id+'&da_id='+daId).request();
			if(res==1){
				alert('该档案编号已经在系统存在！');
				src.disabled = false;
				return false;
			}
			form1.submit();
		}
		
	</script>
</html>

