<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2021-12-09
 * Time: 17:44
 */
namespace app\common;
class ApiErrDesc
{
    /**
     * 通用错误码定义
     */
    const SUCCESS = [0,'Success'];

    const UNKNOW_ERR = [1,'未知错误'];

    const ERROR_URL = [2,'接口不存在'];

    const ERR_PARAMS = [100,'参数错误'];

    const ERR_JWT = [101,'参数验证失败'];

    /**
     * 用户登录错误码
     */
    const ERR_NULL = [1003,'账号或密码不能为空'];
    const ERR_PASSWORD = [1002,'密码错误'];
    const ERR_USERNAME = [1001,'用户名不存在'];


    const ERR_DELETE = [2002,'删除失败'];

}