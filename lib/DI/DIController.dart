import 'package:sample_project/Service/game_contents_service.dart';
import 'package:sample_project/Service/character_service.dart';
import 'package:sample_project/Service/news_service.dart';

class DIController {
  static CharacterServiceType characterService = CharacterService();
  static GameContentsServiceType gameContentsService = GameContentsService();
  static NewsServiceType newsService = NewsService();
}
