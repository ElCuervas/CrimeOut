import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/constants/admin_global_widgets/admin_bottom_navigation.dart';
import 'package:frontend/features/admin_reportes/domain/entities/reporte_sospechoso.dart';
import 'package:frontend/features/admin_reportes/presentation/providers/reporte_sospechoso_provider.dart';
import 'package:frontend/features/admin_reportes/presentation/widgets/reporte_sospechoso_card.dart';
import 'package:frontend/core/constants/admin_global_widgets/admin_banner_header.dart';

class AdminReportesSospechososScreen extends ConsumerWidget {
  const AdminReportesSospechososScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportesAsync = ref.watch(reporteSospechosoProvider);

    return Scaffold(
      body: Column(
        children: [
          const AdminBannerHeader(titulo: 'Administración'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reportes Marcados',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: reportesAsync.when(
                      data: (reportes) => reportes.isEmpty
                          ? const Center(child: Text('No hay reportes sospechosos.'))
                          : ListView.builder(
                              itemCount: reportes.length,
                              itemBuilder: (context, index) {
                                final reporte = reportes[index];
                                return ReporteSospechosoCard(
                                  reporte: reporte,
                                  onVerPerfil: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/admin-user-profile',
                                      arguments: reporte.idUsuario,
                                    );
                                  },
                                );
                              },
                            ),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, _) => Center(child: Text('Error: $e')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AdminBottomNavigationBar(currentIndex:1),
    );
  }
}