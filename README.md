# dotfiles

## Software
| Type        | Software                 | Depencencies    | Comments                                                                             |
|-------------|--------------------------|-----------------|--------------------------------------------------------------------------------------|
| WM          | i3wm                     |                 | A tiling window manager, completely written from scratch.                            |
| Shell       | zsh                      | `wget`, `lua`   | `zinit` is the zsh plugin manager used                                               |
| StatusBar   | i3status-rust            | `xbacklight`    | A feature-rich and resource-friendly replacement for i3status, written in pure Rust. |
| Terminal    | urxvt                    |                 |                                                                                      |
| Multiplexer | tmux                     |                 |                                                                                      |
| Font        | Fantasque Sans Nerd Font |                 |                                                                                      |
| Font        | Font Awesome 4           |                 |                                                                                      |
| Editor      | vim/neovim               | `python-neovim` |                                                                                      |
| Editor      | emacs                    | `ripgrep`, `fd` | doom-emacs                                                                           |
| CVS         | git                      | `diff-so-fancy` | a `perl` script                                                                      |
| Files       | nnn                      |                 |                                                                                      |
| Email       | TODO                     |                 |                                                                                      |
| Music       | TODO                     |                 |                                                                                      |
| Video       | mpv, vlc                 |                 |                                                                                      |
| ScreenShot  | Flameshot                |                 |                                                                                      |
| Notify      |                          |                 |                                                                                      |

https://github.com/gerardbm/dotfiles
https://github.com/xero/dotfiles
https://gitlab.com/BVollmerhaus/dotfiles

## Installation

``` sh
git clone --recursive <repo-url> ~/.dotfiles
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
