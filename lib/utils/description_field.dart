import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DescriptionField extends StatefulWidget {
  final TextEditingController controller;

  const DescriptionField({
    super.key,
    required this.controller,
  });

  static bool validate(BuildContext context, TextEditingController controller) {
    List<String> lines = controller.text.split('\n');

    // Filtrar solo líneas válidas (No válidas serían "- " o vacías)
    int validLinesCount = lines.where((line) {
      String cleanLine = line.replaceAll('-', '').trim();
      return cleanLine.isNotEmpty;
    }).length;

    if (validLinesCount < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, añada al menos dos características claras para ayudar a identificar su objeto."),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  @override
  State<DescriptionField> createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends State<DescriptionField> {
  int _lastDescLength = 0;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      if (_focusNode.hasFocus) {
        // CASO: Usuario entra al campo de texto
        if (widget.controller.text.isEmpty) {
          widget.controller.text = "- ";
          widget.controller.selection = TextSelection.fromPosition(
              TextPosition(offset: widget.controller.text.length)
          );
        }
      } else {
        // CASO: Usuario abandona el campo de texto
        if (widget.controller.text == "- ") {
          widget.controller.clear();
        }
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        maxLines: null,
        keyboardType: TextInputType.multiline,

        inputFormatters: [
          _MaxLengthPerLineFormatter(50),
        ],

        decoration: InputDecoration(
          labelText: "Descripción del Objeto",
          helperText: _focusNode.hasFocus
              ? "Ejemplo de uso: \n"
              "- Color rojo con detalles azules\n"
              "- Marca Nike\n"
              "- Talla M"
              : null,
          helperMaxLines: 5,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.note_outlined),
        ),

        onChanged: (String value) {
          // Lógica para el primer guión
          if (_focusNode.hasFocus && !value.startsWith("- ")) {
            String cleanText = value.trimLeft();
            if (cleanText.startsWith("-")) {
              cleanText = cleanText.substring(1).trimLeft();
            }
            widget.controller.text = "- $cleanText";
            widget.controller.selection = TextSelection.fromPosition(
                TextPosition(offset: widget.controller.text.length)
            );
          }

          // Lógica de Enter para crear guiones
          if (value.length > _lastDescLength && value.endsWith("\n")) {
            widget.controller.text = "$value- ";
            widget.controller.selection = TextSelection.fromPosition(
                TextPosition(offset: widget.controller.text.length)
            );
          }
          _lastDescLength = widget.controller.text.length;
        },
      ),
    );
  }
}



class _MaxLengthPerLineFormatter extends TextInputFormatter {
  final int maxLength;
  _MaxLengthPerLineFormatter(this.maxLength);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final lines = newValue.text.split('\n');
    for (final line in lines) {
      int nonSpaceCount = line.replaceAll(' ', '').length;
      if (nonSpaceCount > maxLength) {
        return oldValue;
      }
    }
    return newValue;
  }
}