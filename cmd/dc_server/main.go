package main

import (
	"fmt"
	"net/http"

	"github.com/Tboules/dc_go_server/internal/routes"
)

func main() {
	router := routes.NewRouter()

	port := 8080
	address := fmt.Sprintf(":%d", port)

	fmt.Printf("Server running on port: %s\n", address)

	err := http.ListenAndServe(address, router)
	if err != nil {
		panic(err)
	}
}
