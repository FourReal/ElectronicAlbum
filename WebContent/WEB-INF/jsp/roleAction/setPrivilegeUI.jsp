<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@	include file="/WEB-INF/jsp/public/commons.jspf" %>
	<script src="jquery-3.2.1.min.js" type="text/javascript"></script>
	<script language="javascript" src="${pageContext.request.contextPath}/script/jquery_treeview/jquery.treeview.js"></script>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/script/jquery_treeview/jquery.treeview.css">
	<script type="text/javascript">
		$(function(){
			//指定事件处理函数
			$("[name=privilegeIds]").click(function(){
				
				//选中或取消一个权限时，也同时选中或取消所有的下级权限
				$(this).siblings("ul").find("input").attr("checked",this.checked);
				
				//当选中一个权限时，也要选中所有的直系上级权限
				if(this.checked==true){
					$(this).parents("li").children("input").attr("checked",true);
				}
				
			});	
			
		});
		
	</script>

</head>
<body>

	<!-- 显示表单内容 -->
	<div id="MainArea">
		<s:form action="role_setPrivilege">
			<s:hidden name="id"></s:hidden>
			<div class="ItemBlock_Title"><!-- 信息说明 --><div class="ItemBlock_Title">正在为【${name}】分配权限</div>
			</div>
			
			<!-- 表单内容显示 -->
			<div class="ItemBlockBoder">
				<div class=ItemBlock>
					<table cellspacing="0" cellpadding="0" class="mainForm">
						<!-- 表头 -->
						<thead>
							<tr align="left" valign="MIDDLE" id="TableTitle">
								<td	width="300px" style="padding-left:7px" >
									<input type="checkbox" id="cbSelectAll" onClick=" $('[name=privilegeIds]').attr('checked',this.checked)" />
									<label for="cbSelectAll">全选</label>
								</td>
							</tr>
						</thead>
						
						<!-- 显示数据列表 -->	
						<tbody id="TableData">
							<tr class="TableDetaill">
								<!-- 显示权限树 -->
								<td>
								
									<%-- <s:checkboxlist name="privilegeIds" list="#privilegeList" listKey="id" listValue="name"></s:checkboxlist>	 --%>
									<s:iterator value="#privilegeList">
									 	<input type="checkbox" name="privilegeIds" value="${id}" id="cb_${id}"
									 		<s:property value="%{id in privilegeIds ? 'checked' : ''}"/>
									 	/>
									 	<label for="cb_${id}">${name}</label>
									 	<br/>
									</s:iterator>	
														

							<!-- 显示树状结构内容 -->
							<%-- <ul id="tree">
							<s:iterator value="#application.topPrivilegeList"> 
								<li>
									<input type="checkbox" name="privilegeIds" value="${id}" id="cb_${id}" <s:property value="%{id in privilegeIds ? 'checked' : ''}"/> />
									<label for="cb_${id}">${name}</label>
									<ul>
									<s:iterator value="children">
										<li>
											<input type="checkbox" name="privilegeIds" value="${id}" id="cb_${id}" <s:property value="%{id in privilegeIds ? 'checked' : ''}"/> />
									 		<label for="cb_${id}">${name}</label>
											<ul>
											<s:iterator value="children">
												<li>
													<input type="checkbox" name="privilegeIds" value="${id}" id="cb_${id}" <s:property value="%{id in privilegeIds ? 'checked' : ''}"/> />
								 					<label for="cb_${id}">${name}</label>
												</li>
											</s:iterator>
											</ul>
										</li>
									</s:iterator>
									</ul>
								</li>
							</s:iterator>
							</ul> --%>								
								
								
								
								</td>
								
								
							</tr>
						</tbody>
						
						
					</table>
					
				</div>
			
			</div>
			
			<script language="javascript">
				$("#tree").treeview();
			</script>
			
			<!-- 表单操作 -->
			<div id="InputDataillBar">
				<s:submit value="提交"></s:submit>
				<a href="javascript:history.go(-1)">返回</a>
			</div>
			
		</s:form>
	</div>
</body>
</html>