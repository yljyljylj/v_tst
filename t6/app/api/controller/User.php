<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2021-12-10
 * Time: 16:39
 */

namespace app\api\controller;


use app\BaseController;
use  \app\api\model\User as UserModel;
use app\common\ResponseJson;

class User extends BaseController
{
    use ResponseJson;
    public function index(){
        $db=new UserModel();
        $res=$db->select()->toArray();
//        halt($res);
        return $this->SuccessJson($res);
    }
}