package main

import (
	"context"
	"encoding/csv"
	"io"
	"log"
	"strconv"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3"
)

type User struct {
	ID   int
	Name string
}

func hello(ctx context.Context, event events.S3Event) error {
	for _, rec := range event.Records {
		svc := s3.New(session.New(&aws.Config{Region: aws.String(rec.AWSRegion)}))
		s3out, err := svc.GetObject(&s3.GetObjectInput{
			Bucket: aws.String(rec.S3.Bucket.Name),
			Key:    aws.String(rec.S3.Object.Key),
		})

		if err != nil {
			log.Fatal(err)
		}

		reader := csv.NewReader(s3out.Body)
		reader.LazyQuotes = true

		for {
			record, err := reader.Read()
			if err == io.EOF {
				break
			}
			id, _ := strconv.Atoi(record[0])
			name := record[1]

			user := User{
				ID:   id,
				Name: name,
			}
			log.Printf("%d: %v", user.ID, user.Name)
		}
		log.Println("end")
	}
	return nil
}

func main() {
	lambda.Start(hello)
}
