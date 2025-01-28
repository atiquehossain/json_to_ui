<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.


<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# json_to_ui

The `json_to_ui` package allows you to dynamically generate Flutter UI based on JSON configuration data. This is particularly useful for building applications where the UI needs to be flexible and defined at runtime, such as apps with dynamic content or user-generated layouts.

## Features

- **Dynamic UI Rendering**: Build complex Flutter widgets like `Scaffold`, `Container`, `Text`, `Button`, etc., from JSON.
- **Customizable Styling**: Apply various styles such as colors, fonts, padding, and borders directly from the JSON.
- **Supports Common Widgets**: Includes support for Flutter's basic widgets such as `Text`, `Row`, `Column`, `Container`, `Padding`, and `ElevatedButton`.
- **Hive Integration**: Optionally save and retrieve JSON data using the Hive database for offline functionality.
- **Network Fetching**: Retrieve UI configurations from a remote server using HTTP requests.

## Getting started

To use the `json_to_ui` package, you'll need to add it to your `pubspec.yaml`:

```yaml
dependencies:
  json_to_ui: ^1.0.0
