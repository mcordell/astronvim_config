local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require "luasnip.util.events"
local ai = require "luasnip.nodes.absolute_indexer"
local extras = require "luasnip.extras"
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require "luasnip.extras.expand_conditions"
local postfix = require("luasnip.extras.postfix").postfix
local types = require "luasnip.util.types"
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

local get_visual = function(_args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end -- Place this in ${HOME}/.config/nvim/LuaSnip/all.lua

local snakeToCamelCase = function(snake_string)
  -- remove .rb extension
  -- convert snake case to camel case
  local camel_case_string = snake_string:gsub("(%l)(%w*)", function(a, b) return string.upper(a) .. b end)
  camel_case_string = camel_case_string:gsub("_", "")

  return camel_case_string
end

local spiltParameters = function(args, _parent, _user_args)
  local output = {}

  for param in args[1][1]:gmatch "([^, ]+)" do
    table.insert(output, "  @" .. param .. " = " .. param)
  end

  return output
end

local splitParamDoc = function(args, _parent, _user_args)
  local output = {}

  for param in args[1][1]:gmatch "([^, ]+)" do
    table.insert(output, "# @param " .. param .. " [Type] description")
  end

  return output
end

local function split(str, delimiter)
  local result = {}
  for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match)
  end
  return result
end

local dynamicModuleName = function(_args, parent)
  local rel = parent.snippet.env.RELATIVE_FILEPATH
  local shorter = parent.snippet.env.TM_FILENAME
  -- Split the relative path
  local parts = split(rel, "/")

  -- Remove the file name from the list
  table.remove(parts)
  if parts[1] == "lib" then table.remove(parts, 1) end
  for it, v in ipairs(parts) do
    parts[it] = snakeToCamelCase(v)
  end
  local result = table.concat(parts, "::")
  return sn(nil, i(1, result))
end

local itblock = fmta(
  [[
      it '<>' do
        <>
      end
    ]],
  {
    i(1, "does something"),
    i(0),
  }
)

local classNode = fmta(
  [[
      # <>
      class <>
          <>
      end
    ]],
  {
    i(2, "docstring"),
    d(1, function(_args, parent)
      local shorter = parent.snippet.env.TM_FILENAME:sub(1, -4)

      return sn(nil, i(1, snakeToCamelCase(shorter)))
    end),
    i(0),
  }
)

local get_class_node = function(_args, _parent) return sn(nil, classNode) end

return {
  s(
    { trig = ">r", desc = "Pipe into reduce", snippetType = "autosnippet" },
    fmt("|> Enum.reduce({}, fn {}, acc -> {} end)", {
      i(1, "acc"),
      i(2, "item"),
      i(0),
    })
  ),
  s(
    { trig = ">m", desc = "Pipe into map", snippetType = "autosnippet" },
    fmt("|> Enum.map(fn {} -> {} end)", {
      i(2, "item"),
      i(0),
    })
  ),
  s(
    { trig = ">t", desc = "Pipe into Kernel.then with &", snippetType = "autosnippet" },
    fmt("|> then(&{}.{}({}, &1))", {
      i(1, "Module"),
      i(2, "function"),
      i(3, "first arg"),
    })
  ),
  s(
    { trig = "bt", desc = "Ecto belongs_to association", wordTrig = true },
    fmt("belongs_to :{}, {}, foreign_key: :{}_id", {
      i(1, "association_name"), -- First placeholder for the association name
      i(2, "ModuleName"), -- Second placeholder for the module representing the association
      i(3, "association_name"), -- Third placeholder for the foreign key (usually same as association name)
    })
  ),
  s(
    { trig = "ho", desc = "Ecto has one association", wordTrig = true },
    fmt("has_one :{}, {}, foreign_key: :{}_id", {
      i(1, "association_name"), -- First placeholder for the association name
      i(2, "ModuleName"), -- Second placeholder for the module representing the association
      i(3, "association_name"), -- Third placeholder for the foreign key (usually same as association name)
    })
  ),
  s(
    { trig = "hm", desc = "Ecto has_many association", wordTrig = true },
    fmt("has_many :{}, {}", {
      i(1, "association_name"), -- First placeholder for the association name
      i(2, "ModuleName"), -- Second placeholder for the module representing the associated records
    })
  ),
  s(
    { trig = "field", desc = "Ecto schema field", wordTrig = true },
    fmt("field :{}, {} {}", {
      i(1, "column_name"), -- First placeholder for the association name
      i(2, "type"), -- Second placeholder for the module representing the associated records
      i(0),
    })
  ),
  s(
    { trig = "live_routes", desc = "", wordTrig = true },
    fmt(
      [[
      live "/{}/:id", {}Live.Show, :show
      live "/{}/:id/show/edit", {}Live.Show, :edit

      live "/{}", {}Live.Index, :index
      live "/{}/new", {}Live.Index, :new
      live "/{}/:id/edit", {}Live.Index, :edit
        ]],
      {
        i(1, "base_route"), -- First placeholder for the association name
        i(2, "module"), -- Second placeholder for the module representing the associated records
        rep(1),
        rep(2),
        rep(1),
        rep(2),
        rep(1),
        rep(2),
        rep(1),
        rep(2),
      }
    )
  ),
}
