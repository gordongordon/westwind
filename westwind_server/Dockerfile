# If you update the dart version, make sure the image is
# compatible with the busybox image.
FROM dart:3.5.2 AS build

WORKDIR /app
COPY . .

RUN dart pub get
RUN dart compile exe bin/main.dart -o bin/server

# delopy heroku
FROM alpine:latest
# heroku
RUN apk add --no-cache nginx bash curl supervisor

# If you update the busybox version, make sure the image is
# compatible with the dart image.
#heroku 
# FROM busybox:1.36.1-glibc

# ENV runmode=development
#ENV runmode=production
#ENV serverid=default
#ENV logging=normal
#ENV role=monolith
#ENV role=serverless

COPY --from=build /runtime/ /
COPY --from=build /app/bin/server server
COPY --from=build /app/config/ config/
COPY --from=build /app/web/ web/
COPY --from=build /app/migrations/ migrations/

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

CMD ["/start.sh"]