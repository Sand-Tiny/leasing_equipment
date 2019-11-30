<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta charset="utf-8">
  <!-- Title and other stuffs -->
  <title>订单管理-天音演艺管理系统</title> 
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="author" content="">
  <!-- Stylesheets -->
  <link href="${rc.contextPath}/style/bootstrap.css" rel="stylesheet">
  <!-- Font awesome icon -->
  <link rel="stylesheet" href="${rc.contextPath}/style/font-awesome.css"> 
  <!-- jQuery UI -->
  <link rel="stylesheet" href="${rc.contextPath}/style/jquery-ui.css"> 
  <!-- Calendar -->
  <link rel="stylesheet" href="${rc.contextPath}/style/fullcalendar.css">
  <!-- prettyPhoto -->
  <link rel="stylesheet" href="${rc.contextPath}/style/prettyPhoto.css">  
  <!-- Star rating -->
  <link rel="stylesheet" href="${rc.contextPath}/style/rateit.css">
  <!-- Date picker -->
  <link rel="stylesheet" href="${rc.contextPath}/style/bootstrap-datetimepicker.min.css">
  <!-- CLEditor -->
  <link rel="stylesheet" href="${rc.contextPath}/style/jquery.cleditor.css"> 
  <!-- Uniform -->
  <!-- <link rel="stylesheet" href="${rc.contextPath}/style/uniform.default.css">  -->
  <!-- Bootstrap toggle -->
  <link rel="stylesheet" href="${rc.contextPath}/style/bootstrap-switch.css">
  <!-- Main stylesheet -->
  <link href="${rc.contextPath}/style/style.css" rel="stylesheet">
  <!-- Widgets stylesheet -->
  <link href="${rc.contextPath}/style/widgets.css" rel="stylesheet">   
    <style>
	.bg_01{
	background-color:#ddd;
	}
	.bg_02{
	background-color:rgba(61,169,93,0.5);
	}
  .out{
    <!--border-bottom: 10px solid #000079;-->
  }
    #tebles{
    border:1px solid black;
    }
    #tebles th,#tebles td{
    text-align:center;
	border-color:1px solid black;
    }
    .butt{
        fon-siz16px;
        padding:15px 15px 15px 0;
    }
    .ta_title{
    fon-size:20px;
    font-weight:bold;
    padding:15px 0;
    }
    .form-group{
        padding-right:5px;
    }
    #out{
        padding-top:30px;
    }
   #out .form-group{
     width:20%;
    display: inline-block;
   }
   .widts{
   width:50%;
   display: inline-block;
   }
   .out table th:nth-child(even), out table td:nth-child(even){
    <#if role='admin'>width:20%</#if>
    <#if role!='admin'>width:30%</#if>
   }
   .out table th:nth-child(odd), out table td:nth-child(odd){
   <#if role='admin'>width:20%</#if>
    <#if role!='admin'>width:30%</#if>
   }
  </style>
  <!-- HTML5 Support for IE -->
  <!--[if lt IE 9]>
  <script src="js/html5shim.js"></script>
  <![endif]-->

  <!-- Favicon -->
  <link rel="shortcut icon" href="${rc.contextPath}/img/favicon/favicon.png">
</head>

<body>
<!-- Header starts -->
  <header>
    <div class="container">
      <div class="row">

        <!-- Logo section -->
        <div class="col-md-4">
          <!-- Logo. -->
          <div class="logo">
            <h1><a href="${rc.contextPath}/">天音演艺<span class="bold"></span></a></h1>
          </div>
          <!-- Logo ends -->
        </div>

        <!-- Button section -->
        <div class="col-md-4 text-center ">
        <#if role='admin'>
         <div class="col-md-10 fon-siz">
             <a href="${rc.contextPath}/inventory/all" class="btn btn-primary btn-lg " role="button">设备管理</a>
             <a href="${rc.contextPath}/order/query" class="btn btn-primary btn-lg " role="button">订单管理</a>
         </div>
        </#if>
        </div>
      </div>
    </div>
  </header>

