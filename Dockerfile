FROM node:20-bookworm-slim

# Render construit ce dépôt puis clone le code du bot dans l'image.
# Bookworm est maintenu ; les retries limitent les erreurs transitoires des miroirs Debian.
RUN rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && apt-get update -o Acquire::Retries=5 \
    && apt-get install -y --no-install-recommends --fix-missing ffmpeg git \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/user-i98625/OVL-MD-V2.git /ovl_bot
WORKDIR /ovl_bot

RUN npm install --omit=dev

EXPOSE 8000

CMD ["npm", "run", "Ovl"]
