package main

import (
	"fmt"
	"log"

	"golang.org/x/net/websocket"
)

//var origin = "http://localhost/"
//var url = "ws://localhost:8080/echo"

func main() {
	ws, err := websocket.Dial("ws://localhost:8080/echo", "", "http://11.com")
	if err != nil {
		log.Fatal(err)
	}

	message := []byte("hello, world ，朱世伟!")
	_, err = ws.Write(message)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Send: %s\n", message)

	var msg = make([]byte, 512)
	_, err = ws.Read(msg)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Receive: %s\n", msg)
}