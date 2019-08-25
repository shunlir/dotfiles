# cargo, dependent by fd & ripgrep
if ! command -v cargo >/dev/null 2>&1; then
  printf "${MAGENTA}Installing rust & cargo...${NORMAL}\n"
  curl -sSf https://static.rust-lang.org/rustup.sh | sh
  echo 'export PATH=$PATH:~/.cargo/bin' >> ~/.zshrc
fi

# fd
if ! command -v fd >/dev/null 2>&1; then
  printf "${MAGENTA}Installing fd...${NORMAL}\n"
  cargo install fd-find
fi

# ripgrep
if ! command -v rg >/dev/null 2>&1; then
  printf "${MAGENTA}Installing ripgrep...${NORMAL}\n"
  cargo install ripgrep
fi

# fzf
if [ ! ~/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --completion --key-bindings --update-rc --no-bash
fi

