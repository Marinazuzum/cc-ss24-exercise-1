# Build stage
FROM golang:1.22 as builder
WORKDIR /app
COPY . .
RUN go mod tidy && go build -o app ./cmd/main.go

# Final image
FROM gcr.io/distroless/base-debian11
WORKDIR /app
COPY --from=builder /app/app .
COPY views/ ./views/
COPY css/ ./css/
EXPOSE 3030
CMD ["./app"]
