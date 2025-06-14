import 'package:flutter/material.dart';

class MunicipalHomeScreen extends StatelessWidget {
  const MunicipalHomeScreen({super.key});

  void _navegarALista(BuildContext context, String tipo) {
    Navigator.pushNamed(context, '/lista-reportes-municipal', arguments: tipo);
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': 'Microtrafico', 'icon': Icons.alarm, 'color': Colors.red, 'tipo': 'MICROTRAFICO'},
      {'label': 'Basural', 'icon': Icons.delete, 'color': Colors.brown, 'tipo': 'BASURAL'},
      {'label': 'Maltrato Animal', 'icon': Icons.pets, 'color': Colors.purple, 'tipo': 'MALTRATO_ANIMAL'},
      {'label': 'Actividad ilícitas', 'icon': Icons.warning, 'color': Colors.amber, 'tipo': 'ACTIVIDAD_ILICITA'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registros', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF6B49F6),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.pushNamed(context, '/municipal-grafico');
            },
            tooltip: 'Gráfico',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: items.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: item['color'] as Color, width: 2),
                  ),
                  elevation: 4,
                ),
                onPressed: () => _navegarALista(context, item['tipo'] as String),
                child: Row(
                  children: [
                    Icon(item['icon'] as IconData, color: item['color'] as Color),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        item['label'] as String,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF6B49F6),
        onTap: (index) {
          switch (index) {
            case 0:
              // Ya estás en esta vista
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/reporte-mapa');
              break;
            case 2:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sección Perfil no disponible aún')),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Registros'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}