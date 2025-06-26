import 'package:flutter/material.dart';

class AdminBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const AdminBottomNavigationBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/admin-home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/admin-reportes');
            break;
          case 2:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sección Perfil no disponible aún')),
            );
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Búsqueda'),
        BottomNavigationBarItem(icon: Icon(Icons.warning), label: 'Reportes'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
      ],
    );
  }
}