<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2021-12-09
 * Time: 17:46
 */

namespace app\common;



trait ResponseJson
{

    public function ErrJson($api,$data=[])
    {
        return $this->JsonResponse($api,$data);
    }

    public function SuccessJson($data=[])
    {
        return $this->JsonResponse(ApiErrDesc::SUCCESS,$data);
    }

    public function JsonResponse($api,$data)
    {
        $content=[
            'code'=>$api[0],
            'msg'=>$api[1],
            'data'=>$data
        ];
        return json($content);
    }
}