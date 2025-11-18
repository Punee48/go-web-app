FROM golang:1.22.5-alpine AS build

WORKDIR /app

COPY go.mod .

#CMD will install dependencies in the go.mod file like pom.xml and requirements.txt file in python 
RUN go mod download 

COPY . .

RUN go build -o main .

# Final Stage in distroless image 
FROM gcr.io/distroless/base

WORKDIR /app

COPY --from=build /app/main .

#Copy the static file from the binary image
COPY --from=build /app/static ./static

#EXPOSE THE PORT 
EXPOSE 8080

CMD ["./main"] #Run the applications
