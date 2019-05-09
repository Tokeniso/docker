#!/bin/sh
#
# 动作 => action
action=$1

# 宿主IP
ip=$2 #192.168.98.128

port=7001
num=6

needIp(){
	if [ ! "$ip" ]; then
		echo '请输入第二个IP参数'
		exit
	fi
}

start(){
	# 启动所有redis节点
	set -e
	for((i=1;i<=$num;i++))
	do
		cd ./${i}
		commend="redis-server ./redis.conf"
		$commend
		cd ../
	done
	set +e
}


stop(){
	# 停止集群所有redis节点
	# set -e

	for((i=1;i<=$num;i++));  
	do
		command="redis-cli -p ${port} -h 192.168.98.128 shutdown"
		$command
		((port++))
	done

}

reload(){
	# 初始化
	set -e

	rm -rf ./[0-9]
	for((i=1;i<=$num;i++)); do
		mkdir ./${i}
		cp /usr/local/redis/redis.conf ./${i}/

		sed -i "s/# bind 127.0.0.1$/bind ${ip}/" ./${i}/redis.conf
		sed -i "s/requirepass 123456$/#requirepass 123456/" ./${i}/redis.conf
		sed -i "s/# cluster-enabled yes$/cluster-enabled yes/" ./${i}/redis.conf
		sed -i "s/^port 6379$/port ${port}/" ./${i}/redis.conf
		sed -i "s/redis_6379.pid/redis_${port}.pid/" ./${i}/redis.conf
		((port++))
	done
	set +e
}


node(){
	nodes=
	for (( i = 1; i <= $num; i++ )); do
		nodes="$nodes $ip:$port"
		((port++))
	done

	./redis-trib.rb create --replicas 1 ${nodes}
}

case $action in
	"-start")
		start
	;;
	"-stop")
		stop
	;;
	"-reload")
		reload
	;;
	"-node")
		node
	;;
	*)
		echo 'command /path/to/redis.sh [option] -start -stop -reload -node'
		echo '-start ip  start all the redis nodes'
		echo '-stop  ip  stop all the redis nodes'
		echo '-reload    delete the old redis configure and copy from the default configure'
		echo '-node      create the redis cluster'
	;;
esac
