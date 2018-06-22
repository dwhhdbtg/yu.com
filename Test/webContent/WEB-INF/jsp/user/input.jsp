<%@ page contentType="text/html;charset=UTF-8" import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<title></title>
		<%@ include file="/common/iframe-meta.jsp"%>
		<script src="${resourcesCtx}/widgets/validation/validate-all-1.0.js" type="text/javascript"></script>
		<script src="${resourcesCtx}/widgets/validation/dynamic.validate.js" type="text/javascript"></script>
		<script type="text/javascript" src="${resourcesCtx}/widgets/timepicker/timepicker-all-1.0.js"></script>
		<script type="text/javascript" src="${resourcesCtx}/widgets/colorbox/jquery.colorbox.js"></script>
		<script type="text/javascript">
				
				function saveinput(url){
					buttonSign="";
					$("#inputForm").attr("action",url);
					$("#inputForm").submit();
				}
				//验证
				function validateinput(){
					$("#inputForm").validate({
						submitHandler: function() {
							var cansave = iMatrix.getSubTableDatas('inputForm');
							if(cansave){
								$(".opt_btn").find("button.btn").attr("disabled","disabled");
								__parseCustomDateTypeValue();//日期格式化保存处理
								ajaxSubmit('inputForm','','main',submitCallback);
							}
						},
						errorPlacement:function(error,element){
							error.appendTo(element.parent().children("span:contains('*')"));
						},
						rules: {
							
						},
						messages: {
							
						}
					});
				}
				function submitCallback(){
					
				}
			</script>
	</head>
	
	<body onload="getContentHeight();"  onunload="destroyUploadControl();">
		<div class="ui-layout-center">
		<div class="opt-body">
			<div class="opt-btn">
				<button class='btn' onclick="saveinput('${ctx}/input/input-save.htm')"><span><span>保存</span></span></button>
			
					<button class='btn' onclick='setPageState();ajaxSubmit("defaultForm","${ctx}/input/input-list.htm","main");'><span><span>返回</span></span></button>
			</div>
			<aa:zone name="main">
				<div id="opt-content" class="form-bg">
				<div id="message" style="display:none;"><s:actionmessage theme="mytheme" /></div>
					<form  id="inputForm" name="inputForm" method="post" action="">
						<input type="hidden" name="id" id="id" value="${id }"/>
						<div>
							用户姓名：<input id="username" name="username" value="${username }"/>
						</div>
						<div>
							性别：<input type="radio" id="sex" name="sex" value="男"/>男</br>
								<input type="radio" id="sex" name="sex" value="女"/>女
						</div>
						<div>
							年龄：<input id="age" name="age" value="${age }"/>
						</div>
						<div>
							身份证号码：<input id="identity" name="identity" value="${identity }"/>
						</div>
						<div>
							手机号码：<input id="phone" name="phone" value="${phone }"/>
						</div>
						<div>
							邮箱：<input id="emain" name="emain" value="${emain }"/>
						</div>
						<div>
							qq：<input id="qq" name="qq" value="${qq }"/>
						</div>
						<div>
							用户姓名：<input id="username" name="username" value="${username }"/>
						</div>
						
						
					</form>
				</div>
				<script type="text/javascript">
				$(document).ready(function(){
					//验证表单字段
					addFormValidate('${fieldPermission}','inputForm');
					iMatrix.autoFillOpinion('${autoFillOpinionInfo}');
					validateinput();
					
				});
			</script>
			</aa:zone>
		</div>
		</div>
	</body>
</html>