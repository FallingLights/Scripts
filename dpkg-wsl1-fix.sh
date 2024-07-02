#!/bin/bash

echo "Starting dpkg error fixing script for WSL1..."

# Try 1
echo "Attempting Try 1..."
sudo mv /var/lib/dpkg/info/libc-bin.* /tmp/
sudo dpkg --remove --force-remove-reinstreq libc-bin
sudo dpkg --purge libc-bin
sudo apt install libc-bin
sudo mv /tmp/libc-bin.* /var/lib/dpkg/info/

# Try 2
echo "Attempting Try 2..."
sudo dpkg --remove --force-remove-reinstreq --force-remove-essential --force-depends libc-bin
sudo dpkg --purge --force-remove-reinstreq --force-remove-essential --force-depends libc-bin
sudo mv /var/lib/dpkg/info/libc6:amd64.* /tmp/
sudo apt install -f libc-bin
sudo mv /tmp/libc6:amd64.* /var/lib/dpkg/info/

# Try 3
echo "Attempting Try 3..."
apt download libc-bin
dpkg -x libc-bin*.deb unpackdir/
sudo cp unpackdir/sbin/ldconfig /sbin/
sudo mv /var/lib/dpkg/info/libc6:amd64.* /tmp/
sudo apt install -f libc-bin
sudo mv /tmp/libc6:amd64.* /var/lib/dpkg/info/

# Try 4
echo "Attempting Try 4..."
for PROBDIR in "" "/usr" "/usr/local"; do 
    find "${PROBDIR}/lib/x86_64-linux-gnu" -type f -ls
done

# Try 5
echo "Attempting Try 5..."
for PROBDIR in "" "/usr" "/usr/local"; do 
    find "${PROBDIR}/lib/x86_64-linux-gnu" -type f -ls
done
sudo apt-get dist-upgrade
sudo apt-get autoremove

# Try 6
echo "Attempting Try 6..."
for PROBDIR in "" "/usr" "/usr/local"; do 
    find "${PROBDIR}/lib/x86_64-linux-gnu" -type f -ls
done
sudo apt install libc-bin -y
sudo mv /var/lib/dpkg/info/libc-bin.* /tmp/
sudo apt install libc-bin -y

echo "All tries completed. If the issue persists, further investigation is required."

exit 0
