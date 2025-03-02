import 'package:sample_project/Service/assignment_service.dart';
import 'package:sample_project/Service/character_service.dart';
import 'package:sample_project/Service/game_contents_service.dart';
import 'package:sample_project/Service/news_service.dart';

abstract class ServiceType {
  CharacterServiceType characterService;
  GameContentsServiceType gameContentsService;
  NewsServiceType newsService;
  AssignmentServiceType assignmentService;

  ServiceType(this.characterService, this.gameContentsService, this.newsService,
      this.assignmentService);
}

class Service implements ServiceType {
  CharacterServiceType characterService = CharacterService();
  GameContentsServiceType gameContentsService = GameContentsService();
  NewsServiceType newsService = NewsService();
  AssignmentServiceType assignmentService = AssignmentService();
}
