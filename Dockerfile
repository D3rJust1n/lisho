# Builder
FROM rust:alpine AS builder
WORKDIR /usr/src/lisho

COPY Cargo.toml Cargo.lock ./
COPY src ./src

RUN cargo build --release

FROM gcr.io/distroless/static-debian12:nonroot
WORKDIR /app

EXPOSE 8080

COPY --from=builder /usr/src/lisho/target/release/lisho /app/lisho

ENTRYPOINT ["/app/lisho"]
CMD ["/app/mappings.txt", "0.0.0.0:8080"]