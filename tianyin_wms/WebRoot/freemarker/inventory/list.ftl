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

    <!-- Sidebar -->
     <div class="sidebar">
        <div class="sidebar-dropdown"><a href="${rc.contextPath}/#">导航</a></div>
        <ul id="nav">
          <li><a href="${rc.contextPath}/index.html" class="open"><i class="icon-home"></i> 首页</a></li>
          <li class="has_sub"><a href="${rc.contextPath}/#"><i class="icon-list-alt"></i> 借款标审核  <span class="pull-right"><i class="icon-chevron-right"></i></span></a>
            <ul>
              <li><a class="acity" href="${rc.contextPath}/widgets1.html">未完成</a></li>
              <li><a class="acity" href="${rc.contextPath}/widgets2.html">全部</a></li>
              <li><a class="acity acity_bg" href="${rc.contextPath}/widgets3.html">统计表</a></li>
         </ul>
          </li> 
           <li class="has_sub"><a href="${rc.contextPath}/#"><i class="icon-file-alt"></i>平台借款 <span class="pull-right"><i class="icon-chevron-right"></i></span></a>
            <ul>
              <li><a class="acity" href="${rc.contextPath}/post.html">借款标审核</a></li>
              <li><a class="acity" href="${rc.contextPath}/login.html">投标中的借款</a></li>
              <li><a class="acity" href="${rc.contextPath}/register.html">还款中的借款</a></li>
              <li><a class="acity" href="${rc.contextPath}/support.html">已完成的借款</a></li>
              <li><a class="acity" href="${rc.contextPath}/invoice.html">失败的借款</a></li>
            </ul>
          </li> 
          <li class="has_sub"><a href="${rc.contextPath}/#"><i class="icon-file-alt"></i>账单管理 <span class="pull-right"><i class="icon-chevron-right"></i></span></a>
            <ul>
               <li><a class="acity" href="${rc.contextPath}/zhangdan1.html">本月到账账单</a></li>
              <li><a class="acity" href="${rc.contextPath}/yuqi.html">逾期账单</a></li>
              <li><a class="acity" href="${rc.contextPath}/huankuan.html">已还款账单</a></li>
            </ul>
          </li> 
        </ul>
    </div>

    <!-- Sidebar ends -->

        <!-- Main bar -->
    <div class="mainbar">
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
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal">新增</button>
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
                <td>${inventory.name!'--'}</td>
                <td>${inventory.price?string(',###.00')}</td>
                <td>${inventory.stock?string(',###')}</td>
                <td><a href="${rc.contextPath}/inventory/del?inventoryId=${inventory.id!'0'}">删除</a></td>
            </tr>
            </#list>
            </tbody>
        </table>
      </div>
    </div>
 </div>
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
                <td><input class="form-control widts" name="inventories[${t_index}].name" type="text" value="0"/></td>
                <td><input class="form-control widts" name="inventories[${t_index}].price" type="number" value="0"/></td>
                <td><input class="form-control widts" name="inventories[${t_index}].stock" type="number" value="0"/></td>
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
            <p class="copy">Copyright &copy; 2012 | <a href="${rc.contextPath}/#">Your Site</a> </p>
      </div>
    </div>
  </div>
</footer>   
<!-- Footer ends -->

<!-- Scroll to top -->
<span class="totop"><a href="${rc.contextPath}/#"><i class="icon-chevron-up"></i></a></span> 


<script src="${rc.contextPath}/js/jquery.js"></script> <!-- jQuery -->
<script src="${rc.contextPath}/js/bootstrap.js"></script> <!-- Bootstrap -->
<script src="${rc.contextPath}/js/jquery-ui-1.9.2.custom.min.js"></script> <!-- jQuery UI -->
<script src="${rc.contextPath}/js/custom.js"></script> <!-- Custom codes -->
</body>
</html>