var buttonSign="";
isUsingComonLayout=false;
	$().ready(function() {
		$( "#tabs" ).tabs();
		validateForm();
		iMatrix.autoFillOpinion('${autoFillOpinionInfo}');
	});

	function validateForm(){
		addFormValidate($("#fieldPermission").val(), 'noticeWorkflowForm');
		noticeWorkflowFormValidate();
	}

	//提交form
	function completeTask(taskTransact) {
		buttonSign="";
		$('#taskTransact').val(taskTransact);
		$("#noticeWorkflowForm").attr("action",webRoot+"/train/noticeWorkflow-completeTask.htm");
		$('#noticeWorkflowForm').submit();
	}
	
	//保存form
	function saveTask() {
	buttonSign="save";
		$("#noticeWorkflowForm").attr("action",webRoot+"/train/noticeWorkflow-save.htm");
		$("#saveTaskFlag").attr("value","true");
		$('#noticeWorkflowForm').submit();
	}

	//表单验证
	function noticeWorkflowFormValidate() { 
		$("#noticeWorkflowForm").validate({
			submitHandler : function() {
				$(".opt_btn").find("button.btn").attr("disabled", "disabled");
				var cansave = iMatrix.getSubTableDatas("noticeWorkflowForm");
				if(cansave){
					$(".opt_btn").find("button.btn").attr("disabled","disabled");
					var clickBtnName = iMatrix.getWorkflowClickButton();
					if(clickBtnName=="SAVE"){
						buttonSign="save";
						$('#noticeWorkflowForm').attr('action',webRoot+"/train/noticeWorkflow-save.htm");
					}else if(clickBtnName!=""){
						buttonSign="";
						$('#noticeWorkflowForm').attr('action',webRoot+"/train/noticeWorkflow-completeTask.htm");
					}
					if("save"==buttonSign){
						ajaxSubmit('noticeWorkflowForm','','main',submitCallback);
					}else{
						$("#noticeWorkflowForm").ajaxSubmit(function (id){
							dealResult(id);
							if(""==buttonSign){
								if(id!=""&&typeof id!='undefined'&&id!=null){
									var ids=id.split(";");
									if(!(ids[1]!=undefined&&ids[1]!=null&&ids[1]!='')){//不是弹出框
										window.parent.close();
									}
								}
							}else{
								buttonSign="";
							}
						});
					}
				}
			},
			errorPlacement:function(error,element){
				error.appendTo(element.parent().children("span:contains('*')"));
			}
		});
	}
	
	function submitCallback(){
		showMsg();
		$( "#tabs" ).tabs();
		validateForm();
	}
	
	//提交后回调事件
	function dealResult(id){
	if(id!=""&&typeof id!='undefined'&&id!=null){
		var ids=id.split(";");
		$("#id").attr("value",ids[0]);
		if(ids[1]!=undefined&&ids[1]!=null&&ids[1]!=''){
			//根据后台返回id判断执行操作，这里代码根据需求写
			if(ids[1]=="OPINION"){//默认值：意见框
				iMatrix.commonOpinion({
					taskId:$("#taskId").val(),
					callbackFun:"submitCommonOpinionForm",
					controlId:"_common_opinion",
					title:"意见"
					});
			}else if(ids[1]=="SELECT_TRANSACTOR"){//默认值：选择办理人
				iMatrix.selectTransactor(selectTransactorCallback,false);
			}
		}else{
			$("#message").show("show");
			setTimeout('$("#message").hide("show");',3000);
		}
	}
}

