package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	fileServer := http.FileServer(http.Dir("/html"))
	http.Handle("/", fileServer)

	fmt.Printf("Starting server at port 80")
	if err := http.ListenAndServe(":80", nil); err != nil {
		log.Fatal(err)
	}
}
