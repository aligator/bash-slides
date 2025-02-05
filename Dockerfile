FROM golang:1.23

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
    python3 \
    python-is-python3 \
    && rm -rf /var/lib/apt/lists/*
RUN go install github.com/maaslalani/slides@latest

COPY . .

VOLUME /keys
EXPOSE 53531
ENTRYPOINT ["./presentation.md"]
CMD ["serve", "--keyPath", "/keys", "--host", "0.0.0.0"]