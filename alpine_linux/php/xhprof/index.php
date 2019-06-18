<?php
//path
define("TOP_PATH",  realpath(dirname(__FILE__) . '/../..'));
define("ROOT_PATH",  realpath(dirname(__FILE__) . '/../'));
define("APP_PATH",  realpath(dirname(__FILE__) . '/../application'));
define("PUBLIC_PATH",  realpath(dirname(__FILE__) . '/../public'));
define("CONF_PATH",  realpath(dirname(__FILE__) . '/../conf'));

//const
define("DOMAIN_ROOT", substr($_SERVER['HTTP_HOST'],strpos($_SERVER['HTTP_HOST'],'.')));
define("DOMAIN_HOST", $_SERVER['HTTP_HOST']);
define("DOMAIN_URL", 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']);
define("IMG_URL", 'http://img.xinghuoread.cn/');
define("SC_URL", 'http://sc.xinghuoread.cn/');
define("APP_URL", 'http://app.xinghuoread.cn/');
define("APP_PF", '10');


//根据不同环境，选择不同的配置文件，多文件主要用于解决多人开发，修改配置文件，本地就需要还原一次的问题
switch(ini_get('yaf.environ')){
    case 'test':
        $application = new Yaf\Application( ROOT_PATH . "/conf/test.ini");
        break;
    case 'develop':
        $application = new Yaf\Application( ROOT_PATH . "/conf/develop.ini");
        break;
    case 'product':
    default:
        $application = new Yaf\Application( ROOT_PATH . "/conf/product.ini");
        break;
}

/*************** 开启xhprof *******************/
xhprof_enable();
$application->bootstrap()->run();

/*************** 取得程序运行数据 *******************/
$xhprofData = xhprof_disable();

/*************** 引入xhprof文件 *******************/
require './xhprof_lib/utils/xhprof_lib.php';
require './xhprof_lib/utils/xhprof_runs.php';

/*************** 生成xhprof数据文件 *******************/
$xhprofRuns = new XHProfRuns_Default();
$runId = $xhprofRuns->save_run($xhprofData, 'xhprof_test');

