

# Introduction

PageEventBus was a modular system build for page internal data exchange, UI and business logic independent.

## Features

- UI and business logic independent through view model
- view model can receive/send event, manipulate view
- view model can manual connect to event bus
- events' input/output data are typed
- business logic's input/output parameters can hide by event bus

## How it works

There are 3 roles in this system:

- page view controller
- child view controllers
- subviews

every role have their own view model or page model for business logic, view model can receive and send event through an event bus, view model also has an unowned view/controller reference, so it can manipulate view/controller when needed.

event bus instance was holding by view or view controller create or connect to, keep a weak ref in global manager with typed name, when no view or view controller holding an event bus, it will auto released.


# Example

the example shows how page view controller, child view controllers and subviews work together using PageEventBus.

first pod install to genereate .xcworkspace

```bash
$ pod install
```

the InfoViewModel can change information when you type phone or email, ResultViewModel can collect input data when it show on window.

view, view controller, view model, page model, event bus are released when you leave that page.
