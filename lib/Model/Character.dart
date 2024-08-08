import 'package:sample_project/Model/card.dart';
import 'package:sample_project/Model/Engraving.dart';
import 'package:sample_project/Model/Equipment.dart';
import 'package:sample_project/Model/Gem.dart';
import 'package:sample_project/Model/Profile.dart';
import 'package:sample_project/Model/Skills.dart';
import 'package:sample_project/Model/collectible.dart';

class CharacterInfo {
  final ArmoryProfile armoryProfile;
  final ArmoryEquipment armoryEquipment;
  final ArmoryEngraving? armoryEngraving;
  final ArmoryCard? armoryCard;
  final ArmorySkills? armorySkills;
  final ArmoryGem armoryGem;
  final List<Collectible> collectibles;

  CharacterInfo(
      {required this.armoryProfile,
      required this.armoryEquipment,
      this.armoryEngraving,
      this.armoryCard,
      this.armorySkills,
      required this.armoryGem,
      required this.collectibles});

  factory CharacterInfo.fromJson(Map<String, dynamic> json) {
    return CharacterInfo(
        armoryProfile: ArmoryProfile.fromJson(json['ArmoryProfile']),
        armoryEquipment: ArmoryEquipment(
            equipments: (json["ArmoryEquipment"] as List)
                .map((jsonItem) => Equipment.fromJson(jsonItem))
                .toList()),
        armoryEngraving: json['ArmoryEngraving'] == null
            ? null
            : ArmoryEngraving.fromJson(json['ArmoryEngraving']),
        armoryCard: json['ArmoryCard'] == null
            ? null
            : ArmoryCard.fromJson(json['ArmoryCard']),
        armorySkills:
            json['ArmorySkills'] == null ? null : ArmorySkills.fromJSON(json),
        armoryGem: ArmoryGem.fromJSON(json),
        collectibles: (json["Collectibles"] as List)
            .map((e) => Collectible.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'ArmoryProfile': armoryProfile,
      'ArmoryEquipment': armoryEquipment,
      'ArmoryEngraving': armoryEngraving
    };
  }
}
