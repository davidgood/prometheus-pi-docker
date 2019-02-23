FROM debian

ENV HOME /root
WORKDIR $HOME

COPY ./prometheus-2.7.1.linux-armv7.tar.gz $HOME

RUN useradd --no-create-home --shell /bin/false prometheus
RUN mkdir /etc/prometheus
RUN mkdir /var/lib/prometheus
RUN chown prometheus:prometheus /etc/prometheus
RUN chown prometheus:prometheus /var/lib/prometheus
RUN tar xvf prometheus-2.7.1.linux-armv7.tar.gz
RUN cp prometheus-2.7.1.linux-armv7/prometheus /usr/local/bin/
RUN cp prometheus-2.7.1.linux-armv7/promtool /usr/local/bin/
RUN chown prometheus:prometheus /usr/local/bin/prometheus
RUN chown prometheus:prometheus /usr/local/bin/promtool
RUN cp -r prometheus-2.7.1.linux-armv7/consoles /etc/prometheus
RUN cp -r prometheus-2.7.1.linux-armv7/console_libraries /etc/prometheus
RUN chown -R prometheus:prometheus /etc/prometheus/consoles
RUN chown -R prometheus:prometheus /etc/prometheus/console_libraries
COPY ./prometheus.yml /etc/prometheus/prometheus.yml
RUN chown prometheus:prometheus /etc/prometheus/prometheus.yml

CMD /usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml
