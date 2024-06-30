# AlexFangSW's Neovim config
Based on **kickstart.nvim**, and gradually modified.

## Multiple nvim configs
Set an alias for the config
When you run Neovim using `nvim-kickstart` alias it will use the alternative config directory and the matching local directory `~/.local/share/nvim-kickstart`. You can apply this approach to any Neovim distribution that you would like to try out.
```bash
alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
```

## Depandencies
### Telescope
- `ripgrep` 
- `fzf` 
