part of 'file_cubit.dart';

enum FileStatusCubit { loading, success, failure }

@immutable
class FileState {
  final FileStatusCubit? status;
  final List<LetterModel>? letters;
  final String? message;
  final bool hasReachMax;

  const FileState(
      {this.letters,
      this.message,
      this.hasReachMax = false,
      this.status = FileStatusCubit.loading});
}
