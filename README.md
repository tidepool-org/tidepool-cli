# tidepool-cli

A command-line tool to easily interact with the Tidepool platform API.

[![Build Status](https://travis-ci.org/tidepool-org/tidepool-cli.png)](https://travis-ci.org/tidepool-org/tidepool-cli)

# Environment

1. Create a brand new `go` directory.
1. Set the `GOPATH` environment variable to the new `go` directory.
1. Add `$GOPATH/bin` to the `PATH` environment variable.
1. Execute `go get github.com/tidepool-org/tidepool-cli` to pull down the project.
1. Change directory to `$GOPATH/src/github.com/tidepool-org/tidepool-cli`.
1. Execute `make editable` to install the various Go tools needed for building and editing the project.

# Makefile

* To setup your Go environment for building and editing the project:

```
make editable
```

* To build the executables:

```
make build
```

All executables are built in the `_bin` directory.

* To run `go fmt`, `goimports`, and `go vet` all at once:

```
make pre-commit
```

* To clean the project of all build files:

```
make clean
```

* To add the required git hooks:

```
make git-hooks
```

# Sublime Text

If you use the Sublime Text editor with the GoSublime plugin, open the `tidepool-cli.sublime-project` project to ensure the `GOPATH` and `PATH` environment variables are set correctly within Sublime Text. In addition, the recommended user settings are:

```
{
  "autocomplete_builtins": true,
  "autocomplete_closures": true,
  "autoinst": false,
  "fmt_cmd": [
    "goimports"
  ],
  "fmt_enabled": true,
  "fmt_tab_width": 4,
  "use_named_imports": true
}
```
