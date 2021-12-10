<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2021-12-09
 * Time: 17:24
 */

namespace app\api\controller;


use app\api\model\User;
use app\common\ApiErrDesc;
use app\common\ResponseJson;
use Firebase\JWT\JWT;

class Login
{
    use ResponseJson;
    public function login(){
        $info=request()->param();
//        return 111;
        if(empty($info) || empty($info['username']) || empty($info['password'])) return $this->ErrJson(ApiErrDesc::ERR_NULL);
        $db=new User();
//        $name=$info['username'];
        $res = $db->where('username',$info['username'])->find();
        if(empty($res)) return $this->ErrJson(ApiErrDesc::ERR_USERNAME);

//        验证密码

       $p=payload;
       $p['uid']=$res['id'];
       $res['token']=JWT::encode($p,jwt_key,jwt_HS);

        return $this->SuccessJson($res);
//        return json($res);
    }
}