local M = {}
M.sandwich_recipes = {
  { __filetype__ = "tex", buns = { "“", "”" }, nesting = 1, input = { 'u"' } },
  { __filetype__ = "tex", buns = { "„", "“" }, nesting = 1, input = { 'U"', "ug", "u," } },
  { __filetype__ = "tex", buns = { "«", "»" }, nesting = 1, input = { "u<", "uf" } },
  { __filetype__ = "tex", buns = { "`", "'" }, nesting = 1, input = { "l'", "l`" } },
  { __filetype__ = "tex", buns = { "``", "''" }, nesting = 1, input = { 'l"' } },
  { __filetype__ = "tex", buns = { '"`', "\\\"'" }, nesting = 1, input = { 'L"' } },
  { __filetype__ = "tex", buns = { ",,", "``" }, nesting = 1, input = { "l," } },
  { __filetype__ = "tex", buns = { "<<", ">>" }, nesting = 1, input = { "l<" } },
  { __filetype__ = "tex", buns = { "&", "\\\\" }, nesting = 1, input = { "&" } },
  { __filetype__ = "tex", buns = { "$", "$" }, nesting = 0 },
  {
    __filetype__ = "tex",
    buns = { "\\(", "\\)" },
    nesting = 1,
    input = { "\\(" },
    ["indentkeys-"] = "{,},0{,0}",
  },
  {
    __filetype__ = "tex",
    buns = { "\\(", "\\)" },
    nesting = 1,
    input = { "$" },
    ["indentkeys-"] = "{,},0{,0}",
  },
  {
    __filetype__ = "tex",
    buns = { "\\{", "\\}" },
    nesting = 1,
    input = { "\\{" },
    ["indentkeys-"] = "{,},0{,0}",
  },
  {
    __filetype__ = "tex",
    buns = { "\\{", "\\}" },
    nesting = 1,
    input = { "$$" },
    ["indentkeys-"] = "{,},0{,0}",
  },
  {
    __filetype__ = "tex",
    buns = { "\\|", "\\|" },
    nesting = 1,
    input = { "\\|" },
    ["indentkeys-"] = "{,},0{,0}",
  },
  {
    __filetype__ = "tex",
    buns = { "\\[", "\\]" },
    nesting = 1,
    input = { "\\[" },
    ["indentkeys-"] = "{,},0{,0}",
  },
  {
    __filetype__ = "tex",
    buns = { "\\left( ", " \\right)" },
    nesting = 1,
    input = { "m(" },
    action = { "add" },
    ["indentkeys-"] = "(,)",
  },
  {
    __filetype__ = "tex",
    buns = { "\\left[ ", " \\right]" },
    nesting = 1,
    input = { "m[" },
    action = { "add" },
    ["indentkeys-"] = "[,]",
  },
  {
    __filetype__ = "tex",
    buns = { "\\left| ", " \\right|" },
    nesting = 1,
    input = { "m|" },
    action = { "add" },
  },
  {
    __filetype__ = "tex",
    buns = { "\\left\\{ ", " \\right\\}" },
    nesting = 1,
    input = { "m{" },
    action = { "add" },
    ["indentkeys-"] = "{,},0{,0}",
  },
  {
    __filetype__ = "tex",
    buns = { "\\left\\langle ", "\\right\\rangle " },
    nesting = 1,
    input = { "m<" },
    action = { "add" },
  },
  {
    __filetype__ = "tex",
    buns = { "\\bigl(", "\\bigr)" },
    nesting = 1,
    input = { "M(" },
    action = { "add" },
    ["indentkeys-"] = "(,)",
  },
  {
    __filetype__ = "tex",
    buns = { "\\bigl[", "\\bigr]" },
    nesting = 1,
    input = { "M[" },
    action = { "add" },
    ["indentkeys-"] = "[,]",
  },
  {
    __filetype__ = "tex",
    buns = { "\\bigl|", "\\bigr|" },
    nesting = 1,
    input = { "M|" },
    action = { "add" },
  },
  {
    __filetype__ = "tex",
    buns = { "\\bigl\\{", "\\bigr\\}" },
    nesting = 1,
    input = { "M{" },
    action = { "add" },
    ["indentkeys-"] = "{,},0{,0}",
  },
  {
    __filetype__ = "tex",
    buns = { "\\bigl\\langle ", "\\bigr\\rangle " },
    nesting = 1,
    input = { "M<" },
    action = { "add" },
  },
  {
    __filetype__ = "tex",
    buns = { "\\textbf{", "}" },
    nesting = 1,
    input = { "bf" },
    action = { "add" },
  },
  {
    __filetype__ = "tex",
    buns = { "\\frac{", "}{}" },
    nesting = 1,
    input = { "fr" },
    action = { "add" },
  },
  {
    __filetype__ = "tex",
    buns = { "\\textit{", "}" },
    nesting = 1,
    input = { "it" },
    action = { "add" },
  },
  {
    __filetype__ = "tex",
    buns = { "\\text{", "}" },
    nesting = 1,
    input = { "tt" },
    action = { "add" },
  },
  {
    __filetype__ = "tex",
    buns = { "\\bm{", "}" },
    nesting = 1,
    input = { "bm" },
    action = { "add" },
  },
  {
    __filetype__ = "tex",
    buns = { "\\mathbb{", "}" },
    nesting = 1,
    input = { "bb" },
    action = { "add" },
  },
  {
    __filetype__ = "tex",
    buns = { "\\sqrt{", "}" },
    nesting = 1,
    input = { "rt" },
    action = { "add" },
  },
  {
    __filetype__ = "tex",
    buns = { "\\mathcal{", "}" },
    nesting = 1,
    input = { "cal" },
    action = { "add" },
  },
  {
    __filetype__ = "tex",
    buns = { "\\begingroup", "\\endgroup" },
    nesting = 1,
    input = { "gr", "\\gr" },
    linewise = 1,
  },
  {
    __filetype__ = "tex",
    buns = { "\\toprule", "\\bottomrule" },
    nesting = 1,
    input = { "tr", "\\tr", "br", "\\br" },
    linewise = 1,
  },
  {
    __filetype__ = "tex",
    buns = "sandwich#filetype#tex#CmdInput()",
    kind = { "add", "replace" },
    action = { "add" },
    listexpr = 1,
    nesting = 1,
    input = { "c" },
    ["indentkeys-"] = "{,},0{,0}",
  },
  {
    __filetype__ = "tex",
    buns = "sandwich#filetype#tex#EnvInput()",
    kind = { "add", "replace" },
    action = { "add" },
    listexpr = 1,
    nesting = 1,
    linewise = 1,
    input = { "e" },
    ["indentkeys-"] = "{,},0{,0}",
    autoindent = 0,
  },
  {
    __filetype__ = "tex",
    buns = { "\\\\\a\\+\\*\\?{", "}" },
    kind = { "delete", "replace", "auto", "query" },
    regex = 1,
    nesting = 1,
    input = { "c" },
    ["indentkeys-"] = "{,},0{,0}",
  },
  {
    __filetype__ = "tex",
    buns = { "\\\begin{[^}]*}\\%(\\[.*\\]\\)\\?", "\\end{[^}]*}" },
    kind = { "delete", "replace", "auto", "query" },
    regex = 1,
    nesting = 1,
    linewise = 1,
    input = { "e" },
    ["indentkeys-"] = "{,},0{,0}",
    autoindent = 0,
  },
  {
    __filetype__ = "tex",
    external = {
      "\\<Plug>(textobj-sandwich-filetype-tex-marks-i)",
      "\\<Plug>(textobj-sandwich-filetype-tex-marks-a)",
    },
    kind = { "delete", "replace", "auto", "query" },
    noremap = 0,
    input = { "ma" },
    indentkeys = "{,},0{,0}",
    autoindent = 0,
  },
}

