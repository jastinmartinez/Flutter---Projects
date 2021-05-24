import 'package:recruitment_app/Models/user.dart';

abstract class Audit {
  static Map<String, dynamic> get createdAudit => {
        'createdBy': User.userRef.id,
        'createdAt': DateTime.now(),
        'modifiedBy': null,
        'modifieddAt': null,
      };

  static Map<String, dynamic> get modifiedAudit => {
        'audit.modifiedBy': User.userRef.id,
        'audit.modifieddAt': DateTime.now(),
      };
}
