SCRIPT_NAME=$(basename "$0")
CURRENT_DIR_RELATIVE=$(dirname "$0")
CURRENT_DIR=$(cd "$CURRENT_DIR_RELATIVE" || exit;pwd)
PARENT_DIR=$(cd "$CURRENT_DIR"/.. || exit;pwd)
#GRANDPARENT_DIR=$(cd "$PARENT_DIR"/.. || exit;pwd)

echo "[Begin markdonwlint]"
pushd "$CURRENT_DIR" >/dev/null
npx markdownlint . --ignore ./node_modules
popd >/dev/null
echo "[End markdownlint]"