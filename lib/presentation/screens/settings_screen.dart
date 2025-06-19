import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ListTile(title: Text('通貨'), subtitle: Text('¥ (日本円)')),
        Divider(),
        ListTile(title: Text('言語'), subtitle: Text('日本語')),
        ListTile(title: Text('ダークモード'), trailing: Icon(Icons.toggle_off)),
        Divider(),
        ListTile(title: Text('アプリ情報')),
      ],
    );
  }
}
