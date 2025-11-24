import 'package:proyecto_ing_sw_10/utils/logic.dart';

final Admin admin = Admin(
  id: "a-001",
  name: "J. Aguirre",
  email: "jaguirre@udec.cl",
  password: "aguirregod",
);

final User usuario1 = User(
  id: "u-001",
  name: "M. Cuello",
  email: "mcuello@udec.cl",
  password: "elmati",
);

final User usuario2 = User(
  id: "u-002",
  name: "Pierluigi Cerulo",
  email: "pcerulo@udec.cl",
  password: "loyica",
);

final User usuario3 = User(
  id: "u-003",
  name: "Carlos Muñoz",
  email: "cmuñoz@udec.cl",
  password: "voytardechicos",
);

final List<User> listaUsuariosRegistrados = [
  admin,
  usuario1,
  usuario2,
  usuario3,
];