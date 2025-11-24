//Clase Usuario, por ahora solo contiene los atributos basicos: id, nombre y correo
class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final bool canDeleteReports;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.canDeleteReports = false,
  });
}

//Clase Admin, por ahora solo contiene los atributos basicos: id, nombre y correo.
//El admin hereda del Usuario, el admin tiene un permiso especial que permite eliminar publicaciones
class Admin extends User {

  const Admin({
    required super.id,
    required super.name,
    required super.email,
    required super.password,
  }) : super(canDeleteReports: true);
}

//Clase Objeto Perdido, este contiene la id, nombre, alguna imagen que lo represente
//y el tiempo en el que fue perdido
class LostObject {
  final String id;
  final String name;
  final String imageUrl;
  final DateTime dateLost;

  LostObject({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.dateLost,
  });
}


//Clase Publicacion, este contiene los atributos id, el objeto al que se refiere perdido, titulo, la descripcion
//del objeto, la ubicacion donde se perdio\encontro, la categoria del objeto (para los filtros), la fecha de la publicacion y
//el numero de id del usuario que hizo el reporte
class Report {
  final String id;
  final LostObject object;
  final String title;
  final String description;
  final String ubication;
  final String category;
  final DateTime dateReported;
  final String userId;
  final String notas;
  final String userName;
  final String userEmail;
  final String userPhone;
  final String initialState;
  String reportState;

  Report({
    required this.id,
    required this.object,
    required this.title,
    required this.description,
    required this.ubication,
    required this.category,
    required this.dateReported,
    required this.userId,
    required this.notas,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.initialState,
    required this.reportState
  });

    @override
  String toString() {
    return 'Report(title: $title, ubication: $ubication, userId: $userId)';
  }
}

//Clase manejadora de reportes en memoria, este crea una lista donde guardar la info de las publicaciones,
//al cerrar la aplicacion, toda info de reportes hechos anteriormente, seran eliminadas.
class ReportManager {
  static final List<Report> _reports = [];

  //Obtener todos los reportes
  static List<Report> get reports => _reports;

  //Agregar un reporte
  static void addReport(Report report) {
    _reports.add(report);
  }

  //Eliminar un reporte
  static void removeReport(String id) {
    _reports.removeWhere((r) => r.id == id);
  }

  //Limpiar todos los reportes (ej. al cerrar sesión)
  static void clearReports() {
    _reports.clear();
  }

  //Ordenar por antiguedad los reportes
  static List<Report> getReportsSorted({bool newestFirst = true}) {
    final sorted = [..._reports];
    sorted.sort((a, b) => newestFirst
        ? b.dateReported.compareTo(a.dateReported)    //más recientes primero
        : a.dateReported.compareTo(b.dateReported));  //más antiguos primero
    return sorted;
  }

}