net_id=$1
if [ -z "$net_id" ]; then
    echo "Usage: $0 <net_id>"
    exit 1
fi
mkdir -p logs
sh test.sh $net_id
