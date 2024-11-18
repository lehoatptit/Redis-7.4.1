#redis version 7.4.1
FROM docker.io/library/redis:7.4.1-alpine3.20

#tao thu muc lam viec
RUN mkdir -p /etc/redis/
RUN mkdir -p /etc/redis/data && \
    mkdir -p /etc/redis/logs && \
    mkdir -p /etc/redis/conf
# thu muc lam viec
WORKDIR /etc/redis/

# copy file cau hinh redis vao thu muc lam viec container
COPY conf/redis.conf /etc/redis/conf/redis.conf

# Copy script entrypoint
COPY redis-entrypoint.sh /usr/local/bin/

# thiet lap quyen thuc thi va so huu file
RUN chown redis:redis /etc/redis/* && \
    chmod +x /usr/local/bin/redis-entrypoint.sh

# mo port  26379 cho Redis trong image
EXPOSE 6379

# dat entrypoint cho contaienr thuc thi lenh chay service redis
ENTRYPOINT ["sh", "/usr/local/bin/redis-entrypoint.sh"]
