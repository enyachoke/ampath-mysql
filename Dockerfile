FROM mysql:5.7
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      cron rsyslog \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
 COPY ./crontab-sample /etc/cron.d/etl-schedule-task
 RUN chmod 0644 /etc/cron.d/etl-schedule-task
 ENV TZ=Africa/Nairobi
 RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure -f noninteractive tzdata
 RUN echo "cron.* /var/log/cron.log" >> /etc/rsyslog.conf
 COPY ./run.sh run.sh
 RUN chmod +x run.sh
 CMD /run.sh