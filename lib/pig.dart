import 'dart:io';
import 'package:path/path.dart' as path;

Future<void> generateOutput({
  required String inputPath,
  required List<String> extensions,
  String? outputPath,
}) async {
  final directory = Directory(inputPath);
  final buffer = StringBuffer();
  
  if (!await directory.exists()) {
    throw ArgumentError('Directory does not exist: $inputPath');
  }

  final files = await _findFiles(directory, extensions);
  for (var file in files) {
    final relativePath = path.relative(file.path, from: inputPath);
    buffer.writeln('========');
    buffer.writeln(relativePath);
    buffer.writeln('========');
    buffer.writeln(await file.readAsString());
    buffer.writeln(); // Add blank line between files
  }

  final output = buffer.toString();
  if (outputPath != null) {
    final outputFile = File(outputPath);
    await outputFile.writeAsString(output);
  } else {
    print(output);
  }
}

Future<List<File>> _findFiles(Directory directory, List<String> extensions) async {
  final files = <File>[];
  
  await for (final entity in directory.list(recursive: true)) {
    if (entity is File) {
      final extension = path.extension(entity.path).toLowerCase();
      if (extensions.contains(extension)) {
        files.add(entity);
      }
    }
  }
  
  // Sort files by path for consistent output
  files.sort((a, b) => a.path.compareTo(b.path));
  return files;
}