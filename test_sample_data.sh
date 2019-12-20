source setup.sh

[[ -f schema.sql ]] || wget -q4 https://raw.githubusercontent.com/yugabyte/yb-sql-workshop/master/query-using-bi-tools/schema.sql

[[ -f sample-data.tgz ]] || wget -q4 https://github.com/yugabyte/yb-sql-workshop/raw/master/query-using-bi-tools/sample-data.tgz

[[ -d data ]] || tar zxvf sample-data.tgz



