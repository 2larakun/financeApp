import 'package:finance_app/presentation/router/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const App()));
}

class App extends ConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerDelegate: ref.read(routerProvider).routerDelegate,
      routeInformationParser: ref.read(routerProvider).routeInformationParser,
      routeInformationProvider: ref
          .read(routerProvider)
          .routeInformationProvider,
    );
  }
}
