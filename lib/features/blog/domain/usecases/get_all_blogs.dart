import 'package:bloggy/core/error/failure.dart';
import 'package:bloggy/core/usecase/use_case.dart';
import 'package:bloggy/features/blog/domain/models/blog.dart';
import 'package:bloggy/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;
  GetAllBlogs(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
