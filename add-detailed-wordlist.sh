#!/bin/bash

# Création du dossier wordlist
mkdir -p wordlist
cd wordlist

echo "[+] Téléchargement des wordlists de mots de passe..."

# Dictionnaire de mots de passe courants (SecLists)
wget -O passwords-common.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Common-Credentials/10-million-password-list-top-1000.txt

# Dictionnaire de mots de passe par défaut
wget -O passwords-default.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Default-Credentials/default-passwords.csv

echo "[+] Téléchargement des wordlists pour directory busting..."

# Dictionnaire pour gobuster - répertoires web courants
wget -O directories-common.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/common.txt

# Dictionnaire plus complet mais raisonnable pour les répertoires
wget -O directories-medium.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/directory-list-2.3-medium.txt

echo "[+] Téléchargement des wordlists pour énumération de sous-domaines..."

# Sous-domaines courants
wget -O subdomains-common.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/subdomains-top1million-5000.txt

# Sous-domaines pour environnements spécifiques
wget -O subdomains-short.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/fierce-hostlist.txt

echo "[+] Téléchargement des wordlists pour fuzzing de paramètres..."

# Paramètres web courants
wget -O parameters-common.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/burp-parameter-names.txt

# Paramètres pour APIs
wget -O parameters-api.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/api/api-endpoints.txt

echo "[+] Téléchargement des wordlists pour virtual hosts..."

# Virtual hosts courants
wget -O vhosts-common.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/namelist.txt

echo "[+] Téléchargement des wordlists pour énumération d'APIs..."

# Endpoints d'API REST
wget -O api-endpoints.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/api/api_seen_in_wild.txt

# Chemins d'API courants
wget -O api-paths.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/swagger.txt

echo "[+] Téléchargement des wordlists pour services réseau..."

# Community strings SNMP
wget -O snmp-strings.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/SNMP/snmp.txt

# Noms d'utilisateurs pour services
wget -O usernames-common.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Usernames/top-usernames-shortlist.txt

# Extensions de fichiers courantes
wget -O file-extensions.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/web-extensions.txt

echo "[+] Téléchargement des wordlists pour bases de données..."

# Noms de tables MySQL courantes
wget -O db-tables-mysql.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/CMS/mysql.txt

# Noms de colonnes courantes
wget -O db-columns.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/CMS/wordpress.txt

echo "[+] Téléchargement des payloads d'injection..."

# Payloads XSS
wget -O payloads-xss.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Fuzzing/XSS/XSS-Jhaddix.txt

# Payloads command injection
wget -O payloads-cmdi.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Fuzzing/command-injection-commix.txt

echo "[+] Vérification des téléchargements..."
ls -lh *.txt *.csv

echo "[+] Wordlists téléchargées avec succès dans le dossier wordlist/"
echo ""
echo "=== AUTHENTIFICATION ==="
echo "    - passwords-common.txt : Top 1000 mots de passe"
echo "    - passwords-default.txt : Mots de passe par défaut"
echo "    - usernames-common.txt : Noms d'utilisateurs courants"
echo ""
echo "=== DÉCOUVERTE WEB ==="
echo "    - directories-common.txt : Répertoires web courants"
echo "    - directories-medium.txt : Liste étendue de répertoires"
echo "    - file-extensions.txt : Extensions de fichiers"
echo ""
echo "=== ÉNUMÉRATION DNS ==="
echo "    - subdomains-common.txt : Top 5000 sous-domaines"
echo "    - subdomains-short.txt : Sous-domaines pour Fierce"
echo "    - vhosts-common.txt : Virtual hosts courants"
echo ""
echo "=== FUZZING WEB ==="
echo "    - parameters-common.txt : Paramètres web courants"
echo "    - parameters-api.txt : Paramètres d'API"
echo ""
echo "=== ÉNUMÉRATION API ==="
echo "    - api-endpoints.txt : Endpoints d'API observés"
echo "    - api-paths.txt : Chemins d'API Swagger"
echo ""
echo "=== SERVICES RÉSEAU ==="
echo "    - snmp-strings.txt : Community strings SNMP"
echo ""
echo "=== BASES DE DONNÉES ==="
echo "    - db-tables-mysql.txt : Tables MySQL courantes"
echo "    - db-columns.txt : Colonnes courantes"
echo ""
echo "=== PAYLOADS D'INJECTION ==="
echo "    - payloads-xss.txt : Payloads XSS"
echo "    - payloads-cmdi.txt : Payloads command injection"

cd ..
