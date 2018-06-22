//显示提示信息，3秒后隐藏
function showMsg(id,time){
	if(id==undefined)id="message";
	$("#"+id).show();
	if(time==undefined)time=3000;
	setTimeout('$("#'+id+'").hide();',time);
}

/*---------------------------------------------------------
函数名称:_add_SWf
参          数:无
功          能:查看流转历史
------------------------------------------------------------*/
function _add_SWf(){
	var so = new SWFObject(
			webRoot+"/widgets/workflowEditor/FlowChartProject.swf",
			"FlowChartProject", "100%", "100%", "9", "#CCCCCC");
	so.addParam("quality", "high");
	so.addParam("name", "FlowChartProject");
	so.addParam("id", "FlowChartProject");
	so.addParam("AllowScriptAccess", "always");
	so.addParam("menu", "false");
	so.addVariable("webRoot", webRoot);
	so.addVariable("companyId", $("#companyId").val());
	so.addVariable("wfId", $("#wfdId").val());
	so.addVariable("instanceId", $("#instanceId").val());
	if($("#localeLang").val() == "en"){
		so.addVariable("localeLanguage", "en_US");
	}else if($("#localeLang").val() == "zh"){
		so.addVariable("localeLanguage", "zh_CN");
	}
	so.addVariable("page", "viewHistoryProcess");
	so.write("flashcontent");
}

/************************************************************
上传正文
************************************************************/
var otherswfu;
/*---------------------------------------------------------
函数名称:uploadFile_d
参          数:url
功          能:正文上传初始化
------------------------------------------------------------*/
function uploadDocument(url){
	otherswfu = new SWFUpload({
		upload_url: url,
		post_params: {"name" : "参数"},
		
		file_post_name : "Filedata", //是POST过去的$_FILES的数组名   () 建议使用这个默认值
		
		file_size_limit : "30 MB",	// 1000MB
		file_types : "*.doc;*.pdf;*.xls;*.wps;*.et;",
		file_types_description : "word,excel,pdf,wps,et",
		file_upload_limit : "0",
		
		file_queue_error_handler : fileQueueError,
		file_dialog_complete_handler : fileDialogComplete,//选择好文件后提交
		file_queued_handler : fileQueued,
		upload_progress_handler : uploadProgress,
		upload_error_handler : uploadError,
		upload_success_handler : uploadSuccess,
		upload_complete_handler : uploadComplete,
		
		// Button Settings
		button_image_url : webRoot + "/images/annex.gif",
		button_placeholder_id : "spanButtonPlaceholder",
		button_width: 250,
		button_height: 18,
		button_text : '<span class="button">请上传文件(最大100MB)</span>',
		button_text_style : '.button {border:1px solid #91B8D2;color:#2970A6;  }',
		button_text_top_padding: 0,
		button_text_left_padding: 18,
		button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
		button_cursor: SWFUpload.CURSOR.HAND,
		
		// Flash Settings
		flash_url : webRoot + "/widgets/swfupload/swfupload.swf",
		
		custom_settings : {
			upload_target : "divFileProgressContainer",
			isUpload : true
		},
		// Debug Settings
		debug: false  //是否显示调试窗口
	});
}

/*---------------------------------------------------------
函数名称:fileDialogBefore
参          数:url
功          能:所好文件之后调用
------------------------------------------------------------*/
function fileDialogBefore(file,swfObject){
	var id=$("#id").attr("value");
	var taskId=$("#taskId").attr("value");
	if(id==""||id==null){
		otherswfu.customSettings.isUpload=false;
		alert("请先保存,再上传!");
		otherswfu.eventQueue=[];
	}else{
		otherswfu.customSettings.isUpload=true;
		otherswfu.setPostParams({"id":id,"taskId":taskId});
		otherswfu.startUpload();
	}
}

/*---------------------------------------------------------
函数名称:rewriteMethod
参          数:url
功          能:所有文件上传之后调用
------------------------------------------------------------*/
function rewriteMethod(file,swfObject){
	alert(1111);
	ajaxSubmit("inputForm", webRoot+"/train/noticeWorkflow-input.htm", "docZones",uploadBack);
}

/**
* 上传之后回调
* @return
*/
function uploadBack(){
//	$( "#tabs" ).tabs();
//	expenseReportFormValidate();
//	$("#outDate").datepicker();
//	validateForm();
	uploadDocument(webRoot+'/train/noticeWorkflow-uploadDocument.htm');
//	getContentHeight();
}