function M.sandwhich_mark_recipe_fn()
  local map = vim.keymap.set
  map(
    "x",
    "<Plug>(textobj-sandwich-filetype-tex-marks-i)",
    "textobj#sandwich#auto('x', 'i', {'synchro': 0}, b:sandwich_tex_marks_recipes)",
    { silent = true, expr = true }
  )
  map(
    "x",
    "<Plug>(textobj-sandwich-filetype-tex-marks-a)",
    "textobj#sandwich#auto('x', 'a', {'synchro': 0}, b:sandwich_tex_marks_recipes)",
    { silent = true, expr = true }
  )
end

M.sandwich_marks_recipes = {
  {
    buns = { "\\%([[(]\\|\\{\\)", "\\%([])]\\|\\}\\)" },
    regex = 1,
    nesting = 1,
  },
  {
    buns = { "|", "|" },
    nesting = 0,
  },
  {
    buns = { "\\m\\C\\[Bb]igg\\?l|", "\\m\\C\\[Bb]igg\\?r|" },
    regex = 1,
    nesting = 1,
  },
  {
    buns = {
      "\\m\\C\\\\%(langle\\|lVert\\|lvert\\|lceil\\|lfloor\\)",
      "\\m\\C\\\\%(rangle\\|rVert\\|rvert\\|rceil\\|rfloor\\)",
    },
    regex = 1,
    nesting = 1,
  },
  {
    buns = {
      "\\m\\C\\left\\%([[(|.]\\|\\{\\|\\langle\\|\\lVert\\|\\lvert\\|\\lceil\\|\\lfloor\\)",
      "\\m\\C\\\right\\%([])|.]\\|\\}\\|\\\rangle\\|\\\rVert\\|\\\rvert\\|\\\rceil\\|\\\rfloor\\)",
    },
    regex = 1,
    nesting = 1,
  },
  --  NOTE: It is not reasonable to set 'nesting' on when former and latter surrounds are same.
  {
    buns = { "\\m\\C\\[Bb]igg\\?|", "\\m\\C\\[Bb]igg\\?|" },
    regex = 1,
    nesting = 0,
  },
  -- NOTE: The existence of '\\big.' makes the situation tricky.
  --       Try to search those two cases independently and adopt the nearest item.
  --         \\big. foo \\big)
  --         \\big( foo \\big.
  --       This roundabout enables the following:
  --         \\big( foo \\big. bar \\big. baz \\big)
  --       When the cursor is on;
  --         foo -> \\big( and \\big.
  --         bar -> nothing
  --         foo -> \\big. and \\big)
  --       were deleted by the input 'sdma'.
  {
    buns = {
      "\\m\\C\\[Bb]igg\\?l\\?\\%([[(]\\|\\{\\|\\langle\\|\\lVert\\|\\lvert\\|\\lceil\\|\\lfloor\\)",
      "\\m\\C\\[Bb]igg\\?r\\?\\%([]).]\\|\\}\\|\\\rangle\\|\\\rVert\\|\\\rvert\\|\\\rceil\\|\\\rfloor\\)",
    },
    regex = 1,
    nesting = 1,
  },
  {
    buns = {
      "\\m\\C\\[Bb]igg\\?l\\?\\%([[(.]\\|\\{\\|\\langle\\|\\lVert\\|\\lvert\\|\\lceil\\|\\lfloor\\)",
      "\\m\\C\\[Bb]igg\\?r\\?\\%([])]\\|\\}\\|\\\rangle\\|\\\rVert\\|\\\rvert\\|\\\rceil\\|\\\rfloor\\)",
    },
    regex = 1,
    nesting = 1,
  },
  {
    buns = { "\\m\\C\\[Bb]igg\\?|", "\\m\\C\\[Bb]igg\\?." },
    regex = 1,
    nesting = 0,
  },
  {
    buns = { "\\m\\C\\[Bb]igg\\?.", "\\m\\C\\[Bb]igg\\?|" },
    regex = 1,
    nesting = 0,
  },
  {
    buns = { "\\m\\C\\[Bb]igg\\?l|", "\\m\\C\\[Bb]igg\\?r[|.]" },
    regex = 1,
    nesting = 1,
  },
  {
    buns = { "\\m\\C\\[Bb]igg\\?l[|.]", "\\m\\C\\[Bb]igg\\?r|" },
    regex = 1,
    nesting = 1,
  },
}

