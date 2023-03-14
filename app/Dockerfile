FROM golang:alpine AS builder

WORKDIR /app/
COPY . /app/
RUN go build -o app.bin .

FROM alpine:latest
COPY --from=builder /app/app.bin /app/app.bin
COPY ./html /html
EXPOSE 80
ENTRYPOINT ["/app/app.bin"]


