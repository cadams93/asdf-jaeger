<div align="center">

# asdf-jaeger [![Build](https://github.com/cadams93/asdf-jaeger/actions/workflows/build.yml/badge.svg)](https://github.com/cadams93/asdf-jaeger/actions/workflows/build.yml) [![Lint](https://github.com/cadams93/asdf-jaeger/actions/workflows/lint.yml/badge.svg)](https://github.com/cadams93/asdf-jaeger/actions/workflows/lint.yml)


[jaeger](https://github.com/cadams93/asdf-jaeger) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add jaeger https://github.com/cadams93/asdf-jaeger.git
```

jaeger:

```shell
# Show all installable versions
asdf list-all jaeger

# Install specific version
asdf install jaeger latest

# Set a version globally (on your ~/.tool-versions file)
asdf global jaeger latest

# Now jaeger commands are available
jaeger --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/cadams93/asdf-jaeger/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [callum.adams](https://github.com/cadams93/)
