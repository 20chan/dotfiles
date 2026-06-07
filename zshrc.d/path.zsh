PATHS=(
  "$HOME/.dotnet/tools"
  "$HOME/.duckdb/cli/latest"
)

for target in "${PATHS[@]}"; do
  [ -d "$target" ] && export PATH="$PATH:$target"
done