<!-- Header ends -->

<!-- Main content starts -->

<div class="content">
        <!-- Main bar -->
  <!-- <div class="mainbar"> -->
      <div class="page-head">
          <div class="bread-crumb">
            当前位置：
            <a href="#">订单管理</a> 
          </div>
          <div class="clearfix"></div>
        </div>
      <div class="content content_padd">
      <div class="col-md-12" style="padding:20px 0 10px">
        <div class="widget-foot">
        <form class="form-inline" role="form">
          <input type="hidden" name="page" value="${page!1}"/>
          <input type="hidden" name="pageSize" value="${pageSize!20}"/>
          <div class="form-group">
            <div class="input-group form_datetime">
              <div class="input-group-addon">开始日期</div>
              <input class="form-control" name="startDate" onClick="WdatePicker()" <#if startDate??>value="${startDate?string("yyyy-MM-dd")}"</#if> readonly type="text" placeholder="开始日期">
            </div>
          </div>
          <div class="form-group">
            <div class="input-group form_datetime">
              <div class="input-group-addon">结束日期</div>
              <input class="form-control" name="endDate" onClick="WdatePicker()" <#if endDate??>value="${endDate?string("yyyy-MM-dd")}"</#if> readonly type="text" placeholder="结束日期">
            </div>
          </div>
            <div class="form-group">
            <div class="input-group">
              <div class="input-group-addon">客户名称</div>
              <input class="form-control" name="consumerName" value="${consumerName}" type="text" placeholder="客户名称">
            </div>
          </div>
          <#if role='admin'>
              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-addon">状态</div>
                    <select name="status" class="form-control">
                            <option value=''>-全部-</option>
                            <option <#if status=1>checked</#if> value="1">未结算</option>
                            <option <#if status=2>checked</#if> value="2">已结算</option>
                    </select>
                </div>
              </div>
          </#if>
      <button type="submit" class="btn btn-primary">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <#if role='admin'>
      <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal">新增</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </#if>
      <button type="button" class="btn btn-primary" onClick="javascript:print();">打印</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <button type="button" class="btn btn-primary" onClick="javascript:exportExcel();">导出Excel</button>
    </form>
      </div>
      </div>
      <div class="widget" style="width: 1110px;">
	  
      <#list orders.data as order>
             <div class="out <#if order_index%2=0>bg_01<#else>bg_02</#if>" <#if order.status=2>style="color:red"</#if>>
                <div class="text-left ta_title" >
                    <span class="order_id">ID：${order.orderId!''}</span>&nbsp;&nbsp;
                    <span>时间：<#if (order.appointDate)??>${order.appointDate?string("yyyy-MM-dd")}</#if></span>&nbsp;&nbsp;
                    <span>地点：${order.appointAddress!''}</span>&nbsp;&nbsp;
                    <span>客户：${order.consumerName!''}</span>&nbsp;&nbsp;
                    <span>电话：${order.consumerPhone!''}</span>&nbsp;&nbsp;
                    <#if role='admin'>
                    <span>合计：${order.sumMoney?string(',###.00')}</span>&nbsp;&nbsp;
                    <span>状态：
                        <span class="status">
                            <#if order.status=1>未结算
                            <#elseif order.status=2>已结算
                            <#elseif order.status=4>已删除
                            <#else>
                            </#if>
                        </span>
                    </span>&nbsp;&nbsp; 
                    <#if order.status=1>
                        <a class="btn btn-default" onClick="updateStatus(this, ${order.orderId!0}, 2)">结算</a>
                        <a class="btn btn-default"  onClick="delcfm(this, '${rc.contextPath}/order/updateStatus?orderId=${order.orderId!0}&status=4')">删除</a>
                    <#elseif order.status=2>
                        <a class="btn btn-default" onClick="updateStatus(this, ${order.orderId!0}, 1)">未结算</a>
                        <a class="btn btn-default" style="display:none" onClick="delcfm(this, '${rc.contextPath}/order/updateStatus?orderId=${order.orderId!0}&status=4')">删除</a>
                    <#else>
                    </#if>
                    <a class="btn btn-default" onClick="addItem(this, ${order.orderId!0})">添加</a>
                    </#if>
                </div>
                <table class="table table-bordered" style="" id="tebles">
                <thead>
                    <tr>
                        <th >名称</th>
                      <#if role='admin'>
                        <th >价格</th>
                      </#if>
                        <th >数量</th>
                        <th >当日剩余数量</th>
                      <#if role='admin'>
                        <th >小计</th>
                      </#if>
                      <#if role='admin'>
                        <th >操作</th>
                      </#if>
                    </tr>
                    </thead>
                    <tbody>
                    <#list order.items as item>
                    <tr>
                        <td>${item.inventoryName!'--'}</td>
                      <#if role='admin'>
                        <td><dd class="price" ondblclick="ShowElement(this, ${order.orderId!0}, ${item.inventoryId!'0'})">${item.price?string(',##0.00')}</dd></td>
                      </#if>
                        <td><dd class="quantity" ondblclick="ShowElement(this, ${order.orderId!0}, ${item.inventoryId!'0'})">${item.quantity?string(',##0')}</dd></td>
                        <td>${item.remanQuantity?string(',##0')}</td>
                      <#if role='admin'>
                        <td>${item.subtotal?string(',##0.00')}</td>
                      </#if>
                      <#if role='admin'>
                        <td>
                            <a class="btn btn-default" onClick="delItem(${item.orderId!0}, ${item.inventoryId!0})">删除</a>
                        </td>
                      </#if>
                    </tr>
                    </#list>
                    </tbody>
                </table>
                </div>
         </#list>
          <p class="text-right butt" style="padding-right: 40px;">
          <span>总条数：${summarize.totalCount?string(',##0')}</span>&nbsp;&nbsp;&nbsp;&nbsp;
          <#if role='admin'>
            <span>结算条数：${summarize.paidCount?string(',##0')}</span>&nbsp;&nbsp;&nbsp;&nbsp;
            <span>未结算条数：${summarize.notpaidCount?string(',##0')}</span>&nbsp;&nbsp;&nbsp;&nbsp;
            <span>总金额：${summarize.totalMoney?string(',##0.00')}</span>&nbsp;&nbsp;&nbsp;&nbsp;
            <span>结算金额：${summarize.paidMoney?string(',##0.00')}</span>&nbsp;&nbsp;&nbsp;&nbsp;
            <span>未结算金额：${summarize.notpaidMoney?string(',##0.00')}</span>
          </#if>
          </p>
          <div class="widget-foot">
              ${pg(orders.total, page, pageSize)}
              <div class="clearfix"></div> 
          </div>
      </div>
    </div>
 </div>
