FROM httpd:2.4-alpine

ARG HOST_USER_ID
ARG HOST_GROUP_ID

COPY custom.conf /usr/local/apache2/conf/custom.conf
COPY project.conf /usr/local/apache2/conf/project.conf

COPY certs/server.crt /usr/local/apache2/conf/server.crt
COPY certs/server.key /usr/local/apache2/conf/server.key

RUN printf "Include conf/custom.conf\n" >> /usr/local/apache2/conf/httpd.conf && \
    printf "Include conf/project.conf" >> /usr/local/apache2/conf/httpd.conf

# create a user and group with the same id as the host user
RUN addgroup -g ${HOST_GROUP_ID} hostuser \
    && adduser -u ${HOST_USER_ID} -G hostuser -H -D hostuser

RUN sed -i \
   -e "s/User daemon/User hostuser/g" \
   -e "s/Group daemon/Group hostuser/g" \
   /usr/local/apache2/conf/httpd.conf

RUN mkdir -p /usr/local/apache2/run \
   && chown -R hostuser:hostuser /usr/local/apache2 \
   && chmod -R 755 /usr/local/apache2/logs \
   && chmod -R 755 /usr/local/apache2/run

RUN sed -i \
    -e 's/^#\(Include .*httpd-ssl.conf\)/\1/' \
    -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' \
    conf/httpd.conf