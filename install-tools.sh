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
pip3 install -r /opt/recon-ng/REQUIREMENTS
ln -s /opt/recon-ng/recon-ng /usr/local/bin/recon-ng
chmod +x /usr/local/bin/recon-ng
# 4. Installation de Metasploit Framework (manuel car Alpine ne l’inclut pas facilement)
echo "[*] Installation de Metasploit (cela peut prendre un moment)..."
gem install bundler
git clone https://github.com/rapid7/metasploit-framework.git /opt/metasploit
cd /opt/metasploit
bundle config set --local without 'development test'
bundle install
ln -s /opt/metasploit/msfconsole /usr/local/bin/msfconsole
ln -s /opt/metasploit/msfvenom /usr/local/bin/msfvenom
chmod +x /usr/local/bin/msfconsole /usr/local/bin/msfvenom
echo "[*] Installation terminée. Teste les outils avec : nikto, gobuster, recon-ng, msfconsole"
