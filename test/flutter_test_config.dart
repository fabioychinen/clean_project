import 'dart:async';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platform/platform.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    final materialIconFont = _loadMaterialFont('MaterialIcons-Regular.otf');
    final materialRobotoFont = _loadMaterialFont('Roboto-Regular.ttf');

    final materialLoader = FontLoader('MaterialIcons')
      ..addFont(materialIconFont);
    final materialFontLoader = FontLoader('Roboto')
      ..addFont(materialRobotoFont);

    await materialLoader.load();
    await materialFontLoader.load();
  });

  await testMain();
}

Future<ByteData> _loadMaterialFont(String fontName) async {
  const FileSystem fs = LocalFileSystem();
  const Platform platform = LocalPlatform();
  final Directory flutterRoot =
      fs.directory(platform.environment['FLUTTER_ROOT']);

  final File font = flutterRoot.childFile(
    fs.path.join(
      'bin',
      'cache',
      'artifacts',
      'material_fonts',
      fontName,
    ),
  );

  final Future<ByteData> bytes = Future<ByteData>.value(
    font.readAsBytesSync().buffer.asByteData(),
  );

  return bytes;
}