-- local F = require "F"
-- local L = require("pl.utils").string_lambda
local templates = require "lv-luasnips.templates"

-- some shorthands...
local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local ns = function(x)
  return sn(nil, x)
end
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
local list_extend = vim.list_extend
local tbl_extend = vim.tbl_extend
local conds = require "luasnip.extras.expand_conditions"
local function sel()
  return f(function(_, snip)
    return (snip and snip.env and snip.env.TM_SELECTED_TEXT) or ""
  end, {})
end

local function fmt(fn, ipairs)
  if ipairs == nil then
    ipairs = {}
  end
  return f(function(_, args)
    return string.format(unpack(fn(args.captures, args.trigger, args)))
  end, ipairs)
end

local function sub(j)
  return f(function(_, args)
    return string.format("%s", args.captures[j])
  end, {})
end

local function con(fn)
  return { condition = fn }
end

local mathmode_ = vim.fn["vimtex#syntax#in_mathzone"]
local mathmode = {
  condition = function()
    return mathmode_() ~= 0
  end,
}
local nonmathmode = {
  condition = function()
    return mathmode_() == 0
  end,
}
local function ms(lhs, rhs)
  return s(lhs, rhs, mathmode)
end

local function nms(lhs, rhs)
  return s(lhs, rhs, nonmathmode)
end

local function nw(k)
  return { trig = k, wordTrig = false }
end

local function re(arg)
  return { trig = arg, regTrig = true }
end

local function renw(arg)
  return { trig = arg, regTrig = true, wordTrig = false }
end

local line_begin = { condition = conds.line_begin }
local no_backslash = {
  condition = function(line_to_cursor, m)
    local n = -m:len() - 1
    print(line_to_cursor:sub(n, n))
    return (mathmode_() ~= 0) and (line_to_cursor:sub(n, n) ~= "\\")
  end,
}
local function lns(lhs, rhs)
  return s(lhs, rhs, line_begin)
end

local trig_fns = {
  "sin",
  "cos",
  "tan",
  "cot",
  "csc",
  "sec",
}

local both_maps = {
  "alpha",
  "beta",
  "gamma",
  "delta",
  "epsilon",
  ["eps"] = "epsilon",
  "zeta",
  "eta",
  "theta",
  "iota",
  "kappa",
  "lambda",
  "mu",
  "nu",
  "xi",
  "omicron",
  "pi",
  "rho",
  "sigma",
  "tau",
  "upsilon",
  "phi",
  "chi",
  "psi",
  "omega",
  "Alpha",
  "Beta",
  "Gamma",
  "Delta",
  "Epsilon",
  "Zeta",
  "Eta",
  "Theta",
  "Iota",
  "Kappa",
  "Lambda",
  "Mu",
  "Nu",
  "Xi",
  "Omicron",
  "Pi",
  "Rho",
  "Sigma",
  "Tau",
  "Upsilon",
  "Phi",
  "Chi",
  "Psi",
  "Omega",
  "varepsilon",
  "vartheta",
  "varpi",
  "varrho",
  "varsigma",
  "varphi",
  "nabla",
  ["grad"] = "nabla",
  "infty",
  "iff",
  "vdots",
  "ddots",
  ["..."] = "ldots",
  [":::"] = "vdots",
  ["=>"] = "implies",
  ["=<"] = "impliedby",
  ["->"] = "to",
  ["|->"] = "mapsto",
  ["!>"] = "mapsto",
  ["<>"] = "mapsto",
  "aleph",
}
for k, v in pairs(both_maps) do -- FIXME: deal with already existing backslash (can use frontier set?)
  local lhs = ("number" == type(k)) and v or k
end

