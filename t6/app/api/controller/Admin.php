<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2021-12-14
 * Time: 9:43
 */

namespace app\api\controller;


use app\BaseController;
use app\common\ApiErrDesc;
use think\facade\Db;
use app\api\model\Admin as AdminModel;

class Admin extends BaseController
{
    public function index(){
        $page=$this->request->param('page');
        $limit=$this->request->param('limit');
        $query=$this->request->param('query');
        $db=new AdminModel();

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
    public function getList(){
        $list=Db::name('auth_group')->select()->toArray();
        return SuccessJson($list);
    }
    public function add(){
        $info=$this->request->param();
        if(empty($info['username'])) return ErrJson(ApiErrDesc::ERR_UPDATE);
        if(empty($info['password'])) return ErrJson(ApiErrDesc::ERR_UPDATE);
        $db=new AdminModel();
        $isname=$db->where('username',$info['username'])->find();
//        var_dump(empty($isname));exit;
        if(!empty($isname)) return ErrJson(ApiErrDesc::ERR_REPEAT);
        $info['create_time']=time();
        $info['password']=password_hash($info['password'],PASSWORD_DEFAULT );
        $res=$db->save($info);
        if($res){
            return SuccessJson();
        }else{
            return ErrJson(ApiErrDesc::ERR_ADD);
        }
    }

    public function edit(){
        $info=$this->request->param();
        $id=$this->request->param('id');
        if(empty($id)) return ErrJson(ApiErrDesc::ERR_PARAMS);
        if(empty($info['username'])) return ErrJson(ApiErrDesc::ERR_PARAMS);
        if(empty($info['password'])) return ErrJson(ApiErrDesc::ERR_PARAMS);
        unset($info['create_time']);
        unset($info['id']);
        $db=new AdminModel();
        $res=$db->where('id',$id)->save($info);
        if($res){
            return SuccessJson();
        }else{
            return ErrJson(ApiErrDesc::ERR_UPDATE);
        }
    }
    public function editStatus(){
        $id=$this->request->param('id');
        $info['status']=$this->request->param('status');
        if(empty($id)) return ErrJson(ApiErrDesc::ERR_PARAMS);
        $db=new AdminModel();
        $res=$db->where('id',$id)->save($info);
        if($res){
            return SuccessJson();
        }else{
            return ErrJson(ApiErrDesc::ERR_UPDATE);
        }
    }
    public function delete(){
        $id=$this->request->param('id');
        if(empty($id)) return ErrJson(ApiErrDesc::ERR_PARAMS);

        $db=new AdminModel();
//        var_dump($db->where('id',$id)->find());exit;
        if($db->where('id',$id)->delete()){
            return SuccessJson();
        }else{
            return ErrJson(ApiErrDesc::ERR_DELETE);
        }
    }
}