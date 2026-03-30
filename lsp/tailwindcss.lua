return {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = { 'html', 'css', 'svelte', 'javascriptreact', 'typescriptreact' },
  root_markers = { 'tailwind.config.js', 'tailwind.config.ts', 'tailwind.config.cjs', '.git' },
}
