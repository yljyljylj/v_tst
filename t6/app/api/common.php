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
