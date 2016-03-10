package main

import (
	"fmt"

	"github.com/tidepool-org/tidepool-cli/version"
)

func main() {
	fmt.Println(version.Long())
}
