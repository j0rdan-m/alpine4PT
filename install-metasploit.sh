# Installation des dépendances système nécessaires pour Metasploit
echo "[*] Installation des dépendances système..."
apk update
apk add --no-cache \
    git ruby ruby-dev ruby-bundler \
    libffi-dev libpcap-dev libxml2-dev libxslt-dev \
    postgresql-dev sqlite-dev yaml-dev zlib-dev ncurses-dev readline-dev \
    curl autoconf bison build-base ruby-json \
    openssl-dev alpine-sdk procps

# Mise à jour des gems Ruby
echo "[*] Mise à jour de RubyGems..."
gem update --system
gem install bundler

# Clonage du dépôt Metasploit
echo "[*] Clonage du dépôt Metasploit Framework..."
if [ ! -d "/opt/metasploit" ]; then
    git clone https://github.com/rapid7/metasploit-framework.git /opt/metasploit
else
    echo "Le répertoire /opt/metasploit existe déjà."
    cd /opt/metasploit
    git pull
fi

# Accès au répertoire Metasploit
cd /opt/metasploit

# Configuration de bundler pour ignorer les environnements de développement et de test
echo "[*] Configuration de bundler..."
bundle config set --local without 'development test'

# Installation des dépendances Ruby
echo "[*] Installation des dépendances Ruby (cela peut prendre plusieurs minutes)..."
bundle install

# Création des liens symboliques
echo "[*] Création des liens symboliques..."
cat << 'EOF' > /usr/local/bin/msfconsole
#!/bin/sh
cd /opt/metasploit
ruby /opt/metasploit/msfconsole "$@"
EOF

cat << 'EOF' > /usr/local/bin/msfvenom
#!/bin/sh
cd /opt/metasploit
ruby /opt/metasploit/msfvenom "$@"
EOF

# Attribution des permissions d'exécution
chmod +x /usr/local/bin/msfconsole /usr/local/bin/msfvenom

# Configuration de la base de données PostgreSQL (optionnel mais recommandé)
echo "[*] Souhaitez-vous configurer PostgreSQL pour Metasploit? (o/n)"
read -r response
if [ "$response" = "o" ] || [ "$response" = "O" ]; then
    echo "[*] Configuration de PostgreSQL..."
    apk add --no-cache postgresql postgresql-contrib
    mkdir -p /run/postgresql
    chown -R postgres:postgres /run/postgresql/
    
    # Initialisation de la base de données
    su postgres -c "initdb -D /var/lib/postgresql/data"
    
    # Démarrage du service PostgreSQL
    su postgres -c "pg_ctl -D /var/lib/postgresql/data start"
    
    # Création de l'utilisateur et de la base de données pour Metasploit
    su postgres -c "createuser -s msf"
    su postgres -c "createdb -O msf msf"
    
    # Configuration de Metasploit pour utiliser PostgreSQL
    cat << 'EOF' > /opt/metasploit/config/database.yml
production:
  adapter: postgresql
  database: msf
  username: msf
  password:
  host: localhost
  port: 5432
  pool: 5
  timeout: 5
EOF
    
    echo "[*] Configuration PostgreSQL terminée."
    echo "[*] Pour démarrer PostgreSQL au démarrage, ajoutez la commande suivante à votre fichier rc.local :"
    echo "su postgres -c \"pg_ctl -D /var/lib/postgresql/data start\""
fi

echo "[+] Installation de Metasploit Framework terminée!"
echo "[+] Vous pouvez maintenant lancer Metasploit en tapant 'msfconsole' dans votre terminal"
