FROM ubuntu:latest

# Hindari interaksi saat instalasi paket
ENV DEBIAN_FRONTEND=noninteractive

# Install OpenSSH Server, sudo, dan curl
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Setup user 'ubuntu' (bisa diubah sesuai keinginan)
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 ubuntu
RUN echo 'ubuntu:password_anda' | chpasswd

# Konfigurasi SSHD untuk container
RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# Salin script entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose Port SSH dan Port Web Default Railway
EXPOSE 22 8080

# Jalankan entrypoint saat container mulai
ENTRYPOINT ["/entrypoint.sh"]
