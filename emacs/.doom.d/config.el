;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(use-package! dap-mode
  :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))

(use-package! eterm-256color
  :after term
  :config
  (add-hook 'term-mode-hook #'eterm-256color-mode))
