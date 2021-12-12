<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2021-12-12
 * Time: 16:22
 */

namespace app\api\controller;


use app\BaseController;
use think\facade\Db;

class Auth extends BaseController
{
    public function index(){
        $db=Db::name('auth_rule');
        $data=$db->select()->toArray();
        return SuccessJson($data);
    }

}