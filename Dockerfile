FROM centos:centos7
MAINTAINER Zdravko Zdravkov <zdravko@octoon.net>
# Special thanks for Prashanth Goriparthi <prashanth@goriparthi.com>

RUN yum -y update; yum clean all
RUN yum -y install sudo epel-release; yum clean all

#Sudo requires a tty. fix that.
RUN sed -i 's/.*requiretty$/#Defaults requiretty/' /etc/sudoers

# Install pgdg repo for getting new postgres RPMs
RUN rpm -ivh https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-3.noarch.rpm

# Install Postgres Version 9.5
RUN yum install postgresql95-server postgresql95 postgresql95-libs postgresql95-contrib postgresql95-plperl postgresql95-devel -y --nogpgcheck

# Modified setup script to bypass systemctl variable read stuff
ADD ./postgresql95-setup /usr/pgsql-9.5/bin/postgresql95-setup

#Modify perms on setup script
RUN chmod +x /usr/pgsql-9.5/bin/postgresql95-setup

#Access from all over --- NEVER DO THIS SHIT IN POST DEV ENVs !!!!!!!!!!!!!!!!!!! <--- READ THIS 
ADD ./postgresql.conf /postgresql.conf
ADD ./pg_hba.conf /pg_hba.conf

#Add start script for postgres
ADD ./start_postgres.sh /start_postgres.sh

RUN chmod +x /start_postgres.sh

EXPOSE 5432

#Run pgEngine
CMD ["/start_postgres.sh"]
