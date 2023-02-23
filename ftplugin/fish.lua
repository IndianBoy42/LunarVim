vim.opt_local.commentstring = "# %s"

-- some shorthands...
local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local l = require("luasnip.extras").lambda
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local pa = ls.parser.parse_snippet
local types = require "luasnip.util.types"
local nl = t { "", "" }
local function nlt(line)
  return t { "", line }
end

local function tnl(line)
  return t { line, "" }
end

require("luasnip").add_snippets("fish", {
  s("elif", {
    t "else if ",
    i(0),
    t { "", "" },
  }),
})
require("luasnip").add_snippets("fish", {
  s("if", {
    t "if ",
    i(0),
    t { "", "end" },
  }),
  s("function", {
    t "function ",
    i(0),
    t { "", "end" },
  }),
  s("alias", {
    t "function ",
    i(1),
    t " --wraps=",
    i(2),
    t { "", "\t" },
    r(2),
    t " ",
    i(0),
    t { "", "end" },
  }),
  s("for", {
    t "for ",
    i(1),
    t " in ",
    i(2),
    t { "", "end" },
  }),
})
