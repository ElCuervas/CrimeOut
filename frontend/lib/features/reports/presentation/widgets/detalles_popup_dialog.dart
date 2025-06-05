import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/reporte_providers.dart';

class DetallesPopupDialog extends ConsumerStatefulWidget {
  const DetallesPopupDialog({super.key});

  @override
  ConsumerState<DetallesPopupDialog> createState() => _DetallesPopupDialogState();
}

class _DetallesPopupDialogState extends ConsumerState<DetallesPopupDialog> {
  late TextEditingController _textoController;

  @override
  void initState() {
    super.initState();
    _textoController = TextEditingController(
      text: ref.read(detallesReporteProvider) ?? '',
    );
  }

  Future<void> _seleccionarImagen() async {
    final picker = ImagePicker();
    final XFile? foto = await picker.pickImage(source: ImageSource.camera);
    if (foto != null) {
      try {
        final base64Img = await compute(_comprimirYCodificar, foto.path);
        ref.read(imagenReporteProvider.notifier).state = base64Img;
      } catch (e) {
        print('Error al procesar la imagen: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagenBase64 = ref.watch(imagenReporteProvider);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Añadir Imagen', style: TextStyle(fontWeight: FontWeight.bold)),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E2E3E),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              onPressed: _seleccionarImagen,
              icon: const Icon(Icons.image),
              label: const Text('Añadir Imagen'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _textoController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: 'Describe los detalles del incidente...',
              ),
              onChanged: (value) {
                ref.read(detallesReporteProvider.notifier).state = value;
              },
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6B49F6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text('Guardar Detalles'),
        ),
      ],
    );
  }
  @override
void dispose() {
  _textoController.dispose();
  super.dispose();
}
}

/// Función separada para compresión y codificación en base64
Future<String> _comprimirYCodificar(String path) async {
  final compressedBytes = await FlutterImageCompress.compressWithFile(
    path,
    quality: 60,
    format: CompressFormat.jpeg,
  );

  if (compressedBytes == null) throw Exception('Error al comprimir imagen');
  return base64Encode(compressedBytes);
}