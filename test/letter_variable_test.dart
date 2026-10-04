import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:terator/data/letter_data.dart';
import 'package:terator/models/letter_variable.dart';

void main() {
  setUpAll(() => initializeDateFormatting('id_ID', null));

  group('fillVar', () {
    test('keeps bold placeholder when empty', () {
      expect(fillVar(null, 'a', '... (Nama)'), '<b>... (Nama)</b>');
      expect(fillVar({'a': '  '}, 'a', '... (Nama)'), '<b>... (Nama)</b>');
    });

    test('renders escaped value with prefix and suffix', () {
      expect(
        fillVar({'a': '1.500.000'}, 'a', 'Rp ... (Nominal)', prefix: 'Rp '),
        'Rp 1.500.000',
      );
      expect(fillVar({'a': '<x>\nB'}, 'a', '...'), '&lt;x&gt;<br>B');
    });
  });

  test('every template variable is rendered when filled', () {
    for (final entry in letterDataMap(null)) {
      final key = entry['key'] as String;
      final variables = LetterData.variables(key);
      final keys = variables.map((v) => v.key).toSet();
      expect(keys.length, variables.length, reason: '$key has duplicate keys');

      for (final v in variables) {
        final html = LetterData.html(key, vars: {v.key: 'NILAI_${v.key}'});
        expect(html, contains('NILAI_${v.key}'),
            reason: '$key: variable ${v.key} is not used in the template');
      }
    }
  });
}
