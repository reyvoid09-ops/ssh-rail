#!/bin/bash

# Pastikan direktori SSH ada
mkdir -p /home/ubuntu/.ssh
chmod 700 /home/ubuntu/.ssh

# Masukkan public key dari environment variable Railway
echo "$SSH_PUBLIC_KEY" > /home/ubuntu/.ssh/authorized_keys
chmod 600 /home/ubuntu/.ssh/authorized_keys

# Sesuaikan kepemilikan agar bisa diakses user (UID 1000)
chown -R 1000:1000 /home/ubuntu/.ssh

# Jalankan service SSH Server di foreground
exec /usr/sbin/sshd -D
