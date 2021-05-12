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

To build and run the Snowman app:

1. Create an `AppConfiguration.plist` file by copying the template `AppConfiguration-template.plist`.

2. Configure the default OpenWeather API or setup an API service of your choice.

#### OpenWeather API

The OpenWeather API is set as the default API service. To use it, simply configure your API key:

1. Set your API key as the value for the `apiKey` in the `AppConfiguration.plist`.

> Note that distributing the app with an API key built-in is **insecure** and this approach is only acceptable for personal use or testing. For any distribution purposes, use a custom backend or the [SnowmanBackend](https://github.com/onehappycat/snowman_backend).

#### SnowmanBackend

To use the [SnowmanBackend](https://github.com/onehappycat/snowman_backend), or any other custom backend, which provides a response that can be decoded using the `SnowmanResponse` (i.e., it has the same format and contains all the required attributes):

1. Initialize the `SnowmanAPI` in the `AppDelegate` with either of the following parameters:

	- `hostname`: the hostname and port of your server (e.g., `www.example.com:3000`); or

	- `url`: the full base URL of the `forecast` resource (e.g., `https://www.example.com:3000/api/v1/forecast`).

#### Custom Backend

If the response of your custom backend can be decoded using the `SnowmanResponse` (i.e., it has the same format and contains all the required attributes), you can utilize the `SnowmanAPI` (see [SnowmanBackend](#snowmanbackend)). If it can't be, you need to implement the support for your custom service.

### Implementing Support for an API Service

1. Conform to the `APIServiceProtocol`.
2. Initialize the service in the `AppDelegate` and inject it into the `LocationsListViewModel`.
