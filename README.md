# flutter_screen_keep_on

A Flutter plugin to keep screen on. AndroidX migrated.

## Usage
To use this plugin, add `screen_keep_on` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Example

``` dart
// Import package
import 'package:screen_keep_on/screen_keep_on.dart';

// Set Keep Screen On
ScreenKeepOn.turnOn(on);

// Get IsOn
bool _isOn = await ScreenKeepOn.isOn;

```