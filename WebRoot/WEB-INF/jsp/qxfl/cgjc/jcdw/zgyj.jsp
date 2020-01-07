<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>整改意见</title>
		<%@ include file="/inc/includeBase.jsp"%>
	</head>
	<body style="width: 70%;">
		<form id="form1" name="form1" method="post" action="${app}/cgjc/cgjc/zgyjSave.do" >
			<input type="hidden" value="${id }" id="id" name="id" />
			<div id="queryPanel" class="queryPanel">
				<div id="queryPanel_title" class="queryPanel_title">
					<div class="queryPanel_title_collapse"></div>
					&nbsp;隐患建议书
				</div>
				<div id="queryPanel_content" class="queryPanel_content"
					style="position: relative;">
					<table class="form_table" width="98%" align="center" >
		                <tr>
		                	<td class="outDetail" style="width: 10%;">
								隐患建议书:
		                	</td>
		                	<td class="outDetail2" >
		                		<input type="text" id="remark5"  name="remark5" value="${baseInfo.remark5 }" />:
		                		我单位按照国家现行规范
								<textarea rows="6" cols="80" id="remark1" name="remark1" >${baseInfo.remark1 }</textarea><br/>
								的要求对你单位的<br />
								<textarea rows="6" cols="80" id="remark2" name="remark2" >${baseInfo.remark2 }</textarea><br/>
								防雷装置进行了检测。经检测，你单位以下防雷装置不符合规范要求，存在安全隐：
		                	</td>
		                </tr>
		                
				</table>
				</div>
			</div>
			<br/>
			<div id="queryPanel_content" class="queryPanel_content">
		    	<center>
		    	<div>
		    		<input type="hidden" value="${base_id }" id="base_id" name="base_id" />
					<input type="hidden" id="pageSize" name="pageSize" value="" />
					<zcc:button id="schbtn" cssClass="ovalbutton" onclick="addInfo();return false;">新增建议</zcc:button>
					<br/>&nbsp;
				</div>
				</center>
				<table class="form_table" style="width: 99%;"
					align="center"  >
					<tr height="25">
						<td class="outDetail"  >
							<font color="red">*</font>&nbsp;建议
						</td>
						<td class="outDetail"  >
							操作
						</td>
					</tr>
						<c:forEach var="row" items="${infoList }">
							<tr id="dcTabs" name="dcTabs">
							<td class="outDetail2"  style="width: 85%;">
								<input dataType="Require" msg="请填写建议信息!" type="text"  id="jyinfo" value="${row.info }" name="jyinfo" size="110"/>
							</td>
							<td class="outDetail"  >
								<a style="color: red; cursor: hand; text-decoration: none; text-decoration: underline;"
									onclick="delRow('dcTabs');return false;"> 
									<b style="font-size: 12px; font-weight: bold;">删 除</b> 
								</a>
							</td>
							</tr>
						</c:forEach>
						<tr id="dcTabs" name="dcTabs">
						<td class="outDetail2"  style="width: 85%;">
							<input dataType="Require" msg="请填写建议信息!" type="text"  id="jyinfo" name="jyinfo" size="110"/>
						</td>
						<td class="outDetail"  >
							<a style="color: red; cursor: hand; text-decoration: none; text-decoration: underline;"
								onclick="delRow('dcTabs');return false;"> 
								<b style="font-size: 12px; font-weight: bold;">删 除</b> 
							</a>
						</td>
					</tr>
				</table>
		    </div>
		</div>
		<c:if test="${baseInfo.rec_id == user.operatorId &&  empty cflag }">
		<div align="center">
			<br/>
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
		
		//动态添加
	function addInfo(){
		$("tr[id='dcTabs']:last").after($("tr[id='dcTabs']:first").clone());
		$("tr[id='dcTabs']:last").show();
		
	}
	
	//动态删除
	function delRow(tableId){
		var tab = document.getElementsByName(tableId);
		if(tab.length == 1){
			alert('最后一条不能删除！');
			return false;
		}
		var tb = document.getElementById(tableId);
		//火狐不兼容 event.srcElementevent 处理，且FF不支持event直接使用
		var event = window.event || arguments.callee.caller.arguments[0];
		var src = event.srcElement || event.target;;
		var row = getRow(src);
		//var tab = $(row).parent().parent();
		$(row).remove();
	}
		
	</script>
</html>

