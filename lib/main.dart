import 'package:flutter/material.dart';

void main() => runApp(SettingsApp());

class SettingsApp extends StatefulWidget {
  @override
  _SettingsAppState createState() => _SettingsAppState();
}

class _SettingsAppState extends State<SettingsApp> {
  bool _isDarkModeEnabled = false;
  String _selectedLanguage = 'Polski';

  void toggleDarkMode(bool value) {
    setState(() {
      _isDarkModeEnabled = value;
    });
  }

  void changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings App',
      theme: _isDarkModeEnabled ? ThemeData.dark() : ThemeData.light(),
      home: SettingsPage(
        toggleDarkMode: toggleDarkMode,
        selectedLanguage: _selectedLanguage,
        changeLanguage: changeLanguage,
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  final Function(bool) toggleDarkMode;
  final String selectedLanguage;
  final Function(String) changeLanguage;

  SettingsPage({
    required this.toggleDarkMode,
    required this.selectedLanguage,
    required this.changeLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedLanguage == 'Polski' ? 'USTAWIENIA' : 'SETTINGS'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(selectedLanguage == 'Polski' ? 'JĘZYK' : 'LANGUAGE'),
            subtitle: Text(selectedLanguage),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LanguagePage(
                    selectedLanguage: selectedLanguage,
                    changeLanguage: changeLanguage,
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text(selectedLanguage == 'Polski' ? 'MOTYW' : 'THEME'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThemePage(toggleDarkMode: toggleDarkMode, selectedLanguage: selectedLanguage),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class LanguagePage extends StatelessWidget {
  final String selectedLanguage;
  final Function(String) changeLanguage;

  LanguagePage({required this.selectedLanguage, required this.changeLanguage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedLanguage == 'Polski' ? 'JĘZYK' : 'LANGUAGE'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                changeLanguage('Polski');
                Navigator.pop(context);
              },
              child: Text('Polski'),
            ),
            ElevatedButton(
              onPressed: () {
                changeLanguage('Angielski');
                Navigator.pop(context);
              },
              child: Text('Angielski'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemePage extends StatelessWidget {
  final Function(bool) toggleDarkMode;
  final String selectedLanguage;

  ThemePage({required this.toggleDarkMode, required this.selectedLanguage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedLanguage == 'Polski' ? 'MOTYW' : 'THEME'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(selectedLanguage == 'Polski' ? 'Ustawienie motywu Jasny/Ciemny' : 'Set Light/Dark Theme'),
            Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {
                toggleDarkMode(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}

