import 'package:dev_tesis/domain/model/curso.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit para manejar el estado del nombre completo
class BDCursosCubit extends Cubit<List<Curso>> {
  BDCursosCubit() : super([]);

  // Método para cambiar el nombre
  void subirCursos(List<Curso> cursos) {
    emit(cursos);
  }
  void limpiarCubit(){
    emit([]);
  }

  //obtener el curso demo
  Curso getCursoDemo(){
    return state.first;
  }

  // Método para agregar un curso a la lista actual
  void agregarCurso(Curso nuevoCurso) {
    List<Curso> cursos = List.from(state); // Crea una nueva lista
    cursos.add(nuevoCurso);
    emit(cursos);
  }

  // eliminar un curso por id
  void eliminarCurso(int id) {
    List<Curso> cursos = List.from(state); // Crea una nueva lista
    cursos.removeWhere((curso) => curso.id == id);
    emit(cursos);
  }


  //actualizar atributo name del curso  buscando el curso por id y actualiza
void actualizarUnidadesCurso(Curso curso) {
  // Buscar el índice del curso existente en la lista
  int index = state.indexWhere((c) => c.id == curso.id);
  if (index != -1) {
    // Si se encuentra el curso, reemplazarlo con el nuevo curso
    List<Curso> cursos = List.from(state);
    cursos[index] = curso;
    emit(cursos);
  }
}
}
