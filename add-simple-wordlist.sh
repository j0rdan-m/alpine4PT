#!/bin/bash

# Création du dossier wordlist
mkdir -p wordlist
cd wordlist

echo "[+] Téléchargement des wordlists de mots de passe..."

# RockYou.txt
wget -O rockyou.txt https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt


# Dictionnaire de mots de passe courants (SecLists)
wget -O passwords-common.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Common-Credentials/10-million-password-list-top-1000.txt

# Dictionnaire de mots de passe par défaut
wget -O passwords-default.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Default-Credentials/default-passwords.csv

echo "[+] Téléchargement des wordlists pour directory busting..."

# Dictionnaire pour gobuster - répertoires web courants
wget -O directories-common.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/common.txt

# Dictionnaire plus complet mais raisonnable pour les répertoires
wget -O directories-medium.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/directory-list-2.3-medium.txt

echo "[+] Téléchargement des wordlists supplémentaires..."

# Extensions de fichiers courantes
wget -O file-extensions.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/web-extensions.txt

# Noms d'utilisateurs courants
wget -O usernames-common.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Usernames/top-usernames-shortlist.txt

echo "[+] Vérification des téléchargements..."
ls -lh *.txt *.csv

echo "[+] Wordlists téléchargées avec succès dans le dossier wordlist/"
echo "    - passwords-common.txt : Top 1000 mots de passe"
echo "    - passwords-default.txt : Mots de passe par défaut"
echo "    - directories-common.txt : Répertoires web courants"
echo "    - directories-medium.txt : Liste étendue de répertoires"
echo "    - file-extensions.txt : Extensions de fichiers"
echo "    - usernames-common.txt : Noms d'utilisateurs"

cd ..
