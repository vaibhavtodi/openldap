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
      &&        DEBIAN_FRONTEND=noninteractive    apt-get   install  -y   ldap-utils                                                        \
                                                                          slapd                                                             \
                                                                          ldapvi                                                            \
      &&        rm         -f        /var/lib/ldap/*                                                                                        \
      &&        touch                /var/lib/ldap/DB_CONFIG                                                                                \
      &&        echo       "set_cachesize 0 2097152 0"  >   DB_CONFIG                                                                       \
      &&        echo       "set_lk_max_objects 1500"    >>  DB_CONFIG                                                                       \
      &&        echo       "set_lk_max_locks 1500"      >>  DB_CONFIG                                                                       \
      &&        echo       "set_lk_max_lockers 1500"    >>  DB_CONFIG                                                                       \
      &&        chmod      -r        openldap:openldap      /var/lib/ldap                                                                   \
      &&        ln         -s        /etc/default/slapd     /etc/ldap/default_slapd

# Copying the Slapd Configuration File
COPY            def_slapd.conf       /etc/ldap/slapd.conf

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

