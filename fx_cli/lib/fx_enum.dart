enum MenuOption {
  basic(
    title: 'Basic command',
    description: 'Basic tools wrapper',
    cliTitle: 'basic',
  ),
  build(
    title: 'Build',
    description: 'Build project with selected flavor(dev/uat/prod)',
    cliTitle: 'build',
  ),
  gen(
    title: 'Generate model',
    description: 'Code generation model utilities.',
    cliTitle: 'gen',
  ),
  doctor(
    title: 'Doctor',
    description: 'Check environment & dependencies.',
    cliTitle: 'doctor',
  ),
  clean(
    title: 'Clean',
    description: 'Clean project and temporary files.',
    cliTitle: 'clean',
  ),
  device(
    title: 'Device',
    description: 'List connected devices.',
    cliTitle: 'device',
  ),
  emulator(
    title: 'Emulator',
    description: 'List or run available emulators.',
    cliTitle: 'emulator',
  ),
  pub(
    title: 'Pub',
    description: 'Pub tools wrapper (cache repair/clean).',
    cliTitle: 'pub',
  ),
  get(
    title: 'Pub Get',
    description: 'Get package dependencies.',
    cliTitle: 'get',
  ),
  cacheClean(
    title: 'Pub Cache Clean',
    description: 'Clean pub cache.',
    cliTitle: 'clean',
  ),
  cacheRepair(
    title: 'Pub Cache Repair',
    description: 'Repair pub cache.',
    cliTitle: 'repair',
  ),
  back(
    title: 'Back',
    description: 'Back to previous menu level.',
    cliTitle: 'back',
  ),
  exit(
    title: 'Exit',
    description: 'Exit the cli application.',
    cliTitle: 'exit',
  );

  final String title;
  final String description;
  final String cliTitle;

  const MenuOption({
    required this.title,
    required this.description,
    required this.cliTitle,
  });
}