FROM docker.elastic.co/elasticsearch/elasticsearch:7.10.1
COPY --chown=elasticsearch:elasticsearch elasticsearch.yml /usr/share/elasticsearch/config/
COPY --chown=elasticsearch:elasticsearch logging.yml /usr/share/elasticsearch/config/

USER elasticsearch
ENV PATH=$PATH:/usr/share/elasticsearch/bin
CMD ["elasticsearch"]
EXPOSE 9200 9300