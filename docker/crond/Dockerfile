FROM fametec/glpi

RUN yum -y install cronie
 
ADD crontab /etc/crontab

VOLUME ["/var/www/html"]

ENTRYPOINT [ "crond", "-s", "-x", "bit", "-n", "/etc/crontab" ]
