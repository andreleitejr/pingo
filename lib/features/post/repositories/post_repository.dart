import 'package:pingo/features/post/models/post.dart';
import 'package:pingo/repositories/database_repository.dart';

class PostRepository extends DataBaseRepository<Post> {
  PostRepository()
      : super(
          name: 'posts',
          fromMap: (document) => Post.fromMap(document),
        );
}
