# json_to_ui

`json_to_ui` is a Flutter package that enables dynamic UI generation from JSON configurations. It simplifies building flexible and dynamic user interfaces, making it ideal for applications that require runtime UI changes or user-generated layouts.

## Features

- **Dynamic UI Rendering**: Generate Flutter widgets such as `Scaffold`, `Container`, `Text`, `Button`, and more from JSON.
- **Customizable Styling**: Apply colors, fonts, padding, borders, and other styles via JSON.
- **Supports Common Widgets**: Works with `Text`, `Row`, `Column`, `Container`, `Padding`, `ElevatedButton`, etc.
- **Hive Integration**: Store and retrieve JSON-based UI configurations locally for offline support.
- **Network Fetching**: Load UI configurations from a remote server via HTTP requests.

## Installation

Add `json_to_ui` to your `pubspec.yaml`:

```yaml
dependencies:
  json_to_ui: ^1.0.0
```

Then, run:

```sh
dart pub get
```

Import the package in your Dart file:

```dart
import 'package:json_to_ui/json_to_ui.dart';
```

## Usage

Example of rendering UI from JSON:

## Example JSON for UI Generation

The following JSON can be used to generate a dynamic UI with the `json_to_ui` package:

```json
{
  "type": "Scaffold",
  "backgroundColor": "#f4f4f4",
  "appBar": {
    "type": "AppBar",
    "backgroundColor": "#6200EE",
    "title": {
      "type": "Text",
      "text": "Resume",
      "style": {
        "color": "#FFFFFF",
        "fontSize": 22,
        "fontWeight": "bold"
      }
    }
  },
  "body": {
    "type": "Center",
    "child": {
      "type": "Padding",
      "padding": {
        "top": 20,
        "left": 20,
        "right": 20,
        "bottom": 20
      },
      "child": {
        "type": "Column",
        "mainAxisAlignment": "center",
        "crossAxisAlignment": "center",
        "children": [
          {
            "type": "CircleAvatar",
            "backgroundImage": {
              "type": "NetworkImage",
              "url": "https://i.pinimg.com/280x280_RS/0e/df/b6/0edfb6a1f3a458cf1d01d03012717ac3.jpg"
            },
            "radius": 60
          },
          {
            "type": "SizedBox",
            "height": 20
          },
          {
            "type": "Text",
            "text": "Atique Hossain",
            "style": {
              "fontSize": 28,
              "fontWeight": "bold",
              "color": "#333333"
            }
          },
          {
            "type": "Text",
            "text": "Software Engineer",
            "style": {
              "fontSize": 20,
              "fontStyle": "italic",
              "color": "#666666"
            }
          },
          {
            "type": "SizedBox",
            "height": 10
          },
          {
            "type": "Text",
            "text": "Email: examplee@gmail.com",
            "style": {
              "fontSize": 16,
              "color": "#333333"
            }
          },
          {
            "type": "SizedBox",
            "height": 20
          },
          {
            "type": "Row",
            "mainAxisAlignment": "center",
            "children": [
              {
                "type": "ElevatedButton",
                "child": {
                  "type": "Text",
                  "text": "LinkedIn",
                  "style": {
                    "color": "#FFFFFF"
                  }
                },
                "onPressed": {
                  "action": "print",
                  "value": "https://www.linkedin.com/in/atique-hossain/"
                },
                "style": {
                  "backgroundColor": "#6200EE",
                  "padding": {
                    "vertical": 10,
                    "horizontal": 20
                  },
                  "shape": {
                    "type": "RoundedRectangleBorder",
                    "borderRadius": 15
                  }
                }
              },
              {
                "type": "SizedBox",
                "width": 10
              },
              {
                "type": "ElevatedButton",
                "child": {
                  "type": "Text",
                  "text": "GitHub",
                  "style": {
                    "color": "#FFFFFF"
                  }
                },
                "onPressed": {
                  "action": "open_github"
                },
                "style": {
                  "backgroundColor": "#333333",
                  "padding": {
                    "vertical": 10,
                    "horizontal": 20
                  },
                  "shape": {
                    "type": "RoundedRectangleBorder",
                    "borderRadius": 15
                  }
                }
              }
            ]
          }
        ]
      }
    }
  }
}
```
Flutter code : 


```dart
import 'package:flutter/material.dart';
import 'package:json_to_ui/json_to_ui.dart';

void main() async {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: JsonNetworkUiBuilder.fromNetwork(
          request: NetworkRequest(
            url: 'https://raw.githubusercontent.com/atiquehossain/testjson/refs/heads/main/testservermain.json',
            method: Method.get,
          ),
          isSaveOnHive: true,
        ),
      ),
    );
  }
}
```

## Additional Information

For more details, bug reports, or contributions, visit the [GitHub repository](https://github.com/atiquehossain/json_to_ui).

## License

This package is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

