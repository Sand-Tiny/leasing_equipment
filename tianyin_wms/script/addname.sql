ALTER TABLE `test`.`order_item` ADD COLUMN `inventory_name` VARCHAR(255) NULL  COMMENT '库存名称' AFTER `inventory_id`;
UPDATE `test`.`order_item` o INNER JOIN `test`.`inventory` i ON o.`inventory_id` = i.`id` SET o.`inventory_name` = i.`name`;

ALTER TABLE `test`.`order_item`   
  ADD COLUMN `order_item_id` INT(11) NOT NULL AUTO_INCREMENT  COMMENT '主键' FIRST, 
  ADD PRIMARY KEY (`order_item_id`);
