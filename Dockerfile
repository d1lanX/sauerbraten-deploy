FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    tar \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Download the latest Sour Linux release
RUN LATEST=$(curl -s https://api.github.com/repos/cfoust/sour/releases/latest \
      | grep browser_download_url \
      | grep linux \
      | cut -d '"' -f 4) \
    && curl -L "$LATEST" -o sour.tar.gz \
    && tar -xzf sour.tar.gz \
    && rm sour.tar.gz \
    && chmod +x sour

EXPOSE 1337
EXPOSE 28785/udp

CMD ["./sour"]
