class TaskModel {
  int? id;
  int? boardId;
  String? reporterId;
  String? assigneeId;
  String? title, status;
  String? description;
  String? startDate;
  String? dueDate;
  String? originalEstimate;
  String? priority;
  String? environment;
  String? createdAt;
  String? updatedAt;
  int? index;

  TaskModel({
    this.id,
    this.boardId,
    this.reporterId,
    this.assigneeId,
    this.title,
    this.status,
    this.description,
    this.startDate,
    this.dueDate,
    this.originalEstimate,
    this.priority,
    this.environment,
    this.createdAt,
    this.updatedAt,
    this.index,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    boardId = json['board_id'];
    reporterId = json['reporter_id'];
    assigneeId = json['assignee_id'];
    title = json['title'];
    status = json['status'];
    description = json['description'];
    startDate = json['start_date'];
    dueDate = json['due_date'];
    originalEstimate = json['original_estimate'];
    priority = json['priority'];
    environment = json['environment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['board_id'] = boardId;
    data['reporter_id'] = reporterId;
    data['assignee_id'] = assigneeId;
    data['title'] = title;
    data['status'] = status;
    data['description'] = description;
    data['start_date'] = startDate;
    data['due_date'] = dueDate;
    data['original_estimate'] = originalEstimate;
    data['priority'] = priority;
    data['environment'] = environment;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['index'] = index;
    return data;
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'board_id': boardId,
      'reporter_id': reporterId,
      'assignee_id': assigneeId,
      'title': title,
      'status': status,
      'description': description,
      'start_date': startDate,
      'due_date': dueDate,
      'original_estimate': originalEstimate,
      'priority': priority,
      'environment': environment,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'index': index,
    };
  }

  // from map
  TaskModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    boardId = map['board_id'];
    reporterId = map['reporter_id'];
    assigneeId = map['assignee_id'];
    title = map['title'];
    status = map['status'];
    description = map['description'];
    startDate = map['start_date'];
    dueDate = map['due_date'];
    originalEstimate = map['original_estimate'];
    priority = map['priority'];
    environment = map['environment'];
    createdAt = map['created_at'];
    updatedAt = map['updated_at'];
    index = map['index'];
  }
}
