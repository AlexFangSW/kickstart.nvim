# AlexFangSW's Neovim config
Based on **kickstart.nvim**, and gradually modified.

## Install 
Place the config under `~/.config/nvim`
```
git clone https://github.com/AlexFangSW/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```
Once you start `nvim` it should be using this config
```
nvim
```

## Multiple nvim configs
Set an alias for the config
When you run Neovim using `nvim-kickstart` alias it will use the alternative config directory and the matching local directory `~/.local/share/nvim-kickstart`. You can apply this approach to any Neovim distribution that you would like to try out.
```bash
alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
```

## Nvim version 0.11

## Depandencies
### Telescope
- `ripgrep` 
- `fzf` 
