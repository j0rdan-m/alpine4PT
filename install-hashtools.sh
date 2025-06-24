#!/bin/sh

# Script d'installation d'outils de décryptage pour CTF sur Alpine Linux
# Ce script installe Hashcat, John the Ripper, Hydra et des dictionnaires pour les challenges CTF

echo "[*] Début de l'installation des outils de décryptage pour CTF..."

# Vérification des droits d'administration
if [ "$(id -u)" -ne 0 ]; then
   echo "Ce script doit être exécuté en tant qu'administrateur" 
   echo "Veuillez utiliser sudo $0"
   exit 1
fi

# Installation des dépendances
echo "[*] Installation des dépendances..."
echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
apk update
apk add --no-cache build-base openssl-dev git wget unzip python3 py3-pip libssh-dev pcre-dev

# 1. Installation de Hashcat
echo "[*] Installation de Hashcat..."
apk add --no-cache hashcat
echo "[+] Hashcat installé avec succès"

# 2. Installation de John the Ripper (version jumbo)
echo "[*] Installation de John the Ripper (version jumbo)..."
apk add --no-cache john

# 3. Installation de Hydra
echo "[*] Installation de Hydra..."
apk add --no-cache hydra
echo "[+] Hydra installé avec succès"

# 7. Installation de JWT Tool
echo "[*] Installation de JWT Tool..."
apk add --no-cache python3 py3-pip
git clone https://github.com/ticarpi/jwt_tool.git /opt/jwt_tool
cd /opt/jwt_tool
python3 -m pip install -r requirements.txt
ln -s /opt/jwt_tool/jwt_tool.py /usr/local/bin/jwt_tool
chmod +x /usr/local/bin/jwt_tool
echo "[+] JWT Tool installé avec succès"

# Hash-identifier
echo "[*] Installation de hash-identifier..."
apk add --no-cache python3
git clone https://github.com/blackploit/hash-identifier.git /opt/hash-identifier
ln -s /opt/hash-identifier/hash-id.py /usr/local/bin/hash-id
chmod +x /usr/local/bin/hash-id
echo "[+] Hash-identifier installé avec succès"

# Creation d'un fichier d'informations sur les outils installés
echo "[*] Création d'un fichier d'informations..."
cat << 'EOF' > /usr/share/crypto-tools-info.txt
Outils de décryptage pour CTF installés :

1. Hashcat - Craquage de mots de passe
   Usage: hashcat -m [mode] -a [attaque] [hash] [dictionnaire]
   Exemple: hashcat -m 0 -a 0 hash.txt /usr/share/wordlists/rockyou.txt

2. John the Ripper - Craquage de mots de passe multi-formats
   Usage: john --format=[format] --wordlist=[dictionnaire] [hash]
   Exemple: john --format=raw-md5 --wordlist=/usr/share/wordlists/rockyou.txt hash.txt

3. Hydra - Outil de brute force pour de nombreux protocoles
   Usage: hydra -l [utilisateur] -P [liste_mdp] [service://serveur]
   Exemple: hydra -l admin -P /usr/share/wordlists/rockyou.txt ssh://10.10.10.10

8. Hash-identifier - Identification du type de hash
   Usage: hash-id
   
Pour plus d'informations sur les options de chaque outil, utilisez le paramètre --help.
EOF

echo "[+] Un guide d'utilisation a été créé dans /usr/share/crypto-tools-info.txt"


