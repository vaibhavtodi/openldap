# Specifing the base image
FROM            debian:8.3

# Maintainer
MAINTAINER      "Vaibhav Todi"       <vaibhavtodi1989@gmail.com>

# Specifing the Label
LABEL           Description="Docker Image where OpenLdap is setup"                                                                          \
                Version="1.0"

# Setting the Environment & Working Directory
ENV             home                 /root
WORKDIR         $home

# Installing OpenLdap
RUN             apt-get  update                                                                                                             \
      &&        DEBIAN_FRONTEND=noninteractive    apt-get   install  -y   ldap-utils  slapd

# Copy entrpoint.sh
COPY            entrypoint.sh        /entrypoint.sh

# Clearing the Docker image
RUN             apt-get    -y        clean                                                                                                  \
      &&        rm         -rf       /var/lib/apt/lists/*                                                                                   \
      &&        rm         -rf       /var/cache/*

# Mounting the vloumes
VOLUME          ["/etc/ldap", "/var/lib/ldap"]

# Exposing the ports
EXPOSE          389                  636

# CMD instruction
CMD             ["/entrypoint.sh"]

