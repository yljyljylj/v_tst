<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2021-12-10
 * Time: 15:06
 */

namespace app\api\controller;



use app\common\ResponseJson;
use think\facade\Db;

class Home
{
    use ResponseJson;
    public function index(){

        $info=[
            [
                'id'=>102,
                'authName'=>'用户管理',
                'path'=>null,
                'icon'=>'el-icon-setting',
                'children'=>[
                    [
                        'id'=>1021,
                        'authName'=>'用户列表',
                        'path'=>'users',
                        'icon'=>'el-icon-eleme',
                        'children'=>[]
                    ]
                ]
            ],
            [
                'id'=>201,
                'authName'=>'权限管理',
                'path'=>null,
                'icon'=>'el-icon-setting',
                'children'=>[
                    [
                        'id'=>2021,
                        'authName'=>'权限列表',
                        'path'=>'auth',
                        'icon'=>'el-icon-eleme',
                        'children'=>[]
                    ]
                ]
            ],
            [
                'id'=>104,
                'authName'=>'文章管理',
                'path'=>null,
                'icon'=>'el-icon-setting',
                'children'=>[
                    [
                        'id'=>1041,
                        'authName'=>'文章列表',
                        'path'=>'list',
                        'icon'=>'el-icon-eleme',
                        'children'=>[]
                    ]
                ]
            ],
          [
              'id'=>101,
              'authName'=>'商品管理',
              'path'=>null,
              'icon'=>'el-icon-s-claim',
              'children'=>[
                  [
                      'id'=>1011,
                      'authName'=>'商品管理1',
                      'path'=>'shop1',
                      'icon'=>'el-icon-s-cooperation',
                      'children'=>[]
                  ],
                    [
                  'id'=>1012,
                  'authName'=>'商品管理2',
                  'path'=>'shop2',
                   'icon'=>'el-icon-picture',
                  'children'=>[]
              ]
              ]
          ],
            [
                'id'=>103,
                'authName'=>'系统管理',
                'path'=>null,
                'icon'=>'el-icon-setting',
                'children'=>[
                    [
                        'id'=>1031,
                        'authName'=>'系统管理',
                        'path'=>'system',
                        'icon'=>'el-icon-eleme',
                        'children'=>[]
                    ]
                ]
            ],

        ];
        return $this->SuccessJson($info);
    }
}