local math_maps = {
  -- TODO: Move some of these to both
  ["c<"] = "subset",
  ["<c"] = "subset",
  ["\\subset="] = "subseteq",
  ["k<"] = "prec",
  ["<k"] = "prec",
  ["\\prec="] = "preceq",
  ["c>"] = "supset",
  [">c"] = "supset",
  ["\\supset="] = "supseteq",
  ["k>"] = "succ",
  [">k"] = "succ",
  ["\\succ="] = "succeq",
  ["inn"] = "in",
  ["nii"] = "ni",
  ["!in"] = "notin",
  ["!!"] = "neg",
  ["--"] = "setminus",
  ["null"] = "emptyset",
  ["varnull"] = "varnothing",
  "cup",
  "cap",
  ["bcup"] = "bigcup",
  ["bcap"] = "bigcap",
  "vee",
  "wedge",
  "vdash",
  "models",
  [">="] = "geq",
  ["=="] = "equiv",
  ["=~"] = "cong",
  "cong",
  "gets",
  ["<-"] = "gets",
  ["t=="] = "triangleq",
  ["<="] = "leq",
  ["!="] = "neq",
  ["~="] = "approx",
  ["~~"] = "sim",
  ["\\sim="] = "simeq",
  [">>"] = "gg",
  ["<<"] = "ll",
  -- TODO: Above these can have &=\\ mappings
  ["xx"] = "times",
  ["ox"] = "otimes",
  ["o+"] = "oplus",
  ["o*"] = "circ",
  ["**"] = "cdot",
  ["||"] = "mid",
  ["+-"] = "pm",
  ["-+"] = "mp",
  ["AA"] = "forall",
  ["qq"] = "quad",
  ["EE"] = "exists",
  ["RR"] = "R",
  ["NN"] = "N",
  ["ZZ"] = "Z",
  ["CC"] = "CC",
  ["QQ"] = "Q",
  ["OO"] = "Op",
  ["to"] = "to",
  ["&&"] = "&",
  ["%%"] = "%",
  -- ["!!"] = "neg",
  -- ["--"] = "setminus",
  -- ["null"] = "emptyset",
  -- ["varnull"] = "varnothing",
  "surd",
  ["span"] = "sspan",
  "argmin",
  "argmax",
  "rank",
  "dag",
  "because",
  "therefore",
  ["part"] = "partial",
  ["inf"] = "infty", -- FIXME: why below here doesn't trigger? WHY DOES IT TRIGGER NOW!?
  "min",
  "max",
  "log",
  "exp",
  "perp",
  "because",
  "therefore",
  "rcancel",
  "Ccancel",

  "sum",
  "prod",
  "iiint",
  "iint",
  "int",
  "oint",
  "lim",
  "left",
  "big",
  "Big",
}
list_extend(math_maps, trig_fns)
-- TODO: have a more flexible way of doing this. USE choice nodes!!!
-- snippets triggered by sum_`
local intlike = {
  ["\\int_"] = { operator = "\\int", low = { i(1, "S") } },
  ["\\int "] = { operator = "\\int", low = { i(1, "-\\infty") }, upp = { i(2, "\\infty") } },
  ["\\int1 "] = { operator = "\\int", low = { i(1, "0") }, upp = { i(2, "1") } },
  ["\\intr "] = { operator = "\\int", low = { i(1, "0") }, upp = { i(2, "\\infty") } },
  ["\\sum_"] = { operator = "\\sum", low = { i(1, "n \\in \\N") } },
  ["\\sum "] = { operator = "\\sum", low = { i(1, "i"), t "=", i(2, "0") }, upp = { i(3, "n") } },
  ["\\sumi "] = { operator = "\\sum", low = { i(1, "i"), t "=", i(2, "0") }, upp = { i(3, "\\infty") } },
  ["\\prod "] = { operator = "\\prod", low = { i(1, "i"), t "=", i(2, "0") }, upp = { i(3, "n") } },
  ["\\prodi "] = { operator = "\\prod", low = { i(1, "i"), t "=", i(2, "0") }, upp = { i(3, "\\infty") } },
  -- TODO: improve placeholders
  -- ["\\sum "] = { operator = "\\sum", low = { i(1, "i=0") }, upp = { i(3, "n") } },
  -- ["\\sumi "] = { operator = "\\sum", low = { i(1, "n=0") }, upp = { i(3, "\\infty") } },
  -- ["\\prod "] = { operator = "\\prod", low = { i(1, "n=0") }, upp = { i(3, "\\infty") } },
  -- ["\\prodi "] = { operator = "\\prod", low = { i(1, "i=0") }, upp = { i(3, "n") } },
  ["\\lim "] = { operator = "\\lim", low = { i(1, "n"), t "\\to", i(2, "\\infty") } },
  ["\\lim_"] = { operator = "\\lim", low = { i(1, "n"), t "\\to", i(2, "\\infty") } },
  ["\\lim0 "] = { operator = "\\lim", low = { i(1, "n"), t "\\to", i(2, "0") } },
  ["lmt "] = { operator = "", low = { i(1) }, upp = { i(2) } },
  ["lmt_"] = { operator = "", low = { i(1) } },
  ["lmt^"] = { operator = "", upp = { i(1) } },
}

local auto = {}
local snips = {}

----------------------------------------------------------------------
--                     Auto expanding Snippets                      --
----------------------------------------------------------------------
-- Derived snippets
for k, v in pairs(both_maps) do -- FIXME: deal with already existing backslash (can use frontier set?)
  local lhs = ("number" == type(k)) and v or k
  -- local lhs = "([^%\\])" .. v
  -- local lhs = "([%p])" .. v
  list_extend(auto, { s(lhs, t("\\" .. v), no_backslash) })
  -- list_extend(auto, { nms(lhs .. " ", t("$\\" .. v .. "$ ")) })
  list_extend(auto, { nms(lhs .. " ", t("\\(\\" .. v .. "\\) ")) })
end

for k, v in pairs(math_maps) do
  local lhs = ("number" == type(k)) and v or k
  list_extend(auto, { s(lhs, t("\\" .. v), no_backslash) })
end
for k, v in pairs(trig_fns) do
  local lhs = ("number" == type(k)) and v or k
  list_extend(auto, { s(re([[ar?c?]] .. lhs), t("\\arc" .. v), no_backslash) })
end

list_extend(auto, {

  s("---- ", { t { "\\hline", "" } }),
  lns("--", t "\\item"),
  -- TODO: all of these can use TM_SELECTED_TEXT
  lns(
    "S{",
    c(1, {
      ns { t "\\section{", sel(), t "}" },
      ns { t "\\subsection{", sel(), t "}" },
      ns { t "\\subsubsection{", sel(), t "}" },
    })
  ),
  lns("s{", { t "\\section{", sel(), i(1), t "}" }),
  lns("ss{", { t "\\subsection{", sel(), i(1), t "}" }),
  lns("sss{", { t "\\subsubsection{", sel(), i(1), t "}" }),
  lns(
    "desc ",
    { t { "\\begin{description}", "\t\\item[" }, i(1), t { "]" }, sel(), i(0), t { "", "\\end{description}" } }
  ),
  -- TODO: more choices?
  lns("ali ", { t { "\\begin{align*}", "" }, sel(), i(0), t { "", "\\end{align*}" } }),
  lns("frame ", { t "\\begin{frame}\frametitle{", i(1), t { "}", "" }, sel(), i(0), t { "", "\\end{frame}" } }),
  lns("alin ", { t { "\\begin{align}", "" }, sel(), i(0), t { "", "\\end{align}" } }),
  lns("eq ", { t { "\\begin{equation*}", "" }, sel(), i(0), t { "", "\\end{equation*}" } }),
  lns("eqn ", { t { "\\begin{equation}", "" }, sel(), i(0), t { "", "\\end{equation}" } }),
  lns("md ", { t { "\\begin{markdown}", "" }, sel(), i(0), t { "", "\\end{markdown}" } }),
  nms(
    "``",
    c(1, {
      ns { t "\\textt{", i(1), t "}" },
      ns { t "\\verb|", i(1), t "|" },
    })
  ),
  ms("cases ", {
    t { "\\begin{cases}", "" },
    sel(),
    i(1),
    t "\t& \\textbf{ if } \t",
    i(2),
    t { "\\\\", "" },
    i(3),
    t { -- TODO: infinite list shenanigans
      "\t& \\textbf{ otherwise }",
      "\\end{cases}",
    },
  }),
  ms("matt ", { t { "\\begin{matrix}", "" }, sel(), i(0), t { "", "\\end{matrix}" } }),
  ms("bmat ", { t { "\\begin{bmatrix}", "" }, sel(), i(0), t { "", "\\end{bmatrix}" } }),
  ms("pmat ", { t { "\\begin{pmatrix}", "" }, sel(), i(0), t { "", "\\end{pmatrix}" } }),
  ms("vmat ", { t { "\\begin{vmatrix}", "" }, sel(), i(0), t { "", "\\end{vmatrix}" } }),
  s("matt ", { t { "\\[\\begin{matrix}", "" }, sel(), i(0), t { "", "\\end{matrix}\\]" } }),
  s("bmat ", { t { "\\[\\begin{bmatrix}", "" }, sel(), i(0), t { "", "\\end{bmatrix}\\]" } }),
  s("pmat ", { t { "\\[\\begin{pmatrix}", "" }, sel(), i(0), t { "", "\\end{pmatrix}\\]" } }),
  s("vmat ", { t { "\\[\\begin{vmatrix}", "" }, sel(), i(0), t { "", "\\end{vmatrix}\\]" } }),
  -- Simple text modifier commands
  -- TODO: extract this
  s("bf{", { t "\\textbf{", sel(), i(1), t "}" }),
  s("it{", { t "\\textit{", sel(), i(1), t "}" }),
  s("em{", { t "\\emph{", sel(), i(1), t "}" }),
  s("ul{", { t "\\underline{", sel(), i(1), t "}" }),
  ms("bm{", { t "\\bm{", sel(), i(1), t "}" }),
  ms("bb{", { t "\\mathbb{", sel(), i(1), t "}" }),
  ms("op{", { t "\\mathop{", sel(), i(1), t "}" }),
  ms("tt{", { t "\\text{", sel(), i(1), t "}" }),
  ms("rt{", { t "\\sqrt{", sel(), i(1), t "}" }),
  ms("cal{", { t "\\mathcal{", sel(), i(1), t "}" }),
  -- Math inline text
  ms("st ", { t "\\text{ s.t. } " }), -- TODO: deduplicate
  ms("let ", { t "\\textbf{let } " }),
  ms("where ", { t "\\textbf{ where } " }),
  ms("if ", { t "\\textbf{ if } " }),
  ms("otherwise ", { t "\\textbf{ otherwise } " }),
  ms("else ", { t "\\textbf{ else } " }),
  -- Math whitespacing
  ms(nw "\\quad\\,,", t "\\qquad "),
  ms(nw "\\,,", t "\\quad"),
  ms(nw ",,", t "\\,"),
  -- TODO: whitespace before and after operators
  -- TODO: line 203 and below
  -- ms(re [[(%w[ ,%)%]%}])to]], { sub(1), t "\\to" }),
  -- Math overhead stuff
  ms(re [[(%\?[%w%^]+),%.]], { t "\\vec{", sub(1), t "}" }),
  ms(re [[(%\?[%w%^]+)%.,]], { t "\\vec{", sub(1), t "}" }),
  ms(re [[(%\?[%w%^]+)->]], { t "\\vec{", sub(1), t "}" }),
  ms(re [[(%\?[%w%^]+)^%.]], { t "\\dot{", sub(1), t "} " }),
  ms(re [[(%\?[%w%^]+)^:]], { t "\\ddot{", sub(1), t "}" }),
  ms(re [[(%\?[%w%^]+)~]], { t "\\tilde{", sub(1), t "}" }),
  ms(re [[(%\?[%w%^]+)^bar]], { t "\\overline{", sub(1), t "}" }),
  ms(re [[(%\?[%w%^]+)^_]], { t "\\overline{", sub(1), t "}" }),
  ms(re [[(%\?[%w%^]+)^hat]], { t "\\hat{", sub(1), t "}" }),
  -- s("$", { t "\\(", i(1), t "\\)", i(0) }),
  s(
    "$",
    c(1, {
      ns { t "\\(", i(1), t "\\)" },
      ns { t "$", i(1), t "$" },
    })
  ),
  ms("bar", { t "\\overline{", i(1), t "}", i(0) }),
  ms("hat", { t "\\hat{", i(1), t "}", i(0) }),
  ms("dot", { t "\\dot{", i(1), t "}", i(0) }),
  ms("iprod", { t "\\iprod{", i(1), t "}", i(0) }),
  -- TODO: meh
  -- ms(">>", { c(1, { t "\\gg", t "\\succ", t "\\supset" }) }),
  -- ms("<<", { c(1, { t "\\ll", t "\\prec", t "\\subset" }) }),
  -- ms("==", { c(1, { t "\\approx", t "\\sim", t "\\cong", t "\\" }) }),
  -- ms("\\gg=", { c(1, { t "\\geq", t "\\succeq", t "\\supseteq" }) }),
  -- ms("\\ll=", { c(1, { t "\\leq", t "\\preceq", t "\\subseteq" }) }),
  ms(re "(%b{})/", {
    t "\\frac",
    sub(1),
    i(1),
    t "}{",
    i(2),
    t "}",
    i(0),
  }),
  ms(re "(%\\?%w+)/", {
    t "\\frac{",
    sub(1),
    t "}{",
    f(function(_, args)
      local f = args.captures[1]
      if f == "\\partial" then
        return "\\partial"
      else
        return ""
      end
    end),
    i(1),
    t "}",
    i(0),
  }),
  ms(re "binom", { t "\\binom", sub(1), t "{", i(0), t "}" }),
  ms("//", {
    t "\\frac{",
    i(1),
    t "}{",
    f(function(nodes, arg)
      local input = nodes[1]
      if input:find("\\partial", 1, true) == 1 then
        return "\\partial "
      end
      return ""
    end, { 1 }),
    i(2),
    t "}",
    i(0),
  }),
  -- TODO: binomial
  ms(re [[([%w^]+)sr]], { sub(1), t "^2" }),
  ms(re [[([%w^]+)cb]], { sub(1), t "^3" }),
  ms("l<", { t "\\langle" }),
  ms("r>", { t "\\rangle" }),
  ms("lcl", { t "\\lceil" }),
  ms("rcl", { t "\\rceil" }),
  ms("lfl", { t "\\lfloor" }),
  ms("rfl", { t "\\rfloor" }),
  -- ms("&", { t "&", i(0), t " \\\\" }), -- TODO: detect align environment?
  ms("&=", { t "&= ", i(0), c(1, { t "\t\\\\", t "", t "$" }) }), -- TODO: detect align environment?
  ms(re "&(\\%w+) ", { t "&", sub(1), t " ", i(0), c(1, { t " \\\\", t "" }) }), -- TODO: detect align environment?
  -- ms("|", { t "|", i(0), t "|" }),

  -- Subscripting and superscripting
  s(
    re [[([A-Za-z])([A-Za-z])([A-Za-z])]],
    f(function(_, arg)
      local cap = arg.captures
      return string.format("%s_%s", cap[1], cap[2])
    end, {}),
    {
      condition = function(_, matched_trigger)
        return (mathmode_() ~= 0) and (matched_trigger:sub(2, 2) == matched_trigger:sub(3, 3))
      end,
    }
  ),
  ms(renw "__", { t "_{", i(1), t "}" }),
  ms(renw "%^%^", { t "^{", i(1), t "}" }),
  nms(renw "%^%^", { t "\\cite{", i(1), t "}" }),
  ms(renw [[(%S) ([%^_])]], { sub(1), sub(2) }), -- Remove extra ws sub/superscript
  ms(renw [[([A-Za-z%}%]%)])(%d)]], { sub(1), t "_", sub(2) }), -- Auto subscript
  -- ms(renw [[([A-Za-z%}%]%)])([a-z])]], { sub(1), t "_", sub(2) }), -- Auto subscript
  ms(renw [[([A-Za-z%}%]%)]) ?_(%d%d)]], { sub(1), t "_{", sub(2), t "}" }), -- Auto escape subscript
  ms(renw [[([A-Za-z%}%]%)]) ?_(%w[+-])]], { sub(1), t "_{", sub(2), i(1), t "}" }), -- Auto escape subscript
  ms(renw [[([A-Za-z%}%]%)]) ?_([%+%-] ?[%d%w])]], { sub(1), t "_{", sub(2), t "}" }), -- Auto escape subscript
  ms(renw [[([A-Za-z%}%]%)]) ?_([%+%-]? ?%\%w+) ]], { sub(1), t "_{", sub(2), t "}" }), -- Auto escape subscript
  ms(renw [[([A-Za-z%}%]%)]) ?%^(%d%d)]], { sub(1), t "^{", sub(2), t "}" }), -- Auto escape subscript
  ms(renw [[([A-Za-z%}%]%)]) ?%^ ?(%d%d)]], { sub(1), t "^{", sub(2), t "}" }), -- Auto escape superscript
  ms(renw [[([A-Za-z%}%]%)]) ?%^([%+%-] ?[%d%w])]], { sub(1), t "^{", sub(2), t "}" }), -- Auto escape superscript
  ms(renw [[([A-Za-z%}%]%)]) ?%^([%+%-]? ?%\%w+) ]], { sub(1), t "^{", sub(2), t "}" }), -- Auto escape superscript
  ms(renw [[([A-Za-z%}%]%)]) ?%^(%w[+-])]], { sub(1), t "^{", sub(2), i(1), t "}" }), -- Auto escape subscript
  ms(nw "_lims", {
    c(1, { t "\\limits", t "" }),
    c(2, { -- TODO: context dependent? more flexible
      ns { t "_", i(1, "S") },
      ns { t "_{", i(1, "i"), t "=", i(2, "0"), t "}^{", i(3, "\\infty"), t "}" },
      ns { t "_", i(1, "n \\in \\N") },
      ns { t "_{", i(1, "-\\infty"), t "}^{", i(2, "\\infty"), t "}" },
      ns { t "_{", i(1, "0"), t "}^{", i(2, "1"), t "}" },
      ns { t "_{", i(1, "0"), t "}^{", i(2, "\\infty"), t "}" },
      ns { t "^", i(1, "S") },
      t "",
    }),
    t " ",
    sel(),
    i(0),
  }),
})

-- for k, v in pairs(intlike) do
--   local snip = { t(v.operator .. "\\limits") }
--   if v.low then
--     list_extend(snip, { t "_{" })
--     list_extend(snip, v.low)
--     list_extend(snip, { t "}" })
--   end
--   if v.upp then
--     list_extend(snip, { t "^{" })
--     list_extend(snip, v.upp)
--     list_extend(snip, { t "}" })
--   end
--   list_extend(auto, { ms(k, snip) })
-- end

local cpairs = {
  ["("] = ")",
  ["["] = "]",
  ["\\("] = "\\)",
  ["\\["] = "\\]",
  ["\\{"] = "\\}",
  ["\\|"] = "\\|",
  ["\\langle"] = "\\rangle",
  ["\\lceil"] = "\\rceil",
  ["\\lfloor"] = "\\rfloor",
  ["|"] = "|",
  -- ["."] = "|", -- TODO: how to do this?
}
local pairmods = {
  ["\\left"] = "\\right",
  ["\\big"] = "\\big",
  ["\\bigg"] = "\\bigg",
  ["\\Big"] = "\\Big",
  ["\\Bigg"] = "\\Bigg",
  ["\\bigl"] = "\\bigr",
  ["\\biggl"] = "\\biggr",
  ["\\Bigl"] = "\\Bigr",
  ["\\Biggl"] = "\\Biggr",
}
local function pairing(ss, pp, es)
  return s(ss .. pp, {
    t(ss),
    i(1, pp),
    t " ",
    sel(),
    i(0),
    t " ",
    t(es),
    f(function(nodes, arg)
      local input = nodes[1][1]
      return cpairs[input] or input
    end, 1),
  })
end

for modl, modr in pairs(pairmods) do
  for pl, pr in pairs(cpairs) do
    list_extend(auto, { pairing(modl, pl, modr) })
  end
end
for pl, pr in pairs(cpairs) do
  list_extend(auto, { s(nw(pl), { t(pl), i(1), sel(), t(pr) }) })
end

----------------------------------------------------------------------
--                         Manual Snippets:                         --
----------------------------------------------------------------------
local theorems = {
  "theorem",
  "definition",
  "remark",
  "problem",
  "lemma",
  "proof",
  "claim",
  "fact",
  "corollary",
}
for k, v in pairs(theorems) do
  local lhs = ("number" == type(k)) and v or k
  list_extend(snips, {
    s(lhs, {
      t { "\\begin{" .. v .. "}", "" },
      sel(),
      i(0),
      t { "", "\\end{" .. v .. "}" },
    }),
  })
end
list_extend(snips, {
  s("beg", {
    t "\\begin{",
    i(1),
    t { "}", "" },
    sel(),
    i(0),
    t { "", "\\end{" },
    r(1),
    t { "}", "" },
  }),
  s("beg", {
    t "\\begin{block}{",
    i(1),
    t { "}", "" },
    sel(),
    i(0),
    t { "", "\\end{block}" },
  }),
  s("beg", {
    t "\\begin{frame}\frametitle{",
    i(1),
    t { "}", "" },
    sel(),
    i(0),
    t { "", "\\end{frame}" },
  }),
  s("wraplist", {
    t { "\\begin{itemize}", "" },
    f(function(_, snip)
      local text = snip and snip.env and snip.env.TM_SELECTED_TEXT
      if text == nil then
        return ""
      end
      local list = {}
      for _, line in pairs(text) do
        vim.list_extend(list, { "\\item " .. line })
      end
      return list
    end, {}),
    i(0),
    t { "", "\\end{itemize}" },
  }),
  s("onslide", {
    t "onslide*<",
    i(1),
    t ">{",
    i(0),
    t "}",
  }),
  s("algo", {
    t "TODO",
  }),
})

for k, v in pairs(templates.tex) do
  list_extend(snips, { pa(k, v) })
end
list_extend(snips, {
  s("subsubsec", { t "subsubsection{", i(0), t "}" }),
})

-- TODO: this could be extended more? but adding the new line is kinda janky
local function infinite_list(item, env, name)
  local rec_ls
  rec_ls = function()
    return sn(nil, {
      c(1, {
        -- important!! Having the sn(...) as the first choice will cause infinite recursion.
        t "",
        -- The same dynamicNode as in the snippet (also note: self reference).
        sn(nil, { t { "", "\t" .. item }, i(1), d(2, rec_ls, {}) }),
      }),
    })
  end

  return s(name or env, {
    t { "\\begin{" .. env .. "}", "\t" .. item },
    i(1),
    d(2, rec_ls, {}),
    t { "", "\\end{" .. env .. "}" },
    i(0),
  })
end

function sizes(def)
  return s(
    def,
    c(1, {
      t "\\fontsize",
      t "\\Huge",
      t "\\huge",
      t "\\LARGE",
      t "\\Large",
      t "\\large",
      t "\\normalsize",
      t "\\small",
      t "\\footnotesize",
      t "\\scriptsize",
      t "\\tiny",
    })
  )
end

list_extend(snips, {
  infinite_list("\\item ", "itemize"),
  infinite_list("\\item[] ", "description"),
  infinite_list("\\item ", "enumerate"),
  sizes "\\fontsize",
  sizes "\\Huge",
  sizes "\\huge",
  sizes "\\LARGE",
  sizes "\\Large",
  sizes "\\large",
  sizes "\\normalsize",
  sizes "\\small",
  sizes "\\footnotesize",
  sizes "\\scriptsize",
  sizes "\\tiny",
})

M.snippets = snips
M.autosnippets = auto

function M.ftplugin()
  -- TODO: inline these variables
  local conf = {
    conceal = 2,
    -- theme = O.lighttheme,
    fontsize = O.bigfontsize,
    filetypes = { "tex", "bib" },
    texlab = {
      aux_directory = ".",
      bibtex_formatter = "texlab",
      build = {
        executable = "tectonic",
        args = {
          -- Input
          "%f",
          -- Flags
          "--synctex",
          "--keep-logs",
          "--keep-intermediates",
          -- Options
          -- OPTIONAL: If you want a custom out directory,
          -- uncomment the following line.
          --"--outdir out",
        },
        forwardSearchAfter = false,
        onSave = true,
      },
      chktex = { on_edit = true, on_open_and_save = true },
      diagnostics_delay = vim.opt.updatetime,
      formatter_line_length = 80,
      forward_search = { args = {}, executable = "" },
      latexFormatter = "latexindent",
      latexindent = { modify_line_breaks = false },
    },
  }
  vim.opt_local.wrap = true
  vim.opt_local.spell = true
  vim.opt.number = false
  vim.opt.relativenumber = false

  local map = vim.keymap.setl
  require("keymappings").wrapjk()
  -- TODO: this sucks ass
  map("v", "<C-b>", "Smb", { remap = true, silent = true })
  map("v", "<C-t>", "Smi", { remap = true, silent = true })
  map("n", "<C-b>", "ysiwbm", { remap = true, silent = true })
  map("n", "<C-t>", "ysiwmi", { remap = true, silent = true })
  map("i", "<C-b>", "<cmd>normal ysiwmb<cr>", { silent = true })
  map("i", "<C-t>", "<cmd>normal ysiwmi<cr>", { silent = true })

  require("lv-lightspeed").au_unconceal(conf.conceal)
  -- vim.opt_local.background = "light"
  if conf.theme then
    vim.cmd(conf.theme)
    -- utils.define_augroups {
    --   _switching_themes = {
    --     { "BufWinEnter", "<buffer>", latexconf.background },
    --     { "BufLeave", "<buffer>", " lua require'theme'()" },
    --   },
    -- }
  end
  if conf.fontsize then
    utils.set_guifont(conf.fontsize)
  end

  require("lsp.config").lspconfig "texlab" {
    filetypes = conf.filetypes,
    settings = {
      texlab = conf.texlab,
    },
  }

  -- require("lv-utils").define_augroups {
  --   _general_lsp = {
  --     { "CursorHold,CursorHoldI", "<buffer>", "lua vim.lsp.buf.formatting()" },
  --     { "CursorMoved,TextChanged,InsertEnter", "<buffer>", "lua vim.lsp.buf.cancel_formatting()" },
  --   },
  -- }

  require("lv-cmp").autocomplete(false)
  require("lv-cmp").sources {
    {
      { name = "luasnip" },
      { name = "nvim_lsp" },
    },
    {
      { name = "buffer" },
      { name = "spell" },
      { name = "omni" },
    },
  }

  local cmp = require "cmp"
  cmp.setup.buffer {
    mapping = {
      ["<CR>"] = cmp.mapping {
        i = function(fallback)
          return fallback()
        end,
      }, -- clear mapping
      ["<TAB>"] = cmp.mapping {
        i = require("lv-cmp").supertab(cmp.confirm),
      },
    },
  }

  require("luasnip").add_snippets("tex", M.snippets)
  require("luasnip").add_snippets("tex", M.autosnippets, { type = "autosnippets" })

  require("lv-pairs.sandwich").add_local_recipes(M.sandwich_recipes)
  vim.b.sandwich_tex_marks_recipes = vim.fn.deepcopy(M.sandwich_marks_recipes) -- TODO: idk what this does
  M.sandwhich_mark_recipe_fn()

  -- Localleader
  local cmd = require("lv-utils").cmd
  mappings.localleader {
    f = { cmd "call vimtex#fzf#run()", "Fzf Find" },
    i = { cmd "VimtexInfo", "Project Information" },
    s = { cmd "VimtexStop", "Stop Project Compilation" },
    t = { cmd "VimtexTocToggle", "Toggle Table Of Content" },
    v = { cmd "VimtexView", "View PDF" },
    c = { utils.conceal_toggle, "Toggle Conceal" },
    b = { cmd "VimtexCompile", "Compile" },
    o = { cmd "VimtexCompileOutput", "Compile Output" },
    e = { cmd "VimtexErrors", "Errors" },
    l = { cmd "TexlabBuild", "Texlab Build" },
    n = {
      function()
        require("nabla").popup()
      end,
      "Nabla",
    },
    m = { cmd "VimtexToggleMain", "Toggle Main File" },
    a = { cmd "AirLatex", "Air Latex" },
  }

  -- require("lv-utils").define_augroups { _vimtex_event = {
  --   { "InsertLeave", "*.tex", "VimtexCompile" },
  -- } }
end

return M
