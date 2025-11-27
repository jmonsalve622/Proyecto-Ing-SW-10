import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:proyecto_ing_sw_10/pages/home_page.dart';
import 'package:proyecto_ing_sw_10/utils/mock_data.dart';

// flutter run -t lib/pages/log_in_page.dart -d edge

/// El Screen de arranque
class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo.shade400,
        foregroundColor: Colors.white,
        title: const ResponsiveAppBarTitle(
          text: "Bienvenido/a al Sistema de Reporte y Seguimiento de Objetos Perdidos",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      /*
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Bienvenido/a al Sistema de Reporte y Seguimiento de Objetos Perdidos",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.indigo.shade400,
        foregroundColor: Colors.white,
      ),
       */
      body: Center(
        // Para desplazarse en el celular
        child: SingleChildScrollView(
          child: Padding(
            // Margen externo para el celular
            padding: const EdgeInsets.all(20.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),

              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.white,
                child: Padding(
                  // padding interno de los textos
                  padding: const EdgeInsets.all(30.0),
                  child: LoginInputSeccion(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


/// Clase con los componentes visuales del login
class LoginInputSeccion extends StatefulWidget {
  const LoginInputSeccion({super.key,});

  @override
  State<LoginInputSeccion> createState() => _LoginInputSeccionState();
}

class _LoginInputSeccionState extends State<LoginInputSeccion> {
  late TextEditingController _emailController;
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onPressedIngresar() {
    final emailIngresado = _emailController.text.trim();
    final passwordIngresado = _passwordController.text;

    try {
      final usuarioEncontrado = listaUsuariosRegistrados.firstWhere(
              (user) => user.email == emailIngresado
      );

      if (usuarioEncontrado.password == passwordIngresado) {
        // CASO: Éxito al intentar logearse
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HomePage(currentUser: usuarioEncontrado),
          ),
        ).then((_) {
          _emailController.clear();
          _passwordController.clear();
        });
      } else {
        // CASO: Correo existe, pero la contraseña está mal
        setState(() {
          _showErrorMessage("Contraseña incorrecta");
        });
      }
    } catch(e) {
      // CASO: No existe el correo ingresado
      _showErrorMessage("Correo no registrado");
    }
  }

  void _showErrorMessage(String mensaje) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red.shade600,
        elevation: 4,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),

        // Icono + Texto
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                mensaje,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        // Duración del mensaje
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Iniciar sesión",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(height: 20),

        Autocomplete<String>(
          // Mostrar correos existentes
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return listaUsuariosRegistrados.map((user) => user.email);
            }

            return listaUsuariosRegistrados
                .map((user) => user.email)
                .where((email) {
              return email.toLowerCase().contains(textEditingValue.text.toLowerCase());
            });
          },

          // Diseño del TextField
          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            _emailController = controller;

            return TextField(
              controller: controller,
              focusNode: focusNode,
              onEditingComplete: onFieldSubmitted,
              decoration: const InputDecoration(
                labelText: "Correo electrónico",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Contraseña",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.lock),
          ),
        ),

        const SizedBox(height: 20),

        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: _onPressedIngresar,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              // Podria ir un padding aqui, solo por detalle visual
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Ingresar",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}



class ResponsiveAppBarTitle extends StatelessWidget {
  final String text;
  final TextStyle style;

  const ResponsiveAppBarTitle({
    super.key,
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: text,
            style: style,
          ),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout(minWidth: 0, maxWidth: double.infinity);

        if (textPainter.width > constraints.maxWidth) {
          // CASO El titulo no cabe (usualmente para version movil)
          return SizedBox(
            height: 30,
            child: Marquee(
              text: text,
              style: style,
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              blankSpace: 50.0,
              velocity: 50.0,
              pauseAfterRound: const Duration(seconds: 2),
              startPadding: 10.0,
            ),
          );
        } else {
          // CASO El titulo cabe (version edge o windows)
          return Text(
            text,
            style: style,
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
}



/*
// Main de prueba
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogInPage(),
    );
  }
}
 */