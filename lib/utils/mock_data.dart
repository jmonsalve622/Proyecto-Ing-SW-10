import 'package:proyecto_ing_sw_10/utils/logic.dart';

final Admin admin1 = Admin(
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

final List<User> listaUsuariosRegistrados = [
  admin1,
  usuario1,
];