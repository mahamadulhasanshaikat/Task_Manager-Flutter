class TMUrls {
  static String baseUrl = 'https://task-manager-api.ostad.live/api/v1';

  static String reqiUrl = '$baseUrl/Registration';
  static String loginUrl = '$baseUrl/Login';
  static String taskStatusCountUrl = '$baseUrl/taskStatusCount';
  static String taskListByStatusUrl(String status) =>
      '$baseUrl/listTaskByStatus/$status';
  static String deleteTaskUrl(String ID) => '$baseUrl/deleteTask/$ID';
  static String updateTaskUserUrl(String ID, String status) =>
      '$baseUrl/updateTaskStatus/$ID/$status';
  static String addNewTaskUrl = '$baseUrl/createTask';
}
