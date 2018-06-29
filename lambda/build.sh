#!/bin/bash

GOOS=linux GOARCH=amd64 go build -o hello hello.go
zip handler.zip ./hello
