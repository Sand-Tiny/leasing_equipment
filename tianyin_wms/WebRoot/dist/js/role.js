//新增角色
//
//










(function(){//角色配置 checked or role验证
$('')

$('input[type="checkbox"]').click(function(){
	if($(this).is(":checked")){
	  $(this).parents('.parent').siblings('.container').find('input[type="checkbox"]').prop('checked',function(){
	    return true;
	  })
	}else{
	   $(this).parents('.parent').siblings('.container').find('input[type="checkbox"]').prop('checked',function(){
	    return false;
	  })
	}
	if($(this).parents('.checked_title').find('input[type="checkbox"]').length==$(this).parents('.checked_title').find('input[type="checkbox"]:checked').length){
	  $(this).parents('.checked_title').siblings('.parent').find('input[type="checkbox"]').prop('checked',function(){
	    return true
	  })
	}else{
	  $(this).parents('.checked_title').siblings('.parent').find('input[type="checkbox"]').prop('checked',function(){
	    return false
	  })
	}
	if($('input[type="checkbox"]').parents('.checked_title').siblings('.parent').find('input[type="checkbox"]').length==$('input[type="checkbox"]').parents('.checked_title').siblings('.parent').find('input[type="checkbox"]:checked').length){
	      $('.quanbu').prop('checked',function(){
	        return true
	      })
	  }else{
	    $('.quanbu').prop('checked',function(){
	        return false
	      })
	  }
});
  checkbox();
function checkbox(){
	$('.checked_title').each(function(){
	    if($(this).find('input').length==$(this).find('input[type="checkbox"]:checked').length){
	      $(this).siblings('.parent').find('input').prop('checked',function(){
	          return true
	      })
	      $('.quanbu').prop('checked',function(){
	          return true
	      })
	    }else{
	      $(this).siblings('.parent').find('input').prop('checked',function(){
	          return false
	      })
	      $('.quanbu').prop('checked',function(){
	          return false
	      })
	    }
	})
};
})();
