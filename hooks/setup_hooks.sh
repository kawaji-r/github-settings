#!/bin/bash
# `hooks`フォルダに入っているファイルすべてを`.git/hooks`フォルダにシンボリックリンクする

function main () {
    link_hooks
}

function link_hooks () {
    # プロジェクトルートディレクトリに移動
    cd "$(git rev-parse --show-toplevel)"

    # .git/hooks ディレクトリの確認
    if [ ! -d .git/hooks ]; then
      echo "Error: .git/hooks directory does not exist."
      exit 1
    fi

    # hooks ディレクトリ内のすべてのファイルにシンボリックリンクを作成
    for hook in ./hooks/*; do
      hook_name=$(basename "$hook")
      target=".git/hooks/$hook_name"

      if [ "$hook_name" == "$(basename "$0")" ]; then
        continue
      fi

      echo =======================
      pwd
      echo ln -s "$hook" "$target"
      continue

      # 既存のフックがある場合
      if [ -e "$target" ]; then
        # 内容が同じ場合はスキップ
        if diff "$hook" "$target" > /dev/null 2>&1; then
          continue
        fi

        # 内容が異なる場合はバックアップを作成
        mv "$target" "$target.backup"
      fi

      ln -s "$hook" "$target"
      echo "Created symlink for $hook_name"
    done

    cd - > /dev/null

    echo "Git hooks have been set up."
}

main
