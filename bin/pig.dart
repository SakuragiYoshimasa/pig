import 'dart:io';
import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'package:pig/pig.dart' as pig;

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('path',
        abbr: 'p',
        help: 'Input directory path (absolute or relative)',
        mandatory: true)
    ..addOption('output',
        abbr: 'o',
        help: 'Output file path (if not specified, prints to console)')
    ..addMultiOption('extensions',
        abbr: 'e',
        help: 'File extensions to include (e.g., .dart,.txt)',
        defaultsTo: ['.txt'])
    ..addFlag('help',
        abbr: 'h',
        help: 'Show this help message',
        negatable: false);

  try {
    final results = parser.parse(arguments);

    if (results['help']) {
      print('Usage: pig [options]');
      print(parser.usage);
      exit(0);
    }

    final inputPath = results['path'];
    final outputPath = results['output'];
    final extensions = (results['extensions'] as List<String>)
        .map((e) => e.startsWith('.') ? e.toLowerCase() : '.$e'.toLowerCase())
        .toList();

    // Convert relative paths to absolute if necessary
    final absoluteInputPath = path.isAbsolute(inputPath)
        ? inputPath
        : path.absolute(inputPath);
        
    String? absoluteOutputPath;
    if (outputPath != null) {
      String absoluteOutputPathInner = path.isAbsolute(outputPath)
          ? outputPath
          : path.absolute(outputPath);

      absoluteOutputPath = absoluteOutputPathInner;
          
      // まず dirname の結果を変数に格納
      final outputDir = path.dirname(absoluteOutputPathInner);
      final parentDir = Directory(outputDir);
      if (!await parentDir.exists()) {
        await parentDir.create(recursive: true);
      }
    }

    await pig.generateOutput(
      inputPath: absoluteInputPath,
      extensions: extensions,
      outputPath: absoluteOutputPath,
    );

    if (outputPath != null) {
      print('Output written to: $absoluteOutputPath');
    }
  } catch (e) {
    stderr.writeln('Error: $e');
    print('\nUsage: pig [options]');
    print(parser.usage);
    exit(1);
  }
}