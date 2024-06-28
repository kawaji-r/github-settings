# リポジトリのURLまたはオーナー/リポジトリ形式で指定します
if [ -z "$REPO" ]; then
  echo "Error: 環境変数[REPO]を設定してください"
  exit 1
fi

gh api \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  /repos/${REPO}/rulesets \
  --input ruleset.json

