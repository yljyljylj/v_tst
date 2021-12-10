<?php
declare (strict_types = 1);

namespace app\api\middleware;

use app\common\ApiErrDesc;
use app\common\ResponseJson;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class Check
{
    use ResponseJson;
    /**
     * 处理请求
     *
     * @param \think\Request $request
     * @param \Closure       $next
     * @return Response
     */
    public function handle($request, \Closure $next)
    {
        //
        $jwt=$request->header('Authorization');
        $url=$request->pathinfo();
        if($url==='login/login' || $url==='login/logout') return $next($request);
        if(empty($jwt)) return $this->ErrJson(ApiErrDesc::ERR_PARAMS);
        try{
            $decoded = JWT::decode($jwt, new Key(jwt_key,jwt_HS ));
        }catch (\Exception $e){
            return $this->ErrJson(ApiErrDesc::ERR_JWT);
        }
        $request->uid = $decoded->uid;
        return $next($request);
    }
}
