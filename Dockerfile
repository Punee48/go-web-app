FROM golang:1.25 AS build

WORKDIR /app

COPY go.mod .

#CMD will install dependencies in the go.mod file like pom.xml and requirements.txt file in python 
RUN go mod download 

COPY . .

RUN go build -o main .

CMD ["/app/main"]

#EXPOSE THE PORT 
EXPOSE 8080

