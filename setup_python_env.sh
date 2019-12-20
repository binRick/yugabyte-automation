
set -e
MODULES="\
	psycopg2-binary \
	yedis \
"

command -v python3 >/dev/null

[[ "$VENV" == "" ]] && export VENV=~/.venv

[[ -e $VENV/bin/activate ]] || python3 -m venv $VENV

source $VENV/bin/activate

pip install $MODULES --upgrade

set +e



