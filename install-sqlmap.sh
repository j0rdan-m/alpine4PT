#!/bin/sh

# Installation de SQLMap sur Alpine Linux
echo "[*] Installation de SQLMap..."

# Installer les dépendances nécessaires
echo "[*] Installation des dépendances système..."
apk update
apk add --no-cache \
    git python3 py3-pip \
    python3-dev build-base libffi-dev \
    openssl-dev

# Créer un environnement virtuel dédié pour SQLMap
echo "[*] Création de l'environnement virtuel..."
python3 -m venv /opt/sqlmap-venv

# Activer l'environnement virtuel pour l'installation
source /opt/sqlmap-venv/bin/activate

# Mettre à jour pip dans l'environnement virtuel
/opt/sqlmap-venv/bin/pip install --upgrade pip

# Cloner le dépôt SQLMap
echo "[*] Téléchargement de SQLMap..."
if [ ! -d "/opt/sqlmap" ]; then
    git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git /opt/sqlmap
else
    echo "Le répertoire /opt/sqlmap existe déjà."
    cd /opt/sqlmap
    git pull
fi

# Installer les dépendances Python (si un fichier requirements.txt existe)
if [ -f "/opt/sqlmap/requirements.txt" ]; then
    echo "[*] Installation des dépendances Python..."
    /opt/sqlmap-venv/bin/pip install -r /opt/sqlmap/requirements.txt
fi

# Créer un script wrapper pour SQLMap
echo "[*] Création du wrapper sqlmap..."
cat << 'EOF' > /usr/local/bin/sqlmap
#!/bin/sh
# Activer l'environnement virtuel et exécuter sqlmap
source /opt/sqlmap-venv/bin/activate
python3 /opt/sqlmap/sqlmap.py "$@"
EOF

# Rendre le script exécutable
chmod +x /usr/local/bin/sqlmap

# Créer des liens symboliques pour les outils supplémentaires si nécessaire
if [ -f "/opt/sqlmap/extra/other/sqlhash.py" ]; then
    cat << 'EOF' > /usr/local/bin/sqlhash
#!/bin/sh
source /opt/sqlmap-venv/bin/activate
python3 /opt/sqlmap/extra/other/sqlhash.py "$@"
EOF
    chmod +x /usr/local/bin/sqlhash
fi

if [ -f "/opt/sqlmap/extra/cloak/cloak.py" ]; then
    cat << 'EOF' > /usr/local/bin/sqlmap-cloak
#!/bin/sh
source /opt/sqlmap-venv/bin/activate
python3 /opt/sqlmap/extra/cloak/cloak.py "$@"
EOF
    chmod +x /usr/local/bin/sqlmap-cloak
fi

echo "[+] Installation de SQLMap terminée!"
echo "[+] Vous pouvez maintenant lancer SQLMap en tapant 'sqlmap' dans votre terminal"
echo "[+] Exemple: sqlmap -u 'http://exemple.com/page.php?id=1' --dbs"
