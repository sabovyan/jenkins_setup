FROM ubuntu:latest

# ENV NVM_DIR /usr/local/nvm

# replace shell with bash so we can source files
# RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt update -y && \
    apt upgrade -y

RUN apt install nginx -y

RUN mkdir app
COPY client app
COPY app.conf /etc/nginx/sites-available/default


# RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
# RUN source $NVM_DIR/nvm.sh
# RUN nvm install --lts

EXPOSE 80

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]