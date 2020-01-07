<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="/inc/includeBase.jsp"%>
<html>
	<head>
		<title>上传</title>
	<style>
		
		table.form_table tr.pageheader td {
			BACKGROUND-IMAGE: url(../../images/img_table_bg.png);
			text-valign: middle;
			text-align: center;
			FONT-WEIGHT: bold;
			FONT-SIZE: 15px;
			width: 100%;
			height: 26px;
			border-collapse: collapse;
			border: solid 1pt #D6E4F1;
			border-bottom: solid 0px;
			color: #004177;
		}
	</style>
	</head>
	<body >
		<form name="form1" id="form1"
			action="${app}/jktsreport/jkts/impFile.do" method="post" >
			<input id="base_id" name="base_id" value="${base_id }" type="hidden" />
			<input id="id" name="id" value="${billInfo.id }" type="hidden" />
			<table width="100%" class="form_table">
				<tr class="pageheader">
					<td  align="center" colspan="2">
						开票信息
					</td>
				</tr>
				<tr>
					<td style="text-align: center; width: 100px;" class="outDetail">
						<font style="color: red;">*</font> 开票单位名称：
					</td>
					<td  class="outDetail2">
						<input type="text" id="remark1" name="remark1" value="${billInfo.remark1 }"  size="40"
							dataType="Require" msg="请填写开票单位名称!" />
					</td>
				</tr>
				<tr>
					<td style="text-align: center; width: 100px;" class="outDetail">
						<font style="color: red;">*</font> 社会统一代码：
					</td>
					<td  class="outDetail2">
						<input type="text" id="remark2" name="remark2" value="${billInfo.remark2 }"  size="40"
							dataType="Require" msg="请填写社会统一代码!" />
					</td>
				</tr>
				<tr>
					<td style="text-align: center; width: 100px;" class="outDetail">
						<font style="color: red;">*</font> 单位地址：
					</td>
					<td  class="outDetail2">
						<input type="text" id="remark3" name="remark3" value="${billInfo.remark3 }" size="40"
							dataType="Require" msg="请填写单位地址!" />
					</td>
				</tr>
				<tr>
					<td style="text-align: center; width: 100px;" class="outDetail">
						<font style="color: red;">*</font> 单位电话：
					</td>
					<td  class="outDetail2">
						<input type="text" id="remark4" name="remark4" value="${billInfo.remark4 }" size="40"
							dataType="Require" msg="请填写单位电话!" />
					</td>
				</tr>
				<tr>
					<td style="text-align: center; width: 100px;" class="outDetail">
						<font style="color: red;">*</font> 开户行名称：
					</td>
					<td  class="outDetail2">
						<input type="text" id="remark5" name="remark5" value="${billInfo.remark5 }" size="40"
							dataType="Require" msg="请填写开户行名称!" />
					</td>
				</tr>
				<tr>
					<td style="text-align: center; width: 100px;" class="outDetail">
						<font style="color: red;">*</font> 开户行账号：
					</td>
					<td  class="outDetail2">
						<input type="text" id="remark6" name="remark6" value="${billInfo.remark6 }" size="40"
							dataType="Require" msg="请填写开户行账号!" />
					</td>
				</tr>
				<tr>
					<td style="text-align: center; width: 100px;"  class="outDetail">
						备注:
					</td>
					<td class="outDetail2">
						<textarea rows="3" cols="60" id="bill_remark" name="bill_remark">${billInfo.bill_remark }</textarea>
					</td>
				</tr>
			</table>
			<div align="center">
				<br>
				
				<zcc:button cssClass="ovalbutton" onclick="saveInfo(this);return false;">保 存</zcc:button>
			</div>
		</form>
	</body>
	<script type="text/javascript">
		
		function saveInfo(src){
			src.disabled=true;
		 	if(!Validator.Validate("form1")){
				src.disabled = false ;
				return false;
			}
			form1.action = "${app}/cgjc/cgjc/billInfoSave.do?method="+'${method}';
			form1.submit();
			
	    }      
	</script>
</html>