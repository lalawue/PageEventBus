

# Introduction

PageEventBus was a modular system build for page internal data exchange, UI and business logic independent.

## Features

- UI and business logic independent through view model
- view model can receive/send event, manipulate view
- view model can manual connect to event bus
- events' input/output data are typed
- business logic's input/output parameters can hide by event bus

# Example

first pod install to genereate .xcworkspace

```bash
$ cd Example
$ pod install
$ open ViewComponent.xcworkspace
```

using [Then](https://github.com/devxoul/Then/) from [Suyeol Jeon](https://github.com/devxoul/)
