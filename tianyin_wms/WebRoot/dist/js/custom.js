/* JS */


/* Navigation */

$(document).ready(function(){

  $(window).resize(function(){
    if($(window).width() >= 765){
      $(".sidebar #nav").slideDown(350);
    }
    else{
      $(".sidebar #nav").slideUp(350); 
    }
  });

  $("#nav > li > a").on('click',function(e){//left list slideUp
      if($(this).parent().hasClass("has_sub")) {
        e.preventDefault();
      }   

      if(!$(this).hasClass("subdrop")) {
        // hide any open menus and remove all other classes
        $("#nav li ul").slideUp(350);

        $("#nav li a").removeClass("subdrop");
        
        // open our new menu and add the open class
        $(this).next("ul").slideDown(350);
        $(this).addClass("subdrop");
      }
      
      else if($(this).hasClass("subdrop")) {
        $(this).removeClass("subdrop");
        $(this).next("ul").slideUp(350);
      } 

  });
$('.has_sub').each(function(){
    if($(this).find('a').hasClass('acity_bg')){
      $(this).find('ul').show();
      $(this).find('a').addClass('subdrop')
    }
})



  $(".sidebar-dropdown a").on('click',function(e){
      e.preventDefault();

      if(!$(this).hasClass("open")) {
        // hide any open menus and remove all other classes
        $(".sidebar #nav").slideUp(350);
        $(".sidebar-dropdown a").removeClass("open");
        
        // open our new menu and add the open class
        $(".sidebar #nav").slideDown(350);
        $(this).addClass("open");
      }
      
      else if($(this).hasClass("open")) {
        $(this).removeClass("open");
        $(".sidebar #nav").slideUp(350);
      }
  });

  $('#forms').on('click',function(){//认证修改个人信息
    if($(this).hasClass('edit')){
      $(this).removeClass('edit')
      $(this).attr('type','submit')
      $(this).replaceWith('<button type="submit" style="width: 5%;margin:30px 20px 20px 0" class="btn btn-primary btn-lg">保存</button>')
       var smsll=$('#home').find('smsll');
       var arr=['phone','hunyin','zinv','che','xianjudi','danweiname','ziwei','nianxian','zhixiqingsu','guanxi','zixi_phone','gongzuodanwei','feizixi','guanxi1','feizixi_phone','gongzuodanwei1']
       smsll.each(function(i){
        var value=$(this).html();
          $(this).replaceWith('<input type="text" name='+arr[i]+' style=" min-width:200px;width:'+$(this).width()+'px;" value="'+value+'" />')
       })
       $('#vidate').validate({
              rules: {
                 phone: {
                  required: true
                }
              },
              messages: {
                 phone: {
                    required: "请输入手机号"
                  }
               
              }
       })
    }
    // else{
    //    $(this).addClass('edit')
    //      var smsll=$('#home').find('input');
    //    $(this).html('修改');
    //      smsll.each(function(){
    //     var value=$(this).val();
    //     $(this).replaceWith('<smsll>'+value+'</smsll>')
    //    })
    // }
  })
$('.rdio_trues').click(function(){//认证弹框
  if($(this).is(":checked") && $(this).hasClass('true')){
    $('#show').show();
  }else{
    $('#show').hide();
  }
  if($(this).is(":checked") && $(this).hasClass('tongguo')){
    $('#tongguo').show();
  }else{
    $('#tongguo').hide();
  }
})
$('.imgs span.acity').each(function(){
  $(this).click(function(){
    $('.imgs span.acity').removeClass('hover')
    $(this).addClass('hover')
  })
})
$('.chi_ul').find('li').each(function(i){//table 切换
  var _this=$(this)
    $(this).click(function(){
      $('.chi_ul').find('li').removeClass('acity')
      $(this).addClass('acity')
      var mao=$(this).attr('data-mao')
      $('.maos').hide();
      $('#'+mao).show()
        if(i==0){
          $('.pag').hide()
        }else{
          $('.pag').show()
        }

      if(i==$('.chi_ul').find('li').length-1){
       $('.nex').hide()
      }else{
        $('.nex').show()
      }      
      
    })

    $('.shenheis').click(function(){//table 切换类容
        var mao=$(this).attr('href');
        $('.renz').each(function(){
          if(mao=='#'+$(this).attr('data-mao')){
            if($(mao).index()==0){
              $('.pag').hide()
            }else{

              $('.pag').show()
            }
            if($(mao).index()==i){
             $('.nex').hide()
            }else{
              $('.nex').show()
            }
            $('.renz').removeClass('acity')
            $(this).addClass('acity')
          }
        })

        $('.maos').hide();
        $(mao).show()
    })


  if($(this).hasClass('acity')){

    var mao=$(this).attr('data-mao')
      $('.maos').hide();
      $('#'+mao).show()
  }

})
$('.closes').click(function(){//关闭弹框
  $('#myModal').modal('hide')
})
 // 下一步
   $('.nex').click(function(){
    next('true')
   })
   //上一步
   $('.pag').click(function(){
    next('false')
   })

   function next(code){
     $('.renz').each(function(i){

        if($(this).hasClass('acity')){
          if(code=='true'){
            ++i 
          }else{
            --i
          }
         
           $('.renz').eq(i).click()
         $('.renz').removeClass('acity')
            $('.renz').eq(i).addClass('acity')
            
            return false;
     

        }
     })
   }
});


