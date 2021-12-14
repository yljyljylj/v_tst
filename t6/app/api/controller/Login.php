<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2021-12-09
 * Time: 17:24
 */

namespace app\api\controller;


use app\api\model\Admin;
use app\BaseController;
use app\common\ApiErrDesc;
use app\common\ResponseJson;
use Firebase\JWT\JWT;

class Login extends BaseController
{
    use ResponseJson;
    public function login(){

        $info=request()->param();
        if(empty($info) || empty($info['username']) || empty($info['password'])) return $this->ErrJson(ApiErrDesc::ERR_NULL);
        $db=new Admin();
        $res = $db->where('username',$info['username'])->find();
        if(empty($res)) return ErrJson(ApiErrDesc::ERR_USERNAME);
//        echo '数据库密码：'.$res['password'];
//        echo "<br/>";
//        echo '登陆密码：'.password_hash($info['password'],PASSWORD_DEFAULT);
        // 验证密码
//        var_dump(password_verify($info['password'],$res['password']));exit;
        if(!password_verify($info['password'],$res['password'])) return ErrJson(ApiErrDesc::ERR_PASSWORD);
//        生成jwt
       $p=payload;
       $p['uid']=$res['id'];
       $data['token']=JWT::encode($p,jwt_key,jwt_HS);
        return SuccessJson($data);
    }
}