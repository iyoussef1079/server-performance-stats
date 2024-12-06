FROM debian:stable-slim

WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y \
    htop \
    procps \
    net-tools \
    sysstat \
    psmisc \
    iproute2 \
    wget \
    vim \
    && rm -rf /var/lib/apt/lists/*

RUN chmod +x ./server-stats.sh

# Create a dummy auth.log file since Docker won't have one
RUN touch /var/log/auth.log

CMD ["./server-stats.sh"]