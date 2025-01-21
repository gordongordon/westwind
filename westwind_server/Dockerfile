FROM dart:3.5.2 AS build

WORKDIR /app
COPY . .

RUN dart pub get
RUN dart compile exe bin/main.dart -o bin/server

FROM alpine:latest

RUN apk add --no-cache nginx bash curl supervisor

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