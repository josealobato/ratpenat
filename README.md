# Project "ratpenat"

> This project is under initial development

The "ratpenat" project is an iOS app to help dyslexic students keep up with their lessons. It will allow them to manage a library of audio snippets for their studies and automatically schedule their study sessions.

**"Ratpenat"** means bat in Catalan (see https://ca.wikipedia.org/wiki/Ratpenats). The name was chosen by **my son Pau**.

> Developer's note: This project is over-engineered. It could have been developed with a simple architecture and a more direct implementation. Still, I use it to practice architecture skills and experiment with new ideas. It also means that it will evolve as I practice new things.

## Documentation

All project development is traced using Github projects (see https://github.com/josealobato/ratpenat/projects?type=beta), and all decisions can be found on the included ADR (find them in [`doc/adr`](doc/adr)).

## Set up for development

This project uses [Swiftlint](https://github.com/realm/SwiftLint). Install it with [Homebrew](http://brew.sh/):

```shell
brew install swiftlint
```

## About Test

The project uses [Sourcery](https://github.com/krzysztofzablocki/Sourcery) to generate all mocks objects used on tests. When running the following command, you will get all generated files in folders like `Ratpenat/Package/<name>/Test/<name>Test/Generated/AutoMockable.generated.swift`.
    
```shell
rake mocks
```