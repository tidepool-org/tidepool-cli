package cmd

import (
	"errors"
	"fmt"
	"os"

	"github.com/codegangsta/cli"
)

func MergeCommands(left []cli.Command, rights ...[]cli.Command) []cli.Command {
	for _, right := range rights {
		for _, command := range right {
			left = append(left, command)
		}
	}
	return left
}

func Die() {
	os.Exit(1)
}

func Error(c *cli.Context, err error) {
	fmt.Fprintf(c.App.Writer, "ERROR: %s\n", err.Error())
}

func ErrorAndDie(c *cli.Context, err error) {
	Error(c, err)
	Die()
}

func EnsureArgs(c *cli.Context, n int) {
	if len(c.Args()) != n {
		ErrorAndDie(c, errors.New("Unexpected arguments"))
	}
}

func EnsureNoArgs(c *cli.Context) {
	EnsureArgs(c, 0)
}
