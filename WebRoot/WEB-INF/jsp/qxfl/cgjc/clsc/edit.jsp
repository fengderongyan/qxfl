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
		<form name="form1"
			action="${app}/jktsreport/jkts/impFile.do" method="post" ENCTYPE="multipart/form-data">
			<table width="100%" class="form_table">
				<tr class="pageheader">
					<td  align="center" colspan="2">
						材料信息上传
					</td>
				</tr>
				<tr>
					<td style="text-align: left; width: 30px;" class="outDetail">
						&nbsp;&nbsp;材料类型：
					</td>
					<td  class="outDetail2">
						<select id="cl_type" name="cl_type">
							<option value="">请选择...</option>
							<option value="1">示意图</option>
							<option value="2">照片</option>
							<option value="3">材料</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="text-align: left; width: 30px;"  class="outDetail">
						&nbsp;&nbsp;材料上传:
					</td>
					<td class="outDetail2">
						<input type="file" name="file" class="up_file" 
							style="width: 55%;height: 25px;" id="importFile" />
					</td>
				</tr>
			</table>
			<div align="center">
				<br>
				
				<zcc:button cssClass="ovalbutton" onclick="imp();return false;">导 入</zcc:button>
			</div>
		</form>
	</body>
	<script type="text/javascript">
		
		function imp(){
		    var file=$('#importFile').val();
		    var clType = $('#cl_type').val();
		    if(file==""){
		    	alert('请选择需要上传的材料！');
		    	return false;
		    }
		    if(clType==""){
		    	alert('请选择材料类型');
		    	form1.cl_type.focus();
		    	return false;
		    }
		    var str = file.substring(file.lastIndexOf(".")+1,file.length).toLowerCase();
		    if(clType == '1' || clType == '2'){//图片上传
		    	if(!(str=='jpg'||str=='jpeg'||str=='bmp'||str=='png')) {
					alert("只能上传格式为jpg、jpeg、bmp、png的图片！");
					form1.cl_type.focus();
					return false;
				}
		    }
			
			var clType = $('#cl_type').val();
			form1.action="${app}/cgjc/cgjc/impFile.do?base_id="+'${base_id}'+'&cl_type='+clType;
			form1.submit();
	    }      
	</script>
</html>