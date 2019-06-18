##目前缺少gd库，还无法正常使用

#### 使用说明
把当前目录下的```xhprof_html``` ```xhprof_lib```放在入口文件```index.php```同级目录下，并修改```index.php```，加入xhprof监听内容。
示例为当前目录下的```index.php```。
另外需要在php的配置文件中指定```xhprof.output_dir = /tmp/xhprof```来存放xhprof生成的文件。
然后访问```http://example.com/xhprof_html/index.php```来查看生成的信息。