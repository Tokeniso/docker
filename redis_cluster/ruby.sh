#!/bin/sh
yum install ruby
# 添加aliyun镜像并检测Ruby版本
gem sources -a http://mirrors.aliyun.com/rubygems/ 

# 安装RAM
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

curl -sSL https://get.rvm.io | bash -s stable

# 更新配置文件，使其立马生效
source /etc/profile.d/rvm.sh
# 安装Ruby2.5
rvm install 2.5

# ruby版本信息
ruby -v

gem install redis