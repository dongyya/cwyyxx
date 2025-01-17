<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>宠物医院管理系统</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<style type="text/css">
	a button{
		outline:none;
	}
</style>

<script type="text/javascript">
	var url;
	
	function openTab(text,url,iconCls){
		if($("#center_tabs").tabs("exists",text)){
			$("#center_tabs").tabs("select",text);
		}else{
			var content="<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='${pageContext.request.contextPath}/pages/main/"+url+"'></iframe>";
			$("#center_tabs").tabs("add",{
				title:text,
				iconCls:iconCls,
				closable:true,
				content:content
			});
		}
	}
	
	function openPasswordModifyDialog(){
		$("#dlg").dialog("open").dialog("setTitle","修改密码");
		url="${pageContext.request.contextPath }/user/modifypwd.html?id=${currentUser.id}"; 
	}
	
	<!--关闭修改密码的模态框-->	
	function closePasswordModifyDialog(){
		$("#dlg").dialog("close");
		$("#oldPassword").val("");
		$("#newPassword").val("");
		$("#newPassword2").val("");
	}
	
	function modifyPassword(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				var oldPassword=$("#oldPassword").val();
				var newPassword=$("#newPassword").val();
				var newPassword2=$("#newPassword2").val();
				if(!$(this).form("validate")){
					return false;
				}
				if(oldPassword!='${currentUser.passWord}'){
					$.messager.alert("系统提示","<font size='3' color='green'>用户原密码输入错误 !<font>");
					return false;
				}
				if(newPassword!=newPassword2){
					$.messager.alert("系统提示","<font size='3' color='green'>确认密码输入错误!<font>");
					return false;
				}
				return true;
			},
			success:function(result){
				var result = eval('('+result+')');
				if(result.success){
					closePasswordModifyDialog();
 					$.messager.show({
						title:'系统提示',
						msg:"<font size='3' color='green'>密码修改成功，下一次登录生效！</font>",
						timeout:2000,
						showType:'slide',
						width:300,
						height:150,
						style:{
							top:'',
							left:'',
							right:0,
							bottom:document.body.scrollTop+document.documentElement.scrollTop
						}
					}); 
				}else{
					$.messager.show({
						title:'系统提示',
						msg:"<font size='3' color='green'>密码修改失败！</font>",
						timeout:2000,
						showType:'slide',
						width:300,
						height:150,
						style:{
							top:'',
							left:'',
							right:0,
							bottom:document.body.scrollTop+document.documentElement.scrollTop
						}
					});
					return;
				}
			}
		});
	}
	
	function logout(){
		$.messager.confirm("系统提示","您确定要退出系统吗",function(r){
			if(r){
				window.location.href="${pageContext.request.contextPath }/user/exit.html"; 
			}
		});
	}
	