function submitCommonOpinionForm(){
	$("#noticeWorkflowForm").attr("action",webRoot+"/train/noticeWorkflow-completeInteractiveTask.htm");
	$("#noticeWorkflowForm").ajaxSubmit(function (id){
		window.parent.close();
		window.parent.location.reload(true);
	});
}
function selectTransactorCallback(){
	var taskId = $("#taskId").attr("value");
	var userId = ztree.getId();
	$.ajax({
		data:{transactorIdStr:userId,taskId:taskId},
		cache:false,
		type:"post",
		url:webRoot+"/train/noticeWorkflow-completeInteractiveTask.htm",
		success:function(data, textStatus){
			window.parent.close();
			window.parent.location.reload(true);
		},
		error:function(){
			   window.location.reload();
		}
	});
}
	//流转历史和表单信息切换
	function changeViewSet(opt){
		if(opt=="basic"){
			ajaxSubmit("defaultForm1", webRoot+"/train/noticeWorkflow-task.htm", 'btnZone,viewZone', validateForm);
		}else if(opt=="history"){
			ajaxSubmit("defaultForm1", webRoot+"/train/noticeWorkflow-showHistory.htm", 'btnZone,viewZone');
		}
	}

	//办理完任务关闭窗口前执行
	function beforeCloseWindow(opt){
		ajaxSubmit("defaultForm1", webRoot+"/train/noticeWorkflow-task.htm", 'btnZone,viewZone');
	}

	//选择加签人员
	function addTask(){
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
						title: "选择加签人员",
						width: 300,
						height:400,
						url:webRoot+"",
						showBranch:true
					},
					feedback:{
						enable: true,
				                //showInput:"point_user",
				                hiddenInput:"addSignPerson",
				                append:false
					},
					callback: {
						onClose:function(){
							addSignCallBack();
						}
					}			
					};
				    popZtree(zTreeSetting);
	}
	function addSignCallBack(){
		if(ztree.getNames().indexOf("全公司")>=0){
			$('#addSignPerson').attr("value","all_user");
		}else{
			$('#addSignPerson').attr("value",ztree.getIds());
		}
		$("#noticeWorkflowForm").attr("action",webRoot+"/train/noticeWorkflow-addSigner.htm");
		$("#noticeWorkflowForm").ajaxSubmit(function (id){
			alert(id);
		});
		validateForm();
	}
	//选择减签人员
	function cutTask(){
		custom_ztree({url:webRoot+'/train/noticeWorkflow-cutsignTree.htm',
			onsuccess:function(){removeSignerCallBack();},
			width:500,
			height:400,
			title:'选择环节',
			postData:{taskId:$("#taskId").attr("value")},
			nodeInfo:['type','name','loginName','transactorId','taskId'],
			multiple:true,
			webRoot:webRoot
		});
	}
	function removeSignerCallBack(){
		var taskIds=getSelectValue("taskId");
		var removeTaskIds="";
		for(var i=0;i<taskIds.length;i++){
			if(taskIds[i]!="company"){
				removeTaskIds=removeTaskIds+taskIds[i]+",";
			}
		}
		if(removeTaskIds.indexOf(",")>=0){
			removeTaskIds=removeTaskIds.substring(0,removeTaskIds.lastIndexOf(","));
		}
		$("#removeTaskIds").attr("value",removeTaskIds);
		$("#noticeWorkflowForm").attr("action",webRoot+"/train/noticeWorkflow-removeSigner.htm");
		$("#noticeWorkflowForm").ajaxSubmit(function (id){
			alert(id);
		});
		validateForm();
	}
	//领取回调
	function receiveback(){
		$("#message").show("show");
		setTimeout('$("#message").hide("show");',3000);
		validateForm();
	}

	//指派
	function assignPerson(){
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
						//chkStyle:"checkbox",
						//chkboxType:"{'Y' : 'ps', 'N' : 'ps' }"
					},
					view: {
						title: "指派人员",
						width: 300,
						height:400,
						url:webRoot+"",
						showBranch:true
					},
					feedback:{
						enable: true,
				                //showInput:"point_user",
				                hiddenInput:"assignee",
				                append:false
					},
					callback: {
						onClose:function(){
							assignPersonCallBack();
						}
					}			
					};
				    popZtree(zTreeSetting);		
	}
	//指派回调
	function assignPersonCallBack(){
		$('#assignee').attr("value",ztree.getLoginName());
		$("#noticeWorkflowForm").attr("action",webRoot+"/train/noticeWorkflow-assign.htm");
			$("#noticeWorkflowForm").ajaxSubmit(function (id){
				alert(id);
				window.parent.close();
			});
	}

	//提交
	workflowButtonGroup.btnSubmitTask.click = function(taskId){
		completeTask('SUBMIT');
	};
	//同意
	workflowButtonGroup.btnApproveTask.click = function(taskId){
		completeTask('APPROVE');
	};
	//不同意
	workflowButtonGroup.btnRefuseTask.click = function(taskId){
		completeTask('REFUSE');
	};
	//加签
	workflowButtonGroup.btnAddCountersign.click = function(taskId){
		addTask();
	};
	//减签
	workflowButtonGroup.btnDeleteCountersign.click = function(taskId){
		cutTask();
	};

	//保存
	workflowButtonGroup.btnSaveForm.click = function(taskId){
		saveTask();
	};

	//取回
	workflowButtonGroup.btnGetBackTask.click = function(taskId){
		$("#noticeWorkflowForm").attr("action",webRoot+"/train/noticeWorkflow-retrieveTask.htm");
		$("#noticeWorkflowForm").ajaxSubmit(function (id){
			if(id=="任务已取回"){
				window.location.reload(false);
			}else{
				alert(id);
			}
		});
	};

	//领取
	workflowButtonGroup.btnDrawTask.click = function(taskId){
		ajaxSubmit("defaultForm1", webRoot+"/train/noticeWorkflow-drawTask.htm", 'btnZone,viewZone',receiveback);
	};
	//放弃领取
	workflowButtonGroup.btnAbandonTask.click = function(taskId){
		ajaxSubmit("defaultForm1", webRoot+"/train/noticeWorkflow-abandonReceive.htm", 'btnZone');
	};

	//指派
	workflowButtonGroup.btnAssign.click = function(taskId){
		assignPerson();
	};

	//已阅
	workflowButtonGroup.btnReadTask.click = function(taskId){
		$('#taskTransact').val('READED');
		ajaxSubmit("noticeWorkflowForm", webRoot+"/train/noticeWorkflow-completeTask.htm", 'main', readTaskCallback);
	};
	//选择环节
	workflowButtonGroup.btnChoiceTache.click = function(){
		completeTask('READED');
	};
	
	function readTaskCallback(){
		$("#message").show("show");
		setTimeout('$("#message").hide("show");',3000);
		window.parent.close();
	}

	//抄送
	workflowButtonGroup.btnCopyTache.click = function(taskId){
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
						title: "抄送人员",
						width: 300,
						height:400,
						url:webRoot+"",
						showBranch:true
					},
					feedback:{
						enable: true,
				                showInput:"copyPerson",
				                hiddenInput:"copyPerson",
				                append:false
					},
					callback: {
						onClose:function(){
							copyPersonCallBack();
						}
					}			
					};
				    popZtree(zTreeSetting);	
		};

	function copyPersonCallBack(){
		if(ztree.getNames().indexOf("全公司")>=0){
			$('#copyPerson').attr("value","all_user");
		}else{
			$('#copyPerson').attr("value",ztree.getLoginNames());
		}
		$("#noticeWorkflowForm").attr("action",webRoot+"/train/noticeWorkflow-copyTask.htm");
		$("#noticeWorkflowForm").ajaxSubmit(function (id){
			alert(id);
		});
	}
	function gobackTask(){
		$("#noticeWorkflowForm").attr("action",webRoot+"/train/noticeWorkflow-goback.htm");
		$("#noticeWorkflowForm").ajaxSubmit(function (id){
			alert(id);
			changeViewSet('basic');
			window.parent.close();
		});
	}