# Pig (Path Input Generator)

Pig は指定されたディレクトリ内のファイルを検索し、それらの内容を特定のフォーマットで出力するコマンドラインツールです。主に、複数のファイルの内容を1つのテキストファイルにまとめる際に使用します。

## 特徴

- 指定されたディレクトリ内のファイルを再帰的に検索
- 特定の拡張子を持つファイルのみを対象に
- 相対パスと絶対パスの両方をサポート
- コンソール出力またはファイル出力に対応
- 出力先ディレクトリが存在しない場合は自動作成

## インストール

1. 依存関係を `pubspec.yaml` に追加:

```yaml
dependencies:
  args: ^2.4.0
  path: ^1.8.0
```

2. 依存関係をインストール:

```bash
dart pub get
```

## 使用方法

基本的な使い方:

```bash
dart run bin/pig.dart -p <input_directory> [-e <extensions>] [-o <output_file>]
```

### オプション

- `-p, --path`: 入力ディレクトリのパス（必須）
- `-e, --extensions`: 対象とするファイルの拡張子（デフォルト: .txt）
- `-o, --output`: 出力ファイルのパス（指定しない場合はコンソールに出力）
- `-h, --help`: ヘルプメッセージを表示

### 使用例

1. .dartファイルと.txtファイルを検索してコンソールに出力:
```bash
dart run bin/pig.dart -p ./my_project -e .dart,.txt
```

2. 特定のファイルに出力:
```bash
dart run bin/pig.dart -p ./my_project -e .dart -o ./output/result.txt
```

3. 絶対パスを使用:
```bash
dart run bin/pig.dart -p /home/user/projects -e .dart,.txt -o /home/user/output.txt
```

## 出力フォーマット

出力は以下のフォーマットで生成されます:

```
========
path/to/file1.txt
========
[file1の内容]

========
path/to/file2.txt
========
[file2の内容]
```

## 開発

### プロジェクト構造

```
pig/
  ├── bin/
  │   └── pig.dart       # メインのエントリーポイント
  ├── lib/
  │   └── pig.dart       # コア機能の実装
  ├── pubspec.yaml       # プロジェクト設定と依存関係
  └── README.md          # このファイル
```

### ビルド

リリース用のビルド:

```bash
dart compile exe bin/pig.dart -o pig
```

## 制限事項

- バイナリファイルは適切に処理されない可能性があります
- 大量のファイルや非常に大きなファイルを処理する場合、メモリ使用量に注意が必要です


## コントリビューション

1. フォークを作成
2. フィーチャーブランチを作成 (`git checkout -b feature/amazing-feature`)
3. 変更をコミット (`git commit -m 'Add some amazing feature'`)
4. ブランチをプッシュ (`git push origin feature/amazing-feature`)
5. プルリクエストを作成

## 謝辞

このプロジェクトは以下のパッケージを使用しています：
- [args](https://pub.dev/packages/args)
- [path](https://pub.dev/packages/path)