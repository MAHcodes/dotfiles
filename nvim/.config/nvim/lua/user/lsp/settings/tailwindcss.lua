return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "aspnetcorerazor", "astro",
    "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs", "erb", "eruby",
    "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs", "html", "html-eex", "heex", "jade", "leaf", "liquid", "markdown",
    "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss",
    "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue",
    "svelte" },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "class:list", "classList", "ngClass", ".*Styles", ".*Classes" },
      experimental = {
        classRegex = {
          "tw`([^`]*)",
          -- this is for intelissense on className : ...
          "className\\s*:\\s*['\"`]([^'\"`]*)['\"`]",
          -- this is for btnClasses = "..."
          -- or btnClasses = { danger : "..."}
          "Classes \\=([^;]*);", "'([^']*)'",
          "Classes \\=([^;]*);", "\"([^\"]*)\"",
          "Classes \\=([^;]*);", "\\`([^\\`]*)\\`"
        }
      },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning"
      },
      validate = true
    }
  }
}
