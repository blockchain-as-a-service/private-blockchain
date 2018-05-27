# !/bin/bash
# bash netstatconf.sh <number_of_nodes> <ws_secret> <node_name> <rpc_host> ... <node_name> <rpc_host>

# sets up a eth-net-intelligence app.json for a local ethereum network cluster of nodes
# - <number_of_nodes> is the number of clusters
# - <ws_server> is the eth-netstats server
# - <ws_secret> is the eth-netstats secret
# - <node_name> is the node name
# - <rpc_host> is private IP of the node name 


N=$1
shift
ws_server=$1
shift
ws_secret=$1
shift

echo -e "["

for ((i=0;i<N;++i)); do
	node_name=$1
	shift
	rpc_host=$1
	shift
    id=`printf "%02d" $i`
    single_template="  {\n    \"name\"        : \"$name_prefix-$i\",\n    \"cwd\"         : \".\",\n    \"script\"      : \"app.js\",\n    \"log_date_format\"   : \"YYYY-MM-DD HH:mm Z\",\n    \"merge_logs\"    : false,\n    \"watch\"       : false,\n    \"exec_interpreter\"  : \"node\",\n    \"exec_mode\"     : \"fork_mode\",\n    \"env\":\n    {\n      \"NODE_ENV\"    : \"production\",\n      \"RPC_HOST\"    : \"$rpc_host\",\n      \"RPC_PORT\"    : \"8545\",\n      \"INSTANCE_NAME\"   : \"$node_name\",\n      \"WS_SERVER\"     : \"$ws_server\",\n      \"WS_SECRET\"     : \"$ws_secret\",\n    }\n  }"

    endline=""
    if [ "$i" -ne "$N" ]; then
        endline=","
    fi
    echo -e "$single_template$endline"
done

echo "]"
