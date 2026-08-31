FROM alpine:latest

# Install curl
RUN apk update && apk add --no-cache curl

ARG APP_URL1
ARG APP_URL2

# Clean and normalize URLs to prevent double-prefixing or missing schemes
RUN echo "=== Testing APP_URL1 ===" && \
    TARGET_URL1=$(echo "$APP_URL1" | sed 's|https://https://|https://|') && \
    echo "Querying: $TARGET_URL1" && \
    curl -sS -L "$TARGET_URL1" | head -n 2 || true

RUN echo "=== Testing APP_URL2 ===" && \
    TARGET_URL2=$(echo "$APP_URL2" | sed 's|https://https://|https://|') && \
    echo "Querying: $TARGET_URL2" && \
    curl -sS -L "$TARGET_URL2" | head -n 2 || true

CMD ["sh", "-c", "curl -sS -L \"$APP_URL1\" | head -n 2"]
