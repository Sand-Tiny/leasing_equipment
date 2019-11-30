<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta charset="utf-8">
  <!-- Title and other stuffs -->
  <title>设备管理-天音演艺管理系统</title> 
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
  .out{
    border-bottom: 1px solid #ddd;
  }
    #tebles{
    border-top:1px solid #ddd
    }
    #tebles th,#tebles td{
    text-align:center
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
   .widts{
   width:50%;
   display: inline-block;
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
         <div class="col-md-10 fon-siz">
             <a href="${rc.contextPath}/inventory/all" class="btn btn-primary btn-lg " role="button">设备管理</a>
             <a href="${rc.contextPath}/order/query" class="btn btn-primary btn-lg " role="button">订单管理</a>
         </div>
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
            <a href="#">设备管理</a> 
          </div>
          <div class="clearfix"></div>
        </div>
      <div class="content content_padd">
      <div class="col-md-12" style="padding:20px 0 10px">
        <div class="widget-foot">
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal">新增</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <button type="button" class="btn btn-primary" onClick="javascript:print();">打印</button>
      </div>
      </div>
      <div class="widget">
        <table class="table table-bordered" style="" id="tebles">
        <thead>
            <tr>
                <th>ID</th>
                <th >名称</th>
                <th >价格</th>
                <th >数量</th>
                <th >操作</th>
            </tr>
            </thead>
            <tbody>
            <#list inventories as inventory>
            <tr>
                <td>${inventory.id!'0'}</td>
                <td><dd class="name" ondblclick="ShowElement(this, 0, ${inventory.id!'0'}, 'name')">${inventory.name!'--'}</dd></td>
                <td><dd class="price" ondblclick="ShowElement(this, 1, ${inventory.id!'0'}, 'price')">${inventory.price?string(',##0.00')}</dd></td>
                <td><dd class="stock" ondblclick="ShowElement(this, 1, ${inventory.id!'0'}, 'stock')">${inventory.stock?string(',##0')}</dd></td>
                <td><a class="btn btn-default"  onClick="delcfm('${rc.contextPath}/inventory/del?inventoryId=${inventory.id!'0'}')">删除</a></td>
            </tr>
            </#list>
            </tbody>
        </table>
      </div>
    </div>
 <!-- </div> -->
</div>
<!-- Content ends -->
<!-- Modal催收管理-->
<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
  <div class="modal-dialog" role="document" style="width:60%">
    <div class="modal-content">
      <div class="out" id="out">
      <form action="${rc.contextPath}/inventory/adds" method="post">
        <table class="table table-bordered" style="" id="tebles">
        <thead>
            <tr>
                <th >名称</th>
                <th >价格</th>
                <th >数量</th>
            </tr>
            </thead>
            <tbody>
            <#list 0..5 as t>
            <tr>
                <td><input <#if t_index = 0>required</#if> class="form-control widts" name="inventories[${t_index}].name" type="text" placeholder="设备名称"/></td>
                <td><input <#if t_index = 0>required</#if> class="form-control widts" name="inventories[${t_index}].price" type="number" placeholder="价格"/></td>
                <td><input <#if t_index = 0>required</#if> class="form-control widts" name="inventories[${t_index}].stock" type="number" placeholder="数量"/></td>
            </tr>
            </#list>
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

<!-- Footer starts -->
<footer>
  <div class="container">
    <div class="row">
      <div class="col-md-12">
            <!-- Copyright info -->
            <p class="copy">Copyright &copy; 2012 | <a href="#">Your Site</a> </p>
      </div>
    </div>
  </div>
</footer>   
<!-- Footer ends -->

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


<script src="${rc.contextPath}/js/jquery.js"></script> <!-- jQuery -->
<script src="${rc.contextPath}/js/bootstrap.js"></script> <!-- Bootstrap -->
<script src="${rc.contextPath}/js/jquery-ui-1.9.2.custom.min.js"></script> <!-- jQuery UI -->
<script src="${rc.contextPath}/js/custom.js"></script> <!-- Custom codes -->
<script src="${rc.contextPath}/js/jquery.jqprint/jquery.jqprint-0.3.js"></script> <!-- Custom codes -->
<script src="${rc.contextPath}/js/jquery.jqprint/jquery-migrate-1.1.0.js"></script> <!-- Custom codes -->
<script>
function delcfm(url) {  
    $('#url').val(url);//给会话中的隐藏属性URL赋值  
    $('#delcfmModel').modal();  
}  
function urlSubmit(){  
    var url=$.trim($("#url").val());//获取会话中的隐藏属性URL  
    window.location.href=url;   
}  
function print(){
    $(".widget").jqprint();
}

function ShowElement(element, type, id, property) {
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
            if (type == 1) {
                if (/\d+/.test(this.value)) {
                    changed = true;
                }
            } else {
                changed = true;
            }
        }
        if (changed) {
            element.innerHTML = this.value;
            
            var $tr = $(element).parent().parent();
            var name = $tr.find(".name").text();
            var price = $tr.find(".price").text();
            var stock = $tr.find(".stock").text();
            $.post("${rc.contextPath}/inventory/update", { id: id, name: name, price : price, stock : stock} );
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