<!-- </div> -->
<!-- Modal催收管理-->
<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
  <div class="modal-dialog" role="document" style="width:60%">
    <div class="modal-content">
      <div class="out" id="out">
      <form action="${rc.contextPath}/order/save" method="post">
        <div class="text-center model_top" >
           <input type="hidden" name="status" value="1"/>
          <div class="form-group">
            <div class="input-group">
              <div class="input-group-addon">时间</div>
              <input class="form-control" onClick="WdatePicker()" name="appointDate" required type="date" readonly placeholder="时间">
            </div>
          </div>
           <div class="form-group">
            <div class="input-group">
              <div class="input-group-addon">地点</div>
              <input class="form-control" name="appointAddress" type="text" placeholder="地点">
            </div>
          </div>
           <div class="form-group">
            <div class="input-group">
              <div class="input-group-addon">客户</div>
              <input class="form-control" name="consumerName" required type="text" placeholder="客户">
            </div>
          </div>
           <div class="form-group">
            <div class="input-group">
              <div class="input-group-addon">电话</div>
              <input class="form-control" name="consumerPhone" type="text" placeholder="电话">
            </div>
          </div>
        </div>
        <table class="table table-bordered" id="tebles">
        <thead>
            <tr>
                <th >名称</th>
                <th >价格</th>
                <th >数量</th>
            </tr>
            </thead>
            <tbody id="add_item">
            <tr id="clone_1" class='item-row'>
                <td><select class="form-control widts" name="items[0].inventoryId">
                        <option value="0">--请选择--</option>
                    <#list inventorys as inventory>
                        <option value="${inventory.id}" price=${inventory.price} inventoryName=${inventory.name}>${inventory.name}</option>
                    </#list>
                </select></td>
                <td><input required class="form-control widts" name="items[0].price" type="number" placeholder="价格"/></td>
                <input name="items[0].inventoryName" type="hidden"/>
                <td><input required class="form-control widts" name="items[0].quantity" type="number" placeholder="数量"/>
				<button type="button" class="btnAdd001 btn-primary" style="margin:0 10px" data-toggle="modal" data-target="#modal">+</button>
				</td>
            </tr>
            </tbody>
        </table>
        <p class="text-right butt" >
            <input type="submit" class="btn btn-default" value="保存"/>&nbsp;&nbsp;&nbsp;&nbsp;
        </p>
        </form>
      </div>
    </div>
  </div>
