<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>连云港长虹防雷工程中心</title>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
		<script type="text/javascript" src="${app}/js/jquery/jquery-1.12.4.js"></script>
		<script type="text/javascript" src="${app}/js/jquery/jquery.ajax.js"></script>
		<script type="text/javascript" src="${app}/js/common.js"></script>
		<link rel="stylesheet" type="text/css" href="${app}/css/themes/default/default.css" />
		<style type=text/css>
			table.mobile tr.pageheader1 td {
				text-valign: middle;
				text-align: center;
				FONT-WEIGHT: bold;
				FONT-SIZE: 13px;
				height: 26px;
				border-collapse: collapse;
				border: solid 1pt #D6E4F1;
				border-bottom: solid 0px;
				color: #004177;
				
			}
			table.list {
				border-collapse: collapse;
				background-color: white;
				font-size: 12px;
				width: 100%;
			}
			table.list th,table.list td {
				padding: 1px 2px 1px 2px !important;
				text-align: center;
				vertical-align: middle;
				align: center;
				font-weight: normal;
				border: 1px solid #B8C9D8;
			}
			table.list thead tr{
				color: #0054A6;
				font-size: 12px;
				height: 25px;
				font: 12px;
			}
			
			table.list thead tr th{
				font-weight: bold !important;
			}
			
			table.list tr.over {
				background-color: #fefae2;
			}
			
			table.list tr.even {
				background-color: #ECF7FF;
			}
			
			table.list tr.odd {
				background-color: #FFFFFF;
			}
			
			.todo_mid {
				width:100%;
				height:100%;
			}
		</style>
	</head>
	<body scroll="no" style="width: 100%; height: 100%">
		<zcc:csrfToken />
		<center >
		<div class="todo_mid">
			<table class="mobile" style="width: 60%; height: 50%;">
				<tr class="pageheader1" height="30">
					<td width="90%" style="text-align: center;">
						<span  >
							<font color="#0054A6">提 交 报 告 信 息</font>&nbsp;&nbsp;
							<a href="#" onclick="moreTj();" 
								style="color: red; text-decoration: underline; padding-right: 10px; ">更多</a>
						</span>
					</td>
				</tr>
				<tr>
					<td style="width: 90%; padding: 0 0 0 0px !important;vertical-align: top;">
						<table class="list">
							<thead>
								<tr style="background-color: #ECF7FF">
									<th>
										档案编码
									</th>
									<th>
										报告编码
									</th>
									<th>
										单位名称
									</th>
									<th>
										报告状态
									</th>
								</tr>
							</thead>
							<c:forEach var="row" items="${tcbgList}" varStatus="s" begin="0" end="4">
								<tr class="${s.count % 2 == 1 ? 'odd':'even' }" height="24px">
									<td>
										${row.da_id }
									</td>
									<td>
										${row.bg_id}
									</td>
									<td>
										${row.dw_name }
									</td>
									<td>
										<c:choose>
											<c:when test="${row.lc_id == 1 }">待提交</c:when>
											<c:when test="${row.lc_id == 2 }">待校核</c:when>
											<c:when test="${row.lc_id == 3 }">待签发</c:when>
											<c:when test="${row.lc_id == 4 }">待打印</c:when>
											<c:when test="${row.lc_id == 5 }">已打印</c:when>
											<c:when test="${row.lc_id == 6 }"><font color="red">待提交</font></c:when>
											<c:when test="${row.lc_id == 7 }"><font color="red">待校核</font></c:when>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</table>
					</td>	
				</tr>
				<tr class="pageheader1" height="30">
					<td width="90%" style="text-align: center;">
						<span  >
							<c:choose>
								<c:when test="${user.operatorId == 150010 || user.operatorId == 159999}">
									<font color="#0054A6">签 发 报 告 信 息</font> &nbsp;&nbsp;
									<a href="#" onclick="moreJh();" 
										style="color: red; text-decoration: underline; margin-right: 10px;">更多</a>
								</c:when>
								<c:otherwise>
									<font color="#0054A6">校 核 报 告 信 息</font> &nbsp;&nbsp;
									<a href="#" onclick="moreJh();" 
										style="color: red; text-decoration: underline; margin-right: 10px;">更多</a>
								</c:otherwise>
							</c:choose>
						</span>
					</td>
				</tr>
				<tr>
					<td style="width: 90%; padding: 0 0 0 0px !important;vertical-align: top;">
						<table class="list" >
							<thead>
								<tr style="background-color: #ECF7FF">
									<th>
										档案编码
									</th>
									<th>
										报告编码
									</th>
									<th>
										单位名称
									</th>
									<th>
										报告状态
									</th>
								</tr>
							</thead>
							<c:forEach var="row" items="${jhbgList}" varStatus="s">
								<tr class="${s.count % 2 == 1 ? 'odd':'even' }" height="24px">
									<td>
										${row.da_id }
									</td>
									<td>
										${row.bg_id}
									</td>
									<td>
										${row.dw_name }
									</td>
									<td>
										<c:choose>
											<c:when test="${row.lc_id == 1 }">待提交</c:when>
											<c:when test="${row.lc_id == 2 }">待校核</c:when>
											<c:when test="${row.lc_id == 3 }">待签发</c:when>
											<c:when test="${row.lc_id == 4 }">待打印</c:when>
											<c:when test="${row.lc_id == 5 }">已打印</c:when>
											<c:when test="${row.lc_id == 6 }"><font color="red">待提交</font></c:when>
											<c:when test="${row.lc_id == 7 }"><font color="red">待校核</font></c:when>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</table>
					</td>
				</tr>
			</table>
		</div>
		</center>
	</body>
	
	<script type="text/javascript">
		function moreJh() {
			MyWindow.OpenCenterWindowScroll('${app}/todo/allJhFrame.do','allReportFrame',600,900);		
		}
		function moreTj() {
			MyWindow.OpenCenterWindowScroll('${app}/todo/allTcFrame.do','allTcFrame',600,900);		
		}
		
	</script>
</html>