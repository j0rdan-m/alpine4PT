apk update
apk add git python3
apk add py3-pip
python3 -m venv /venv/
. /venv/bin/activate
python3 -m pip install pipx
python3 -m pipx ensurepath
pipx install exegol
echo "alias exegol='sudo -E $(echo ~/.local/bin/exegol)'" >> ~/.bash_aliases && source ~/.bash_aliases
pipx ensurepath
exec $SHELL
exegol install
