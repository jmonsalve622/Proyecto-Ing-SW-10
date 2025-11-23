import 'package:flutter/material.dart';
import 'package:proyecto_ing_sw_10/utils/mock_data.dart';
import 'package:proyecto_ing_sw_10/utils/logic.dart';

/// Al abrir el sistema se puede seleccionar entre Usuario o Admistrador.
/// Se puede escribir el nombre de Usuario y la contraseña.
/// Se realiza el login exitosamente.

// flutter run -t lib/log_in_page.dart -d edge

class LoginInputSeccion extends StatefulWidget {
  final Admin adminInstance;

  const LoginInputSeccion({
    super.key,
    required this.adminInstance,
  });

  @override
  State<LoginInputSeccion> createState() => _LoginInputSeccionState();
}

class _LoginInputSeccionState extends State<LoginInputSeccion> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.adminInstance.email);
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validarLogin() {
    if (_emailController.text == widget.adminInstance.email &&
        _passwordController.text == widget.adminInstance.password) {
      print("Entrando a la vista del Admin");
    } else {
      print("Datos incorrectos o este email no es de Admin");
    }
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
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: "Correo electrónico",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
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
            onPressed: _validarLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              // Podria ir un padding aqui por diseño meramente
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

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      appBar: AppBar(
        title: const Text("Ingreso al Sistema"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        // Para desplazarse en el celular
        child: SingleChildScrollView(
          child: Padding(
            // Margen externo para celulares
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
                  child: LoginInputSeccion(adminInstance: admin1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




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