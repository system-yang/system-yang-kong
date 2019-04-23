<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="easyui-layout" style="width:100%;height:100%; " data-options="border:false">
	<div data-options="region:'north'" style="height:35px" data-options="border:false">
		<div id="p" class="easyui-panel" style="padding:5px;" data-options="">当前位置 >></div>
	</div>
	<div data-options="region:'center',">
		<div style="margin-top:10px;margin-left:30px">
			<form id="searchUserForm" method="post"  >
				登录账号: <input class="easyui-textbox" style="width:120px" name="username">
				用户名: <input class="easyui-textbox" style="width:120px" name="nickname">
				起始日期: <input class="easyui-datebox" style="width:120px" name="starttime">
				终止日期: <input class="easyui-datebox" style="width:120px" name="endtime">
				生效：<input class="easyui-radiobutton" name="status" value="0" checked="true">
				失效：<input class="easyui-radiobutton" name="status" value="1" >
				<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="SearchUser()">查询</a>
			</form>
		</div>
		<div style="margin-left:30px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addUserWindow()">添加</a>
			<div id="win" style="display: none;">
				<div style="margin-left:30px">
					<form id="addUserForm" method="post">
				    	<table cellpadding="5">
				    		<tr>
				    			<td>登录账号:</td>
				    			<td><input class="easyui-textbox" type="text" name="username" data-options="required:true"></input></td>
				    		</tr>
				    		<tr>
				    			<td>登录密码:</td>
				    			<td><input class="easyui-textbox" type="password" name="password" data-options="required:true"></input></td>
				    		</tr>
				    		<tr>
				    			<td>邮箱:</td>
				    			<td><input class="easyui-textbox" type="text" name="email" data-options="required:true,validType:'email'"></input></td>
				    		</tr>
				    		<tr>
				    			<td>手机号::</td>
				    			<td><input class="easyui-textbox" type="text" name="phone" data-options="required:true"></input></td>
				    		</tr>
				    		<tr>
				    			<td>备注:</td>
				    			<td><input class="easyui-textbox" name="message" data-options="multiline:true" style="height:60px"></input></td>
				    		</tr>
				    	</table>
			    	</form>
				    <div style="text-align:center;padding:5px">
				    	<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="submitAddUserForm()">确认添加</a>
				    	<a href="javascript:void(0)" class="easyui-linkbutton" style="margin-left:20px" onclick="cancleForm()">取消添加</a>
				    </div>
			    </div>
			</div>
		</div>
		<div style="width:100%;height:400px;margin-left:20px">
			<table id="dg"  data-options="rownumbers:true,singleSelect:true,autoRowHeight:true,pagination:true,pageSize:10">
			</table>
		</div>
	</div>
</div>


<script>
	/*
	function getData(){
		var rows = [];
		 for(var i=1; i<=800; i++){
			var amount = Math.floor(Math.random()*1000);
			var price = Math.floor(Math.random()*1000);
			rows.push({
				inv: 'Inv No '+i,
				date: $.fn.datebox.defaults.formatter(new Date()),
				name: 'Name '+i,
				amount: amount,
				price: price,
				cost: amount*price,
				note: 'Note '+i
			});
		}
		return rows;
	}
	*/
	
 	function pagerFilter(data){
		if (typeof data.length == 'number' && typeof data.splice == 'function'){	// is array
			data = {
				total: data.length,
				rows: data
			}
		}
		var dg = $(this);
		var opts = dg.datagrid('options');
		var pager = dg.datagrid('getPager');
		pager.pagination({
			onSelectPage:function(pageNum, pageSize){
				opts.pageNumber = pageNum;
				opts.pageSize = pageSize;
				pager.pagination('refresh',{
					pageNumber:pageNum,
					pageSize:pageSize
				});
				dg.datagrid('loadData',data);
			}
		});
		if (!data.originalRows){
			data.originalRows = (data.rows);
		}
		var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
		var end = start + parseInt(opts.pageSize);
		data.rows = (data.originalRows.slice(start, end));
		return data;
	}
	
	$(function(){
		
		$('#dg').datagrid({
			type: "POST",
			url: basePath +'/user/list',
		    dataType: "json",
            fit:true,
            loadMsg:'加载中...',
            fitColumns:true,
            columns: [[
                { field: 'uid', title: 'id', align:'center',  hidden:true},
                { field: 'username', title: '登录账号', align:'center', width: 15 },
                { field: 'nickname', title: '用户名', align:'center', width: 15 },
                { field: 'email', title: '邮箱', align:'center', width: 15 },
                { field: 'phone', title: '手机号', align:'center', width: 15 },
                /* { field: 'sex', title: '性别', align:'center', width: 15 ,
                	formatter: function(value,row,index){
						if (row.sex='0'){
							return "女";
						} else {
							return "男";
						}
					}	
                }, */
                { field: 'status', title: '状态', align:'center', width: 15 ,
                	formatter: function(value,row,index){
						if (row.status='0'){
							return "生效";
						} else {
							return "失效";
						}
					}
                },
                { field: 'createdtime', title: '创建时间', align:'center', width: 26 ,
                	formatter: function(value,row,index){
	                	if (row.createdtime != null) {
	                        var date = new Date(row.createdtime);
	                        return date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate()+ ' ' +date.getHours() +':'+date.getMinutes()+':'+ date.getSeconds();
	                    }
					}	
                },
                { field: 'handle', title: '操作', align:'center', width: 40,
                	formatter: function(value,row,index){
						return "<button>修改</button><button>删除</button>";
					}	
                }
            ]]
        });
		
		$('#dg').datagrid({loadFilter:pagerFilter});
		//$('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', getData());
		
	});
	
	/*弹出添加用户窗口*/
	function addUserWindow(){
		$('#win').window({
			title:'用户添加',
			width:400,
		    height:350,
		    closable:true,
		    draggable:true,
		    resizable:false
		});
		
	}
	/*提交添加用户表单*/
	function submitAddUserForm(){
		$('#searchUserForm').form('submit', {
			type: "POST",
			url: basePath +'/user/add',
		    onSubmit : function() {
		    },
		    success:function(result){
		        alert("添加成功！");
		        $('#win').window('close');
		    }
		});
	}
	
	/*取消提交*/
	function cancleForm(){
		$('#win').window('close');
	}
	
	/*条件查询*/
	function SearchUser(){
		$('#searchUserForm').form('submit', {
			type: "POST",
			url: basePath +'/user/list',
		    onSubmit : function() {
		    },
		    success:function(result){
		        result = $.parseJSON(result); 
		        alert("查询成功！");
		    }
		});
	}
</script>