class NavigationStateDTO {
  bool allTasksPage;
  int? taskId;

  NavigationStateDTO(this.allTasksPage, this.taskId);

  NavigationStateDTO.allTasksPage()
      : allTasksPage = true,
        taskId = null;

  NavigationStateDTO.task(int id)
      : allTasksPage = false,
        taskId = id;
}
