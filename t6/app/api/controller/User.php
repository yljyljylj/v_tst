<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2021-12-10
 * Time: 16:39
 */

namespace app\api\controller;


use  \app\api\model\User as UserModel;
use app\BaseController;
use app\common\ApiErrDesc;
use app\common\ResponseJson;

class User extends BaseController
{
    use ResponseJson;
    public function index(){
        $page=$this->request->param('page');
        $limit=$this->request->param('limit');
        $query=$this->request->param('query');
        $db=new UserModel();
        if(isset($query) || !empty($query)){
            $db=$db->where('username','like','%'.$query.'%');
        }
        $info=$db->page($page)->limit($limit)->order('id')->select()->toArray();
        $total=$db->count('id');
        $content=[
            'code'=>ApiErrDesc::SUCCESS[0],
            'msg'=>ApiErrDesc::SUCCESS[1],
            'total'=>$total,
            'data'=>$info
        ];
        return json($content);
    }
    public function save(){
        $info=$this->request->param();
        $info['password']=password_hash($info['password'],PASSWORD_DEFAULT );
//        var_dump($info);return;
//        return $this->ErrJson(ApiErrDesc::ERR_ADD);
        $db=new UserModel();
        $res=$db->save($info);
        if($res){
            return $this->SuccessJson();
        }else{
            return $this->ErrJson(ApiErrDesc::ERR_ADD);
        }
//        var_dump($info);
    }

  public function edit(){
        $info=$this->request->param();
        if(empty($info)) return $this->ErrJson(ApiErrDesc::ERR_UPDATE);
        $data['username']=$info['username'];
        $data['password']=password_hash($info['password'],PASSWORD_DEFAULT) ;
        $data['status']=$info['status'];
        $data['groupid']=$info['groupid'];
//      var_dump($data);
        $db=new UserModel();
        $res=$db->where('id',$info['id'])->save($data);
        if($res){
            return $this->SuccessJson();
        }else{
            return $this->ErrJson(ApiErrDesc::ERR_UPDATE);
        }
    }
}