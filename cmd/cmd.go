package cmd

import (
	"github.com/codegangsta/cli"
	"github.com/tidepool-org/tidepool-cli/version"
)

func NewApp() *cli.App {
	app := cli.NewApp()
	app.Usage = "Command-line interface to interact with the Tidepool API"
	app.Version = version.Long()
	app.Authors = []cli.Author{
		{"Jamie Bate", "jamie@tidepool.org"},
		{"Darin Krauss", "darin@tidepool.org"},
	}
	app.Copyright = "Copyright \u00A9 2016, Tidepool Project"
	app.HideVersion = true
	app.Commands = MergeCommands(
		VersionCommands(),
	)
	return app
}
