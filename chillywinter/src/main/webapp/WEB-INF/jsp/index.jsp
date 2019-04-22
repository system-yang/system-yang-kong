<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>主页</title>
    <%@ include file="commons/basejs.jsp" %>
</head>
	<body class="easyui-layout" data-options="fit:true" >
		<div id="grad1" data-options="region:'north', " style="height:7%;text-align:center;margin:auto;color:#888888;font-size:20px;font-weight:bold;background-color: #1C86EE;"></div>
		<div data-options="region:'west',title:'菜单导航',  " style="width:10%;  ">
			<div class="easyui-panel" data-options="border:false" style="padding:10px" >
			<ul id="tt" class="easyui-tree"></ul>
			</div>
		</div>
		<div data-options="region:'center', " >
			<div id="tab" class="easyui-tabs" data-options="tabWidth:150" style="width:100%; height: 100%; ">
				<div title="首页" style="padding:20px;">
					<h2 style="color: #52D689;">欢迎进入XXX管理平台</h2>
				</div>
			</div>
			<div id="mm" class="easyui-menu" data-options="" style=""></div>
		</div>
	</body>
	
	
<script type="text/javascript">
$(function(){
	
	
	
	/*加载左侧菜单*/
	/* */
	$.post({
		type: "POST",
		url: basePath +'/menu/tree',
		success: function(data){
			$('#tt').tree({
				data: data,
				animate:true ,
				parentField:"pid",
				onClick: function(node){
					var nodeState = node.state;
					if(nodeState =='open'){
						$('#tt').tree('collapse',node.target);
					}else{
						$('#tt').tree('expand',node.target);
					}
					
					if(node.url!='#'){
						var url = node.url;
						var opts = {
				                title : node.text,
				                border : false,
				                closable : true,
				                fit : true,
				                //iconCls : node.iconCls
				            };
			            if (url && url.indexOf("http") == -1) {
			                url = basePath + url;
			            }
			            if (node.openMode == 'iframe') {
			            	opts.tabContent = '<iframe src="' + url + '" frameborder="0" style="border:0;width:100%;height:99.5%;"></iframe>';
			                addTab(opts);
			            } else if (url) {
			                opts.href = url;
			                addTab(opts);
			            }
					}
				}
			});

		},
		dataType: "json"
	});  
	
	
	/*标签页的操作*/
	$('#tab').tabs({
		onSelect:function(title,index){
			//alert("当前选中标签页"+index);
			var menuNodeSize = $('#tt').tree('getRoots').length;
			for (var i=0;i<menuNodeSize;i++)
			{	
				var menuNode = $('#tt').tree('find',i+1);
				var menuLeafs = $('#tt').tree('getChildren',menuNode.target);
				for (var a=0;a<menuLeafs.length;a++)
				{
					var clefa = menuLeafs[a];
					var clefaTitle = $(menuLeafs[a]).attr("text");
					if( title == clefaTitle){
						//alert("当前选中菜单"+clefaTitle);
						$('#tt').tree('expandAll',menuNode.target);
						$('#tt').tree('select',clefa.target);
					}
				}
			}
		},
		onClose:function(title,index){
			//根据title移除
			$('#tab').tabs('close',title);
		},
		/*绑定右键菜单*/
		onContextMenu:function(e, title,index){
			
			var itemLefa1 = $('#menu1');
			var itemLefa2 = $('#menu2');
			var itemLefa3 = $('#menu3');
			$('#mm').menu('removeItem', itemLefa1);
			$('#mm').menu('removeItem', itemLefa2);
			$('#mm').menu('removeItem', itemLefa3);
			
			e.preventDefault();
			$('#mm').menu('appendItem', {
				id:'menu1',
				text: '关闭当前标签页',
				onclick: function(){
					var tab = $('#tab').tabs('getSelected');
					var index = $('#tab').tabs('getTabIndex',tab);
					if(index==0){
						return ;
					}
					
					$('#tab').tabs('close',title);
				}
			});
			$('#mm').menu('appendItem', {
				id:'menu2',
				text: '关闭其他标签页',
				onclick: function(){
					var totalSize = 0;
					var menuNodeSize = $('#tt').tree('getRoots').length;
					for (var i=0;i<menuNodeSize;i++)
					{	
						var menuNode = $('#tt').tree('find',i+1);
						var menuLeafs = $('#tt').tree('getChildren',menuNode.target);
						totalSize += menuLeafs.length;
					}
					for (var a = 0; a < menuNodeSize; a++) {
						var leaf = $('#tt').tree('find',a+1);
						for (var s=0;s<menuLeafs.length;s++){
							var lefaChild = $('#tt').tree('getChildren',leaf.target);
							var clefaTitle = $(lefaChild[s]).attr("text");
							if(title != clefaTitle){
								$('#tab').tabs('close',clefaTitle);
							}
						}	
					}
				}
			});
			$('#mm').menu('appendItem', {
				id:'menu3',
				text: '关闭当前左边标签页',
				onclick: function(){
					var tab = $('#tab').tabs('getSelected');
					var index = $('#tab').tabs('getTabIndex',tab);
					for (var s = index-1;s > 0 ;s--){
						//alert(s);						
						$('#tab').tabs('close',s);
					}
				}
			});
			
			$('#mm').menu('show', {
				left: e.pageX,
				top: e.pageY
			});
		}
	});
});
/*添加标签页*/
function addTab(opts){
	var tabExist = $('#tab').tabs('exists',opts.title);
	if(tabExist){
		$('#tab').tabs('select',opts.title);
		return ;
	}
	$('#tab').tabs('add',opts);
};




