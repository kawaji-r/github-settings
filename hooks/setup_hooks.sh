#!/bin/bash
# `hooks`フォルダに入っているファイルすべてを`.git/hooks`フォルダにシンボリックリンクする

# プロジェクトルートディレクトリに移動
cd "$(git rev-parse --show-toplevel)"

# .git/hooks ディレクトリの確認
if [ ! -d .git/hooks ]; then
  echo "Error: .git/hooks directory does not exist."
  exit 1
fi

# hooks ディレクトリ内のすべてのファイルにシンボリックリンクを作成
for hook in .git-settings/hooks/*; do
  hook_name=$(basename "$hook")
  target=".git/hooks/$hook_name"

  if [ "$hook_name" == "$(basename "$0")" ]; then
    continue
  fi

  # 既存のフックがある場合はバックアップを作成
  if [ -e "$target" ]; then
    mv "$target" "$target.backup"
  fi

  ln -s "../../$hook" "$target"
  echo "Created symlink for $hook_name"
done

cd - > /dev/null

echo "Git hooks have been set up."

