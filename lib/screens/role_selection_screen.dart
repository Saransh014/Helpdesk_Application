import 'package:flutter/material.dart';
import 'package:task_app/screens/customer_login_screen.dart';
import 'package:task_app/screens/admin_login_screen.dart';
import 'package:task_app/screens/support_agent_login_screen.dart';
import 'package:provider/provider.dart';
import 'package:task_app/services/theme_service.dart';

class RoleSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select Role',
              style: TextStyle(fontWeight: FontWeight.bold)),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(
                    themeService.isDarkMode
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Switch(
                    value: themeService.isDarkMode,
                    onChanged: (value) {
                      themeService.toggleTheme();
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Colors.blueGrey,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.blueGrey[200],
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRoleButton(
                  context,
                  'Customer',
                  Icons.person,
                  CustomerLoginScreen(),
                ),
                SizedBox(height: 16),
                _buildRoleButton(
                  context,
                  'Admin',
                  Icons.admin_panel_settings,
                  AdminLoginScreen(),
                ),
                SizedBox(height: 16),
                _buildRoleButton(
                  context,
                  'Support Agent',
                  Icons.support_agent,
                  SupportAgentLoginScreen(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton(
      BuildContext context, String role, IconData icon, Widget screen) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            SizedBox(width: 8),
            Text(role, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 0),
      ),
    );
  }
}
