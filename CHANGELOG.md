## 0.0.1


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