</div>
<footer>
  <div class="container">
    <div class="row">
      <div class="col-md-12">
            <!-- Copyright info -->
            <p class="copy">Copyright &copy; 2012 | <a href="${rc.contextPath}/#">Your Site</a> </p>
      </div>
    </div>
  </div>
</footer>

<!-- 信息删除确认 -->  
<div class="modal fade" id="delcfmModel">  
  <div class="modal-dialog">  
    <div class="modal-content message_align">  
      <div class="modal-header">  
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>  
        <h4 class="modal-title">提示信息</h4>  
      </div>  
      <div class="modal-body">  
        <p>您确认要删除吗？</p>  
      </div>  
      <div class="modal-footer">  
         <input type="hidden" id="url"/>  
         <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>  
         <a  onclick="urlSubmit()" class="btn btn-success" data-dismiss="modal">确定</a>  
      </div>  
    </div><!-- /.modal-content -->  
  </div><!-- /.modal-dialog -->  
</div><!-- /.modal -->

<!-- item添加对话框 -->  
<div class="modal fade" id="addItemModel">  
  <div class="modal-dialog">  
    <div class="modal-content message_align">  
      <div class="modal-header">  
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>  
        <h4 class="modal-title">添加条目</h4>  
      </div>  
      <div class="modal-body">
      <table class="table table-bordered">
        <thead>
            <tr>
                <th >名称</th>
                <th >价格</th>
                <th >数量</th>
            </tr>
            </thead>
            <tbody>
            <tr class='item-row'>
                <td style="width:260px;"><select id="itemSelect" class="form-control widts">
                    <option value="0">--请选择--</option>
                    <#list inventorys as inventory>
                        <option value="${inventory.id}" price=${inventory.price} inventoryName=${inventory.name}>${inventory.name}</option>
                    </#list>
                </select></td>
                <td><input id="addPrice" required class="form-control widts" type="number" placeholder="价格"/></td>
                <td><input id="addQuantity" required class="form-control widts" type="number" placeholder="数量"/>
                </td>
            </tr>
            </tbody>
        </table>
      </div>  
      <div class="modal-footer">  
         <input type="hidden" id="url"/>  
         <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>  
         <a  onclick="doAddItem()" class="btn btn-success">添加</a>  
      </div>  
    </div><!-- /.modal-content -->  
  </div><!-- /.modal-dialog -->  
</div><!-- /.modal -->
    
