<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2021-12-10
 * Time: 17:46
 */

namespace app\api\controller;



use app\BaseController;
use app\api\model\Aritcle as AritcleModel;
use app\common\ApiErrDesc;

class Aritcle extends BaseController
{
    public function index(){
        $page=$this->request->param('page');
        $limit=$this->request->param('limit');
        $query=$this->request->param('query');
        $db=new AritcleModel();
        if(isset($query) || !empty($query)){
            $db=$db->where('title','like','%'.$query.'%');
        }
        $info=$db->page($page)->limit($limit)->order('id')->select()->toArray();
//                var_dump($info);

        $total=$db->count('id');
        $content=[
            'code'=>ApiErrDesc::SUCCESS[0],
            'msg'=>ApiErrDesc::SUCCESS[1],
            'total'=>$total,
            'data'=>$info
        ];
        return json($content);
//        var_dump($info);
    }
    public function delete(){
        $id=$this->request->param('id');
        if(empty($id)) return ErrJson(ApiErrDesc::ERR_PARAMS);
        $db=new AritcleModel();
        $res=$db->where('id',$id)->delete();
        if($res){
            return SuccessJson();
        }else{
            return ErrJson(ApiErrDesc::ERR_DELETE);
        }

        echo $id;
    }
}