#!/bin/bash
set -e

echo "📦 Installing pver CLI tool..."

mkdir -p "$HOME/.local/bin"
cp ./pver "$HOME/.local/bin/pver"

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
echo "ℹ️ Using shell config file: $SHELL_RC"

FUNC_TAG="# >>> pver shell integration >>>"

if grep -q "$FUNC_TAG" "$SHELL_RC" 2>/dev/null; then
  echo "🔁 pver shell integration already exists in $SHELL_RC"
else
  cat << 'EOF' >> "$SHELL_RC"

# >>> pver shell integration >>>
function pver() {
  case "$1" in
    init)
      command pver init "${@:2}"
      ;;
    cd)
      VENV_DIR=${2:-venv}
      if [[ -f "$VENV_DIR/bin/activate" ]]; then
        echo "🔗 Activating $VENV_DIR"
        source "$VENV_DIR/bin/activate"
      else
        echo "❌ Virtual environment not found at $VENV_DIR"
      fi
      ;;
    exit)
      if type deactivate >/dev/null 2>&1; then
        echo "🔌 Deactivating virtual environment"
        deactivate
      else
        echo "⚠️ No virtual environment is currently active"
      fi
      ;;
    *)
      command pver "$@"
      ;;
  esac
}
# <<< pver shell integration <<<
EOF
  echo "✅ Added pver function to $SHELL_RC"
fi

if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$SHELL_RC"; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
  echo "✅ Added ~/.local/bin to PATH in $SHELL_RC"
fi

echo "✅ Installation complete. Please run: source $SHELL_RC"
