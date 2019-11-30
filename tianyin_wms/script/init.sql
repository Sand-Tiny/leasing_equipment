#库存
CREATE TABLE `inventory`(  
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` VARCHAR(255) COMMENT '设备名称',
  `stock` INT(6) UNSIGNED COMMENT '设备库存',
  `price` DOUBLE(10,2) COMMENT '标准单价',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stock Keeping Unit(库存单元)';

#订单
CREATE TABLE `order`(  
  `order_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `appoint_date` datetime COMMENT '约定日期',
  `consumer_name` VARCHAR(255) COMMENT '客户名称',
  `appoint_address` VARCHAR(255) COMMENT '约定地点',
  `consumer_phone` VARCHAR(255) COMMENT '客户电话',
  `status` INT(2) NOT NULL default 1 COMMENT '订单状态 1-未结算正常订单 2-结算 4-已删除',
  `create_time` datetime COMMENT '创建时间',
  PRIMARY KEY (`order_id`)
) ENGINE=MyISAM CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='订单';

#订单详情
CREATE TABLE `order_item`(  
  `order_id` INT(11) UNSIGNED NOT NULL COMMENT '订单ID',
  `inventory_id` INT(11) UNSIGNED NOT NULL COMMENT '库存ID',
  `quantity` INT(11) UNSIGNED NOT NULL COMMENT '数量',
  `price` DOUBLE(10,2) COMMENT '实际单价'
) ENGINE=MyISAM CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='订单详情';
