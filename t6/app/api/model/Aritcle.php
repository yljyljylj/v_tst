<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2021/12/10
 * Time: 21:01
 */

namespace app\api\model;


use think\Model;

class Aritcle extends Model
{
    protected $autoWriteTimestamp = true;
    // 定义时间戳字段名
    protected $createTime = 'create_time';
    protected $updateTime = 'update_time';

}