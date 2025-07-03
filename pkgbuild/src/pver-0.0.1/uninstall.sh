#!/bin/bash
set -e

echo "🧹 Uninstalling pver CLI tool..."

USER_SHELL=$(basename "$SHELL")

get_zshrc_path() {
  if [ -n "$ZDOTDIR" ] && [ -d "$ZDOTDIR" ]; then
    echo "$ZDOTDIR/.zshrc"
    return
  fi

  if [ -f "$HOME/.zshenv" ]; then
    local zdotdir
    zdotdir=$(grep -E '^\s*export ZDOTDIR=' "$HOME/.zshenv" | sed -E 's/.*ZDOTDIR=["'"'"']?([^"'"'"']+)["'"'"']?/\1/')
    if [ -n "$zdotdir" ] && [ -d "$zdotdir" ]; then
      echo "$zdotdir/.zshrc"
      return
    fi
  fi

  echo "$HOME/.zshrc"
}

get_shell_rc() {
  case "$USER_SHELL" in
    zsh)
      get_zshrc_path
      ;;
    bash)
      for rc in "$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.profile"; do
        [ -f "$rc" ] && echo "$rc" && return
      done
      echo "$HOME/.bashrc"
      ;;
    fish)
      echo "$HOME/.config/fish/config.fish"
      ;;
    *)
      echo "$HOME/.profile"
      ;;
  esac
}

SHELL_RC=$(get_shell_rc)
echo "ℹ️ Detected shell: $USER_SHELL"
echo "ℹ️ Using shell config: $SHELL_RC"

if [ -f "$SHELL_RC" ]; then
  # 删除 pver shell 函数块
  sed -i "/# >>> pver shell integration >>>/,/# <<< pver shell integration <<</d" "$SHELL_RC"
  # 删除 PATH 行
  sed -i '/export PATH="\$HOME\/\.local\/bin:\$PATH"/d' "$SHELL_RC"
  echo "✅ Removed pver shell function and PATH from $SHELL_RC"
else
  echo "⚠️ $SHELL_RC not found, skipping shell config cleanup"
fi

# 删除可执行文件
if [ -f "$HOME/.local/bin/pver" ]; then
  rm -f "$HOME/.local/bin/pver"
  echo "✅ Removed ~/.local/bin/pver"
else
  echo "ℹ️ pver binary not found"
fi

echo "✅ Uninstallation complete. Please run: source $SHELL_RC"
