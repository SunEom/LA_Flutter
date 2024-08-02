class AlertData {
  final String title;
  final String body;
  final Function? onComplete;
  final Function? onCancel;

  const AlertData(
      {required this.title,
      required this.body,
      this.onComplete,
      this.onCancel});
}
