class Environments {
  static const String PRODUCTION = 'prod';
  static const String QAS = 'QAS';
  static const String DEV = 'dev';
  static const String LOCAL = 'local';
}

class ConfigEnvironments {
  static const String _currentEnvironments = Environments.LOCAL;
  static final List<Map<String, String>> _availableEnvironments = [
    {
      'env': Environments.LOCAL,
      'url': 'http://52.66.208.144/api/v1/',
      'cabUrl': "https://supergrydapi.ritikasingh.site/uber/v1/",
      'foodUrl':'https://supergrydapi.ritikasingh.site/behrouzbiryani/v1/'
    },
    {
      'env': Environments.DEV,
      'url': '',
    },
    {
      'env': Environments.QAS,
      'url': '',
    },
    {
      'env': Environments.PRODUCTION,
      'url': '',
    },
  ];

  static Map<String, String> getEnvironments() {
    return _availableEnvironments.firstWhere(
      (d) => d['env'] == _currentEnvironments,
    );
  }
}

enum UrlType { base, cab, food }
