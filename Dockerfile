# Builder
FROM rust:alpine as builder
WORKDIR /usr/src/lisho

# Nur die notwendigen Dateien für den Build kopieren
COPY Cargo.toml Cargo.lock ./
COPY src ./src

RUN cargo build --release

# Runtime
FROM gcr.io/distroless/static-debian12:nonroot
WORKDIR /app

# EXPOSE früh für besseres Layer-Caching
EXPOSE 8080

# Nur die kompilierte Binary kopieren
COPY --from=builder /usr/src/lisho/target/release/lisho /app/lisho

ENTRYPOINT ["/app/lisho"]
# mappings.txt wird zur Laufzeit per bind-mount bereitgestellt
CMD ["/app/mappings.txt", "0.0.0.0:8080"]
