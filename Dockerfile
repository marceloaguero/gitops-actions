FROM golang:1.12 as builder

ENV GO111MODULE=on
WORKDIR /go/src/github.com/marceloaguero/gitops-actions
COPY . .

RUN go get -d -v ./...
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /go/bin/gitops-actions .

FROM scratch
WORKDIR /root/
COPY --from=builder /go/bin/gitops-actions .
EXPOSE 8080
ENTRYPOINT ["./gitops-actions"]