var menudata = [
	{
		"id": 1,
		"text": "用户管理",
		"state": "closed",
		"checked": false,
		"attributes": null,
		"url": "/user/manage",
		"iconCls": null,
		"pid": 0,
		"children": [
			{
				"text": "用户添加",
				"state": "open",
				"checked": false,
				"attributes": null,
				"url": "/user/add",
				"pid": 1,
			},
			{
				"id": 3,
				"text": "用户删除",
				"state": "closed",
				"checked": false,
				"attributes": null,
				"url": "/user/del",
				"iconCls": null,
				"pid": 1,
				"openMode": null
			},
			{
				"id": 4,
				"text": "用户查询",
				"state": "closed",
				"checked": false,
				"attributes": null,
				"url": "/user/list",
				"iconCls": null,
				"pid": 1,
				"openMode": null
			}
		],
		"openMode": null
	},
	{
		"id": 5,
		"text": "角色管理",
		"state": "closed",
		"checked": false,
		"attributes": null,
		"url": "/role/manage",
		"iconCls": null,
		"pid": 0,
		"children": [
			{
				"id": 6,
				"text": "角色添加",
				"state": "closed",
				"checked": false,
				"attributes": null,
				"url": "/role/add",
				"iconCls": null,
				"pid": 5,
				"openMode": null
			},
			{
				"id": 7,
				"text": "角色删除",
				"state": "closed",
				"checked": false,
				"attributes": null,
				"url": "/role/del",
				"iconCls": null,
				"pid": 5,
				"openMode": null
			},
			{
				"id": 8,
				"text": "角色查询",
				"state": "closed",
				"checked": false,
				"attributes": null,
				"url": "/role/list",
				"iconCls": null,
				"pid": 5,
				"openMode": null
			}
		],
		"openMode": null
	},
	{
		"id": 9,
		"text": "菜单管理",
		"state": "closed",
		"checked": false,
		"attributes": null,
		"url": "/menu/manage",
		"iconCls": null,
		"pid": 0,
		"children": [
			{
				"id": 10,
				"text": "菜单添加",
				"state": "closed",
				"checked": false,
				"attributes": null,
				"url": "/menu/add",
				"iconCls": null,
				"pid": 9,
				"openMode": null
			},
			{
				"id": 11,
				"text": "菜单删除",
				"state": "closed",
				"checked": false,
				"attributes": null,
				"url": "/menu/del",
				"iconCls": null,
				"pid": 9,
				"openMode": null
			},
			{
				"id": 12,
				"text": "菜单查询",
				"state": "closed",
				"checked": false,
				"attributes": null,
				"url": "/menu/list",
				"iconCls": null,
				"pid": 9,
				"openMode": null
			}
		],
		"openMode": null
	},
	{
		"id": 13,
		"text": "运维管理",
		"state": "closed",
		"checked": false,
		"attributes": null,
		"url": "/operation/manage",
		"iconCls": null,
		"pid": 0,
		"children": [
			{
				"id": 14,
				"text": "日志查询",
				"state": "closed",
				"checked": false,
				"attributes": null,
				"url": "/operation/log",
				"iconCls": null,
				"pid": 13,
				"openMode": null
			},
			{
				"id": 15,
				"text": "API查询",
				"state": "closed",
				"checked": false,
				"attributes": null,
				"url": "/swagger-ui.html",
				"iconCls": null,
				"pid": 13,
				"openMode": null
			}
		],
		"openMode": null
	}
];
</script>

</html>