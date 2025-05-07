class TaskState {
  TaskState init() {
    return TaskState();
  }

  TaskState clone() {
    return TaskState();
  }
}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}

final class TaskLoaded extends TaskState {
  final Map<String, dynamic> task;
  TaskLoaded(this.task);
}

final class TaskCompleted extends TaskState {
  final Map<String, dynamic> task;
  TaskCompleted(this.task);
} 