// sqflite has no web implementation; on web the wasm-backed factory from
// sqflite_common_ffi_web is used instead (web is for UI development only).
export 'db_factory_io.dart' if (dart.library.js_interop) 'db_factory_web.dart';
