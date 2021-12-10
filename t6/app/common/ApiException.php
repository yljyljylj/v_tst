<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2021-12-10
 * Time: 11:07
 */

namespace app\common;


use think\Exception;

class ApiException extends Exception
{
     public $code;
     public $message;
     public function __construct(array $apiErrDesc)
     {
         $this->code=$apiErrDesc[0];
         $this->message=$apiErrDesc[1];
     }
}