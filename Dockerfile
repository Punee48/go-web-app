FROM golang:1.25-alpine AS build

WORKDIR /app

COPY go.mod .

#CMD will install dependencies in the go.mod file like pom.xml and requirements.txt file in python
RUN go mod download

COPY . .

RUN go build -o main .

# Final Stage in distroless image
FROM alpine:latest

RUN adduser -D appuser

WORKDIR /app

COPY --from=build /app/main .

#Copy the static file from the binary image
COPY --from=build /app/static ./static

RUN chmod +x ./main && chown appuser:appuser ./main

USER appuser

#EXPOSE THE PORT
EXPOSE 8080

CMD ["./main"]

