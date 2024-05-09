class Respuesta {
  int? id;
  String? respuestaUsuario;
  int? peso;
  int? actividadId;
  int? seguimientoId;

  Respuesta(
      {this.id,
      this.respuestaUsuario,
      this.peso,
      this.actividadId,
      this.seguimientoId});

  Respuesta copyWith(
      {int? id,
      String? respuestaUsuario,
      int? peso,
      int? actividadId,
      int? seguimientoId}) {
    return Respuesta(
        id: this.id,
        respuestaUsuario: respuestaUsuario ?? this.respuestaUsuario,
        peso: peso ?? this.peso,
        actividadId: actividadId ?? this.actividadId,
        seguimientoId: seguimientoId ?? this.seguimientoId);
  }

  // To Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'respuestaUsuario': respuestaUsuario,
      'peso': peso,
      'actividadId': actividadId,
      'seguimientoId': seguimientoId,
    };
  }



  factory Respuesta.fromJson(respuesta) {
    return Respuesta(
        id: respuesta['id'],
        respuestaUsuario: respuesta['respuestaUsuario'],
        peso: respuesta['peso'],
        actividadId: respuesta['actividadId'],
        seguimientoId: respuesta['seguimientoId'],
        );
    
  }
}
