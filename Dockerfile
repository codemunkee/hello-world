FROM golang:1.18
WORKDIR /usr/src/hello-world
COPY go.mod main.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o hello-world .

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /usr/src/hello-world ./
EXPOSE 8080/tcp
CMD ["/root/hello-world"]  
