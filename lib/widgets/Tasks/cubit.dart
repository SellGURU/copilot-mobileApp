import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:copilet/utility/token/getTokenLocaly.dart';
import 'package:copilet/constants/endPoints.dart';
import 'state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  final Dio _dio = Dio();

  Future<void> loadTask(Map<String, dynamic> task) async {
    emit(TaskLoading());
    try {
      emit(TaskLoaded(task));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> completeTask(Map<String, dynamic> task) async {
    emit(TaskLoading());
    try {
      var token = await getTokenLocally();
      _dio.options.headers['Authorization'] = "bearer $token";
      
      // Call the checkTask endpoint
      final response = await _dio.post(Endpoints.checkTask, data: {
        "task_id": task["id"],
      });

      // Only update task completion status if the API call was successful
      if (response.statusCode == 200) {
        task['completed'] = 'Done';
        emit(TaskCompleted(task));
      } else {
        emit(TaskError("Failed to complete task"));
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> updateTask(Map<String, dynamic> task) async {
    emit(TaskLoading());
    try {
      var token = await getTokenLocally();
      _dio.options.headers['Authorization'] = "bearer $token";
      
      // Here you would typically make an API call to update the task
      // For now, we'll just emit the updated task
      emit(TaskLoaded(task));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
} 