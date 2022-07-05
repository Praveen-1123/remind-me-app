import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remind_me/constants/strings.dart';
import 'package:remind_me/utils/themes.dart';
import 'services/auth/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(RemindME(themeMode: savedThemeMode));
}

class RemindME extends StatefulWidget {
  final themeMode;
  const RemindME({Key key, @required this.themeMode}) : super(key: key);

  @override
  _RemindMEState createState() => _RemindMEState();
}

class _RemindMEState extends State<RemindME> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: Themes().lightTheme,
      dark: Themes().darkTheme,
      initial: widget.themeMode ?? AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        title: app_name,
        home: AuthenticationWrapper(),
      ),
    );
  }
}
