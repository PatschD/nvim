return {
  "echasnovski/mini.indentscope",
  opts = {
    -- symbol = "▏",
    symbol = "│",
    options = { try_as_border = true },
    draw = {
      animation = require("mini.indentscope").gen_animation.none(),
    },
  },
}
