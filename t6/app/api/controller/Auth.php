<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2021-12-12
 * Time: 16:22
 */

namespace app\api\controller;


use app\BaseController;
use app\common\ApiErrDesc;
use think\facade\Db;

class Auth extends BaseController
{
    public function index(){
        $page=$this->request->param('page');
        $limit=$this->request->param('limit');
        $query=$this->request->param('query');
        $db=Db::name('auth_rule');

        if(isset($query) || !empty($query)){
            $db=$db->where('title','like','%'.$query.'%');
        }
        $info=$db->page($page)->limit($limit)->order('id')->select()->toArray();
//        var_dump($info);exit;
        $total=$db->count('id');
        $content=[
            'code'=>ApiErrDesc::SUCCESS[0],
            'msg'=>ApiErrDesc::SUCCESS[1],
            'total'=>$total,
            'data'=>$info
        ];
        return json($content);
//        $data=$db->select()->toArray();
//        return SuccessJson($data);
    }
    public function Rules(){
        $info=Db::name('auth_group')->select()->toArray();
        return SuccessJson($info);
    }
    public function add(){
        $info=$this->request->param();
        $res=Db::name('auth_group')->insert($info);
        if($res){
            return SuccessJson();
        }else{
            return ErrJson(ApiErrDesc::ERR_ADD);
        }
    }
    public function edit(){
        $info['id']=$this->request->param('id');
        $info['name']=$this->request->param('name');
        $info['title']=$this->request->param('title');
        if(!isset($info['name']) || empty($info['name'])) return ErrJson(ApiErrDesc::ERR_PARAMS);
        $info['update_time']=time();
        $res=Db::name('auth_group')->save($info);
        if($res){
            return SuccessJson();
        }else{
            return ErrJson(ApiErrDesc::ERR_UPDATE);
        }
    }

    public function editStatus(){
        $info['id']=$this->request->param('id');
        $info['status']=$this->request->param('status');
        if(empty( $info['id'])) return ErrJson(ApiErrDesc::ERR_PARAMS);
        $info['update_time']=time();
        $res=Db::name('auth_group')->save($info);
        if($res){
            return SuccessJson();
        }else{
            return ErrJson(ApiErrDesc::ERR_UPDATE);
        }
    }

    public function delRule(){
        $id=$this->request->param('id');
        if(empty($id)) return ErrJson(ApiErrDesc::ERR_PARAMS);
        $res=Db::name('auth_group')->where('id',$id)->delete();
        if($res){
            return SuccessJson();
        }else{
            return ErrJson(ApiErrDesc::ERR_DELETE);
        }
    }

    public function list(){
        $id=$this->request->param('id');
        $res=Db::name('auth_group')->where('id',$id)->find();
        if($res['rules']=='#'){
            $rule=Db::name('auth_rule')->select();
            $info= rules($rule);
            return SuccessJson($info);
        }

    }
    public function getTopRule(){
        $res=Db::name('auth_rule')->where('pid',0)->select();
        return SuccessJson($res);
    }

    public function secondList(){
        $pid=$this->request->param('pid');
        $res=Db::name('auth_rule')->where('pid',$pid)->select();
        return SuccessJson($res);
    }

}