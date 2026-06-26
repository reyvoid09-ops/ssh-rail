FROM ubuntu:22.04

# Install SSH Server dan tools dasar
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    curl \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Konfigurasi agar SSH mengizinkan login dengan password dan root
RUN mkdir -p /var/run/sshd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Ekspos port 22
EXPOSE 22

# Buat env untuk password default (bisa diubah di dashboard Railway)
ENV SSH_PASSWORD="12345678"

# Jalankan script untuk set password dan start SSH service
CMD echo "root:$SSH_PASSWORD" | chpasswd && /usr/sbin/sshd -D
