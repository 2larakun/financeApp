// GoRouteクラスのpathプロパティとnameプロパティを保存するクラス
class _RouteInfo {
  final String path;
  final String name;

  const _RouteInfo(this.path, this.name);
}

class AppRoutes {
  static const home = _RouteInfo('/home', 'home');
  static const report = _RouteInfo('/report', 'report');
  static const settings = _RouteInfo('/settings', 'settings');
  static const expenseInput = _RouteInfo('/expense_input', 'expense_input');
}
