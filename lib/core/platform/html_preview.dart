// Web-only replacement for the native HTML→PDF preview: renders the letter
// HTML in an iframe. On mobile this is never used (PDFView is used instead).
export 'html_preview_stub.dart'
    if (dart.library.js_interop) 'html_preview_web.dart';
