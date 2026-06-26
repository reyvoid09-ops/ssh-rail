#!/bin/bash

# Pastikan direktori SSH ada
mkdir -p /home/ubuntu/.ssh
chmod 700 /home/ubuntu/.ssh

# Masukkan public key dari environment variable Railway SSH_PUBLIC_KEY kosong atau tidak
if [ -z "$SSH_PUBLIC_KEY" ]; then
    echo "ERROR: SSH_PUBLIC_KEY environment variable is empty!"
    exit 1
else
    # Menggunakan printf untuk menghindari masalah whitespace/newline dari Railway
    printf "%s\n" "$SSH_PUBLIC_KEY" > /home/ubuntu/.ssh/authorized_keys
    chmod 600 /home/ubuntu/.ssh/authorized_keys
    echo "Success: SSH_PUBLIC_KEY has been written to authorized_keys."
fi

# Sesuaikan kepemilikan agar bisa diakses user (UID 1000)
chown -R 1000:1000 /home/ubuntu/.ssh

# Jalankan service SSH Server di foreground
exec /usr/sbin/sshd -D
