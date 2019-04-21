<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta charset="utf-8">
  <!-- Title and other stuffs -->
  <title>向右转管理系统</title> 
  <meta name="keywords" content="" />
  <meta name="description" content="" />
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
            <h1><a href="${rc.contextPath}/#">向右转风控系统<span class="bold"></span></a></h1>
            <!-- <p class="meta">后台管理系统</p> -->
          </div>
          <!-- Logo ends -->
        </div>

        <!-- Button section -->
        <div class="col-md-4 text-center ">
         <div class="col-md-10 fon-siz">
             <a href="${rc.contextPath}/#" class="btn btn-primary btn-lg " role="button">风控审核</a>
             <a href="${rc.contextPath}/#" class="btn btn-primary btn-lg " role="button">风控配置</a>
         </div>
        </div>

        <!-- Data section -->

        <div class="col-md-4 text-right fon-siz padding">
            <span href="${rc.contextPath}/#" class=" " role="button">李婷</span>
             <a href="${rc.contextPath}/#" class="" role="button">退出</a>
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
            <a href="${rc.contextPath}/index.html">系统</a> 
            <!-- Divider -->
            <span class="divider">/</span> 
            <a href="${rc.contextPath}/#" class="bread-current">借款标审核</a>
            <span class="divider">/</span>
            <a href="${rc.contextPath}/#" class="bread-current">未完成</a>
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
              <input class="form-control" name="startDate" <#if startDate??>value="${startDate?string("yyyy-MM-dd")}"</#if> type="date" placeholder="开始日期">
            </div>
          </div>
          <div class="form-group">
            <div class="input-group form_datetime">
              <div class="input-group-addon">结束日期</div>
              <input class="form-control" name="endDate" <#if endDate??>value="${endDate?string("yyyy-MM-dd")}"</#if> disabled="disabled" type="date" placeholder="结束日期">
            </div>
          </div>
            <div class="form-group">
            <div class="input-group">
              <div class="input-group-addon">客户名称</div>
              <input class="form-control" name="consumerName" value="${consumerName}" type="text" placeholder="客户名称">
            </div>
          </div>
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
      <button type="submit" class="btn btn-primary">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal">新增</button>
    </form>
      </div>
      </div>
      <div class="widget">
      <#list orders.data as order>
             <div class="out">
                <div class="text-center ta_title" >
                    <span>ID：${order.orderId!''}</span>&nbsp;&nbsp;
                    <span>时间：<#if (order.appointDate)??>${order.appointDate?string("yyyy-MM-dd")}</#if></span>&nbsp;&nbsp;
                    <span>地点：${order.appointAddress!''}</span>&nbsp;&nbsp;
                    <span>客户：${order.consumerName!''}</span>&nbsp;&nbsp;
                    <span>电话：${order.consumerPhone!''}</span>&nbsp;&nbsp;
                    <span>合计：${order.sumMoney?string(',###.00')}</span>&nbsp;&nbsp;
                    <span>状态：
                        <#if order.status=1>未结算
                        <#elseif order.status=2>已结算
                        <#elseif order.status=4>已删除
                        <#else>
                        </#if>
                    </span>&nbsp;&nbsp; 
                    <#if order.status=1>
                        <a class="btn btn-default" href="${rc.contextPath}/order/updateStatus?orderId=${order.orderId!0}&status=2">结算</a>
                        <a class="btn btn-default" href="${rc.contextPath}/order/updateStatus?orderId=${order.orderId!0}&status=4">删除</a>
                    <#elseif order.status=2>
                        <a class="btn btn-default" href="${rc.contextPath}/order/updateStatus?orderId=${order.orderId!0}&status=1">未结算</a>
                    <#else>
                    </#if>
                </div>
                <table class="table table-bordered" style="" id="tebles">
                <thead>
                    <tr>
                        <th >名称</th>
                        <th >价格</th>
                        <th >数量</th>
                        <th >小计</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list order.items as item>
                    <tr>
                        <td>${item.inventory.name!'--'}</td>
                        <td>${item.price?string(',###.00')}</td>
                        <td>${item.quantity?string(',###')}</td>
                        <td>${item.subtotal?string(',###.00')}</td>
                    </tr>
                    </#list>
                    </tbody>
                </table>
                </div>
         </#list>
                <div class="out">
                    <div class="text-center ta_title" >
                        <span>时间：2015-09-01</span>&nbsp;&nbsp;
                    <span>地点：新希望国际</span>&nbsp;&nbsp;
                    <span>客户：小波</span>&nbsp;&nbsp;
                    <span>电话：138 8888 8888</span>&nbsp;&nbsp;
                    <span>状态：已付款</span>
                    </div>
                    <table class="table table-bordered" style="" id="tebles">
                    <thead>
                        <tr>
                            <th >名称</th>
                            <th >数量</th>
                            <th >价格</th>
                            <th >小计</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>高并发编程</td>
                            <td style="text-align:center">1</td>
                            <td>99.9</td>
                            <td>99.9</td>
                        </tr>
                        <tr>
                            <td>设计模式</td>
                            <td>2</td>
                            <td>69</td>
                            <td>138</td>
                        </tr>
                        </tbody>
                    </table>
                    <p class="text-right butt" >
                        <span>合计：237.9</span>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="button" class="btn btn-default" value="结算"/>&nbsp;&nbsp;
                        <input type="button" class="btn btn-default" value="删除"/>
                    </p>
                </div>
                
                 <div class="out">
                        <div class="text-center ta_title" >
                            <span>时间：2015-09-01</span>&nbsp;&nbsp;
                            <span>地点：新希望国际</span>&nbsp;&nbsp;
                            <span>客户：小波</span>&nbsp;&nbsp;
                            <span>电话：138 8888 8888</span>&nbsp;&nbsp;
                            <span>状态：已付款</span>
                        </div>
                        <table class="table table-bordered" style="" id="tebles">
                        <thead>
                            <tr>
                                <th >名称</th>
                                <th >数量</th>
                                <th >价格</th>
                                <th >小计</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>高并发编程</td>
                                <td style="text-align:center">1</td>
                                <td>99.9</td>
                                <td>99.9</td>
                            </tr>
                            <tr>
                                <td>设计模式</td>
                                <td>2</td>
                                <td>69</td>
                                <td>138</td>
                            </tr>
                            </tbody>
                        </table>
                        <p class="text-right butt" >
                        <span>合计：237.9</span>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="button" class="btn btn-default" value="结算"/>&nbsp;&nbsp;
                        <input type="button" class="btn btn-default" value="删除"/>
                        </p>
                </div>
                
              <p class="text-right butt" >
              <span>总条数：${summarize.totalCount?string(',###')}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                <span>结算条数：${summarize.paidCount?string(',###')}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                <span>未结算条数：${summarize.notpaidCount?string(',###')}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                <span>总金额：${summarize.totalMoney?string(',###.00')}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                <span>结算金额：${summarize.paidMoney?string(',###.00')}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                <span>未结算金额：${summarize.notpaidMoney?string(',###.00')}</span>
              </p>
              <div class="widget-foot">
                  <ul class="pagination pull-right">
                    <li><a href="${rc.contextPath}/#">上一页</a></li>
                    <li><a href="${rc.contextPath}/#">1</a></li>
                    <li><a href="${rc.contextPath}/#">2</a></li>
                    <li><a href="${rc.contextPath}/#">3</a></li>
                    <li><a href="${rc.contextPath}/#">4</a></li>
                    <li><a href="${rc.contextPath}/#">下一页</a></li>
                  </ul>
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
              <input class="form-control" name="appointDate" required type="text" placeholder="时间">
            </div>
          </div>
           <div class="form-group">
            <div class="input-group">
              <div class="input-group-addon">地点</div>
              <input class="form-control" name="appointAddress" required type="text" placeholder="地点">
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
              <input class="form-control" name="consumerPhone" required type="text" placeholder="电话">
            </div>
          </div>
        </div>
        <table class="table table-bordered" style="" id="tebles">
        <thead>
            <tr>
                <th >名称</th>
                <th >价格</th>
                <th >数量</th>
            </tr>
            </thead>
            <tbody>
            <#list inventorys as t>
            <tr>
                <td><select class="form-control widts" name="items[${t_index}].inventoryId">
                        <option value="0">--请选择--</option>
                    <#list inventorys as inventory>
                        <option value="${inventory.id}" price=${inventory.price}>${inventory.name}</option>
                    </#list>
                </select></td>
                <td><input class="form-control widts" name="items[${t_index}].price" type="text" value="0"/></td>
                <td><input  class="form-control widts" name="items[${t_index}].quantity" type="text" value="0"/></td>
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
<script src="${rc.contextPath}/js/jquery.js"></script> <!-- jQuery -->
<script src="${rc.contextPath}/js/bootstrap.js"></script> <!-- Bootstrap -->
<script src="${rc.contextPath}/js/jquery-ui-1.9.2.custom.min.js"></script> <!-- jQuery UI -->
<script src="${rc.contextPath}/js/custom.js"></script> <!-- Custom codes -->
<script src="${rc.contextPath}/js/bootstrap-datetimepicker.min.js"></script> <!-- Custom codes -->
<script src="${rc.contextPath}/js/bootstrap-datetimepicker.js"></script> <!-- Custom codes -->
            
<script>
$('option').click(function(){
  var price = $(this).attr('price');
  var pricenode = $(this).parents('tr').find('input:first');
  pricenode.val(price);
});
</script>
</body>
</html>