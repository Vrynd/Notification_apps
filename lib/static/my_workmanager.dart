enum MyWorkManager {
  oneOff("task-identifier", "task-identifier"),
  periodic("com.dicoding.notificationApp", "com.dicoding.notificationApp");

  final String uniqueName;
  final String taskName;
  const MyWorkManager(this.uniqueName, this.taskName);
}
