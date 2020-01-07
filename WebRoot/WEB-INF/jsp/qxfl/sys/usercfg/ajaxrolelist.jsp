<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="zcc" uri="/WEB-INF/zcc"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<zcc:checkboxlist name="role_id" id="role_id" list="rolesList"
	checkboxLabel="ROLE_NAME" checkboxValue="ROLE_ID"
	value="${userInfo.role_ids}" delims="," columns="1" onclick="checkRole(this)"
	required="true" dataType="Group" msg="至少为用户分配一种角色" />
