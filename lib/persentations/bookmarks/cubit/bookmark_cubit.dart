import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:terator/core/date_setting.dart';
import 'package:terator/models/bookmark_model.dart';
import 'package:terator/repositories/bookmark_repository.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(const BookmarkState());

  final BookmarkRepository _bookmarkRepo = BookmarkRepository();

  Future<void> load() async {
    emit(state.copyWith(status: BookmarkStatusCubit.loading));
    try {
      final List<BookmarkModel> bookmarks = await _bookmarkRepo.all();
      emit(BookmarkState(
        status: BookmarkStatusCubit.success,
        bookmarks: bookmarks,
        keys: bookmarks.map((e) => e.letterKey ?? '').toSet(),
      ));
    } catch (e) {
      emit(state.copyWith(
          status: BookmarkStatusCubit.failure, message: e.toString()));
    }
  }

  bool isBookmarked(String letterKey) => state.keys.contains(letterKey);

  Future<void> add({
    required String letterKey,
    required String title,
    String? subtitle,
    String? categoryTitle,
  }) async {
    await _bookmarkRepo.insert({
      'letter_key': letterKey,
      'title': title,
      'subtitle': subtitle,
      'category_title': categoryTitle,
      'created_at': DateSetting.timestamp(),
    });
    await load();
  }

  Future<void> remove(String letterKey) async {
    await _bookmarkRepo.deleteByKey(letterKey);
    await load();
  }

  Future<void> removeAll() async {
    await _bookmarkRepo.deleteAll();
    await load();
  }

  Future<void> toggle({
    required String letterKey,
    required String title,
    String? subtitle,
    String? categoryTitle,
  }) async {
    if (isBookmarked(letterKey)) {
      await remove(letterKey);
    } else {
      await add(
        letterKey: letterKey,
        title: title,
        subtitle: subtitle,
        categoryTitle: categoryTitle,
      );
    }
  }
}
