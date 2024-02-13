local ls = require("luasnip")

local s, i = ls.s, ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s("chore", fmt("chore: {}\n{}", { i(1), i(2) })),
  s("ci", fmt("ci: {}\n{}", { i(1), i(2) })),
  s("docs", fmt("docs: {}\n{}", { i(1), i(2) })),
  s("feat", fmt("feat: {}\n{}", { i(1), i(2) })),
  s("fix", fmt("fix: {}\n{}", { i(1), i(2) })),
  s("refactor", fmt("refactor: {}\n{}", { i(1), i(2) })),
  s("style", fmt("style: {}\n{}", { i(1), i(2) })),
  s("test", fmt("test: {}\n{}", { i(1), i(2) })),

  s("chores", fmt("chore({}): {}\n{}", { i(1), i(2), i(3) })),
  s("cis", fmt("ci({}): {}\n{}", { i(1), i(2), i(3) })),
  s("docss", fmt("docs({}): {}\n{}", { i(1), i(2), i(3) })),
  s("feats", fmt("feat({}): {}\n{}", { i(1), i(2), i(3) })),
  s("fixs", fmt("fix({}): {}\n{}", { i(1), i(2), i(3) })),
  s("refactors", fmt("refactor({}): {}\n{}", { i(1), i(2), i(3) })),
  s("styles", fmt("style({}): {}\n{}", { i(1), i(2), i(3) })),
  s("tests", fmt("test({}): {}\n{}", { i(1), i(2), i(3) })),

  s("feat!", fmt("feat!: {}\n{}", { i(1), i(2) })),
  s("fix!", fmt("fix!: {}\n{}", { i(1), i(2) })),

  s("feats!", fmt("feat!({}): {}\n{}", { i(1), i(2), i(3) })),
  s("fixs!", fmt("fix!({}): {}\n{}", { i(1), i(2), i(3) })),

  s("cob", fmt("Co-Authored-By: {}", { i(1) })),

  s("BREAK", fmt("BREAKING CHANGE: {}", { i(1) })),
}
