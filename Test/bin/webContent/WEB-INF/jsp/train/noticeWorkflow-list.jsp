<%@ page contentType="text/html;charset=UTF-8" import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<title></title>
	<%@include file="/common/meta.jsp" %>
	<script src="${resourcesCtx}/widgets/validation/validate-all-1.0.js" type="text/javascript"></script>
	<script src="${resourcesCtx}/widgets/validation/dynamic.validate.js" type="text/javascript"></script>
	<script type="text/javascript" src="${ctx}/widgets/workflowEditor/swfobject.js"></script>
	<script type="text/javascript" src="${ctx}/widgets/swfupload/swfupload.js"></script>
		<script type="text/javascript" src="${ctx}/widgets/swfupload/handlers.js"></script>
		
	<script type="text/javascript" src="${resourcesCtx}/js/workflowTag.js"></script>
	<script type="text/javascript" src="${resourcesCtx}/js/opinion.js"></script>
	<script type="text/javascript" src="${ctx}/js/notice-workflow-list.js"></script>
	<script type="text/javascript" src="${ctx}/js/demo.js"></script>
</head>

<body onclick="$('#sysTableDiv').hide(); $('#styleList').hide();" >
	<%@ include file="/menus/header.jsp" %>
	<div class="ui-layout-center">
		<div class="opt-body">
			<form id="defaultForm" name="defaultForm" method="post"  action=""></form>
			<aa:zone name="mainZone">
				<aa:zone name="main">
					<div class="opt-btn">
						<button  class='btn' onclick="iMatrix.showSearchDIV(this);"><span><span>查询</span></span></button>
						<button class="btn" onclick="createNoticeWorkflow('${ctx}/train/noticeWorkflow-input.htm');"><span><span>新建</span></span></button>
						<button class="btn" onclick="updateNoticeWorkflow('${ctx}/train/noticeWorkflow-input.htm');"><span><span>修改</span></span></button>
						<button class="btn" onclick="deleteNoticeWorkflow('${ctx}/train/noticeWorkflow-delete.htm');"><span><span >删除</span></span></button>
						<button class="btn" onclick="viewNoticeWorkflow('${ctx}/train/noticeWorkflow-view.htm');"><span><span >查看</span></span></button>
					</div>
					<div id="message"><s:actionmessage theme="mytheme" /></div>	
					<div id="opt-content" >
						<form id="contentForm" name="contentForm" method="post"  action="">
							<grid:jqGrid gridId="noticeWorkflowGridId" url="${ctx}/train/noticeWorkflow-listDatas.htm" submitForm="defaultForm" code="TRAIN_NOTICE_WORKFLOW" ></grid:jqGrid>
						</form>
					</div>
				</aa:zone>
			</aa:zone>
		</div>
	</div>
	
</body>
<script type="text/javascript" src="${resourcesCtx}/widgets/colorbox/jquery.colorbox.js"></script>
<script src="${resourcesCtx}/widgets/timepicker/timepicker_<%=com.norteksoft.product.util.ContextUtils.getCurrentLanguage()%>.js" type="text/javascript"></script>
<script type="text/javascript" src="${resourcesCtx}/widgets/timepicker/timepicker-all-1.0.js"></script>
</html>