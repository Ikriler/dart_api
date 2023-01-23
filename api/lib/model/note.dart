import 'package:conduit/conduit.dart';
import 'package:api/model/user.dart';

class Note extends ManagedObject<_Note> implements _Note {}

class _Note {
  @primaryKey
  int? id;
  @Column(nullable: false)
  int? number;
  @Column(nullable: false)
  String? name;
  @Column(nullable: false)
  String? text;
  @Column(nullable: false)
  String? category;
  @Column(nullable: false)
  String? dateTimeCreate;
  @Column(nullable: false)
  String? dateTimeEdit;

  @Relate(#noteList, isRequired: true, onDelete: DeleteRule.cascade)
  User? user;
}