import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/domain/model/respuesta.dart';
import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:dev_tesis/domain/repository/curso_repository.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/seguimiento_bloc.dart';
import 'package:dev_tesis/ui/bloc/unidades_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CursosCasoUso {
  final CursoRepository cursoRepository;
  final BuildContext context;

  CursosCasoUso({required this.cursoRepository, required this.context});

  Future<List<Curso>> getCursos() async {
    return await cursoRepository.getCursos();
  }

  void guardarCurso(Curso curso) {
    cursoRepository.guardarCurso(curso);
  }

  //obtener curso por su id
  Future<Curso> getCursoById(String id) {
    return cursoRepository.getCursoById(id);
  }

  // crear Seguimientos del curso
  void crearSeguimientos(List<Estudiante> estudiantes, int idProfesor,
      int idCurso, List<Actividad> actividades) {
    /*
    Recorre la lista de estudiantes y crea un seguimiento para cada uno de ellos
    */
    List<Seguimiento> seguimientos = [];
    for (int i = 0; i < estudiantes.length; i++) {
      seguimientos.add(
        Seguimiento(
            id: i,
            respuestasActividades: List.generate(
                actividades.length,
                (index) => Respuesta(
                    id: i,
                    respuestaUsuario: '',
                    peso: -1,
                    actividadId: actividades[index].id!,
                    seguimientoId: i)),
            test: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            calificacion: 0,
            userId: estudiantes[i].id,
            cursoId: idCurso),
      );
    }

    seguimientos.add(Seguimiento(
        id: seguimientos.length + 1,
        respuestasActividades: List.generate(
            actividades.length,
            (index) => Respuesta(
                id: 1,
                respuestaUsuario: '',
                peso: -1,
                actividadId: actividades[index].id!,
                seguimientoId: seguimientos.length + 1)),
        test: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        calificacion: 0,
        userId: idProfesor,
        cursoId: idCurso));

    cursoRepository.crearSeguimientos(seguimientos);
    // Copia en Cubit
    context
        .read<SeguimientosEstudiantesCubit>()
        .subirSeguimientos(seguimientos);
  }

  //Metodo que agrega una actividad en el seguimiento del grupo
  void agregarActividad(int idCurso, Actividad actividad, int unidadId) {
    /*
    context.read<UnidadesCubit>().addActividad(
        Actividad(
            id: actividad.id,
            nombre: actividad.nombre,
            descripcion: actividad.descripcion,
            estado: actividad.estado,
            pesoRespuestas: actividad.pesoRespuestas,
            habilidades: actividad.habilidades,
            tipoActividad: actividad.tipoActividad),
        unidadId);
*/
    context.read<CursoCubit>().addActividad(actividad, unidadId, context);
    context
        .read<SeguimientosEstudiantesCubit>()
        .agregarRespuesta(idCurso, actividad);
  }

  //** FIREBASE */
  // Método para subir el objeto a Firestore
  Future<void> subirCursoFB(Curso curso) async {
    // Referencia a la colección "productos" en Firestore
    final db = FirebaseFirestore.instance;

    // Convertir el objeto Curso a un mapa
    Map<String, dynamic> data = curso.toMap();

    // Agregar el documento a la colección
    final cursoref = db.collection("cursos").doc();

    try {
      await cursoref.set(data);
      print("Curso creado exitosamente");
    } catch (e) {
      print("Error al crear curso: $e");
    }
  }
}
