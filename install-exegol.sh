apk update
apk add git python3
apk add py3-pip
python3 -m venv /venv/
. /venv/bin/activate
python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipx install exegol
pipx ensurepath
exec $SHELL
exegol install