</script>
</head>
<body class="easyui-layout">   
    <div data-options="region:'north',split:true" style="height:67px;background:#E0EDFF;">
		<div style="height:35px;">
			<div style="padding-left:15px;padding-top:5px;">
				<img src="${pageContext.request.contextPath}/others/images/logo.png">&nbsp;&nbsp;
				<div style="padding-top:5px;; padding-left:55px;margin-top:-48px; ">
					<font size="6" style="font-family: cursive;">宠物医院管理系统</font>
				</div>
			</div>
			<div style="margin-top: -35px;padding-left: 800px;">
				<font size="6" style="font-family: cursive;">欢迎您：
				  <font color="red">
				    <c:if test="${currentUser.userName == null}">游客模式</c:if>
				    <c:if test="${currentUser.userName != null && currentUser.userName != ''}">${currentUser.userName}</c:if>
				  </font>
				</font>
				<c:if test="${currentUser.userName == null}">
				  <a style="outline: none;width:50px" href="${pageContext.request.contextPath }/index/goLogin.html" class="text-right pull-right" target="_bank"><font size="5" style="font-family: cursive;">登录</font></a>
				  <a style="outline: none;width:50px" href="${pageContext.request.contextPath }/index/goFindpwd.html" class="text-right pull-right" target="_bank"><font size="5" style="font-family: cursive;">注册</font></a>
				</c:if>
				<c:if test="${currentUser.userName != null && currentUser.userName != ''}">
				  <a style="outline: none;width:50px" href="${pageContext.request.contextPath }/user/exit.html" class="text-right pull-right" target="_bank"><font size="5" style="font-family: cursive;">退出</font></a>
                </c:if>
			</div>
		</div>
    </div>   
    
    <div data-options="region:'south',title:'<center></center>',split:true" style="height:35px;"></div> 
      
	 <div region="west" style="width: 210px" title="导航菜单" split="true">
		<div class="easyui-accordion" data-options="fit:true,border:false">
		    <c:if test="${currentUser != null}">
		      <c:if test="${currentUser.userTypeId != 3 }">
		        <div title="个人信息管理" data-options="iconCls:'icon-personal'" style="padding: 10px">
				  <a href="javascript:openTab('个人信息详情','userInfo.jsp','icon-personal-detail')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-personal-detail'" style="width: 150px;">个人信息详情</a>
			   </div>
		      </c:if>
		      <c:if test="${currentUser.userTypeId==3 }">
		        <div title="用户管理" data-options="iconCls:'icon-user'" style="padding: 10px">
				  <a href="javascript:openTab('用户列表','userList.jsp','icon-c-user-list')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-c-user-list'" style="width: 150px;">用户列表</a>
				  <a href="javascript:openTab('个人信息详情','userInfo.jsp','icon-personal-detail')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-personal-detail'" style="width: 150px;">个人信息详情</a>
			    </div>
		      </c:if>
	 		  <div title="系统管理"  data-options="iconCls:'icon-item'" style="padding:10px">
				<a href="javascript:openPasswordModifyDialog()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 150px;">修改密码</a>
				<a href="javascript:logout()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-exit'" style="width: 150px;">安全退出</a>
			  </div>
		    </c:if>
		</div>
	</div>
    
    <div data-options="region:'center',title:' &nbsp;功能主界面'" style="padding:2px;background:white;">
    	<div id="center_tabs" class="easyui-tabs" fit="true">
    		<div title="首页" data-options="iconCls:'icon-home'" align="center" style="margin-top: 150px">
    			<font style="font-family: cursive;font-size: 100px;">欢迎使用宠物医院管理系统</font>
    		</div>
    	</div>
    </div>  
    
    <div id="dlg" class="easyui-dialog" style="width: 400px;height:230px;padding: 10px 20px"
  		closed="true" closeable="false" buttons="#dlg-buttons">
	 	<form id="fm" method="post">
	 		<table cellspacing="8px">
	 			<tr>
	 				<td>用户名：</td>
	 				<td><input type="text" id="userName" name="userName" value="${currentUser.userName }" readonly="readonly" style="width: 200px"/></td>
	 			</tr>
	 			<tr>
	 				<td>原密码：</td>
	 				<td><input type="password" id="oldPassword" class="easyui-validatebox" required="true" style="width: 200px"/></td>
	 			</tr>
	 			<tr>
	 				<td>新密码：</td>
	 				<td><input type="password" id="newPassword" name="newPassWord" class="easyui-validatebox" required="true" style="width: 200px"/></td>
	 			</tr>
	 			<tr>
	 				<td>确认新密码：</td>
	 				<td><input type="password" id="newPassword2"  class="easyui-validatebox" required="true" style="width: 200px"/></td>
	 			</tr>
	 		</table>
	 	</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:modifyPassword()" class="easyui-linkbutton" iconCls="icon-ok" style="outline: none">保存</a>
		<a href="javascript:closePasswordModifyDialog()" class="easyui-linkbutton" iconCls="icon-cancel" style="outline: none">关闭</a>
	</div> 
</body> 
</html>