

## 0.0.1

# Changelog

## [1.0.2] - 2025-01-29

### Added
- **NetworkService**: Implemented methods for handling network requests, including support for both GET and POST requests.
- **Hive Integration**: Added functionality to save and fetch network data from local Hive storage for offline use.
- **Internet Connectivity Check**: Introduced `hasInternetConnection()` to check for an active internet connection before making network requests.
- **Dynamic UI Fetching**: Added functionality to fetch dynamic UI configurations from a remote server or load them from local Hive storage when offline.

### Fixed
- Fixed an issue where network requests would not fallback to cached data when offline.

### Changed
- Improved error handling for network failures and added more informative error messages.
- Enhanced the `fetchJson()` method to better handle network status and cache data.




## 1.0.1
- 📌 Issue fixed

## 1.0.0 - Initial Release
- 🎉 First stable version of `json_to_ui`.
- 📌 Supports dynamic UI generation from JSON.
- 🚀 Includes network requests, storage handling, and widget rendering.


### Initial Setup:
- Created a Flutter application to dynamically build UI from JSON data.
- Added `NetworkService` to handle HTTP requests with support for `GET`  method.
- Introduced `HiveService` for local caching of network data, including functions to save, retrieve, and clear data.
- Added a method to check internet connectivity before fetching data from the network.

### UI Builder:
- Introduced `JsonNetworkUiBuilder` to fetch JSON from a remote URL and dynamically generate the UI.
- Implemented `UIBuilder` to parse JSON into Flutter widgets such as `Scaffold`, `Container`, `Column`, `Row`, and `Text`.
- Widgets can be customized with properties like `padding`, `margin`, `backgroundColor`, and `fontSize`.

### Network Handling:
- Network data is fetched and parsed into widgets if the internet connection is available.
- If no internet connection is detected, the app uses cached data stored via `HiveService`.

### Error Handling:
- Errors in network requests (e.g., no internet or failed request) are caught, and fallback data (cached) is used where applicable.

