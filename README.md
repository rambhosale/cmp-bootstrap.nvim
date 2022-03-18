# cmp-bootstrap.nvim

cmp-bootstrap.nvim is nvim-cmp completion source for bootstrap 4 class names

## Requirements

- Neovim >= 0.5.1
- nvim-cmp

## Installation

using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
    "rambhosale/cmp-bootstrap.nvim",
    after = "nvim-cmp"
    event = "InsertEnter",
 }
```

## Setup

Add the following code to in your init.lua or a simillar file

```lua
   local cmp = require("cmp")

   cmp.setup.filetype('html', {
      sources = cmp.config.sources({
         { name = 'cmp_bootstrap' },
         -- other sources
      })
   })
```

![Screenshot from 2022-03-18 17 59 18](https://user-images.githubusercontent.com/21305685/159003225-57077074-3a6e-413f-893e-702cc645b7d0.png)
![Screenshot from 2022-03-18 17 59 38](https://user-images.githubusercontent.com/21305685/159003247-e10d6067-a204-4b89-9005-ccc337d130cf.png)
