<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="easyui-layout" style="width:100%;height:100%; " data-options="border:false">
		<div data-options="region:'north'" style="height:35px" data-options="border:false">
		<div id="p" class="easyui-panel" style="padding:5px;" data-options="">当前位置 >></div>
		</div>
		<div data-options="region:'center',">
			<div>
			起始日期: <input class="easyui-datebox" style="width:80px">
			终止日期: <input class="easyui-datebox" style="width:80px">
			Language: 
			<select class="easyui-combobox" panelHeight="auto" style="width:100px">
				<option value="java">Java</option>
				<option value="c">C</option>
				<option value="basic">Basic</option>
				<option value="perl">Perl</option>
				<option value="python">Python</option>
			</select>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search">Search</a>
			</div>
			<div style="width:900px;height:400px">
			<table id="dg"  data-options="rownumbers:true,singleSelect:true,autoRowHeight:true,pagination:true,pageSize:10">
			</table>
			</div>
		</div>
	</div>


<script>
	/**/
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
                { field: 'username', title: 'username', align:'center', width: 15 },
                { field: 'nickname', title: 'nickname', align:'center', width: 15 },
                { field: 'age', title: 'age', align:'center', width: 15 },
                { field: 'phone', title: 'phone', align:'center', width: 15 },
                { field: 'sex', title: 'sex', align:'center', width: 15 ,
                	formatter: function(value,row,index){
						if (row.sex='0'){
							return "女";
						} else {
							return "男";
						}
					}	
                },
                { field: 'status', title: 'status', align:'center', width: 15 },
                { field: 'createdtime', title: 'createdtime', align:'center', width: 26 },
                { field: 'handle', title: '操作', align:'center', width: 26 ,
                	formatter: function(value,row,index){
						/* if (row.sex='0'){
							return "女";
						} else {
							return "男";
						} */
						return "<button>修改</button><button>删除</button>";
					}	
                }
            ]]
        });
		
		$('#dg').datagrid({loadFilter:pagerFilter});
		//$('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', getData());
		
	});
</script>