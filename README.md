

# Introduction

PageEventBus was a modular system build for page internal data exchange, UI and business logic independent.

## Features

- UI and business logic independent through view model
- view model can receive/send event, manipulate view
- view model can auto connect to event bus when they holding by a visible view
- events' input/output data are typed

## How it works

There are 3 roles in this system:

- page view controller
- child view controllers
- subviews

every role have their own view model for business logic, view model can receive and send event through an event bus, view model also has an unowned view reference, so it can manipulate view when needed.

event bus instance was holding by page view controller, child view controller and subviews will connect to event bus when their view didMoveToWindow, through responder chain.


# Example

the example shows how page view controller, child view controllers and subviews work together using PageEventBus.

first pod install to genereate .xcworkspace

```bash
$ pod install
```

the InfoViewModel can change information when you type phone or email, ResultViewModel can collect input data when it show on window.
