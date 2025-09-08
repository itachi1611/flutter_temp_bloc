enum Routers {
  /// Root page
  root('/', '/'),
  /// Home page
  home('/home', 'home'),
  pageNotFound('/pageNotFound', 'pageNotFound'),
  /// Test
  test('/test', 'test');

  final String routerPath;  /// Path to navigate to.
  final String routerName;  /// Human-readable name used internally for identification.

  const Routers(
    this.routerPath,
    this.routerName,
  );
}