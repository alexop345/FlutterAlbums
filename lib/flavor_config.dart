enum Flavor { dev, stage, prod }

class FlavorValues {
  final String baseUrl;
  FlavorValues({required this.baseUrl});
}

class FlavorConfig {
  final Flavor flavor;
  final FlavorValues values;
  static late FlavorConfig _instance;

  factory FlavorConfig({
    required Flavor flavor,
    required FlavorValues values,
  }) {
    _instance = FlavorConfig._internal(flavor, values);
    return _instance;
  }

  FlavorConfig._internal(this.flavor, this.values);
  static FlavorConfig get instance {
    return _instance;
  }

  static bool isDev() => _instance.flavor == Flavor.dev;
  static bool isProd() => _instance.flavor == Flavor.stage;
  static bool isStage() => _instance.flavor == Flavor.prod;
}
