<%@ page contentType="text/html;charset=UTF-8" import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<title>通知管理</title>
	<%@include file="/common/meta.jsp" %>
	<script src="${resourcesCtx}/widgets/validation/validate-all-1.0.js" type="text/javascript"></script>
	<script src="${resourcesCtx}/js/opinion.js" type="text/javascript"></script>
	<script type="text/javascript">
		function createNotice(){
			//刷新区域方法
			aa.submit('contentForm', '${ctx}/train/input.htm', 'main',createNoticeCallback); 
		}

		function createNoticeCallback(){
			$("#expenseReportForm").validate({
				submitHandler:function() {
					saveFunction();//验证成功后调用的方法
				},
				rules:{
					title:"required"
				},
				messages:{
					title:"必填"
				}
			});
		}

		function saveFunction(){
			aa.submit('expenseReportForm', '${ctx}/train/save.htm', 'main',saveCallback); 
		}

		function saveCallback(){
			showMsg();
			createNoticeCallback();
		}

		function updateNotice(){
			var ids=jQuery("#expenseReportList").getGridParam('selarrrow');
			if(ids.length<=0){
				alert("请选择记录！");
				return;
			}else if(ids.length>1){
				alert("请选择一条记录！");
			}else{
				$("#id").val(ids);
				//刷新区域方法
				aa.submit('contentForm', '${ctx}/train/input.htm', 'main',createNoticeCallback); 
			}
		}

		//删除
		function deleteNotices(){
			var ids=jQuery("#expenseReportList").getGridParam('selarrrow');
			if(ids.length<=0){
				alert("请选择需要删除的记录！");
				return;
			}
			$("#ids").val(ids.join(','));
			aa.submit('contentForm', '${ctx}/train/delete.htm', 'main',showMsg); 
		}


		function save(){
			$("#expenseReportForm").submit();
		}
		
		function backToList(){
			aa.submit('expenseReportForm', '${ctx}/train/list.htm', 'main'); 
		}

		function selectPerson(){
			var zTreeSetting={
					leaf: {
						enable: false
					},
					type: {
						treeType: "MAN_DEPARTMENT_TREE",
						noDeparmentUser:true,
						onlineVisible:false
					},
					data: {
						chkStyle:"checkbox", 
						chkboxType:"{'Y' : 'ps', 'N' : 'ps' }"
					},
					view: {
						title: "选择人员",
						width: 300,
						height:400,
						url:"${ctx}",
						showBranch:false
					},
					feedback:{
						enable: true,
				                showInput:"userNames",
				                hiddenInput:"userIds",
				                append:false
					},
					callback: {
						onClose:function(){
							alert(11);
						}
					}			
					};
				    popZtree(zTreeSetting);
		}
	</script>
</head>

<body onclick="$('#sysTableDiv').hide(); $('#styleList').hide();" >
	<%@ include file="/menus/header.jsp"%>
	
	<div class="ui-layout-center">
			<div class="opt-body">
				<aa:zone name="main">
					<div class="opt-btn">
						<button  class='btn' onclick="iMatrix.showSearchDIV(this);"><span><span>查询</span></span></button>
					<security:authorize ifAnyGranted="train-train-input">
						<button class='btn' onclick="createNotice();"><span><span>新建</span></span></button>
					</security:authorize>
					<security:authorize ifAnyGranted="train-train-input">
						<button class='btn' onclick="updateNotice();"><span><span>修改</span></span></button>
					</security:authorize>
					<security:authorize ifAnyGranted="train-train-delete">
						<button class='btn' onclick="deleteNotices();"><span><span>删除</span></span></button>
					</security:authorize>
						<button  class='btn' onclick="iMatrix.export_Data('${ctx}/train/export.htm');"><span><span>另存为</span></span></button>
					</div>
					
					
					<div id="opt-content">
					<div id="message"><s:actionmessage theme="mytheme" /></div>	
					<script type="text/javascript">setTimeout("$('#message').hide('show');",3000);</script>
						<form id="contentForm"  method="post"  action="">
							<input name="id" id="id" type="hidden"></input>
							<input name="ids" id="ids" type="hidden"></input>
							<grid:jqGrid gridId="expenseReportList" url="${ctx}/train/list-datas.htm" code="TRAIN_NOTICE"></grid:jqGrid>
						</form>
					</div>
				</aa:zone>
			</div>
	</div>
</body>
<script type="text/javascript" src="${resourcesCtx}/widgets/colorbox/jquery.colorbox.js"></script>
<script src="${resourcesCtx}/widgets/timepicker/timepicker_<%=com.norteksoft.product.util.ContextUtils.getCurrentLanguage()%>.js" type="text/javascript"></script>
<script type="text/javascript" src="${resourcesCtx}/widgets/timepicker/timepicker-all-1.0.js"></script>
<script src="${resourcesCtx}/widgets/validation/dynamic.validate.js" type="text/javascript"></script>
</html>