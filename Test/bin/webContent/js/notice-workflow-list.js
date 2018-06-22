function viewNoticeWorkflow(url){
						var ids = jQuery("#noticeWorkflowGridId").getGridParam('selarrrow');
						if(ids==""){
							alert("请选择一条数据");
						}else if(ids.length > 1){
							alert("只能选择一条数据");
						}else if(ids.length == 1){
							ajaxSubmit("defaultForm",url+"?id="+ids[0],"main",null);
						}
						
					}
					//新建
					function createNoticeWorkflow(url){
						ajaxSubmit("defaultForm",url,"main",createNoticeWorkflowCallback);
					}
					function createNoticeWorkflowCallback(){
						validateNoticeWorkflow();
						uploadDocument(webRoot+'/train/noticeWorkflow-uploadDocument.htm');
						getContentHeight();
					}
					//验证
					function validateNoticeWorkflow(){
						$("#inputForm").validate({
							submitHandler: function() {
								var cansave = iMatrix.getSubTableDatas('inputForm');
								if(cansave){
									$(".opt_btn").find("button.btn").attr("disabled","disabled");
									__parseCustomDateTypeValue();//日期格式化保存处理
									ajaxSubmit('inputForm','','main',submitCallback);
								}
							},
							rules: {
								
							},
							messages: {
								
							}
						});
					}
					
					//修改
					function updateNoticeWorkflow(url){
						var ids = jQuery("#noticeWorkflowGridId").getGridParam('selarrrow');
						if(ids==""){
							alert("请选择一条数据");
						}else if(ids.length > 1){
							alert("只能选择一条数据");
						}else if(ids.length == 1){
							ajaxSubmit("defaultForm",url+"?id="+ids[0],"main",createNoticeWorkflowCallback);
						}
					}
					function changeViewSet(opt){
						if(opt=="basic"){
							ajaxSubmit("defaultForm1", webRoot+"/train/noticeWorkflow-view.htm", 'viewZone');
						}else if(opt=="history"){
							ajaxSubmit("defaultForm1", webRoot+"/train/noticeWorkflow-showHistory.htm", 'viewZone');
						}
					}
					var buttonSign="";
					workflowButtonGroup.btnStartWorkflow.click = function(taskId){
						saveNoticeWorkflow(webRoot+'/train/noticeWorkflow-save.htm');
					};
					workflowButtonGroup.btnSubmitWorkflow.click = function(taskId){
						submitNoticeWorkflow(webRoot+'/train/noticeWorkflow-submitProcess.htm');
					};
					
					function submitNoticeWorkflow(url){
						buttonSign="firstSubmit";
						$('#taskTransact').val("SUBMIT");
						$("#inputForm").attr("action",url);
						$("#inputForm").submit();
					}
					
					function submitCallback(){
						if(buttonSign!="firstSubmit"){//第一环节提交不在此处显示“提交成功”信息，在下面的dealResult中显示
							showMsg();
						}
						validateNoticeWorkflow();
						getContentHeight();
						if(buttonSign=="firstSubmit"){
							buttonSign="";
							dealResult($("#submitResult").val());
						}
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
							showMsg();
							setPageState();
							ajaxSubmit("defaultForm",webRoot+"/train/noticeWorkflow-list.htm","main");
						}
					}
				}
			
					function submitCommonOpinionForm(){
						$("#inputForm").attr("action",webRoot+"/train/noticeWorkflow-completeInteractiveTask.htm");
						$("#inputForm").ajaxSubmit(function (id){
							//刷新区域
							setPageState();
							ajaxSubmit("defaultForm",webRoot+"/train/noticeWorkflow-list.htm","main");
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
								//刷新区域
								setPageState();
								ajaxSubmit("defaultForm",webRoot+"/train/noticeWorkflow-list.htm","main");
							}
						});
					}
					
					function saveNoticeWorkflow(url){
						$("#inputForm").attr("action",url);
						$("#inputForm").submit();
					}
					
					//删除
					function deleteNoticeWorkflow(url){
						var ids = jQuery("#noticeWorkflowGridId").getGridParam('selarrrow');
						if(ids.length<=0){
							alert("请选择数据");
						}else {
							ajaxSubmit('defaultForm', url+'?ids='+ids.join(','), 'main',showMsg);
						}
					}