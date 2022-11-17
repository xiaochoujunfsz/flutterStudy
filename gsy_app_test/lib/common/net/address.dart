//地址数据
class Address {
  static const String host = "https://api.github.com/";
  static const String hostWeb = "https://github.com/";
  static const String graphicHost = 'https://ghchart.rshah.org/';
  static const String updateUrl =
      'https://gitee.com/CarGuo/GSYGithubAppFlutter/releases';

  //获取授权  post
  static getAuthorization() {
    return "${host}authorizations";
  }
}
