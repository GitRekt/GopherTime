FROM bitnami/golang:1.13 as builder
COPY main.go /
RUN go build /main.go

FROM bitnami/minideb:stretch
RUN mkdir -p /app
WORKDIR /app
COPY --from=builder /go/main .
COPY home.html .
RUN useradd -r -u 1001 -g root nonroot
RUN chown -R nonroot /app
USER nonroot
ENV PORT=8080
CMD /app/main
