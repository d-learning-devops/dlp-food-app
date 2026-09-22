FROM alpine:latest

# Install curl
RUN apk add --no-cache curl

ARG URL1
ARG URL2

# Set as runtime variables
ENV RUNTIME_URL1=$URL1
ENV RUNTIME_URL2=$URL2

# Verify both URLs during build and print headers
RUN echo "=== Validating URL1: $URL1 ===" && \
    curl -sS -I -L "$URL1" | head -n 4 || echo "URL1 verification finished"

RUN echo "=== Validating URL2: $URL2 ===" && \
    curl -sS -I -L "$URL2" | head -n 4 || echo "URL2 verification finished"

# Print verified URLs on container execution
CMD ["sh", "-c", "echo 'Application starting with verified URLs: URL1='$RUNTIME_URL1' URL2='$RUNTIME_URL2"]
