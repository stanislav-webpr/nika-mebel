<?php

class ModelModuleComplects extends Model
{
    public function install()
    {
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "complect`");
        $this->db->query("CREATE TABLE `" . DB_PREFIX . "complect` (
          `complect_id` int(11) NOT NULL AUTO_INCREMENT,
          `product_id` int(11) NOT NULL,
          PRIMARY KEY (`complect_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8");

        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "complect_product`");
        $this->db->query("CREATE TABLE `" . DB_PREFIX . "complect_product` (
          `product_id` int(11) NOT NULL AUTO_INCREMENT,
          `complect_id` int(11) NOT NULL,
          `name` varchar(255) NOT NULL,
          `price` decimal(15,4) NOT NULL,
          `image` varchar(255) NOT NULL,
          `length` decimal(15,8) NOT NULL,
          `width` decimal(15,8) NOT NULL,
          `height` decimal(15,8) NOT NULL,
          PRIMARY KEY (`product_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8");
    }

    public function uninstall()
    {
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "complect`");
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "complect_product`");
    }
}

?>