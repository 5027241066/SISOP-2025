echo "CPU Model: $(lscpu | grep -m1 'Model name' | cut -d ':' -f2 | xargs)"
echo "CPU Usage: $(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}')%"
echo "Terminal: $(tty)"
