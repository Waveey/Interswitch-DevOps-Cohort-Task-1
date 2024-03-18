# Use a minimal base image
FROM golang:1.21-alpine AS build

# Set the current working directory inside the container
WORKDIR /app

# Copy the Go module files
COPY go.mod ./

# Download and cache Go modules
RUN go mod download

# Copy the rest of the application source code
COPY . .

# Build the application
RUN go build -o http-echo .

# Create a new stage with a minimal base image
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the built executable from the previous stage
COPY --from=build /app/http-echo .

# Expose the port that the server will listen on
EXPOSE 5678

# Set the ECHO_TEXT environment variable
ENV ECHO_TEXT="Ogonna Nnamani's submission"

# Set the entry point for the container
ENTRYPOINT ["./http-echo"]

