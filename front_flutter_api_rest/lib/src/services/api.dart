class ConfigApi {
  static const String appName = "FRANCHESCAS";
  static const String apiURL = "192.168.0.108:9090";
  static String buildUrl(String endpoint) {
    return 'http://$apiURL$endpoint';
  }
}
