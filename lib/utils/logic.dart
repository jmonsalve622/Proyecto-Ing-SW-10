//Clase Usuario, por ahora solo contiene los atributos basicos: id, nombre y correo
class User {
  final String id;
  final String name;
  final String email;

  User({required this.id,
  required this.name,
  required this.email,});
}

//Clase Admin, por ahora solo contiene los atributos basicos: id, nombre y correo.
//El admin hereda del Usuario, el admin tiene un permiso especial que permite eliminar publicaciones
class Admin extends User {
  final bool canDeleteReports;

  Admin({
    required String id,
    required String name,
    required String email,
    this.canDeleteReports = true,
  }) : super(id: id, name: name, email: email);
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
}





//El siguiente codigo que esta abajo, es un codigo que podria ser utilizado si se planea
//en algun futuro implementar memoria, donde se permita almacenar publicaciones,
//donde se guarden incluso despues de cerrar el programa.


  //Convierte la instancia de Report en un Map,
  //util para guardar en Firebase\Firestore o serializar a JSON.
  //El mapa puede incluir tambien los datos del LostObject.
//  Map<String, dynamic> toMap() {
//    return {
//      'id': id,
//      'object': {
//        'id': object.id,
//        'name': object.name,
//        'imageUrl': object.imageUrl,
//        'dateLost': object.dateLost.toIso8601String(),
//      },
//      'title': title,
//      'description': description,
//      'ubication': ubication,
//      'category': category,
//      'dateReported': dateReported.toIso8601String(),
//      'userId': userId,
//      'notas': notas,
//    };
//  }

  //Aca transformamos el mapa con los datos, en un objeto Report,
  //retornando una instancia del mapa, lista para usarse en la app
//  factory Report.fromMap(Map<String, dynamic> map) {
//    return Report(
//      id: map['id'],
//     object: LostObject(
//        id: map['object']['id'],
//        name: map['object']['name'],
//        imageUrl: map['object']['imageUrl'],
//        dateLost: DateTime.parse(map['object']['dateLost']),
//      ),
//      title: map['title'],
//      description: map['description'],
//      ubication: map['ubication'],
//      category: map['category'],
//      dateReported: DateTime.parse(map['dateReported']),
//      userId: map['userId'],
//      notas: map['notas'],
//    );
//  }
//}