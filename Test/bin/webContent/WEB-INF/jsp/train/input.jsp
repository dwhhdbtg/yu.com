<%@ page contentType="text/html;charset=UTF-8" import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<title>通知管理</title>
</head>

<body onclick="$('#sysTableDiv').hide(); $('#styleList').hide();" >
				<aa:zone name="main">
					<div class="opt-btn">
						<button class='btn' onclick="save();"><span><span>保存</span></span></button>
						<button class='btn' onclick="backToList();"><span><span>返回</span></span></button>
					</div>
					
					
					<div id="opt-content">
					<div id="message"><s:actionmessage theme="mytheme" /></div>	
					<form  id="expenseReportForm" name="expenseReportForm" method="post" action="">
						<input type="hidden" name="id" id="id" value="${id }"></input>
						<table class="form-table-without-border">
							<tr>
								<td class="content-title">标题</td>
								<td><input id="title" name="title" value="${title }" /><span style="color: red">*</span> </td>
							</tr>
							<tr>
								<td>通知对象</td>
								<td><input name="userIds" id="userIds" type="hidden" value="${userIds }"></input>
								<input name="userNames" id="userNames" value="${userNames }"></input> <a class='btn' href="#" onclick="selectPerson();"><span><span >选择</span></span></a>
								</td>
							</tr>
							<tr>
								<td>通知类型</td>
								<td><select name="type">
									<s:iterator value="@com.train.entity.NoticeType@values()" var="state">
										<option <s:if test="#state==type">selected="selected"</s:if> value="${state}"><s:text name="%{code}"></s:text></option>
									</s:iterator>
								</select>
								</td>
							</tr>
							<tr>
								<td>通知内容</td>
								<td></td>
							</tr>
							<tr>
								<td colspan="2"><textarea name="content" rows="10">${content }</textarea></td>
							</tr>
							</table>
					</form>
					</div>	
				</aa:zone>
</body>
</html>