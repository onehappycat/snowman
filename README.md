# ⛄️ Snowman

Snowman is a macOS status menu weather app written in SwiftUI.

## Table of Contents

- [Screenshots](#screenshots)
- [Building a Snowman](#building-a-snowman)

## Screenshots

![screenshot](screenshots/screenshots.png)

## Building a Snowman

### Requirements

- macOS 11.0+
- Swift 5.3+
- Xcode 12.0+
- An API key for a weather API service

### Development Setup

1. Add your API key to an API Service initialization in the `AppDelegate` or initialize your own service.

> Note that distributing the app with an API key built-in is **insecure** and this approach is only acceptable for personal use or testing. For any distribution purposes, use a custom backend or the [SnowmanBackend](https://github.com/onehappycat/snowman_backend).

All done and ready to build! No dependencies or further steps necessary.

### Implementing Support for an API Service

1. Conform to `APIServiceProtocol`.
2. Initialize the service in the `AppDelegate` and inject it into the `LocationsListViewModel`.
