package cmd

import (
	"fmt"

	"github.com/codegangsta/cli"
	"github.com/tidepool-org/tidepool-cli/version"
)

func VersionCommands() []cli.Command {
	return []cli.Command{
		{
			Name:   "version",
			Usage:  "print the base version",
			Action: versionBase,
			Subcommands: []cli.Command{
				{
					Name:   "base",
					Usage:  "print the base version",
					Action: versionBase,
				},
				{
					Name:   "short",
					Usage:  "print the short version, including short git commit",
					Action: versionShort,
				},
				{
					Name:   "long",
					Usage:  "print the long version, including long git commit",
					Action: versionLong,
				},
				{
					Name:   "commit",
					Usage:  "print the long git commit",
					Action: versionCommit,
				},
			},
		},
	}
}

func versionBase(c *cli.Context) {
	EnsureNoArgs(c)
	fmt.Fprintln(c.App.Writer, version.Base)
}

func versionShort(c *cli.Context) {
	EnsureNoArgs(c)
	fmt.Fprintln(c.App.Writer, version.Short())
}

func versionLong(c *cli.Context) {
	EnsureNoArgs(c)
	fmt.Fprintln(c.App.Writer, version.Long())
}

func versionCommit(c *cli.Context) {
	EnsureNoArgs(c)
	fmt.Fprintln(c.App.Writer, version.Commit)
}
