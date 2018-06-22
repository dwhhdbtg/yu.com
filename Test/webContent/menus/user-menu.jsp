<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

	<div id="myExpenseReport" class="west-notree"  ><a href="#" onclick="thirdMenuClick('myExpenseReport');">用户列表</a></div>
<!-- 	<div id="report" class="west-notree"  ><a href="#" onclick="thirdMenuClick('report');">联系人</a></div>
	 -->
	<!--<div id="automationTool" class="west-notree" ><a href="#" onclick="thirdMenuClick('automationTool');">自动化工具</a></div>-->
	<div class="linee"></div>
<script type="text/javascript">
function thirdMenuClick(menuDivId){
	var url = window.location.href;
	var menuId = "";
	if(url.indexOf("menuId=")>=0){
		if(url.indexOf("&")>=0){
			var params = url.substring(url.indexOf("menuId=")+7);
			if(params.indexOf("&")>=0){//地址如http://....htm?menuId=123&position=list1
				menuId = params.substring(0,params.indexOf("&"));
			}else{//地址如http://....htm?menuId=123
				menuId = params;
			}
		}else{
			menuId = url.substring(url.indexOf("menuId=")+7);
		}
	}
	var menuIdParam = "";
	if(menuId!=""){
		menuIdParam = "menuId="+menuId;
	}
	if(menuDivId=="myExpenseReport"){
		window.location.href = "${ctx }/user/list.htm?"+menuIdParam;
	}/* else if(menuDivId=="report"){
		window.location.href = "${ctx }/contacts/list.htm?"+menuIdParam;
	} */
}
</script>