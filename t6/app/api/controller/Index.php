<?php
declare (strict_types = 1);

namespace app\api\controller;


class Index
{
    public function index()
    {
        $info=request()->param();
        return json($info);
        return '您好！这是一个[api]示例应用';
    }
}
