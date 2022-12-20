# Flutter Production Boilerplate

## A flutter project containing flutter\_bloc, flutter\_lints, hive, easy\_localization and more!

This repository is the starting point for collection templates. If you have any suggestions or improvements feel free to let me know. The project strives to implement best practices recommended by Google and other developers. These best practices include but are not limited to:

- Using BLOC & Cubit for state management.
- Using Flutter Lints for stricter linting rules.
- Using Hive for platform independent storage that also works for web.
- Project structure, const constructors, extracted widgets and many more...

## Installation

This repository requires [Flutter](https://flutter.dev/docs/get-started/install) to be installed and present in your development environment.

1. Clone the project and enter the project folder.

    ```sh
    git clone https://github.com/anfeichtinger/flutter_production_boilerplate.git
    cd flutter_production_boilerplate
    ```

    ```
    Feel free to remove any unnecessary resources
    ```

2. Get the dependencies.

    ```sh
    flutter pub get
    ```

3. Run the app via command line or through your development environment. (optional)

    ```sh
    flutter run lib/main.dart
    ```

## Pub packages

This repository makes use of the following pub packages:

| Package                                                              | Version  | Usage                                                |
|----------------------------------------------------------------------|----------|------------------------------------------------------|
| [Intl](https://pub.dev/packages/intl)                                | ^0.17.0  | Multi language*                                      |
| [Intl Utils](https://pub.dev/packages/intl_utils)                    | ^2.8.1   | Multi language utils*                                |
| [Bloc](https://pub.dev/packages/bloc)                                | ^8.1.0   | State management*                                    |
| [Flutter Bloc](https://pub.dev/packages/flutter_bloc)                | ^8.1.1   | State management*                                    |
| [Hydrated Bloc](https://pub.dev/packages/hydrated_bloc)              | ^9.0.0   | Persists Bloc state with Hive                        |
| [Hive](https://pub.dev/packages/hive)                                | ^2.2.3   | Platform independent storage                         |
| [Hive Generator](https://pub.dev/packages/hive_generator)            | ^2.0.0   | Platform independent storage support                 |
| [Shared Preferences](https://pub.dev/packages/shared_preferences)    | ^2.0.15  | Shared preferences storage                           |
| [Url Launcher](https://pub.dev/packages/url_launcher)                | ^6.1.7   | Open urls in Browser                                 |
| [Flutter Display Mode](https://pub.dev/packages/flutter_displaymode) | ^0.4.1   | Support high refresh rate displays                   |
| [Path Provider](https://pub.dev/packages/path_provider)              | ^2.0.11  | Get the save path for Hive                           |
| [Permission Handler](https://pub.dev/packages/permission_handler)    | ^10.2.0  | Handler app permission                               |
| [Google Fonts](https://pub.dev/packages/google_fonts)                | ^2.0.5   | Fonts provided by google                             |
| [Connectivity Plus](https://pub.dev/packages/connectivity_plus)      | ^2.0.5   | Check internet's connection status                   |
| [Retrofit](https://pub.dev/packages/retrofit)                        | ^3.3.1   | Retrofit                                             |
| [Dio](https://pub.dev/packages/dio)                                  | ^4.0.6   | Retrofit                                             |
| [Another Flushbar](https://pub.dev/packages/another_flushbar)        | ^1.12.29 | Flushbar                                             |
| [Animated Snack Bar](https://pub.dev/packages/animated_snack_bar)    | ^0.3.0   | Animated Snack bar                                   |
| [Equatable](https://pub.dev/packages/equatable)                      | ^3.0.1   | Easily compare custom classes, used for Bloc states* |
| [Logger](https://pub.dev/packages/logger)                            | ^1.1.0   | Custom logger                                        |
| [Device Info Plus](https://pub.dev/packages/device_info_plus)        | ^8.0.0   | Get device information                               |
| [Splash View](https://pub.dev/packages/splash_view)                  | ^2.0.1   | Custom splash screen                                 |
| [Cupertino Icons](https://pub.dev/packages/cupertino_icons)          | ^2.0.5   | Cupertino icons                                      |
| [Flutter Lints](https://pub.dev/packages/flutter_lints)              | ^2.0.1   | Stricter linting rules                               |
| [Retrofit Generator](https://pub.dev/packages/retrofit_generator)    | ^4.2.0   | Generation for retrofit                              |
| [Json Serializable](https://pub.dev/packages/json_serializable)      | ^6.5.4   | Handling JSON                                        |
| [Hive Generator](https://pub.dev/packages/hive_generator)            | ^2.0.0   | Hive generator tool                                  |
| [Build Runner](https://pub.dev/packages/build_runner)                | ^2.3.3   | Standalone generator and watcher for Dart            |


device_info_plus: ^8.0.0
> \* Recommended to keep regardless of your project

## Changing the package and app name

```
Uncomment change_app_package_name: ^1.1.0 in tools section
run flutter pub run change_app_package_name:main com.new.package.name
Comment again change_app_package_name: ^1.1.0 in tools section
```

## Note

After following the installation steps you can customize your project.

1. Theme

   _You can customize your brand colors in the [lib/config/theme.dart](./lib/common/app_themes.dart) file. The project useses colors from [TailwindCSS](https://tailwindcss.com/docs/customizing-colors). As primary swatch the indigo color palette is used while for the text the gray color palette is used. Feel free to replace those values with your own. In order to get a smooth transition for the text colors it is necessary to override each text type in the TextTheme._

2. Removing unwanted packages

   _If a package is not listed, then removing it from [pubspec.yaml](./pubspec.yaml) as well as all imports and uses should be enough. This is required for removing every packages, the following instructions are an addition to that._

3. Flutter Lints

   _Delete the [analysis_options.yaml](./analysis_options.yaml) file. As an alternative you can modify the rules in this file or use a different package like [Lint](https://pub.dev/packages/lint)._

5. Url Launcher

   _For iOS go to [ios/Runner/Info.plist](./ios/Runner/Info.plist) and remove the following code:_

    ```
    <key>LSApplicationQueriesSchemes</key>
    <array>
      <string>https</string>
      <string>http</string>
    </array>
    ```

   For Android you can take a look at this [Stackoverflow issue](https://stackoverflow.com/a/65082750) for more information. Visit [android/app/src/AndroidManifest.xml](./android/app/src/main/AndroidManifest.xml) and remove the
   following code:

    ```
    <queries>
         <intent>
            <action android:name="android.intent.action.VIEW" />
            <data android:scheme="https" />
        </intent>
    </queries>
    ```
   > \* Set up domain for open on browser

## Commands

#### Get the dependencies

```
- flutter pub run build_runner build watch --enable-experiment=non-nullable --delete-conflicting-outputs (flutter ver 1xx)
- flutter pub run build_runner build watch --delete-conflicting-outputs (flutter ver >= 2xx)  
```

#### Clear the cache

```
flutter pub cache clean
flutter pub cache repair
```

#### For iOS only

##### Mac ARM

```
1. sudo arch -x86_64 gem install ffi (install ffi)
2. sudo arch -x86_64 pod install (pod install)
```

##### Mac Intel

```
pod install (pod install)
```

## Screenshots

#### Light Theme

#### Dark Theme

## License

MIT