# dotfiles

## Software
| Type         | Software                 | Depencencies    | Comments                                                                             |
|--------------|--------------------------|-----------------|--------------------------------------------------------------------------------------|
| WM           | i3wm                     |                 | A tiling window manager, completely written from scratch.                            |
| Shell        | zsh                      | `wget`, `lua`   | `zinit` is the zsh plugin manager used                                               |
| StatusBar    | i3status-rust            | `xbacklight`    | A feature-rich and resource-friendly replacement for i3status, written in pure Rust. |
| Terminal     | urxvt                    |                 |                                                                                      |
| Multiplexer  | tmux                     |                 |                                                                                      |
| Font         | Fantasque Sans Nerd Font |                 |                                                                                      |
| Font         | Font Awesome 4           |                 |                                                                                      |
| Editor       | vim/neovim               | `python-neovim` |                                                                                      |
| Editor       | emacs                    | `ripgrep`, `fd` | doom-emacs                                                                           |
| CVS          | git                      | `diff-so-fancy` | a `perl` script                                                                      |
| Files        | nnn                      |                 |                                                                                      |
| Video        | mpv, vlc                 |                 |                                                                                      |
| ScreenShot   | Flameshot                |                 |                                                                                      |
| Notification | dunst                    |                 |                                                                                      |

### General Dependencies
| Package                                                    | Depended by                 | Note       |
|------------------------------------------------------------|-----------------------------|------------|
| `wget`                                                     | zsh - zinit                 |            |
| `fzf`                                                      | zsh(Aloxaf/fzf-tab)         |            |
| `lua`                                                      | zsh - skywind3000/z.lua     | optional   |
| `ripgrep`                                                  | vim, emacs                  |            |
| `fd`                                                       | vim, emacs                  |            |
| `diff-so-fancy`                                            | git                         |            |
| `xbacklight`                                               | statusbar - i3status-rust   | for laptop |
| `make`                                                     | vim - RRethy/vim-hexokinase |            |
| `go`                                                       | vim - RRethy/vim-hexokinase |            |
| `nodejs`                                                   | vim - neoclide/coc.nvim     |            |
| `python-neovim`                                            | nvim                        |            |
| npm `dockerfile-language-server-nodejs`                    | vim, emacs                  | Dokerfile  |
| npm `bash-language-server`                                 | vim, emacs                  | Shell      |
| `python-jedi`                                              | vim, emacs                  | Python     |
| OpenJDK                                                    | vim, emacs                  | Java       |
| Dotnet SDK                                                 | vim, emacs                  | C#         |
| [i3status-rust](https://github.com/greshake/i3status-rust) | i3                          |            |

### Language Denpendencies
#### C/C++
* vim: `ccls`
* emacs: `ccls`
#### CMake
#### Bash
* vim: 
* emacs: `npm i -g bash-language-server`
#### Python
* vim: `python-jedi`(ArchLinux)
* emacs: `M-x lsp-install-server RET mspyls`
#### Java
* vim
* emacs: `jdk-openjdk`(ArchLinux), `Mx lsp-install-server RET jdtls`
#### C#
* vim
* emacs: 
#### YAML


## Installation

``` sh
git clone --recursive https://github.com/shunlir/dotfiles.git ~/.dotfiles
# or use the following command after clone
cd ~/.dotfiles && git submodule update --init --recursive 

# install stow or xstow
```

## Navigation

| Action        | i3(Super)               | Tmux(Alt)          | Vim                    |
|---------------|-------------------------|--------------------|------------------------|
|               | _(windows)_             | _(panes)_          | _(windows)_            |
| Focus left    | `Super + h`             | `Alt + h`          | `Alt + h`              |
| Focus Right   | `Super + l`             | `Alt + l`          | `Alt + l`              |
| Focus Up      | `Super + k`             | `Alt + k`          | `Alt + k`              |
| Focus Down    | `Super + j`             | `Alt + j`          | `Alt + j`              |
| Focus Last    | TODO                    | TODO               | TODO                   |
| Focus Next    | TODO                    | TODO               | TODO                   |
| Focus Prev    | TODO                    | TODO               | TODO                   |
|               | _(workspaces)_          | _(windows)_        | _(tabs)_               |
| Focus #N      | `Super + #N`            | `Alt + #N`         | `#N` `g` `t` (builtin) |
| Move to #N    | `Super + Shift + #N`    | `Alt + Shift + #N` | TODO:Tabmerge plugin   |
|               | _(current window)_      | _(current panel)_  | _(current window)_     |
| Fullscreen    | `Super + f`             | `Alt + f`          | `<Leader>` `w` `f`     |
| Resize Left   | `<Super + r>` `h`       | `Alt + Shift + h`  | `Alt + Shift + h`      |
| Resize Right  | `<Super + r>` `l`       | `Alt + Shift + l`  | `Alt + Shift + l`      |
| Resize Up     | `<Super + r>` `k`       | `Alt + Shift + k`  | `Alt + Shift + k`      |
| Reisze Down   | `<Super + r>` `j`       | `Alt + Shift + j`  | `Alt + Shift + j`      |
| Move to Left  | `Super + Shift + left`  | swap-panel -t <>   | `<Leader>` `w` `h`     |
| Move to Right | `Super + Shift + Right` | swap-panel -t <>   | `<Leader>` `w` `l`     |
| Move to Up    | `Super + Shift + Up`    | swap-panel -t <>   | `<Leader>` `w` `k`     |
| Move to Down  | `Super + Shift + Down`  | swap-panel -t <>   | `<Leader>` `w` `j`     |
| Split v       | `Super + .`             | `Alt + .`          | `<Leader>` `w` `.`     |
| Split h       | `Super + -`             | `Alt + -`          | `<Leader>` `w` `-`     |

## References
* https://github.com/gerardbm/dotfiles
* https://github.com/xero/dotfiles
* https://gitlab.com/BVollmerhaus/dotfiles
