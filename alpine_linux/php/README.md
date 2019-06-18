#### 说明

## images目录
images目录下为已构建好的镜像。
```php-alpine```为官方php:7.1.28-fpm-alpine的镜像，国内可能由于网络原因无法顺利拉取该镜像，所以可以手动导入。使用```docker load -i /path/to/php-alpine```，然后通过imageId设置tag。
文件```Deps```的Dockerfile为在官方php:7.1.28-fpm-alpine的镜像基础上添加了一些额外的依赖，方便测试时减少安装依赖的时间。

## xhprof目录
目前xhprof还无法使用，需要在php中额外安装gd库。但是使用apk add安装gd库依赖时，需要使用到apk的边缘包，但是网络环境有问题，所以还无法成功安装gd库。

## test文件
用于测试在alpine-linux中安装gd库的依赖。
