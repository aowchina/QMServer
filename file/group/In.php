<?php
//连接db
//$con = conDb();

$link=mysql_connect('10.13.31.27','root','Ylyq130712'); 
if(!$link) echo "失败!"; 
else echo "成功!"; 
mysql_close();

?>
