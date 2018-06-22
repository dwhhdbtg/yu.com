<%@ page contentType="text/html;charset=UTF-8" import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>报销单</title>
<%@include file="/common/meta.jsp"%>
<!--上传js-->
	<script type="text/javascript" src="${resourcesCtx}/js/staff-tree.js"></script>
	<script type="text/javascript" src="${resourcesCtx}/js/custom.tree.js"> </script>
	<script type="text/javascript" src="${ctx}/widgets/workflowEditor/swfobject.js"></script>
	<script type="text/javascript" src="${resourcesCtx}/js/workflowTag.js"></script>
	<script type="text/javascript" src="${resourcesCtx}/js/opinion.js"></script>
	<script type="text/javascript" src="${ctx}/js/notice-workflow-task.js"></script>

</head>

<body>
<div class="opt-body">
<aa:zone name="main">
		<aa:zone name="btnZone">
				<div class="opt-btn">
					<wf:workflowButtonGroup taskId="${taskId}" submitForm="noticeWorkflowForm"></wf:workflowButtonGroup>
					<button class='btn' onclick="gobackTask();">
						<span><span>退回</span>
						</span>
					</button>
				</div>
			</aa:zone>
			<div style="display: none;" id="message">
				<s:actionmessage theme="mytheme" />
			</div>
			<div id="opt-content" class="form-bg">
				<form id="defaultForm1" name="defaultForm1"action="">
					<input type="hidden" name="id" id="id" value="${id}"  />
					<input name="taskId" id="taskId" value="${taskId}" type="hidden"/>
					<input id="selecttacheFlag" type="hidden" value="true"/>
				</form>
				<div id="tabs">
					<ul>
						<li><a href="#tabs-1" onclick="changeViewSet('basic');">表单信息</a></li>
						<li><a href="#tabs-1" onclick="changeViewSet('history');">流转历史</a></li>
					</ul>
					<div id="tabs-1">
						<aa:zone name="viewZone">
							<form id="noticeWorkflowForm" name="noticeWorkflowForm" method="post"
								action="${ctx}/expense-report/complete-task.htm">
								<input type="hidden" name="id" id="id" value="${id}" />
								<input type="hidden" name="taskId" id="taskId" value="${taskId}" />
								<input type="hidden" name="taskTransact" id="taskTransact" />
								<input type="hidden" name="addSignPerson" id="addSignPerson" />
								<input type="hidden" name="copyPerson" id="copyPerson" />
								<input type="hidden" name="saveTaskFlag" id="saveTaskFlag"  />
								<input type="hidden" name="removeTaskIds" id="removeTaskIds" />
								<input type="hidden" name="assignee" id="assignee" />
								<input type="hidden"  name="opinion" id="_common_opinion" />
								<textarea style="display: none" id="fieldPermission">${fieldPermission}</textarea>
								<grid:formView code="TRAIN_NOTICE_WORKFLOW" entity="${noticeWorkflow}" taskId="${taskId}"></grid:formView>
							</form>
						</aa:zone>
					</div>
				</div>
			</div>
		</aa:zone>
	</div>
</body>
<script type="text/javascript" src="${resourcesCtx}/widgets/colorbox/jquery.colorbox.js"></script>
<script type="text/javascript" src="${resourcesCtx}/widgets/timepicker/timepicker-all-1.0.js"></script>
<script src="${resourcesCtx}/widgets/validation/validate-all-1.0.js" type="text/javascript"></script>
<script src="${resourcesCtx}/widgets/validation/dynamic.validate.js" type="text/javascript"></script>
</html>