# Base image
FROM alpine:3.23

# Install MariaDB server
RUN apk add --no-cache mariadb mariadb-client

# Create directory for runtime socket
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Copy custom config (optional but good practice for inception)
COPY conf/my.cnf /etc/mysql/my.cnf

# Copy init script
COPY ./tools/init_db.sh /init_db.sh
RUN chmod +x /init_db.sh

# Expose MariaDB port
EXPOSE 3306

# Needed Fix!
RUN sed -i '/skip-networking/d' /etc/my.cnf.d/mariadb-server.cnf

# Start MariaDB through init script
ENTRYPOINT ["/init_db.sh"]

