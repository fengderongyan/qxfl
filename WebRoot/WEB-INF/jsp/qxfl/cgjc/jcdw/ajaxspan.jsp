<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/inc/includeBase.jsp" %>
<div id="queryPanel_content" class="queryPanel_content"
	style="position: relative;">
	<table class="search" cellspacing="0" cellpadding="0">
		<tr>
			<td class="outDetail">
				年度：
			</td>
			<td class="outDetail2">
				<zcc:select list="yearsList" name="year" id="year"
					headLabel="请选择..." headValue=""
					optionLabel="year" optionValue="year" />
			</td>
			<td class="outDetail" style="width: 70px;">
				报告编号：
			</td>
			<td class="outDetail2" style="width: 100px;">
				<input type="text" id="bg_id" name="bg_id" />

			<td class="outDetail" style="width: 70px;">
				单位名称：
			</td>
			<td class="outDetail2" style="width: 100px;">
				<input type="text" id="dw_name" name="dw_name" />
			</td>
		</tr>
	</table>
	<div id="queryPanel_footer" class="queryPanel_footer"
		style="position: absolute; bottom: 1px; right: 10px;">
		<input type="hidden" id="pageSize" name="pageSize" value="" />
		<zcc:button id="schbtn" cssClass="ovalbutton" onclick="sch('${app}/cgjc/cgjc/njInfoList.do');return false;">查 询</zcc:button>
		&nbsp;&nbsp;
		<zcc:button id="schbtn" cssClass="ovalbutton" onclick="changType(1);return false;">首 检</zcc:button>
	</div>
</div>
<script>
	form1.action="${app}/cgjc/cgjc/njInfoList.do";
	form1.submit();
</script>