<script src="${rc.contextPath}/js/jquery.js"></script> <!-- jQuery -->
<script src="${rc.contextPath}/js/bootstrap.js"></script> <!-- Bootstrap -->
<script src="${rc.contextPath}/js/jquery-ui-1.9.2.custom.min.js"></script> <!-- jQuery UI -->
<script src="${rc.contextPath}/js/custom.js"></script> <!-- Custom codes -->
<script src="${rc.contextPath}/js/bootstrap-datetimepicker.min.js"></script> <!-- Custom codes -->
<script src="${rc.contextPath}/js/bootstrap-datetimepicker.js"></script> <!-- Custom codes -->
<script src="${rc.contextPath}/js/WdatePicker.js"></script> <!-- Custom codes -->
<script src="${rc.contextPath}/js/jquery.jqprint/jquery.jqprint-0.3.js"></script> <!-- Custom codes -->
<script src="${rc.contextPath}/js/jquery.jqprint/jquery-migrate-1.1.0.js"></script> <!-- Custom codes -->
<script>

var $curnode;
var optOrderId;

$(function(){
var index = 1;
$('#add_item').delegate('.btnAdd001','click',function(){
var _tr=$('#clone_1').clone().removeAttr('id');
var _new_tr = $(_tr).find('button').removeClass('btnAdd001').addClass('btnDel002').html('-').parent().parent();
$(this).parent().parent().parent().append(_new_tr);
refreshItemIndex();
}).delegate('.btnDel002','click',function(){
$(this).parent().parent().remove();
refreshItemIndex();
})
function refreshItemIndex(){
        $(".item-row").each(function(index){
        $(this).find("[name$='inventoryId']").attr("name", "items[" + index + "].inventoryId");
        $(this).find("[name$='inventoryName']").attr("name", "items[" + index + "].inventoryName");
        $(this).find("[name$='price']").attr("name", "items[" + index + "].price");
        $(this).find("[name$='quantity']").attr("name", "items[" + index + "].quantity");
    });
    $('select').unbind("change");
    $('select').bind("change", function(){
        var price = $(this).find('option:selected').attr('price');
        var pricenode = $(this).parents('tr').find('input:first');
        pricenode.val(price);
        var name = $(this).find('option:selected').attr('inventoryName');
        var namenode = $(this).parents('tr').find("[name$='inventoryName']");
        namenode.attr("value", name);
    });
}
$('select').change(function(){
      var price = $(this).find('option:selected').attr('price');
      var pricenode = $(this).parents('tr').find('input:first');
      pricenode.val(price);
      var name = $(this).find('option:selected').attr('inventoryName');
      var namenode = $(this).parents('tr').find("[name$='inventoryName']");
      namenode.attr("value", name);
});
})
function changePage(page){
    var search = location.search;
    if (search.indexOf("page=") != -1) {
        location.href=location.pathname + search.replace(/page=\d+/g,'page=' + page);
    } else {
        if (search.indexOf("?") != -1) {
            location.href = location.pathname + search + "&page=" + page;
        } else {
            location.href = location.pathname + search + "?page=" + page;
        }
    }
}
function turnPage() {
    var page = $(".stage_page_in").val();
    if (undefined != page && 0 < page.length && /^\d+$/.test(page.trim())) {
        page = page.replace(/\D/g,'');
        changePage(page)
    } else
        alert("请输入正确的页码");
}

function delcfm(element, url) {  
    $curnode = $(element);
    $('#url').val(url);//给会话中的隐藏属性URL赋值  
    $('#delcfmModel').modal();  
}  
function urlSubmit(){  
    var url=$.trim($("#url").val());//获取会话中的隐藏属性URL  
    $.get(url);
    var statusEle = $curnode.parent().find(".status");
    $(statusEle).text('已删除');
    $curnode.hide();
    $curnode.prev().hide();
}  
function print(){
var content = $('.widget');
$(content).find('.order_id').remove();
    $(content).jqprint();
}

