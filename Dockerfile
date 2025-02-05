FROM golang:1.23

WORKDIR /usr/src/app

RUN go install github.com/maaslalani/slides@latest

COPY . .

EXPOSE 53531
ENTRYPOINT ["./presentation.md"]
CMD ["serve"]