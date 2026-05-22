part of 'bookmark_cubit.dart';

enum BookmarkStatusCubit { loading, success, failure }

@immutable
class BookmarkState {
  final BookmarkStatusCubit? status;
  final List<BookmarkModel> bookmarks;
  final Set<String> keys;
  final String? message;

  const BookmarkState({
    this.status = BookmarkStatusCubit.loading,
    this.bookmarks = const [],
    this.keys = const {},
    this.message,
  });

  BookmarkState copyWith({
    BookmarkStatusCubit? status,
    List<BookmarkModel>? bookmarks,
    Set<String>? keys,
    String? message,
  }) {
    return BookmarkState(
      status: status ?? this.status,
      bookmarks: bookmarks ?? this.bookmarks,
      keys: keys ?? this.keys,
      message: message ?? this.message,
    );
  }
}