// 图片上传
// json 
// url:上传地址
// id:elm 
// type:add || undefined 默认undefined
// yes:function(){} 回掉函数 默认undefined
// error:function(){}回掉函数 默认undefined
// 
// 
function file(json){
 var json_extensions=json.extensions || "gif,jpg,jpeg,bmp,png";
  var uploader = WebUploader.create({
    server:json.url,
    pick: json.id,
    resize: false,
   accept :{
     title: 'Images',
    extensions: json_extensions,
    mimeTypes: 'image/*'
   }
  })
 $('.uploaer').on('click','.del',function(){
            $(this).parents('.imgs').remove();
        })
  uploader.on( 'fileQueued',function(file){
      addNode(file)
       
  })
  function addNode(file){
      var file_id=file.id;

        uploader.makeThumb( file, function( error, src ){
          if(json.type == undefined){
            uploader.removeFile( file_id );
            $(json.id).parents('.imgs').find('img').attr('src',src);
          }else{
            json.fn &&json.fn();
            
          }
          
        },170,128)
         if(json.type !=undefined && json.type==='add'){
            $('.uploaer').on('click','.del',function(){
               uploader.removeFile( file_id );
              $(this).parents('.imgs').remove();
               var aa=uploader.getStats()
               return 

          })

         }else{
            $(json.id).siblings('.del').on('click',function(){
              uploader.removeFile( file_id );
              $(json.id).parents('.imgs').remove();
              var aa=uploader.getStats()
               console.log(aa.cancelNum    )
          })
         }
  }
  //上传成功后触发事件;
      uploader.on('uploadSuccess',function( file, response ){
          if(json.yes){
            json.yes( file, response)
          }
      })
      uploader.on('uploadError',function( file, response ){
          if(json.error){
            json.error( file, response)
          }
      })
      
  uploader.on('error', function( code ) {
        var text = '';
        switch( code ) {
          case  'F_DUPLICATE' : text = '该文件已经被选择了!' ;
          break;
          case  'Q_EXCEED_NUM_LIMIT' : text = '上传文件数量超过限制!' ;
          break;
          case  'F_EXCEED_SIZE' : text = '文件大小超过限制!';
          break;
          case  'Q_EXCEED_SIZE_LIMIT' : text = '所有文件总大小超过限制!';
          break;
          case 'Q_TYPE_DENIED' : text = '文件类型不正确或者是空文件!';
          break;
          default : text = '未知错误!';
          break;  
        }
        alert( text );
    });
}
