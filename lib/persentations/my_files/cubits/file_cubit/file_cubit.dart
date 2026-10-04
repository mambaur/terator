import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:terator/models/letter_model.dart';
import 'package:terator/repositories/letter_repository.dart';

part 'file_state.dart';

class FileCubit extends Cubit<FileState> {
  FileCubit() : super(const FileState());

  final LetterRepository _letterRepo = LetterRepository();
  final int _limit = 10;

  List<LetterModel> _data = [];

  int _page = 1;
  bool hasReachMax = false;

  // Active filter from the File Saya search bar / category chips; kept so
  // pagination and refreshes stay within it.
  String _query = '';
  List<String>? _templateNames;

  /// Sets the search text / template filter (null = all) and reloads.
  Future<void> applyFilter({String query = '', List<String>? templateNames}) {
    _query = query;
    _templateNames = templateNames;
    return getFiles(isInit: true);
  }

  Future<void> getFiles({bool isInit = false}) async {
    if (isInit) {
      emit(const FileState(status: FileStatusCubit.loading));
      _page = 1;
      List<LetterModel> response = await _letterRepo.all(
          page: _page,
          limit: _limit,
          query: _query,
          templateNames: _templateNames);
      _data = response;
      hasReachMax = _data.length < _limit ? true : false;
      emit(FileState(
          status: FileStatusCubit.success,
          hasReachMax: hasReachMax,
          letters: _data));
    } else {
      _page++;
      List<LetterModel> response = await _letterRepo.all(
          page: _page,
          limit: _limit,
          query: _query,
          templateNames: _templateNames);
      _data.addAll(response);
      hasReachMax = (response).length < _limit ? true : false;
      emit(FileState(
          status: FileStatusCubit.success,
          hasReachMax: hasReachMax,
          letters: _data));
    }
  }
}
