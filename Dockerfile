FROM nginx:latest

ARG ROOT=/app
ARG APP_ENV
ARG APP_PORT

ENV APP_ENV $APP_ENV
ENV PORT $APP_PORT

RUN apt-get update && apt-get install -y supervisor
COPY /devops/supervisor/supervisor.conf /etc/supervisord.conf

COPY /devops/nginx/default.conf.template /etc/nginx/conf.d/default.conf.template
COPY /devops/nginx/nginx.conf /etc/nginx/nginx.conf
COPY public $ROOT/public
COPY storage $ROOT/storage

ADD /devops/scripts/entrypoint.sh /
RUN chmod +x /entrypoint.sh

CMD ["/bin/bash", "-c", "/entrypoint.sh ${PORT}"]
