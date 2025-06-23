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
apk update
apk add --no-cache build-base openssl-dev git wget unzip python3 py3-pip libssh-dev pcre-dev

# 1. Installation de Hashcat
echo "[*] Installation de Hashcat..."
apk add --no-cache hashcat
echo "[+] Hashcat installé avec succès"

# 2. Installation de John the Ripper (version jumbo)
echo "[*] Installation de John the Ripper (version jumbo)..."
apk add --no-cache openssl-dev yasm pkgconfig
git clone https://github.com/openwall/john.git /opt/john
cd /opt/john/src
./configure && make -j4
ln -s /opt/john/run/john /usr/local/bin/john
ln -s /opt/john/run/zip2john /usr/local/bin/zip2john
ln -s /opt/john/run/rar2john /usr/local/bin/rar2john
ln -s /opt/john/run/office2john /usr/local/bin/office2john
ln -s /opt/john/run/pdf2john /usr/local/bin/pdf2john
echo "[+] John the Ripper installé avec succès"

# 3. Installation de CyberChef (outil en ligne)
echo "[*] Installation de CyberChef..."
mkdir -p /opt/cyberchef
wget -O /opt/cyberchef/CyberChef.zip https://github.com/gchq/CyberChef/releases/latest/download/CyberChef.zip
unzip /opt/cyberchef/CyberChef.zip -d /opt/cyberchef
rm /opt/cyberchef/CyberChef.zip
echo "[+] CyberChef installé dans /opt/cyberchef"

# 4. Installation de fcrackzip
echo "[*] Installation de fcrackzip..."
apk add --no-cache fcrackzip
echo "[+] fcrackzip installé avec succès"

# 5. Installation de RsaCtfTool
echo "[*] Installation de RsaCtfTool..."
apk add --no-cache python3 py3-pip py3-wheel py3-setuptools
git clone https://github.com/Ganapati/RsaCtfTool.git /opt/RsaCtfTool
cd /opt/RsaCtfTool
pip3 install -r requirements.txt
ln -s /opt/RsaCtfTool/RsaCtfTool.py /usr/local/bin/rsactftool
chmod +x /usr/local/bin/rsactftool
echo "[+] RsaCtfTool installé avec succès"

# 6. Installation de Hydra
echo "[*] Installation de Hydra..."
apk add --no-cache hydra
echo "[+] Hydra installé avec succès"

# Alternative: Compilation depuis les sources si besoin
# echo "[*] Installation de Hydra depuis les sources..."
# apk add --no-cache build-base openssl-dev libssh-dev pcre-dev
# git clone https://github.com/vanhauser-thc/thc-hydra.git /opt/hydra
# cd /opt/hydra
# ./configure
# make
# make install
# echo "[+] Hydra installé avec succès"

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

# Hashid
echo "[*] Installation de hashid..."
pip3 install hashid
echo "[+] Hashid installé avec succès"

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

3. CyberChef - Outil de manipulation de données en ligne
   Localisation: /opt/cyberchef

4. fcrackzip - Craquage de fichiers ZIP protégés par mot de passe
   Usage: fcrackzip -D -p [dictionnaire] -u [fichier.zip]
   Exemple: fcrackzip -D -p /usr/share/wordlists/rockyou.txt -u protected.zip

5. RsaCtfTool - Craquage/attaques pour RSA
   Usage: rsactftool --publickey [fichier-clé] --attack [mode]
   Exemple: rsactftool --publickey ./key.pub --private

6. Hydra - Outil de brute force pour de nombreux protocoles
   Usage: hydra -l [utilisateur] -P [liste_mdp] [service://serveur]
   Exemple: hydra -l admin -P /usr/share/wordlists/rockyou.txt ssh://10.10.10.10

7. JWT Tool - Analyse et manipulation de tokens JWT
   Usage: jwt_tool [token]
   Exemple: jwt_tool eyJhbGciOiJIUzI1NiJ9...

8. Hash-identifier - Identification du type de hash
   Usage: hash-id
   
9. Hashid - Identification du type de hash (alternative)
   Usage: hashid [hash]

Pour plus d'informations sur les options de chaque outil, utilisez le paramètre --help.
EOF

echo "[+] Un guide d'utilisation a été créé dans /usr/share/crypto-tools-info.txt"

echo "[*] Installation terminée. Voici les commandes disponibles :"
echo "- hashcat"
echo "- john"
echo "- hash-id"
echo "- hashid"  
echo "- fcrackzip"
echo "- hydra"
echo "- rsactftool"
echo "- jwt_tool"
echo ""
echo "Les dictionnaires sont disponibles dans /usr/share/wordlists/"
echo "Consultez /usr/share/crypto-tools-info.txt pour plus d'informations sur l'utilisation"
