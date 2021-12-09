<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2021-12-09
 * Time: 17:24
 */

namespace app\api\controller;


use app\api\model\User;
use app\common\ResponseJson;

class Login
{
    use ResponseJson;
    public function login(){
        $db=new User();
        $res=$db->where('username','aaaa')->find();
        return $this->SuccessJson($res);
//        return json($res);
    }
}