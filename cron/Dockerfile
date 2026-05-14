FROM ubuntu:latest

# Install cron
RUN apt-get update \
    && apt-get install -y --no-install-recommends cron php-cli \
    && ln -s /usr/bin/php /usr/local/bin/php \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN ln -s /app /root/www

# Add crontab file in the cron directory
COPY cronlist /etc/cron.d/simple-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/simple-cron
RUN crontab /etc/cron.d/simple-cron

# Run the command on container startup
CMD ["cron", "-f"]
