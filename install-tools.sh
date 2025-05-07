# 1. Installation de Nikto
echo "[*] Installation de Nikto..."
git clone https://github.com/sullo/nikto.git /opt/nikto
ln -s /opt/nikto/program/nikto.pl /usr/local/bin/nikto
chmod +x /usr/local/bin/nikto
# 2. Installation de Gobuster
echo "[*] Installation de Gobuster..."
apk add --no-cache go
export GOPATH=/root/go
export PATH=$PATH:$GOPATH/bin
go install github.com/OJ/gobuster/v3@latest
ln -s /root/go/bin/gobuster /usr/local/bin/gobuster
# 3. Installation de Recon-ng
echo "[*] Installation de Recon-ng..."
git clone https://github.com/lanmaster53/recon-ng.git /opt/recon-ng
echo "Création de l'environnement virtuel..."
python3 -m venv /opt/recon-ng-venv
echo "Installation des dépendances Python..."
/opt/recon-ng-venv/bin/pip install --upgrade pip
/opt/recon-ng-venv/bin/pip install -r /opt/recon-ng/REQUIREMENTS
echo "Création du wrapper recon-ng..."
cat << 'EOF' > /usr/local/bin/recon-ng
#!/bin/sh
# Activer l'environnement virtuel et exécuter recon-ng
source /opt/recon-ng-venv/bin/activate
cd /opt/recon-ng
python3 /opt/recon-ng/recon-ng "$@"
EOF
chmod +x /usr/local/bin/recon-ng

# 4. Installation de nmap
echo "[*] Installation de nmap..."
apk add nmap

echo "[*] Installation terminée. Teste les outils avec : nikto, gobuster, recon-ng, nmap"
