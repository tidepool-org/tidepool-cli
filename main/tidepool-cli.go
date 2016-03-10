package main

import (
	"os"

	"github.com/tidepool-org/tidepool-cli/cmd"
)

func main() {
	cmd.NewApp().Run(os.Args)
}
