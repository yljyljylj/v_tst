<?php
// 这是系统自动生成的公共文件
// 应用公共文件
define('jwt_key', 'vtst.com');
define('payload', [
    "iss" => "http://example.org",
    "aud" => "http://example.com",
    "iat" => time(),
    "nbf" => time()
]);
define('jwt_HS', 'HS256');

function ErrJson($api,$data=[])
{
    return JsonResponse($api,$data);
}

function SuccessJson($data=[])
{
    return JsonResponse(\app\common\ApiErrDesc::SUCCESS,$data);
}

function JsonResponse($api,$data)
{
    $content=[
        'code'=>$api[0],
        'msg'=>$api[1],
        'data'=>$data
    ];
    return json($content);
}

//排序
function rules($array){
    $items = array();
    foreach($array as $value){
        $items[$value['id']] = $value;
    }
//    return $items;
    //第二部 遍历数据 生成树状结构
    $tree = array();
    foreach($items as $key => $item){
        if(isset($items[$item['pid']])){
            $items[$item['pid']]['son'][] = &$items[$key];
        }else{
            $tree[] = &$items[$key];
        }
    }
    return $tree;
//    foreach ($rule as $key=>$val){
//        if($val['pid']==0){
//            $info[]=$val;
//        }
//    }
//    foreach ($rule as $key=>$val){
//        foreach ($info as $k=>$v){
//            if($val['pid']==$v['id']){
//                $info[$k]['children'][]=$val;
//            }
//        }
//    }
//    return $info;
}
