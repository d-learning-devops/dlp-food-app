FROM alpine:latest
ARG APP_URL1
ARG APP_URL2
RUN echo "Building image with injected URLs"
CMD ["sh", "-c", "echo App URL 1: $APP_URL1 && echo App URL 2: $APP_URL2"]