function exportExcel(){
    var url = '${rc.contextPath}/order/export?startDate=' + $("[name='startDate']").val() + 
    '&endDate=' + $("[name='endDate']").val() + '&consumerName=' + $("[name='consumerName']").val() + 
    '&status=' + $("[name='status']").val();
    window.open(url);
}

function addItem(element, orderId) {
    console.log('addItem: ', element, orderId);
    optOrderId = orderId;
    $('#addItemModel').modal();
}

function doAddItem(){
    var $select = $('#itemSelect');
    var inventoryId = $select.find("option:selected").val();
    var inventoryName = $select.find("option:selected").text();
    var price = $('#addPrice').val();
    var quantity = $('#addQuantity').val();
    var param = {
        orderId: optOrderId,
        inventoryId: inventoryId,
        inventoryName: inventoryName,
        price: price,
        quantity: quantity
    }
    $.post("${rc.contextPath}/order/addItem", param, function(res){
        if(res > 0){
            alert('添加成功！');
            location.reload();
        }else{
            alert('添加失败！');
        }
    });
}

function delItem(orderId, inventoryId){
    console.log('delItem: ', orderId, inventoryId);
    var status = confirm("确定要删除吗？");
    if(!status){
        return;
    }
    $.post("${rc.contextPath}/order/deleteItem", { orderId: orderId, inventoryId: inventoryId},function(res){
        console.log(res);
        if(res > 0){
            alert('删除成功！');
            location.reload();
        }else{
            alert('删除失败！');
        }
    });
}

function updateStatus(element, orderId, status) {
    $.post("${rc.contextPath}/order/updateStatus", { orderId: orderId, status: status} );
    var statusEle = $(element).parent().find(".status");
    //alert(statusEle);
    if (status == 1) {
        console.info(statusEle);
        //statusEle.innerHTML = '未结算';
        $(statusEle).text('未结算');
        var $ahref = $(element);
        $ahref.text("已结算");
        $ahref.next().show();
        $ahref.attr('onClick', 'updateStatus(this, ' + orderId + ', 2)');
    }
    if (status == 2) {
        console.info(statusEle);
        //statusEle.innerHTML = '已结算';
        $(statusEle).text('已结算');
        var $ahref = $(element);
        $ahref.text("未结算");
        $ahref.next().hide();
        $ahref.attr('onClick', 'updateStatus(this, ' + orderId + ', 1)');
    }
    if (status == 4) {
        console.info(statusEle);
        //statusEle.innerHTML = '已删除';
        $(statusEle).text('已删除');
    }
    return;
}

function ShowElement(element, orderId, inventoryId) {
    var oldhtml = element.innerHTML;
    //创建新的input元素
    var newobj = document.createElement('input');
    //为新增元素添加类型
    newobj.type = 'text';
    //为新增元素添加value值
    newobj.value = oldhtml;
    //为新增元素添加光标离开事件
    newobj.onblur = function() {
        var changed = false;
        if (this.value != oldhtml && this.value != '') {
            if (/\d+/.test(this.value)) {
                changed = true;
            }
        }
        if (changed) {
            element.innerHTML = this.value;
            
            
            var $tr = $(element).parent().parent();
            var price = $tr.find(".price").text();
            var quantity = $tr.find(".quantity").text();
            $.post("${rc.contextPath}/order/updateItem", { orderId: orderId, inventoryId: inventoryId, price : price, quantity : quantity} );
            return;
        }
        element.innerHTML = oldhtml;
        //当触发时判断新增元素值是否为空，为空则不修改，并返回原有值 
    }
    //设置该标签的子节点为空
    element.innerHTML = '';
    //添加该标签的子节点，input对象
    element.appendChild(newobj);
    //设置选择文本的内容或设置光标位置（两个参数：start,end；start为开始位置，end为结束位置；如果开始位置和结束位置相同则就是光标位置）
    newobj.setSelectionRange(0, oldhtml.length);
    //设置获得光标
    newobj.focus();
}
</script>
</body>
</html>