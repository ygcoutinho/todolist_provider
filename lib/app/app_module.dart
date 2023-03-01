import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_provider/app/app_widget.dart';
import 'package:todolist_provider/app/core/database/sqlite_adm_connection.dart';
import 'package:todolist_provider/app/core/database/sqlite_connection_factory.dart';

class AppModule extends StatefulWidget {
  const AppModule({Key? key}) : super(key: key);

  @override
  State<AppModule> createState() => _AppModuleState();
}

class _AppModuleState extends State<AppModule> {
  final sqliteAdmConnection = SqliteAdmConnection();
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(sqliteAdmConnection);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(sqliteAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => SqliteConnectionFactory(),
          lazy: false,
        ),
      ],
      child: const AppWidget(),
    );
  }
}
