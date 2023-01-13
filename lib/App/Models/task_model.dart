class TaskModel {
  int? id, boardId, reporterId, assigneeId;
  String? title,
      description,
      startDate,
      dueDate,
      originalEstimate,
      priority,
      environment,
      createdAt,
      updatedAt;

  TaskModel({
    this.id,
    this.boardId,
    this.reporterId,
    this.assigneeId,
    this.title,
    this.description,
    this.startDate,
    this.dueDate,
    this.originalEstimate,
    this.priority,
    this.environment,
    this.createdAt,
    this.updatedAt,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    boardId = json['board_id'];
    reporterId = json['reporter_id'];
    assigneeId = json['assignee_id'];
    title = json['title'];
    description = json['description'];
    startDate = json['start_date'];
    dueDate = json['due_date'];
    originalEstimate = json['original_estimate'];
    priority = json['priority'];
    environment = json['environment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['board_id'] = boardId;
    data['reporter_id'] = reporterId;
    data['assignee_id'] = assigneeId;
    data['title'] = title;
    data['description'] = description;
    data['start_date'] = startDate;
    data['due_date'] = dueDate;
    data['original_estimate'] = originalEstimate;
    data['priority'] = priority;
    data['environment'] = environment;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }
}
