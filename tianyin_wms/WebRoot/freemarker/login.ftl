﻿<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta charset="utf-8">
  <!-- Title and other stuffs -->
  <title>登录-天音演艺管理系统</title> 
  <meta name="keywords" content="天音演艺管理系统" />
  <meta name="description" content="天音演艺管理系统" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="author" content="">
  <!-- Stylesheets -->
  <link href="${rc.contextPath}/style/bootstrap.css" rel="stylesheet">
  <link rel="stylesheet" href="${rc.contextPath}/style/font-awesome.css">
  <link href="${rc.contextPath}/style/style.css" rel="stylesheet">
  <link href="${rc.contextPath}/style/bootstrap-responsive.css" rel="stylesheet">
  <!-- HTML5 Support for IE -->
  <!--[if lt IE 9]>
  <script src="js/html5shim.js"></script>
  <![endif]-->
  <!-- Favicon -->
  <link rel="shortcut icon" href="${rc.contextPath}/img/favicon/favicon.png">
</head>

<body>

<!-- Form area -->
<div class="admin-form">
  <div class="container">

    <div class="row">
      <div class="col-md-12">
        <!-- Widget starts -->
            <div class="widget worange">
              <!-- Widget head -->
              <div class="widget-head">
                <i class="icon-lock"></i> 登陆 
              </div>

              <div class="widget-content">
                <div class="padd">
                  <!-- Login form -->
                  <form class="form-horizontal" action="${rc.contextPath}/tologin" method="post">
                    <!-- Email -->
                    <div class="form-group">
                      <label class="control-label col-lg-3" for="inputEmail">用户名</label>
                      <div class="col-lg-9">
                        <input name="username" required type="text" class="form-control" id="inputEmail" placeholder="请输入用户名">
                      </div>
                    </div>
                    <!-- Password -->
                    <div class="form-group">
                      <label class="control-label col-lg-3" for="inputPassword">密码</label>
                      <div class="col-lg-9">
                        <input type="password" required name="password" class="form-control" id="inputPassword" placeholder="请输入密码">
                      </div>
                    </div>
                    <div class="col-lg-9 col-lg-offset-2">
						<button type="submit" class="btn btn-danger">登陆</button>
					</div>
                    <br />
                  </form>
				  
				</div>
                </div>
              
            
            </div>  
      </div>
    </div>
  </div> 
</div>
	
		

<!-- JS -->
<script src="js/jquery.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>