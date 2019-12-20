set -e
command -v java >/dev/null 2>&1 || yum -y install java-1.8.0-openjdk-headless

java -version

[[ -f yb-sample-apps.jar ]] || wget https://github.com/yugabyte/yb-sample-apps/releases/download/v1.2.0/yb-sample-apps.jar?raw=true -O yb-sample-apps.jar

[[ "$ENDPOINTS" == "" ]] && export ENDPOINTS="0.0.0.0:9042"

TEST_CMD="java -jar ./yb-sample-apps.jar  \
      --workload CassandraKeyValue   \
      --nodes $ENDPOINTS             \
      --nouuid                       \
      --value_size 256               \
      --num_threads_read 0           \
      --num_threads_write  256       \
      --num_unique_keys 1000000000"

echo $TEST_CMD
eval $TEST_CMD
