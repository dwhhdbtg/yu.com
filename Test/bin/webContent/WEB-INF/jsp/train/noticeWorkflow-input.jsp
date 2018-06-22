<%@ page contentType="text/html;charset=UTF-8" import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<title></title>
		<%@include file="/common/meta.jsp" %>
			</head>
	
	<body onload="getContentHeight();"  onunload="destroyUploadControl();">
		<div class="ui-layout-center">
		<div class="opt-body">
				<aa:zone name="main">
					<div class="opt-btn">
							<s:if test="taskId==null || (workflowInfo!=null && workflowInfo.processState.code=='process.unsubmit')">
								<wf:workflowButtonGroup taskId="${taskId }"></wf:workflowButtonGroup>
							</s:if>
							<button class='btn' onclick='setPageState();ajaxSubmit("defaultForm","${ctx}/train/noticeWorkflow-list.htm","main");'><span><span>返回</span></span></button>
					</div>
					<div id="opt-content" class="form-bg">
					<div id="message" style="display:none;"><s:actionmessage theme="mytheme" /></div>
						<form  id="inputForm" name="inputForm" method="post" action="">
							<input type="hidden" name="id" id="id" value="${id}"/>
							<input type="hidden" name="taskId" id="taskId" value="${taskId }" />
							<input type="hidden" name="submitResult" id="submitResult" value="${submitResult}"/>
							<input  type="hidden"  name="opinion" id="_common_opinion" />
							<input type="hidden" name="taskTransact" id="taskTransact" value="${taskTransact }"/>
								<grid:formView code="TRAIN_NOTICE_WORKFLOW" entity="${noticeWorkflow}" taskId="${taskId }"></grid:formView>
								<aa:zone name="docZones">
								<div id="spanButtonPlaceholder" style="display: none;margin-left: 100px;"></div>
								<span id="divFileProgressContainer"></span>
									<table>
									<tr>
									<td>文件名</td><td>操作</td>
									</tr>
									<s:iterator value='documentList'>
										<tr>
										<td>${fileName}</td><td><a>下载</a><a>删除</a></td>
										</tr>
									</s:iterator>
									</table>
								</aa:zone>
						</form>
					</div>
					<script type="text/javascript">
					$(document).ready(function(){
						//验证表单字段
						addFormValidate('${fieldPermission}','inputForm');
						iMatrix.autoFillOpinion('${autoFillOpinionInfo}');
					});
				</script>
				</aa:zone>
			</div>
			</div>
	</body>
</html>