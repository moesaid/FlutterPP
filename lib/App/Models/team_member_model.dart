class TeamMemberModel {
  String? id, teamId, userId;

  TeamMemberModel({
    this.id,
    this.teamId,
    this.userId,
  });

  TeamMemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team_id'] = teamId;
    data['user_id'] = userId;
    return data;
  }

  // copy with
  TeamMemberModel copyWith({
    String? id,
    String? teamId,
    String? userId,
  }) {
    return TeamMemberModel(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      userId: userId ?? this.userId,
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'team_id': teamId,
      'user_id': userId,
    };
  }
}
