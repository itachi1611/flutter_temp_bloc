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

| Package                                                              | Usage                                                |
|----------------------------------------------------------------------|------------------------------------------------------|
| [Intl](https://pub.dev/packages/intl)                                | Multi language*                                      |
| [Intl Utils](https://pub.dev/packages/intl_utils)                    | Multi language utils*                                |
| [Bloc](https://pub.dev/packages/bloc)                                | State management*                                    |
| [Flutter Bloc](https://pub.dev/packages/flutter_bloc)                | State management*                                    |
| [Hydrated Bloc](https://pub.dev/packages/hydrated_bloc)              | Persists Bloc state with Hive                        |
| [Hive](https://pub.dev/packages/hive)                                | Platform independent storage                         |
| [Hive Generator](https://pub.dev/packages/hive_generator)            | Platform independent storage support                 |
| [Shared Preferences](https://pub.dev/packages/shared_preferences)    | Shared preferences storage                           |
| [Url Launcher](https://pub.dev/packages/url_launcher)                | Open urls in Browser                                 |
| [Flutter Display Mode](https://pub.dev/packages/flutter_displaymode) | Support high refresh rate displays                   |
| [Path Provider](https://pub.dev/packages/path_provider)              | Get the save path for Hive                           |
| [Permission Handler](https://pub.dev/packages/permission_handler)    | Handler app permission                               |
| [Google Fonts](https://pub.dev/packages/google_fonts)                | Fonts provided by google                             |
| [Connectivity Plus](https://pub.dev/packages/connectivity_plus)      | Check internet's connection status                   |
| [Retrofit](https://pub.dev/packages/retrofit)                        | Retrofit                                             |
| [Dio](https://pub.dev/packages/dio)                                  | Retrofit                                             |
| [Another Flushbar](https://pub.dev/packages/another_flushbar)        | Flushbar                                             |
| [Animated Snack Bar](https://pub.dev/packages/animated_snack_bar)    | Animated Snack bar                                   |
| [Firebase Core](https://pub.dev/packages/firebase_core)              | Firebase core                                        |
| [Firebase Analytics](https://pub.dev/packages/firebase_analytics)    | Firebase analytics                                   |
| [Equatable](https://pub.dev/packages/equatable)                      | Easily compare custom classes, used for Bloc states* |
| [Logger](https://pub.dev/packages/logger)                            | Custom logger                                        |
| [Device Info Plus](https://pub.dev/packages/device_info_plus)        | Get device information                               |
| [English Word](https://pub.dev/packages/english_words)               | Generate english words                               |
| [Splash View](https://pub.dev/packages/splash_view)                  | Custom splash screen                                 |
| [Cupertino Icons](https://pub.dev/packages/cupertino_icons)          | Cupertino icons                                      |
| [Flutter Lints](https://pub.dev/packages/flutter_lints)              | Stricter linting rules                               |
| [Retrofit Generator](https://pub.dev/packages/retrofit_generator)    | Generation for retrofit                              |
| [Json Serializable](https://pub.dev/packages/json_serializable)      | Handling JSON                                        |
| [Json Annotation](https://pub.dev/packages/json_annotation)          | Json Annotation                                      |
| [Hive Generator](https://pub.dev/packages/hive_generator)            | Hive generator tool                                  |
| [Build Runner](https://pub.dev/packages/build_runner)                | Standalone generator and watcher for Dart            |
| [Animations](https://pub.dev/packages/animations)                    | Flutter pre-build animations collection              |
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

4. Url Launcher

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
5. Firebase
   ```shell
   # Install the CLI if not already done so
   dart pub global activate flutterfire_cli

   # Run the `configure` command, select a Firebase project and platforms
   flutterfire configure
   ```
6. Intl
   ```shell
   # Generate localization files
   flutter pub run intl_utils:generate
   ```

## Commands

#### Get the dependencies

```shell
- flutter pub run build_runner build watch --enable-experiment=non-nullable --delete-conflicting-outputs (flutter ver 1xx)
- flutter pub run build_runner build watch --delete-conflicting-outputs (flutter ver >= 2xx)  
```

#### Clear the cache

```shell
flutter pub cache clean
flutter pub cache repair
```

#### Active flutter_gen for asset management

```shell
dart pub global activate flutter_gen
```

#### For iOS only

##### Mac ARM

```shell
1. sudo arch -x86_64 gem install ffi (install ffi)
2. sudo arch -x86_64 pod install (pod install)
```

##### Mac Intel

```shell
pod install (pod install)
```

```
Incase MacOS unable to boot simulator, follow step below
* With MacOS version >= 13: Go to System Settings → General → Storage → Developer → Delete "Developer Caches"
* With MacOS version < 12: About this Mac → Storage → Manage → Developer → Delete all the content
```

## Screenshots

#### Light Theme

#### Dark Theme

## License

MIT