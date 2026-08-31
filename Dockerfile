FROM alpine:latest

# Install curl
RUN apk update && apk add --no-cache curl

ARG APP_URL1
ARG APP_URL2

# Execute curl during build and display the first 2 lines
RUN echo "=== Testing APP_URL1 ===" && \
    curl -sS -L "$APP_URL1" | head -n 2 || true

RUN echo "=== Testing APP_URL2 ===" && \
    curl -sS -L "$APP_URL2" | head -n 2 || true

# Startup command to query the URL at runtime and output the first 2 lines
CMD ["sh", "-c", "echo '--- Runtime URL1 curl ---' && curl -sS -L \"$APP_URL1\" | head -n 2"]
